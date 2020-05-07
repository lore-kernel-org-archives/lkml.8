Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B189C54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343572075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEGNlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:41:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:57847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgEGNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:41:31 -0400
IronPort-SDR: KTBlUNEmoFuQYJPwzWYrnvxt5vvBk3+SKDAaniDm7aaysQaleKPL4nSJ1prlPYe2Jk57FPXSsM
 +G2fBm67PGNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:41:30 -0700
IronPort-SDR: G7ce+OsY5MlHspOLUOm76PNjgGDXmJ4FDym/wEFtCeIGUxBxYbcB2EB0DDIi60NghlARqDS2Hn
 6Eau5r4ymXqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="263938934"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2020 06:41:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWgmI-005Dmr-GN; Thu, 07 May 2020 16:41:30 +0300
Date:   Thu, 7 May 2020 16:41:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH 0/1] Add USB role switch to tps6598x
Message-ID: <20200507134130.GX185537@smile.fi.intel.com>
References: <20200507124556.1774311-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507124556.1774311-1-bryan.odonoghue@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:45:55PM +0100, Bryan O'Donoghue wrote:
> This patch - adds USB role switching to the TI TPS6598x. It has been tested
> out with a ChipIdea controller inside a Qualcomm MSM8939.
> 
> Right now you need to have configured the TPS firmware with the TI
> configuration tool so that the chip knows if it should initiate or accept
> data and power role swaps.
> 
> https://www.ti.com/lit/an/slva843a/slva843a.pdf

Can you include that in the patch under DocLink tag with some background info?

-- 
With Best Regards,
Andy Shevchenko


