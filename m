Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A8EC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96920663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgCPPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:33:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:21338 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbgCPPdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:33:07 -0400
IronPort-SDR: UEXN8bZw49xlQIP0ehCoWOiJRsYu+ZNv0AxZ+v8vHLhWo3/vlt1LiReuv+Sr+QHUq4ePzWDR6o
 dp2PG4fmva7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:33:06 -0700
IronPort-SDR: iITveEGsB4PM/qGADp4pXTOILr3PlYoZBRaDxL2M2sonmhpy4W1Khrjrb5ebjKAGrgLHTJLQlO
 4S+ARju9YjGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="417177457"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2020 08:33:02 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 0/9] x86: Easy way of detecting MS Surface 3
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 16 Mar 2020 17:33:02 +0200
Message-ID: <871rps9uxd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> While working on RTC regression, I noticed that we are using the same DMI check
> over and over in the drivers for MS Surface 3 platform. This series dedicated
> for making it easier in the same way how it's done for Apple machines.

[...]

>   x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
>   x86/quirks: Join string literals back

These two don't seem to be related to the Surface 3 cause of the rest of
the patchset, or am I missing something?

Regards,
--
Alex
