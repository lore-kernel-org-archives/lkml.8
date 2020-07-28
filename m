Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1724C433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E62070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgG1McI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:32:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:14685 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgG1McF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:05 -0400
IronPort-SDR: I8pWUMARg2m+9SG5GPJiipL7YRfaz2hIem85gMYMYDNmHbfjLLzaPTgAZ9wUy3+n5plwnqjiqU
 FfDHIBbFR1qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="149058119"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="149058119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:32:04 -0700
IronPort-SDR: 4YjtbwCd5BbR2ffPSzRSejd71IJXA9RDCTUG/Rj6Y8wr7IhPWeHpPKIEvnmK75T7nbnhpGU+qW
 FzBO9DnLRDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="394317464"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Jul 2020 05:32:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jul 2020 15:32:00 +0300
Date:   Tue, 28 Jul 2020 15:32:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     =?iso-8859-1?Q?J=FCrgen?= Stauber <j.stauber@icloud.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: High load from process irq/65-i2c-INT3 - kernel module tps6598x
Message-ID: <20200728123200.GF883641@kuha.fi.intel.com>
References: <376EFB02-6CA2-4D5A-883B-7843B6F6B6EC@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <376EFB02-6CA2-4D5A-883B-7843B6F6B6EC@icloud.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jürgen,

I'm sorry about the late reply (vacation).

On Mon, Jul 20, 2020 at 06:31:04PM +0200, Jürgen Stauber wrote:
> Hi all,
> 
> I was made aware in the following launchpad bug report, that I should report
> the issue directly with the upstream maintainers:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1883511
> <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1883511>
> 
> As mentioned in the report, I experience high cpu load due to an interrupted
> irq/65-i2c-INT3 process. A short fix is to unload the kernel module tps6598x.
> 
> Please be lenient with me, since I’ve got no glue whether I’m doing this
> correctly.
> 
> In case you need more details/logs/information, please let me know.

There is one thing that you may be able to try. If you can enter the
BIOS menu, then you should be able to disable an option called
"UCMCx". Unfortunately I don't know the full path to that option in
the BIOS menu of the NUC, or is entering the BIOS menu possible in the
first place. It is also possible that there is no option "UCMCx" at
all.

Unfortunately I don't have access to NUC10 at the moment, but I'll try
get one.

Br,

-- 
heikki
