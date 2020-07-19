Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197ADC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9679208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYKhSqvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGSWr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:47:56 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8727C0619D2;
        Sun, 19 Jul 2020 15:47:55 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so11708194ilt.8;
        Sun, 19 Jul 2020 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=752GIqWb7TeflmfvTlvXG4lE85m80lDi3OdyHGBoGE4=;
        b=SYKhSqvg0eRjLfsoeBoocA3N8uY4CC49g8HYKV4q1YUiDsWzl5zJ7I011lkNHPOvb2
         WJXrXr7Nu+vSqqNGStE1BrRAlT6/pRpdtRbk3/8pM5CalsGjmJdtwRQj/1IASfmxaFWK
         L7C65KMmIMFp8dUFFeW06R6FnhD3sQemF08kVNr2rxq/xsT5fTOsLOD4XTPkbLtZ4Obp
         pNAiTQ5HJHzL/+Qw5E1EpyMaXKt1cZ3IMCK8DdkGo8uenP0pXXIL9u0OZZVe85POo0Xf
         wuS3LWoBkDXLcE2w56JAOlu6jxOWK2rdeaLChOUEWPi+nk0GnVC5Lt1MZapCNcjkrIA8
         6flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=752GIqWb7TeflmfvTlvXG4lE85m80lDi3OdyHGBoGE4=;
        b=juswCXNC+se51HY+TwUKGu24hoWnJ4Du/vL/dp1ZTGGWqhyWXxpCPOIb7xXef1XvT6
         8cy5cySsAm88Pl25y7UAO8WglPwXw62pZS7XL35RMqqFg2/QyY9FcD7QKccKgsIjkQlI
         DHnoP18TWhwJWOiYiLv1Uh0uo3pb6IMLrwRwGGhVPbR4W0mqvxBstKZI7LINLHiT19ph
         LM9T9hV1NK/iq+uaHKs0G7KgqXPw5iiLYMN9rJPbdfdbWa8/Obud7NmjwGVstzTi6SQ9
         S5gBeDKOtJS+CQB7HXYAvJuSxsslCfFi1pszSjO3Qc6y7EMh9GP/GB3g4p5XlaxSRE3F
         edBA==
X-Gm-Message-State: AOAM5314Z/3fLI8fy8wKXR+pFN8t0BYZ4zlLOgg638rXP/8CPLSJ5JRz
        Cd0RcXMJ+XQuMHqoOr1MsoFHNs+xFTEOkjmjx7A=
X-Google-Smtp-Source: ABdhPJxQq5vcDCcmYHgb5SHeEoGyf/RBEQJNp1ljNaDlfoLHRjDkfUgM8yK5bYY1GVTkQEoYTf5yNC21RRfTGe3fHpw=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr20118496ild.212.1595198874273;
 Sun, 19 Jul 2020 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
 <000201d62835$7ddafe50$7990faf0$@samsung.com> <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
 <CANFS6bbandOzMxFk-VHbHR1FXqbVJSE_Dr3=miQSwwDcJO-v0A@mail.gmail.com> <CA+icZUUiOqP5=1i6QtorSbjsyaQRe1thwcp36qfTdDUnKKqmJA@mail.gmail.com>
In-Reply-To: <CA+icZUUiOqP5=1i6QtorSbjsyaQRe1thwcp36qfTdDUnKKqmJA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 20 Jul 2020 00:47:43 +0200
Message-ID: <CA+icZUV1AtKYt-K21mc4daQr4avA_PLs21LOxctWEP6r_cRhcw@mail.gmail.com>
Subject: Re: exfatprogs-1.0.3 version released
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>,
        Sven Hoexter <hoexter@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC Sven Hoexter (Debian maintainer of exfatprogs ]

Just wanted to let you know Debian has an exfatprogs package in their
official repositories.

- Sedat -

[1] https://packages.debian.org/sid/exfatprogs
[2] http://sven.stormbind.net/blog/posts/deb_debian_and_exfat/
