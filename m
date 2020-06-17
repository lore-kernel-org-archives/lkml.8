Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1947C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E89320DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL6Rvzwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFQL50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgFQL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:57:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7CC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:57:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so1521703oii.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TAhtBD0JZB3OeqVg4Sg/t5NA/0YJ+SzdMDki1DJcps=;
        b=hL6Rvzwasvh8JclW23b05+UHwnW8NXnEYh6K8YFuMwRssrzpSI8d711InpIaF8o3V9
         Ln6kuk4PFZ7ujW3Nezxl3SkzV3Z1c0GLtwSQSDZxWbHp3SIL/haBQ4IKFpicUq78HWUV
         MSu7BfIbtxs/18Dtx/4UpOw7o6ttX/Sr3TRkZHw7zsYtoPsoRuxy6WfZoBDDOtX5Gakg
         KcO8q5HlWW2YWC43IFOx+6+Brv9my73D60JX0YxYB0m0CnWTGNLAyJFp5i/GqMYbDjo4
         iWQc249KmUImK3L5VpIScQn+PzrRKnK4RkuKeo95onNnXtUVJmAQmSmr4umhAisyDpo2
         O4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TAhtBD0JZB3OeqVg4Sg/t5NA/0YJ+SzdMDki1DJcps=;
        b=QcP1rJNPrai5lDdzgNQ+Ncy3nUA1bTJ1P2kDHjM+sX9Iee/Twzst66xKp4US2hsfhF
         TQJNRxRM8lDt0SK1EcsHiNIlGXHykx/QbaB7R3kkQG+BX/qml++hNO5vZBtC3PV8+bYl
         5dnIAkLqb8dXRAD7fnEWD5/FjpEZ9Stjrx5tKiPj42qDBfVlaS5/2noQjw40Gwva7zSZ
         S5hmtARBgyQa4niWj3we1qIrruNK3Ag9+1tNebatcxaGasZ2XBAp7v07zhbAQVP0fVo/
         KxMz+RdVaxNORC6uy+5U6AFeyHvB3YAhn9tnZu9YwjkwsZJtq2pLgeyU+T/d41O+8VRd
         3dwA==
X-Gm-Message-State: AOAM533WIOF7eYqPk4FxXzySRjGlU7+lJShNsEc+i/Ev4KYlyDib0O9S
        Km3s1ExgEaYdOO4P3oh3jkbIiTeNjZcZEq47eMsrzw==
X-Google-Smtp-Source: ABdhPJyi4phMmweTWv3U8Zb8tbN3nMTf9bjdjul0rHspdSGtdhbOiqjUK3aUeI32cQLZPgZ2xIOZMMLiXTJn4sjP+00=
X-Received: by 2002:aca:c391:: with SMTP id t139mr7342114oif.166.1592395043660;
 Wed, 17 Jun 2020 04:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-5-sumit.semwal@linaro.org> <20200602113241.GE5684@sirena.org.uk>
 <CAO_48GGgNUGosN2PiL=U5JkR3Bh5wNK3N4xYYML1UwmdfDPRww@mail.gmail.com>
 <20200602122554.GG5684@sirena.org.uk> <CAO_48GFwEHBGmz0QvN+pXFSyHC9+7=0aoJLHF4uupGSx2TcSvA@mail.gmail.com>
 <20200617114721.GD4613@sirena.org.uk>
In-Reply-To: <20200617114721.GD4613@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 17 Jun 2020 17:27:12 +0530
Message-ID: <CAO_48GF9pKZCCof170TvB0ubOkecDzcGhtUUuY_Td78L1J338A@mail.gmail.com>
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

On Wed, 17 Jun 2020 at 17:17, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 17, 2020 at 05:12:35PM +0530, Sumit Semwal wrote:
>
> > I understand from a pure regulators' correctness point of view,
> > ENABLE_CTL should be the one checked there, so I can change the patch
> > as you suggested, but there seems to be some performance penalty
> > there.
>
> I thought the goal was to have the performance penalty to ensure that
> the regulator had actually started?
IMHO, with the poll_enabled_time mechanism added, we would not need to
wait for the full enabled_time time for the regulator to get enabled,
but we could poll (and potentially know earlier) if the regulator is
enabled.
The performance penalty I was talking, is about how should we check if
the regulator is really enabled or not - via reading the STATUS1
register, which seems to tell the status a bit faster, or via reading
the ENABLE_CTL register which we also use to enable/disable the
regulator, but which seems to be slower in updating the status.

>
> > > > The WARN_ON? This was suggested by Bjorn to catch the case where the
> > > > DT binding for a PMIC instantiates only one of the regulators.
>
> > > No, this whole loop - why this whole match and get child stuff?
>
> > This loop mechanism is what I saw in the other qcom regulators
> > upstream, so thought it was an acceptable way.
> > For the two children nodes, do you recommend another mechanism to get
> > and validate both nodes?
>
> I don't understand what you mean by "two children nodes" here?
The two 'lab' and 'ibb' regulator nodes that are part of the labibb node.

Best,
Sumit.
