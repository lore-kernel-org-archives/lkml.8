Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF964C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7CB20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IVpjNOL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCRHRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:17:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33113 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:17:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id c20so19446471lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFq8ZCIAoaagUUYPh3q+Bqojfoi/xwpn0FlUttraLqI=;
        b=IVpjNOL5Ix1cmD5w7cJvqO9HeI0jMMLCs5x43kjK32vaDHJDkQg3Ps2+VED8E6pnMo
         vQQehV3QqvRm5t5UOADUXLnPAMdfbzgjVSc/U35xp326TM5ZVdrAetCot2PDNIP9NQeT
         iseclkPBcsG+qTzeAIVmcx8BUv3mEANZrqAqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFq8ZCIAoaagUUYPh3q+Bqojfoi/xwpn0FlUttraLqI=;
        b=hlvNA1cwzKm05pU76O0amlvhxOgZERzUAaRHwJw+mbCc2E1HMbl/qzIcrxniG0QFJh
         GKTxDK8PugD0+E+goOsJpTFyOzLXhHMTVZU4/NHVdchHsAtrOmbdDXsK0CCN2f4tYFa1
         TXyPf5CxgGukv+usWRUQ0afRHInL7p291P3MuklhtU/JiVQsMR2ymz4hJHx0uLNcqT+m
         z7uwXrhO9tdH5/hrHo0UmvhI/jIX1U4YOPSqc28dGg1wBDtA2Gjn3ishiHHVFNvJHgZS
         W8epHWF0amw1uXSEh25FZ/zdM02guk/MsUb9OL0risXCvMpvWuLPnObctIZtLJUkJoiC
         2ywA==
X-Gm-Message-State: ANhLgQ2DuCoaj6QQ1abW4Wqx8z6hOZTYBSi6n5rUPA4gS7Ak8dyJbukf
        yQqU7Gg1a/INbU92u72vhxhHUnyeNIthHDm/MEbXZA==
X-Google-Smtp-Source: ADFU+vu5gggcDXYHEq5zSBc/2H4ehIao1aUungq7csm6+Pd+Q1wu+AyOauZDrmi6cY/VbemIvWoVZs/r4FRuXkM3mhs=
X-Received: by 2002:ac2:482f:: with SMTP id 15mr2004539lft.111.1584515841161;
 Wed, 18 Mar 2020 00:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
 <20200317061522.12685-3-rayagonda.kokatanur@broadcom.com> <CAPcyv4j1BJStqSZvbNdjHs0RoSWWtk06ieQAXOUwJCjP8mqBLQ@mail.gmail.com>
In-Reply-To: <CAPcyv4j1BJStqSZvbNdjHs0RoSWWtk06ieQAXOUwJCjP8mqBLQ@mail.gmail.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Wed, 18 Mar 2020 12:47:09 +0530
Message-ID: <CAHO=5PE9SLg2O1fp5YUp0Z0sbNfKNiu5kGXBRtHmGyXRW5w3pg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] async_tx: fix possible negative array indexing
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Mar 16, 2020 at 11:16 PM Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com> wrote:
> >
> > Fix possible negative array index read in __2data_recov_5() function.
> >
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  crypto/async_tx/async_raid6_recov.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
> > index 33f2a8f8c9f4..9cd016cb2d09 100644
> > --- a/crypto/async_tx/async_raid6_recov.c
> > +++ b/crypto/async_tx/async_raid6_recov.c
> > @@ -206,7 +206,7 @@ __2data_recov_5(int disks, size_t bytes, int faila, int failb,
> >                 good_srcs++;
> >         }
> >
> > -       if (good_srcs > 1)
> > +       if ((good_srcs > 1) || (good < 0))
> >                 return NULL;
>
> Read the code again, I don't see how this can happen.

This case can happen and it is reported by coverity tool.
In the for loop , the condition "if (blocks[i] == NULL)" true all the
time then variable 'good' will be -1.
