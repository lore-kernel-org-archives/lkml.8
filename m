Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01EDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5713214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XUB1rIWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgAaVSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:18:25 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:32896 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgAaVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:18:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580505503; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=c5POQGsK03IMyYhyXfqfpslU7IQ1EXdg2hdGsgrQr9c=; b=XUB1rIWtLKxnwZrz/69BsNYQ62algPtd98jvC7dg8a/5C1GFpds8+6zVStVTUfqfWwVm+5LP
 vD/NsoznVFEA1I3f1Sz1eruVozjr/v81s8hUv9a0RIeMzsumV8HO5LRkoSDbI6dyYzeyrxte
 q6sHvzK4Amz2sSlsZxLXW2sMpbU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e349999.7f95ad1b54c8-smtp-out-n03;
 Fri, 31 Jan 2020 21:18:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36EFCC4479C; Fri, 31 Jan 2020 21:18:17 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94395C447A4;
        Fri, 31 Jan 2020 21:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94395C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 31 Jan 2020 14:18:13 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
Message-ID: <20200131211813.GA16531@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1580117390-6057-1-git-send-email-smasetty@codeaurora.org>
 <CAD=FV=VFVC6XJ=OXJCSd2_oij5vggKnTedGP0Gj4KHC50QH0SQ@mail.gmail.com>
 <4bd79f53cab95db9286067836722dd4b@codeaurora.org>
 <CAD=FV=X7pUvab1FXkPbxio_0hW0mvAguFbPAcfQ1=K9HD9bMug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X7pUvab1FXkPbxio_0hW0mvAguFbPAcfQ1=K9HD9bMug@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:08:09AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jan 31, 2020 at 4:16 AM <smasetty@codeaurora.org> wrote:
> >
> > >> +                       reg = <0 0x0506a000 0 0x31000>, <0 0x0b290000
> > >> 0 0x10000>,
> > >> +                               <0 0x0b490000 0 0x10000>;
> > >> +                       reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> > >> +                       interrupts = <GIC_SPI 304
> > >> IRQ_TYPE_LEVEL_HIGH>,
> > >> +                                  <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> > >> +                       interrupt-names = "hfi", "gmu";
> > >> +                       clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> > >> +                              <&gpucc GPU_CC_CXO_CLK>,
> > >> +                              <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> > >> +                              <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> > >> +                       clock-names = "gmu", "cxo", "axi", "memnoc";
> > >> +                       power-domains = <&gpucc CX_GDSC>;
> > >
> > > Bindings claim that you need both CX and GC.  Is sc7180 somehow
> > > different?  Bindings also claim that you should be providing
> > > power-domain-names.
> > No this is still needed, We need the GX power domain for GPU recovery
> > use cases where the shutdown was not successful.
> 
> This almost sounds as if the bindings should mark the GX power domain
> as optional?  The driver can function without it but doesn't get all
> the features?  As the binding is written right now I think it is
> "invalid" to not specify a a GX power domain and once the yaml
> conversion is done then it will even be flagged as an error.  That's
> going to make it harder to land the your patch...

For GMU attached targets the GX power domain is mandatory assuming you want to
recover successfully from a hard GMU hang, that is.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
