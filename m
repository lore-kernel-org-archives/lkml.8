Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B835C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA51D206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjo3j7NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgEUWXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgEUWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:23:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:23:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so3539084plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N2wKxaW6lDoNkWJApceaOVJtkImjIaOQnCYFrOJceIM=;
        b=wjo3j7NTmZ6x2EPn4FNPGkgF3yq0SZt3IyHQQlwg+08rNmo6WNGyqJQJpTIxlhmCi2
         d0W9GHskbnb5PGZM0fgLL0PBPcTlum856yl7gPGlQpDh+9euCe72c3W3zAwSDC+MgxPz
         V+w+OOkMkowlIGHMqw01C72mOSt8+rlwlUFED3ywlW6H6Hg270VX1MEkgqAliMlggROv
         cpdtEJ7zkMztQQS2ZHU2wNROlVxcX+TvzA7/WjMkk5CH0w098tbMCy/4zYwY+0gFLqpR
         2Cedi9dxq9gg2xkw6/J/a+UztG42BYSV2t1qfH6q4/VZHLzO2JMqR286ijN/XkNnf2f9
         LEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2wKxaW6lDoNkWJApceaOVJtkImjIaOQnCYFrOJceIM=;
        b=JmlZha+sORyOmDP3Gwzf+Ds1ncwxBO9NA5AZxK9feRvnd586Ho0zIlIyfBJyYQxxac
         FD4WgLE2Gecp0nJkg5eAp0Z2Fpj2FO4Vl7/k6Tt7/BVi0HFUytZiit/EgvWe2nzYCFj9
         7YLxE1hcRosohvu/DDV7RswbcMF+RdDX2NNBkeHkvMGPCjQFczrAPHeDS5hUoBHXc3uj
         nbCMMFOuKJx6QksYJc5xSlSU3cp/CeA5L81d7nOK6ZLhaPm0jcWUmlviOmaeci1wi3N2
         oC7T1EHqPzelsgMDbeyU5q2JfIpQX1M/C1Xz7mCkkVmHm8KyRUgXNO1dsIQzHdeah4vq
         +sIg==
X-Gm-Message-State: AOAM532Rs1hNgu3742y+c/hIdSQ31LG2i//Tg6SBGGLUT7aSG+yDu4v0
        Pw5G2Of2SGlgu2TZpJQS2TUWaw==
X-Google-Smtp-Source: ABdhPJx4w0xWOxaP5k03XXaaUIrnPMYU5QWKAquQCASJdj6CT7akrgbu0lcPQoBQZTArdHRtmJAinQ==
X-Received: by 2002:a17:90a:a43:: with SMTP id o61mr773896pjo.179.1590099816842;
        Thu, 21 May 2020 15:23:36 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i10sm5301018pfa.166.2020.05.21.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:23:36 -0700 (PDT)
Date:   Thu, 21 May 2020 16:23:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] TI K3 DSP remoteproc driver for C66x DSPs
Message-ID: <20200521222334.GA11366@xps15>
References: <20200521001006.2725-1-s-anna@ti.com>
 <5f84465e-8f63-51b4-4758-59c85d3ad597@ti.com>
 <20200521190141.GN408178@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521190141.GN408178@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gents,

On Thu, May 21, 2020 at 12:01:41PM -0700, Bjorn Andersson wrote:
> On Thu 21 May 11:59 PDT 2020, Suman Anna wrote:
> 
> > Hi Bjorn,
> > 
> > On 5/20/20 7:10 PM, Suman Anna wrote:
> > > Hi All,
> > > 
> > > The following is v2 of the K3 DSP remoteproc driver supporting the C66x DSPs
> > > on the TI K3 J721E SoCs. The patches are based on the latest commit on the
> > > rproc-next branch, 7dcef3988eed ("remoteproc: Fix an error code in
> > > devm_rproc_alloc()").
> > 
> > I realized I also had the R5F patches on my branch, so the third patch won't
> > apply cleanly (conflict on Makefile). Let me know if you want a new revision
> > posted for you to pick up the series.
> > 
> 
> That should be fine, thanks for the heads up!
> 
> Will give Mathieu a day or two to take a look as well.

I don't see having the time to review this set before the middle/end of next
week.  I also understand we are crunched by time if we want to get this in
for the upcoming merge window.

If memory serves me well there wasn't anything controversial about this work.
Under normal circumstances I'd give it a final look but I trust Suman to have
carried out what we agreed on.

Bjorn - if you are happy with this set then go ahead and queue it.

Thanks,
Mathieu

> 
> Regards,
> Bjorn
> 
> > regards
> > Suman
> > 
> > > 
> > > v2 includes a new remoteproc core patch (patch 1) that adds an OF helper
> > > for parsing the firmware-name property. This is refactored out to avoid
> > > replicating the code in various remoteproc drivers. Please see the
> > > individual patches for detailed changes.
> > > 
> > > The main dependent patches from the previous series are now staged in
> > > rproc-next branch. The only dependency for this series is the common
> > > ti-sci-proc helper between R5 and DSP drivers [1]. Please see the initial
> > > cover-letter [2] for v1 details.
> > > 
> > > regards
> > > Suman
> > > 
> > > [1] https://patchwork.kernel.org/patch/11456379/
> > > [2] https://patchwork.kernel.org/cover/11458573/
> > > 
> > > Suman Anna (4):
> > >    remoteproc: Introduce rproc_of_parse_firmware() helper
> > >    dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
> > >    remoteproc/k3-dsp: Add a remoteproc driver of K3 C66x DSPs
> > >    remoteproc/k3-dsp: Add support for L2RAM loading on C66x DSPs
> > > 
> > >   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 190 +++++
> > >   drivers/remoteproc/Kconfig                    |  13 +
> > >   drivers/remoteproc/Makefile                   |   1 +
> > >   drivers/remoteproc/remoteproc_core.c          |  23 +
> > >   drivers/remoteproc/remoteproc_internal.h      |   2 +
> > >   drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 773 ++++++++++++++++++
> > >   6 files changed, 1002 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> > >   create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > > 
> > 
