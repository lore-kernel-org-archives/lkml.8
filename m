Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E40C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E303206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mlJLtlVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgC3SYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:24:48 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39743 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3SYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:24:46 -0400
Received: by mail-vs1-f49.google.com with SMTP id j128so11700000vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBiWhVp0IqfyFDNmwRRGA/s+Dtxuu8Q2mjZHUKcx0uk=;
        b=mlJLtlVPXBg1gWOsSAxsoafEcJT38NiNpF0UOqjmzXlo8GohAqgw297ZK1Swt56Bly
         V3nGgPyqvQPMeDtng5baT7oly6ktnoBEa56u9lCaFRUnAvGmc515iPKUrcWy2Hs+fCMI
         IFS1C4dlShgMqMwCUu2tNPruIHdi1VqoM0tac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBiWhVp0IqfyFDNmwRRGA/s+Dtxuu8Q2mjZHUKcx0uk=;
        b=cDxAE+Bg4W5t/Ay4O2h3CgFa7Vx6/4xQFIlI4oUObMoMla3C1iDhkdEkvKiob9axM/
         UGgdr6RPPCY6yyGYBtcSic9y1X8LZyvA47uBAXUXmc07HozxSTh2aBZ75/mSDnAMBoKa
         wfKxLihZPQqib84MCNZaQRI6LZwKivLhiI1Vyjj9RK6w/N+Rsm3326A31g9NNgcWTgWf
         mTlVVQ95tPdyfdGkKjZSY+19kl06Wh+CO8sj9srhwN/X6f+kNnLi1Y05grwMgw+O7Phc
         hdE013LaA4S2fgTb9BoREuhldXvxfYGYNbKTV/Nv2d2SoCGOom3vaVBa50AG46Af+dU2
         ZEbg==
X-Gm-Message-State: AGi0PuZHk/mxVu55X+hIIGeg4NyBc+XnnYH65XXyW9KCGBIWB6lW/GGI
        29Lt7dt9CO+LePZpxBhsDXQWLKFyg/Y=
X-Google-Smtp-Source: APiQypJJPYo0z3QVGQck/85PaRD7teNGsgBqGnnw0D9KTvpBzevvjGzZCokODQtSse/5R3XGXLcnzg==
X-Received: by 2002:a67:3355:: with SMTP id z82mr9517178vsz.76.1585592683679;
        Mon, 30 Mar 2020 11:24:43 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id o39sm6163573uad.6.2020.03.30.11.24.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 11:24:43 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id f17so4759681vkk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:24:42 -0700 (PDT)
X-Received: by 2002:a1f:a9d2:: with SMTP id s201mr8815125vke.92.1585592681966;
 Mon, 30 Mar 2020 11:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com> <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com> <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
In-Reply-To: <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Mar 2020 11:24:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
Message-ID: <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> > Of course the fact that in practice we'll *always* see the warning
> > because there's no way to tear down the default DMA domains, and even
> > if all devices *have* been nicely quiesced there's no way to tell, is
> > certainly less than ideal. Like I say, it's not entirely clear-cut
> > either way...
> >
>
> Thanks for these examples, good to know these scenarios in case we come
> across these.
> However, if we see these error/warning messages appear everytime then
> what will be
> the credibility of these messages? We will just ignore these messages
> when
> these issues you mention actually appears because we see them everytime
> on
> reboot or shutdown.

I would agree that if these messages are expected to be seen every
time, there's no way to fix them, and they're not indicative of any
problem then something should be done.  Seeing something printed at
"dev_error" level with an exclamation point (!) at the end makes me
feel like this is something that needs immediate action on my part.

If we really can't do better but feel that the messages need to be
there, at least make them dev_info and less scary like:

  arm-smmu 15000000.iommu: turning off; DMA should be quiesced before now

...that would still give you a hint in the logs that if you saw a DMA
transaction after the message that it was a bug but also wouldn't
sound scary to someone who wasn't seeing any other problems.

-Doug
