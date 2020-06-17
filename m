Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EF5206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRikB7fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFQLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:42:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C5DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:42:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k15so1336986otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKWtFIYfKFOwpbzZCQAzRyePUOEgW5s9rDZzhxjhDfs=;
        b=HRikB7fKxjKifECDakHvZhGhna07GnY3Vo+B+n4UD42jyVrmgGAEnpY33CQV88Z62X
         0udVcVTTcJXD3fta2FIoFmWcBlryJUq8A18kNMdYsAS3qdCPCVuXQO1FbijWHQJik08d
         24RVBLLRVqJb+fwxyGxVmgQ5LRItdP4RDe5Qm0dW/6slkJAONs7YsU9wt5By3TyykOCW
         jEw5GpBE73V4yFwVtHYdQiZLl39g4lYRBcNYc9p6qovoZe4KINyHYBMt1UwESvsCNtKL
         +H7LYzsmp7NiURlkLx8i59a/vNsC2shRxVOCuoNlRhKHPzoYaMld8PK+FiIwYvqyGUF7
         NM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKWtFIYfKFOwpbzZCQAzRyePUOEgW5s9rDZzhxjhDfs=;
        b=b3k1i9d33/vBgB5hJI/L1Vk6ymMcQLcSz9qlML/6St2CbioFtcSfNzo2NzPPdpLM2I
         WGzV7GF5B629csCrFNoiM4ZGAFaYwdz5KOyhcRBgMUJmhwCugJhBDXq0ySixANHctJuC
         A4S3nB0sPVrzQACkBcyk3Sj7lOizG6yZaHfG3hlU5S01bOcUxMkAuhB8tg78wc63QB47
         EqPmCWMA823DbZazpqPE/MDplSYmYWw79zll1b04DbTOHJ4BavtzXMc9MHlk6p2sadhM
         Es7PGL95Vzjfpm2NVn+9Oy8pkw111gewWcVoVw2bOjAYyRmfYpiJp60pK298h2I0RMXd
         RfQA==
X-Gm-Message-State: AOAM531qUKiECZlc9OdIKtaxNqSxr4rJwRXQh5UGBt6nlKA/MsnlETsq
        AgC2HgVXh+bPX2iDTv4YADJZeVwec2fhM30VQBee9w==
X-Google-Smtp-Source: ABdhPJyEbofVby0G8kGXR+vvfNhB4AvAOrnZfTfD8U151zYCvlIkScVjZcclzby9MNu9D+uRKBmz+cSkXmck4VW5ams=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr5361623otq.371.1592394167036;
 Wed, 17 Jun 2020 04:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-5-sumit.semwal@linaro.org> <20200602113241.GE5684@sirena.org.uk>
 <CAO_48GGgNUGosN2PiL=U5JkR3Bh5wNK3N4xYYML1UwmdfDPRww@mail.gmail.com> <20200602122554.GG5684@sirena.org.uk>
In-Reply-To: <20200602122554.GG5684@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 17 Jun 2020 17:12:35 +0530
Message-ID: <CAO_48GFwEHBGmz0QvN+pXFSyHC9+7=0aoJLHF4uupGSx2TcSvA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] regulator: qcom: Add labibb driver
To:     Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        Nisha Kumari <nishakumari@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, 2 Jun 2020 at 17:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 05:40:45PM +0530, Sumit Semwal wrote:
> > On Tue, 2 Jun 2020 at 17:02, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, Jun 02, 2020 at 03:39:23PM +0530, Sumit Semwal wrote:
>
> > > This should be a get_status() callback...
>
> > From my (limited) understanding of downstream code, it seemed like for
> > this set of regulators, the 'enabled' check is done via the
> > 'REG_LABIBB_STATUS1 reg; for some reason, not via the same enable_reg
> > / enable_mask ones.  That's why I used it as is_enabled() callback.
> > I will try and check with the QC folks to clarify this point about
> > their hardware.
>
> The way this is functioning at the minute the downstream code is just
> buggy.

Apologies for the delay in responding - I pinged the QC folks, and was
waiting for their reply but haven't got any response so far.

I tried your suggestion to use the ENABLE_CTL register for checking if
the regulator is actually enabled. In my limited testing on the Poco,
it seems like the STATUS1 register updates faster than the ENABLE_CTL
register, so on the device, I see noticeable lag when I use ENABLE_CTL
for is_enabled() check. [This is especially true for the IBB, which
takes longer to become usable than the LAB regulator.]

I understand from a pure regulators' correctness point of view,
ENABLE_CTL should be the one checked there, so I can change the patch
as you suggested, but there seems to be some performance penalty
there.

>
> > > ...is_enabled() should just be regulator_is_enabled_regmap() and these
> > > functions should just be removed entirely, you can use the regmap
> > > operations directly as the ops without the wrapper.
>
> > The 2 wrappers are a precursor to the next patch, where we keep track
> > of regulator's enable status to check during SC handling.
>
> Add the functions when they're useful, not before.  TBH if the register
> is write only you're probably better off adding a register cache.

Agreed, I will remove the wrappers from here, using the regmap
functions, and add the wrappers with the SC handling patch.
>
> > > > +     match = of_match_device(qcom_labibb_match, &pdev->dev);
> > > > +     if (!match)
> > > > +             return -ENODEV;
> > > > +
> > > > +     for (reg_data = match->data; reg_data->name; reg_data++) {
> > > > +             child = of_get_child_by_name(pdev->dev.of_node, reg_data->name);
> > > > +
> > > > +             if (WARN_ON(child == NULL))
> > > > +                     return -EINVAL;
> > >
> > > This feels like the DT bindings are confused - why do we need to search
> > > like this?
>
> > The WARN_ON? This was suggested by Bjorn to catch the case where the
> > DT binding for a PMIC instantiates only one of the regulators.
>
> No, this whole loop - why this whole match and get child stuff?
This loop mechanism is what I saw in the other qcom regulators
upstream, so thought it was an acceptable way.
For the two children nodes, do you recommend another mechanism to get
and validate both nodes?

Best,
Sumit.
