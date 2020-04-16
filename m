Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B651C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013942076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502646AbgDPIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:48:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:52782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502417AbgDPIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:41:39 -0400
IronPort-SDR: eU+hST5QcsZMXFzsfDA+bPOoa14Th0fl6mEaJZXn7VyE+60VLQuokZPQ+qw1xUWAhzI7W0eQ3O
 ErKLzzjLb1Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:40:51 -0700
IronPort-SDR: O02uliJ2TLB1Rf4DXiGVg6osSYXxLlEMbhiySqv0IWWASNVxV8ObPNorwq5u5No587JPMWRHH1
 Q7qD6DPl3gWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363921031"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Apr 2020 01:40:49 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Apr 2020 11:40:48 +0300
Date:   Thu, 16 Apr 2020 11:40:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <20200416084048.GT2586@lahna.fi.intel.com>
References: <PSXP216MB043820634A932AF06774C0FC80DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04389E900D109FC827A5752580DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04389E900D109FC827A5752580DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 02:04:25AM +0800, Nicholas Johnson wrote:
> This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> 
> Commit 664f0549380c ("nvmem: core: use is_bin_visible for permissions")
> incidentally adds support for write-only nvmem. Hence, this workaround
> is no longer required, so drop it.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Applied, thanks!
