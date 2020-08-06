Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ABCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85E520855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ilj501oW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFVRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:17:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:17:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so21322pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV8wb+RsdeHYLL81ZzFkJklCb773PCylfjZoQQTqqHk=;
        b=Ilj501oWJ1SJEEkOu4H0cRl65mw/mGy5jAcbhftwByDGT6m9P1BaJYr4Q3HXbt386t
         X9spmjep6n/w4vk/sm6rcjF0qtYeMwfs49DmGEDOc19jhubsDg+YAI3FVehBsyLWyr07
         bwf5KfOPc9u+iWiWVHMN20Wg/JCtF7pcoZyOB2UeyGXB0/cdURoDO9Xz56HzILfTGhyC
         ez7HMsHEBfsP3izaeTIP+EKvOA0SQbSsrDFjOrGYLmUznUk8QewWRxVNfzV8p0CfwBfF
         zdamkXFxvcJ93mPrSNLxZgA7L7kURrj7ehHzrgqQzx1eSLuylA6FmP/iMtJcclVQAsYm
         E/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV8wb+RsdeHYLL81ZzFkJklCb773PCylfjZoQQTqqHk=;
        b=OgADZc8MhPxo7tB9l5VJgpbfAYkjyPM+NIVPGBY9BE6k/HmV2BwQOez7n1ghLs5qte
         kF3JUdh2fsMmARAIBtHDF1IY48uEJmE3o90h+BkqeYR33RPzzuZn44v8R7tQLUeoO8li
         2e/fwKC503ZpsD+2FvoFzSfmv/R0o79RyB3xzHKoD6ebkdGsMKOVrlRnUzoRzwEQrpxM
         fmH5I7+cWoy6TU56pbwQbQFg7qOPpu4xRaoNMjsNYuS5AR7CoXpeSthgIAlXTOrNm1po
         W45/JZrukt/e7i+bXXEWEAbMJ+ueJZSeYHhnGHO9bRqhZhZ6zbOWgVf63Ben286oxAuc
         Qd0w==
X-Gm-Message-State: AOAM533u88x33a7XmGGTQ2ar/lp71gUwCcfWgzGElzy3jY7AzBxtguOw
        b+633Bj7Dm28JF9sam1/VmDGVsJmAmOr1Szv1FmSXw==
X-Google-Smtp-Source: ABdhPJwxa5hoV+G+t7Ugq7LuOXigLOdS0GIeXL4QAEqUmFx9J9SHj9yeMKBtNaXsYZy3Ec8R9vvh0bo0MJfkC9L0ilY=
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr9728271plb.21.1596748629518;
 Thu, 06 Aug 2020 14:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com> <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <CALAqxLUz6GTT96nO9igiWVwyaRs_xbO+=mySLm4BKX6-Uh90ZA@mail.gmail.com>
 <5e6124390b9e3e7f4d6f6decbdb669ca@kernel.org> <CAGETcx89BRdSP6FKjDPU0zapt0ET9_PUr6bjZb9EA-jYn0maFw@mail.gmail.com>
 <4d79a3e9c8c24f8adb6f7ade97d5a9c6@kernel.org> <CALAqxLUhit4Zz27Uce7gPGVRmkDJ_2UTC2fyk8NkOfgqR8diHQ@mail.gmail.com>
 <c5e73672a123ee6a920bdd0c3d6023c4@kernel.org>
In-Reply-To: <c5e73672a123ee6a920bdd0c3d6023c4@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 6 Aug 2020 14:16:33 -0700
Message-ID: <CAGETcx90=BDUE5Mr8xNBBOunp2zp=ApkUdJZCVTNEkOTs38iyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Steev Klimaszewski <steev@kali.org>,
        Nial Peters <uceenpe@ucl.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:31 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-06 21:09, John Stultz wrote:
> > On Thu, Aug 6, 2020 at 12:59 PM Marc Zyngier <maz@kernel.org> wrote:
> >> OK, thanks for confirming. It would have been good if these patches
> >> had seen a bit more testing.
> >
> > Yes, again, my apologies for that!
>
> I would say this should be the job of the patch author, before
> anyone else. Yes, silly bugs happen. In this occurrence, it
> could have been avoided by just boot-testing it, though.

Sorry about this. I don't have a DB 845c to test this one. I generally
work with John or try and backport changes to devices I have that are
running older 4.xx kernels. This one seemed harmless/simple enough
that I didn't think I needed to go through all that. But obviously the
few times you don't test is when things fail :-(

-Saravana
