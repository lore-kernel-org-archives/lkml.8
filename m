Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF982086A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bysO8gE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHVUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgHVUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:47:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230FC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:47:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d11so6809336ejt.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HQaixpV1W6ja8XORGv/OFO3Xqa6umvUnjXwcLD9RpM=;
        b=bysO8gE1mzCl5ZuDnGZNQ43PkG4IHOdcM9jmDetVVRwg1JQGgOVCRZBuksRWj8ZbqF
         J9+1Ipg3Bg7Si2dhiY6kVrA+iKRSdod9kxh1syhQqWBsIMCE+zrVgqpMxSvWUMHLfZj2
         qoobEYKpdDQhpK1UrUA4KJuq7Lpi9o7Nxg+VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HQaixpV1W6ja8XORGv/OFO3Xqa6umvUnjXwcLD9RpM=;
        b=mBX28x8HLXDpfNMHvywo6ZiG+f45Z316UPU576llGnt/ozScRu7htKrPmn3L4UqxhH
         i2wHrHzBR53gAZf/oTgo7Rqwtgc9mUIFOZSZe3EzBxococLEnh2veBy03vX5MVH70wj+
         lQUXPdAQofOaqd6nMrjERpJAdI7CD3PhTAWGDw3u+9D4r86NVP4MDTPazvJT5g5RvMy6
         bnd78vvEQ6f1uVckTItVvZ4nUD5PSWLMPovpwdUw/UlgbclL1SKl6esP4wWhu7HcuFAS
         LYNA9Y6xX3ZtqPia3NiFt5lRO9MqqM/DSFrSUkFmk4MKvoYQrdD+ikkgbkib6zbCitHh
         RfHg==
X-Gm-Message-State: AOAM5312wxVSI3LYET4Gw5cVU/a46wJMP5x5thRYHpx5dxvpLouKBJjt
        IQMEqZu8XWqNvsA4IAkC/yRUxdMHoiH17jbbxSJzQg==
X-Google-Smtp-Source: ABdhPJxK3qsIb4xjVVCe1jnha9CuWFheFQV5viEirtZQ84VEqjFNAYdGEhKGtDinwelRxtoaW3YlDOFaCDVgWqhc8Cw=
X-Received: by 2002:a17:906:d92:: with SMTP id m18mr9063590eji.428.1598129250618;
 Sat, 22 Aug 2020 13:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165221.32267-1-mmayer@broadcom.com> <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
 <20200822164619.GA24669@kozik-lap> <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
 <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
In-Reply-To: <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Sat, 22 Aug 2020 13:47:19 -0700
Message-ID: <CAGt4E5td_4YhL2y0Z6iS+eGv666TKrkKnEgM8vmTwNjNYMz6Dg@mail.gmail.com>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 at 13:21, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 8/22/2020 1:14 PM, Markus Mayer wrote:
> > On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
> >>> On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>>
> >>>> On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> >>>>> We would overrun the error_text array if we hit a TIMEOUT condition,
> >>>>> because we were using the error code "ETIMEDOUT" (which is 110) as an
> >>>>> array index.
> >>>>>
> >>>>> We fix the problem by correcting the array index and by providing a
> >>>>> function to retrieve error messages rather than accessing the array
> >>>>> directly. The function includes a bounds check that prevents the array
> >>>>> from being overrun.
> >>>>>
> >>>>> This patch was prepared in response to
> >>>>>      https://lkml.org/lkml/2020/8/18/505.
> >>>>>
> >>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >>>>
> >>>> Your Signed-off-by does not match From field. Please run
> >>>> scripts/checkpatch on every patch you send.
> >>>>
> >>>> I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> >>>> address.
> >>>
> >>> No. I have always been using mmayer@broadcom.com since it is shorter.
> >>> That's also what's in the MAINTAINERS file. Please change it back. I
> >>> accidentally used the long form for one of my e-mail replies which is
> >>> where the confusion must have originated.
> >>
> >> I'll drop the patch then. You need to resend with SoB matching email.
> >
> > Oh, I am starting to see what's happening here. This is new and
> > apparently due to some changes with the mail server setup on our end.
> >
> > I have this in my patch file:
> >
> > $ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
> >  From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
> > From: Markus Mayer <mmayer@broadcom.com>
> > Date: Fri, 21 Aug 2020 08:56:52 -0700
> >
> > Sending patches like this used to work. Clearly our SMTP server has
> > now taken it upon itself to rewrite the sender e-mail address. I
> > wasn't expecting that. Let me look into it. Sorry for the hassle. It
> > was not intentional.
>
> Yes, if you used to use the SMTP relay server which did not require
> authentication for internal hosts, and now you use smtp.gmail.com with
> your broadcom.com username, the SMTP server will rewrite the From: to
> match the username used to authenticate with the server.

Actually, it was the other way around. Connecting to smtp.gmail.com
does allow the "From:" header to be customized. The envelope sender,
i.e. the "From " line at the very beginning of the e-mail, might still
get rewritten, but that's okay since the "From:" header is left alone.
The internal SMTP server, however, which does not require
authentication, unexpectedly rewrites the "From:" header in the middle
of the e-mail header.

Got it set up now in a way that should work. At least it did in my
test. I'll send out v3 of the patch momentarily, and then we'll know
for sure.

Regards,
-Markus
