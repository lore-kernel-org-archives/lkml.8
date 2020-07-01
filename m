Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E60206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgugAnlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgGAM2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgGAM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:28:20 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8390C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:28:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id di5so5929292qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x+BeeH1jYGXK8cfygVL8IQfqxHcN06ti3g1VzLYimNQ=;
        b=QgugAnlCHHjSSnVHrk6C4jhX65XJ/7MQonaAL3yBlfy9sFckvSCtEmlzDg42xrHZgZ
         6OZ49jhC1lJvGSGQvdT4Zf+zQGdKMCxtjoDLXF5uXAFpkhfJNLNizR+A2F9GFSVHmWC5
         HpLayED7ARa27hFj9rxrElzJiztB7uR7leDEx9rH2Kv0SKQ6jHTK6EEBgsqre6u/6xHK
         2Un/L9Ka7eEpoCex7uH4sX5ZyKaO0lH5iIasFgZ0DjobSHBgKdsn0HNopGAssHDX3HbO
         9C/syItZgzXUcmC4m7sjUwrpPZTSBhEHZ05cUVFh051PgmbOSxx8KomB9XjyiHdEoOzV
         LGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x+BeeH1jYGXK8cfygVL8IQfqxHcN06ti3g1VzLYimNQ=;
        b=twPdig3fAXPcHsKXZ+wL8Dw72o9w8NxFQwf/Bp2BY7gSj56wXMGPC1Ng/E6cyIowZR
         GiEvKozV6+tJQvRTi0U4iWIjTFf3Q07usK8lmcTLbG8soDkqzaxaWcrn1Lc52pTRY3Iu
         kgceiJfNOkKt8Hd58uaBhln91gvVObJybi6iplEW/F3+nQkXP+fIVP/2e+Rq+XQVyM0Z
         ySLNrJPHvSvWyW5xJyRNHaOi8uzB5bTxNQhv2HmO3LaYBylx34cE/p7pFv2uF4ZTkt42
         aK4jIKM+zEnkia3+w4k9nNAxtbeRyE/uNxfdu1jzLybcgDn51zO0HbK+MuixAqlPM56K
         BK5w==
X-Gm-Message-State: AOAM530fToM83rA2C7RY/+QOCrlmxIhD8t296lMev1osQkaJ2iIU4IPd
        CJEopZtBYQX+/3QEw/gEn55Zbs307S628cLuxzQQewsbVeIFaA==
X-Google-Smtp-Source: ABdhPJxafBqxFuTp3lrqQFMS1kQlPvnsv0h4pz7C0t6sMAGfTYC64uqViDP8Hk1AjSeISPVrz86pmPyID+llIyFpPz0=
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr18474750qvc.15.1593606499816;
 Wed, 01 Jul 2020 05:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200701105824.GB2098169@kroah.com> <CAAvDm6YjbvEq9Y3wG-Lx_-hJtQ_LW28j97BOqvrewYXnEAS2dg@mail.gmail.com>
In-Reply-To: <CAAvDm6YjbvEq9Y3wG-Lx_-hJtQ_LW28j97BOqvrewYXnEAS2dg@mail.gmail.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Wed, 1 Jul 2020 20:28:07 +0800
Message-ID: <CAAvDm6Y17WijBAWQ8z+zcxYJP6Ek7JZ6bXg6fOpinSVKpMTeyA@mail.gmail.com>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Greg KH <greg@kroah.com>
Cc:     Kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gred
Thank you for taking the time to respond to me.

>> Would it do harm to the hardware?
> It might, try it and see :)
It's really bad news.


=E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <sunshilong369@gmail.com> =E4=BA=8E2=
020=E5=B9=B47=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:24=
=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, Gred
> Thank you for taking the time to respond to me.
> >> Would it do harm to the hardware?
> > It might, try it and see :)
> It's really bad news.
