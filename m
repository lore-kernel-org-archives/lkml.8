Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58289206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6sCkftY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3AbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:31:06 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44810 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3AbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:31:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id y184so531149vkc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPkGA3GK3blVdQi8+NIYhn2wAG+9S/XJZPz8vvp4cLo=;
        b=M6sCkftYdw+yxCZolQLugqQz0RovdHNk6PaR2tvafsXWi2mt6BF6Ldsv8+gYeZxs4Y
         T2tWoq+ubinXa1WQmLOIo4QqMm2Q2BQMVBcF/P7CTCZTe0tWMlAeT7Guo+gsC2Doi5Vb
         boHynzCL0K0eWTW5QtPEO9/8SJrt4pkwf46fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPkGA3GK3blVdQi8+NIYhn2wAG+9S/XJZPz8vvp4cLo=;
        b=Ibk1CrD6lpJirQvHVIrhj24v7sGJ2T9waFruIe44nu4uVexzTYKCzdfVu80V0crIs/
         s3aH881KaY+4ggstXadV+I70VvEmU2AyFi/HnzpPE7uPVxkUsVKkMxvHPwfPgZOui7Qp
         iM/kJN14Wa1sgSWpXh20G/212sKv07ksQhD+ujpOFxuSHkNw0mbaGQBSfqQZN8/HfzG/
         uVfqZ+NSsiXVKxxOCAZ2WxnbVwW17/WFUx7cLWfOfhrX2YwzQsnMiXDmq1RxvPQ4Ym7S
         TIrB+XXuTqq/5p9hDhkLM1RGR71XTt5okILGS4CgSKci+p99YcrwrqVXmw0eRCaHTbj/
         jA0A==
X-Gm-Message-State: APjAAAVLTozuqihU7DCgFPMAu6KaiRPczuwRvugXPtf698EHXlst8E0E
        9tWwC6s3Jr7Ti8qhIFPqPh4L1u4/s6c=
X-Google-Smtp-Source: APXvYqw8oLESthY+ErK2RwF9V8vLb3Yx0ByUQb0wTsP53Kh+VCgsoFD0+8gr4VjXYpfeTrO3gXtnZA==
X-Received: by 2002:a1f:28cd:: with SMTP id o196mr1260911vko.87.1580344264528;
        Wed, 29 Jan 2020 16:31:04 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id z15sm952099vsz.27.2020.01.29.16.31.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 16:31:04 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id c129so539934vkh.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 16:31:03 -0800 (PST)
X-Received: by 2002:a1f:c686:: with SMTP id w128mr1285411vkf.34.1580343865022;
 Wed, 29 Jan 2020 16:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20200129132313.1.I4452dc951d7556ede422835268742b25a18b356b@changeid>
 <CAL_JsqJk1NZSDAXgqc-CS9a1UCmNYPhC-LwjPUZaX2oK=EtHzQ@mail.gmail.com>
 <CAD=FV=XLq4-EdsuKnDjuc3-6P3i6o-tV5MJbdFbvAscF_ouOpg@mail.gmail.com> <CAL_JsqLVaJMidm2QcpmxXeT+Q+uU8esm1shdRs3BVoeRYqhJng@mail.gmail.com>
In-Reply-To: <CAL_JsqLVaJMidm2QcpmxXeT+Q+uU8esm1shdRs3BVoeRYqhJng@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Jan 2020 16:24:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uv-td=PhCSZNsjBB-cQB=vJKLbw_BLbM3B1ORRzuTB5A@mail.gmail.com>
Message-ID: <CAD=FV=Uv-td=PhCSZNsjBB-cQB=vJKLbw_BLbM3B1ORRzuTB5A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clk: qcom: Fix self-validation, split, and
 clean cruft
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>, sivaprak@codeaurora.org,
        anusharao@codeaurora.org, Sricharan <sricharan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 29, 2020 at 3:50 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jan 29, 2020 at 5:26 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 29, 2020 at 2:01 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Wed, Jan 29, 2020 at 3:23 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > The 'qcom,gcc.yaml' file failed self-validation (dt_binding_check)
> > > > because it required a property to be either (3 entries big),
> > > > (3 entries big), or (7 entries big), but not more than one of those
> > > > things.  That didn't make a ton of sense.
> > > >
> > > > This patch splits all of the exceptional device trees (AKA those that
> > > > would have needed if/then/else rules) from qcom,gcc.yaml.  It also
> > > > cleans up some cruft found while doing that.
> > > >
> > > > After this lands, this worked for me atop clk-next:
> > > >   for f in \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml \
> > > >     Documentation/devicetree/bindings/clock/qcom,gcc.yaml; do \
> > > >       ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=$f; \
> > > >       ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=$f; \
> > > >   done
> > >
> > > Note that using DT_SCHEMA_FILES may hide some errors in examples as
> > > all other schemas (including the core ones) are not used for
> > > validation. So just 'make dt_binding_check' needs to pass (ignoring
> > > any other unrelated errors as it breaks frequently). Supposedly a
> > > patch is coming explaining this in the documentation.
> >
> > That seems like it's going to be a huge pain going forward, but OK.
>
> Use of DT_SCHEMA_FILES hiding problems or having to run 'make
> dt_binding_check' on everything?

Having to run 'make dt_binding_check' on everything.  I guess maybe if
the tree stays clean it won't be too bad and it wasn't too bad against
the current linux-next, but I can imagine that every time I want to
run this I'll run into a pile of warnings / errors in other people's
files.  Then I need to figure out what to ignore / workaround.  If
something fails badly (like intel-gw-pcie.yaml) I'll have to realize
that I should just delete that file to get the rest of the run to
report errors that are relevant to me.

This'll probably be worse because most maintainer trees are based on
"-rc1" and at least in the past I've found that "-rc1" tends to have
lots of problems.  Each maintainer then fixes the problems relative to
their own subsystem, but it's not a wonderful thing to rely on.


> I could probably rework things such that you can check a single
> binding example against all schema, but dtbs still get validated by
> just a single schema.

This would be helpful.  ...or some way to easily make really bad
failures non-fatal.  Then I can maybe just diff the results before my
patch and after and that'll give me a hint of what I've fixed / made
worse.


> Probably is. There are cases where a new schema breaks another file's
> example. If someone has a gcc node in another example for example.

At this point I'm going to say that we're better off than we were, but
I'll try to keep this in mind for future patches.


-Doug
