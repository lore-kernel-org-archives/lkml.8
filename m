Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA59520786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHRPL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:11:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:54595 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHRPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:11:26 -0400
IronPort-SDR: VLJ01JHyOp6SbVB/gOumoQmlR+hiS6MuzCRFG611NJZLYJP3mhY2dbjLX2cJ+urJw0Ma8e+WWN
 w3As+iJPQfUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134986578"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="134986578"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 08:11:26 -0700
IronPort-SDR: wpnUt6l9zL5pTGol124Nt0/IN+bZOQ6r1M/bJ27aHUxqFKdewMwDsMoP6G4BixKoPq1AWF6CgK
 U7y3y3zpprQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="441253428"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2020 08:11:24 -0700
Date:   Tue, 18 Aug 2020 23:07:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200818150738.GA11659@yilunxu-OptiPlex-7050>
References: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
 <20200817082410.GB19661@yilunxu-OptiPlex-7050>
 <20200817091252.GV4354@dell>
 <20200818083647.GE22873@yilunxu-OptiPlex-7050>
 <5a2d4761-e800-bfb6-d67b-8740b8039ecc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2d4761-e800-bfb6-d67b-8740b8039ecc@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that's a good optimization. I'll include this change and send a
v4.

Thanks.

On Tue, Aug 18, 2020 at 07:40:45AM -0700, Tom Rix wrote:
> Yilun,
> 
> I was looking at the tx side a bit and think the padding function could be moved into the pkt/phy function.  The pky/phy function already is looking for the eop's so reuse it and remove the search for eop and exchange the loops that do char moving and padding to mem* functions.  The logic is something like.                                                          
> if (tb == tb_end - 1 && !eop_inserted) {
>         *pb = PKT_EOP;
> 
>         p_eop = pb;
> 
> ...
> 
>     dst_pb = &br->phy_buf[aligned_len];
>     size_t s = pb - p_eop + 1;
>     /* move EOP and bytes after EOP to the end of aligned size */
>     memmove(dst_pb - s, p_eop, s);
>     /* fill the hole with PHY_IDLEs */
>     memset(p_eop, PHY_IDLE, aligned_len - br->phy_len);
>     /* update the phy data length */
> 
> Tom
> 
>  
> 
> On 8/18/20 1:36 AM, Xu Yilun wrote:
> > On Mon, Aug 17, 2020 at 10:12:52AM +0100, Lee Jones wrote:
> >> On Mon, 17 Aug 2020, Xu Yilun wrote:
> >>
> >>> Hi Brown & jones:
> >>>
> >>> I tried to refacor the regmap code and add comments in this patchset. I
> >>> made big changes to the rx flow and remove some tricky parts in it.
> >>>
> >>> Would it be more understandable than last version? I'm expecting your
> >>> comments on it when you have time, thanks in advance.
> >> Just resubmit please.  We can review the code itself.
> > Ok. I'll rebase it to 5.9-rc1 and resubmit it.
> >
> > Thanks,
> > Yilun
> >
> >> -- 
> >> Lee Jones [李琼斯]
> >> Senior Technical Lead - Developer Services
> >> Linaro.org │ Open source software for Arm SoCs
> >> Follow Linaro: Facebook | Twitter | Blog
