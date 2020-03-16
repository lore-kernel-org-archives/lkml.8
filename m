Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4AF2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgCPP1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:27:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:11731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbgCPP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:27:35 -0400
IronPort-SDR: kCGQrXEE1V+GUrE6fjCSE0XJbK9jVxlrK6qPIN2jxc3BsihBcueFNCX7JKKxLyfT28XHbofath
 myTlAprhpxiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:27:34 -0700
IronPort-SDR: wTruhLha5iPirvApJKWs83GJMsu6ZOv0htAvYKoYuEjeBqG1fqIlWo/HGoxaimuqCAhCwZVfxy
 6BRvpI71UUeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="237980193"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2020 08:27:31 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 5/9] x86/quirks: Convert DMI matching to use a table
In-Reply-To: <20200122112306.64598-6-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com> <20200122112306.64598-6-andriy.shevchenko@linux.intel.com>
Date:   Mon, 16 Mar 2020 17:27:30 +0200
Message-ID: <874kuo9v6l.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> +static const struct dmi_system_id x86_machine_table[] __initconst = {
> +	{
> +		.ident = "x86 Apple Macintosh",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		},
> +		.driver_data = &x86_apple_machine,
> +	},
> +	{
> +		.ident = "x86 Apple Macintosh",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
> +		},
> +		.driver_data = &x86_apple_machine,
> +	},
> +	{}
> +};
> +
> +static void __init early_platform_detect_quirk(void)
> +{
> +	const struct dmi_system_id *id;
> +
> +	id = dmi_first_match(x86_machine_table);
> +	if (!id)
> +		return;
> +
> +	printk(KERN_DEBUG "Detected %s platform\n", id->ident);
> +	*((bool *)id->driver_data) = true;

I'd suggest that x86_apple_machine and the ones that you add further
down this patchset, be made functions instead. That way you could at
first hide the global bool(s) and then replace this with something a
little more type safe.

Regards,
--
Alex
