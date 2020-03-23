Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19FBC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CAF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCWG72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:59:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:32005 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWG72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:59:28 -0400
IronPort-SDR: 6mr2jgrVmXoC+DhfbQj1lUB3/VCHSyZRCF/ZRCpnWUXkCVqvHfnjSgfLiYce31Frl4uAM3jRd7
 /OuxmKG/pmDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 23:59:27 -0700
IronPort-SDR: cA2lPX0pXEB4WbXpZNzyZ6o003Vj3Hz6tZxc8gwP70Shsc5CrZjpoUQk90wYjym2ikqqEMAwyr
 F65MQg6NEaMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="445703253"
Received: from rupengwe-mobl1.ccr.corp.intel.com ([10.249.168.143])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2020 23:59:25 -0700
Message-ID: <9698a9f2c49e3ca286b946eeb7de3399c406ea5e.camel@intel.com>
Subject: Re: linux-next: build failure after merge of the thermal tree
From:   Zhang Rui <rui.zhang@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andres Freund <andres@anarazel.de>
Date:   Mon, 23 Mar 2020 14:59:24 +0800
In-Reply-To: <20200323110852.1f08e4f1@canb.auug.org.au>
References: <20200323110852.1f08e4f1@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 11:08 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the thermal tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/thermal/intel/intel_pch_thermal.c:306:2: error: expected '}'
> before '[' token
>   306 |  [board_lwb] = {
>       |  ^
> drivers/thermal/intel/intel_pch_thermal.c:285:18: note: to match this
> '{'
>   285 | } board_info[] = {
>       |                  ^
> 
> Caused by commit
> 
>   16cd95bab00f ("thermal: intel_pch_thermal: Add PCI ids for
> Lewisburg PCH.")
> 
> I have used the thermal tree from next-20200320 for today.
> 
Bug has been fixed.
BTW, I think you can remove Eduardo from this loop, because he is not
working as the thermal maintainer right now.

thanks,
rui

