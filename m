Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E272173E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw9i6jQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHET3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgHET31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:29:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540FC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:29:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so32849667ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8b7ZxzAJUuZyOmA9rjQfMMfXWA2lApFCOKA99bteGU=;
        b=Bw9i6jQewHTzmB9Yq437oKHeGjjYk3eso3TEcDin+YMuMrEwUmE4qW+bAiecA8zUNM
         ymvphP49ZJbxIIi24GX7C7ww33liFUcm7Eotku3gMkceswdWwiQBt2ilH9uvE5Fm9eTz
         eP6vQ1paIgiNfwyUvh9QqViYzHIn416iQShdYnf2UgiQfEvT4VtYrbGA649VuLIs8846
         3VPjY6xeGv5YZIsi4uOWFCSkb18bMKfxNxBn32YSuE/+QvEnL6P7hi3Pve6SAw8TFF+B
         w6zzsQlfC3fZn/XLgtWcMl3bG8QRc3hlZ28V2fmb3T8A4IFEHEehjjbCk92xHzzxk8FM
         W2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8b7ZxzAJUuZyOmA9rjQfMMfXWA2lApFCOKA99bteGU=;
        b=HuEgQudBt0WplkH4ug5xIT2guS8XQj1TILpXlOZLZQpsZFvdvw+A8pezFTn5DlqS/s
         0ycly8KEWfAt6dSJ+1Bjd0BIViWqiVZShXnGKSEOLE01eqdkmq/Zuz9tcQszfTxet+GP
         +v1d+lRVsTcErZSpbCBYJOccIMR2N7OA9sf+uJAhp+PaSVtX/kYS7G+cTFrblen905Qg
         yXb9NcGKkk49IgvgAZwYq44+9cPc+qjKSycZ9GyKyIys7cAqXLvJOKpV2FiS9+YTHjFB
         bQjMNXQ4+gnmIEMJftoQ4RAE9DE4lj1xZ+/UifgeBULyo6ojMK1frAXa1D+d1x4xsU2V
         9umg==
X-Gm-Message-State: AOAM533eTPrvW3B5wKg50x1iOaq1TjwCO/Tc2aOIQVNoGt359hPJ9lJg
        J5Bq4h+UPew6IXRHozX19RkJOGMDFwO0qNOjCOI=
X-Google-Smtp-Source: ABdhPJz60WbPGbMHfR3RQgL76FbUYqmp10TXL0TN8L7qY7H7tnq96j0rDwz0F6U5yshkUojybqfHN7TqxU0c5GeRifk=
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr873983eji.52.1596655765954;
 Wed, 05 Aug 2020 12:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug> <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
In-Reply-To: <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Wed, 5 Aug 2020 21:28:50 +0200
Message-ID: <CAMS8qEVzCtxrH-K4U4_TeHi3RXDQ7UeGo+sVnB-HPS0Y+mju-w@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the kind words, I really appreciate it.

>My impression is that the newly added phones are still fairly rudimentary,
>but some others that were added in the past releases have gotten
>further. I don't know any details, but I've added Konrad to Cc, he can
>comment on his work.

Thanks for adding me. The Sony sdm630/6 phones are shaping up really
well, but most of the work is not upstreamed yet mainly due to SMMU
maintainers not liking Qualcomm code and looking for cleaner
solutions. As time progresses, more things will see the light of the
upstream. The current-ish progress can be seen on my github [1]. And
much more is yet to come.

Regarding msm8992/4, there is a need for the 20nm DSI PHY driver. It
exists for every other gen of qcom SoCs since 2013, but due to low
interest in these platforms, this specific one never got there. I
tried emailing the person who wrote most of the present ones, but
gmail told me the mail didn't exist :shrug:.

>> Should we have some kind of linux-phones mailing list? There is quite a lot of
>> stuff common in phones.

>PostmarketOS is probably the right place to look for this.

First of all: postmarketOS, not PostmarketOS :P

I would actually say that's incorrect. With the release of the
PinePhone and the Librem 5, the Linux mobile community has entered its
heyday and plenty mobile-oriented distributions have arisen (for
example Mobian, Manjaro ARM, Pure OS-ARM etc.) and some have gotten
more attention than before (think Ubuntu Touch, Maemo Leste). pmOS is
only one of many.

The current thing to do is every distro maintains their own kernel (or
over 100 like in pmOS, which is terrible for the poor CI :/) and only
a small percentage of patches end up being upstreamed for various
reasons (clean-ness of the code, will of the maintainers, time
constraints..). As time goes, we're gonna see more stuff being added.

[1] https://github.com/konradybcio/linux/commits/58ninges_labs

Konrad
