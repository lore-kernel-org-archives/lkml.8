Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BF4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Xs55ZdM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgANSGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:06:05 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37444 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:06:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579025163; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=pFpRqstlJrkjwz5Jitm1T/3UmfsGbLTwe4ukl7K6y3E=; b=Xs55ZdM5iu2TJMOZD96Ab9NxFm2m9tENdLQlOgXSAJn8uAe2J3yN5rJ9xFtmF8Iz/OZVq0Hj
 XcvreNVbfpcwg3CAfuCLE2UXad737VK99tB0xzQZDmfCLPd1bIfHx6NE1ni+p9Tm+vEWCU+q
 siNtsunx99XiituSB8R2P1DOJ1E=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1e0309.7f3f1fbd0110-smtp-out-n02;
 Tue, 14 Jan 2020 18:06:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B306CC43383; Tue, 14 Jan 2020 18:06:00 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E93FC433CB;
        Tue, 14 Jan 2020 18:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E93FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 14 Jan 2020 11:05:56 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Kristian Kristensen <hoegsberg@google.com>
Cc:     Rob Clark <robdclark@chromium.org>, Brian Ho <brian@brkho.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH 2/2] drm/msm: Add MSM_WAIT_IOVA ioctl
Message-ID: <20200114180556.GC2371@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Kristian Kristensen <hoegsberg@google.com>,
        Rob Clark <robdclark@chromium.org>, Brian Ho <brian@brkho.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Sean Paul <sean@poorly.run>
References: <20200113153605.52350-1-brian@brkho.com>
 <20200113153605.52350-3-brian@brkho.com>
 <20200113175148.GC26711@jcrouse1-lnx.qualcomm.com>
 <CAJs_Fx6AVwA73eN+Rs=GAvBPD1Leq=WKG9w_2hohpzmecK_C_A@mail.gmail.com>
 <20200114172319.GA2371@jcrouse1-lnx.qualcomm.com>
 <CAOPc6TnEZY9zxz-JPzh-7awWOtLrP_tiv+Sa0b3gh5HFp09QaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOPc6TnEZY9zxz-JPzh-7awWOtLrP_tiv+Sa0b3gh5HFp09QaA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 09:30:00AM -0800, Kristian Kristensen wrote:
> On Tue, Jan 14, 2020 at 9:23 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > On Tue, Jan 14, 2020 at 08:52:43AM -0800, Rob Clark wrote:
> > > On Mon, Jan 13, 2020 at 9:51 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > > >
> > > > On Mon, Jan 13, 2020 at 10:36:05AM -0500, Brian Ho wrote:
> > > > > +
> > > > > +     vaddr = base_vaddr + args->offset;
> > > > > +
> > > > > +     /* Assumes WC mapping */
> > > > > +     ret = wait_event_interruptible_timeout(
> > > > > +                     gpu->event, *vaddr >= args->value, remaining_jiffies);
> > > >
> > > > I feel like a barrier might be needed before checking *vaddr just in case you
> > > > get the interrupt and wake up the queue before the write posts from the
> > > > hardware.
> > > >
> > >
> > > if the gpu is doing posted (or cached) writes, I don't think there is
> > > even a CPU side barrier primitive that could wait for that?  I think
> > > we rely on the GPU not interrupting the CPU until the write is posted
> >
> > Once the GPU puts the write on the bus then it is up to the whims of the CPU
> > architecture. If the writes are being done out of order you run a chance of
> > firing the interrupt and making it all the way to your handler before the writes
> > catch up.
> >
> > Since you are scheduling and doing a bunch of things in between you probably
> > don't need to worry but if you start missing events and you don't know why then
> > this could be why. A rmb() would give you piece of mind at the cost of being
> > Yet Another Barrier (TM).
> 
> Doesn't the fence case do the same thing without a barrier?

We get a free __iormb() and dma_rmb() from every gpu_read() so I think that
is enough to catch everything up when the interrupt handler reads the status
register and in most cases we don't check the fence until after that. I'm not
sure that covers all the possible error cases.  Maybe something to look into?

Also that field is marked as volatile in the struct, but I'm not sure that does
anything useful.

Jordan

> > > BR,
> > > -R
> > > _______________________________________________
> > > Freedreno mailing list
> > > Freedreno@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/freedreno
> >
> > --
> > The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
