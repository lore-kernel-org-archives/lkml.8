Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DBB221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRlSSDXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHFUJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:09:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 13:09:44 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q9so21512206oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baDhumlHPR4KZDRGWPG+BY/sJ0EvMqkXlvyotkwDgAY=;
        b=oRlSSDXKpr1tuboVg6DmbxsKw9ibJRM+lTlvt3g9XYBG6V4FB5yiSSRxRZSIfbTHCT
         Zqa8a9C97l16PvPM4kmKE4jUksPG2eMjnOMlK5WGwgYmDfJHqeKKoe9WTdh6Jl5Mh9gt
         pN8LMEaY3eAwOAKL2IMiNRijk1Trjy3VriS18vRk3LUhAcqDanmWafLEtfRDU1PYBMt5
         sK6yJepm7+139uyf95d1+BQgpqkGDsskaMnbOFLWLnV4XXIhZnyAJK6OgI0SmNwhSiLh
         Vg6/8PNotmLbZJjJEkM+lvIRlzLv3rYk1kQ+2BanfvU1/R8j4p+F3lCCzLg670bQdKDP
         uzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baDhumlHPR4KZDRGWPG+BY/sJ0EvMqkXlvyotkwDgAY=;
        b=hHCYtKPBQmMVe/DtUddtA38HHViyLm5LQOYid+sWL1r6If+vWuircfCm5X+t6sxmF0
         +EjkSarJsPzYKDLYCwbYH8hTRze6dkRiBgTCL78ewPN2OJAQTMXz+BgxxO3GDzYTdMME
         Istnbys5jXn9tsHzGBFiwM6sZ/zgO7dDHKatojpms7+78fuo8T89ZrNb2oKbiMgTAYJ/
         pPQePsZfR7qsJhi30VW46mftepGc9TgJhZ9ZaZNs8a8XT106OtQoyCi1c415c5jFNcvT
         fBu8PhM0kkFv2pQL5heai+m7+xFq81FbY5PQokPkLmSkayotsg2bSXbDrbUTg2nym1wQ
         3D8Q==
X-Gm-Message-State: AOAM532k35O4xYLXf1NrSQCF2Y7RCPPlI2Nln+CjrFdlv6BrEC3hlmx6
        NTl3Narzo1aYPRP7j+0A0izviPMm6mG6ryJ19Toz0g==
X-Google-Smtp-Source: ABdhPJyouhMEou4EoV57JwviEafrLG3PdiaOsgmtRljCsjehbL6Jk4wnfPp7i3y+0Gj/s8dM11i6GVD2c2aM62B2ER8=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr2715675otq.221.1596744584103;
 Thu, 06 Aug 2020 13:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com> <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <CALAqxLUz6GTT96nO9igiWVwyaRs_xbO+=mySLm4BKX6-Uh90ZA@mail.gmail.com>
 <5e6124390b9e3e7f4d6f6decbdb669ca@kernel.org> <CAGETcx89BRdSP6FKjDPU0zapt0ET9_PUr6bjZb9EA-jYn0maFw@mail.gmail.com>
 <4d79a3e9c8c24f8adb6f7ade97d5a9c6@kernel.org>
In-Reply-To: <4d79a3e9c8c24f8adb6f7ade97d5a9c6@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 6 Aug 2020 13:09:32 -0700
Message-ID: <CALAqxLUhit4Zz27Uce7gPGVRmkDJ_2UTC2fyk8NkOfgqR8diHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
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

On Thu, Aug 6, 2020 at 12:59 PM Marc Zyngier <maz@kernel.org> wrote:
> OK, thanks for confirming. It would have been good if these patches
> had seen a bit more testing.

Yes, again, my apologies for that!

> > I'm assuming you'll put up the patch yourself. Please let me know if
> > you need me to send one.
>
> I have queued this [1] in -next.
>
> It'd be good if someone (John?) could give a Tested-by.

Just validated. Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for the quick fix!
-john
