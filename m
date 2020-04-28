Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03310C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBFE20661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttQF3DTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD1H1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1H1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:27:19 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A66C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:27:19 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id y10so20334024uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rR0Tq01EW6G96Kr8m4k7WEsqMBf2zW4LmCXnAJMMG7g=;
        b=ttQF3DTh71bnQw2JUlFb5ZzLOtVYjLAuayQXDH68d+wX9whgtK06GEHSs5N93HbbBQ
         RCgkv++O27jAfsEtpD7AWuDXPiiDeePcVfAwBopDeW8gl439w5WW4iZu7xHyHzm/5RfC
         wsCD4b2VdepAzSeYEqbGA/ZW8jg9U5utSmLdvIGsk/0oLja6s44GB/nD4NI08dyPLJD1
         sv0uLNObrkEf3Py2Eq8gRfjGMQ/aUkeK7MNRgeEyRiR7RSNByroyn6pyvcfaDVmwa5yT
         jdflvdvQ2wQewYCI81vtwFO5HtmhqsJoawQyPLN8aWVq2oLF8AEOTGZodXRxPWCo1gwI
         tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR0Tq01EW6G96Kr8m4k7WEsqMBf2zW4LmCXnAJMMG7g=;
        b=OQiLCLvuGDCNCaxCEVWM874DnCcSexT9Q/6k/GTW9tHD2KQcAJK5MGQ5g+FcE5p/jw
         BJv52zZrNby6e4qLfZAI38gjaFI0zgwhds4LO0IffjyRhV6/G/OOtfjbwV6DdVmNHJfP
         1JlNE8G25XODCAO0slyprqpss+yO27/x2LxgVFdkAPq5BgY7zP7+Bx8TZStiJrbRcywU
         zTdBYHwSg4JrGwiztu2Q2lm3LUILW9Oh30iKGNYiDPIMwCDOxirl3g5lk9NkQF91cALn
         QuwGZ0BH/hFVPIV7GVIFKnUtDDDdx3iRXDp+ivqG08IkWnOCzVZRbmRI0ubyyoI7elSU
         iJ1A==
X-Gm-Message-State: AGi0Pubo0CjNsyMq5DGeEtYcZTKQUbCzYrB3Q14FE66HnvY/bU+qZ+k6
        /azQRB2LnoVetmpsYNq1chXSVQ2kNHlbQ0u0gA==
X-Google-Smtp-Source: APiQypLSYusQzxgSHZip5MGAyhegR+PGuBhGAQKIRrFfSVvbqK2qNEk3tEedH37QPBH+SmRS20IT5zfLT6Ot4UsqpKY=
X-Received: by 2002:a67:8d0a:: with SMTP id p10mr19857851vsd.45.1588058838098;
 Tue, 28 Apr 2020 00:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
 <1587715859.28179.17.camel@suse.cz> <CALjTZvb_nzOXd09VXJDECu4b7xuS3tduQ1SXJ0BrpCMBp4qcRQ@mail.gmail.com>
 <1587830499.28179.66.camel@suse.cz>
In-Reply-To: <1587830499.28179.66.camel@suse.cz>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 28 Apr 2020 08:27:06 +0100
Message-ID: <CALjTZvaJB7jrRFWOH2a9Ua-+-S_8Xwyu+W+FtBp-YdG-UkikJw@mail.gmail.com>
Subject: Re: [BISECTED] bug/regression, x86-64: completely unbootable machine
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 at 17:01, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> There is an easy way to tell (besides compiling with those patches on top and
> check if it works): run the command "turbostat --interval 1 sleep 0", the
> output should tell you the content of the register MSR_TURBO_RATIO_LIMIT.
>
> If bits 31:24 are zero, you see the bug (the code divides by that value),
> otherwise you don't. Some 2 cores / 4 threads CPU have a non-zero value there
> (even if it doesn't mean much), some others have zero instead.
>
> The Intel Software Developer Manual (SDM) says the register content is like
> this:
>
>     Bit Fields      Bit Description
>     7:0             Maximum turbo ratio limit of 1 core active.
>     15:8            Maximum turbo ratio limit of 2 core active.
>     23:16           Maximum turbo ratio limit of 3 core active.
>     31:24           Maximum turbo ratio limit of 4 core active.
>     39:32           Maximum turbo ratio limit of 5 core active.
>     47:40           Maximum turbo ratio limit of 6 core active.
>     55:48           Maximum turbo ratio limit of 7 core active.
>     63:56           Maximum turbo ratio limit of 8 core active.
>
> As I wrote above, some 2c/4t CPUs will say (correctly) their 4 cores turbo
> frequency is zero, such as this Intel Core i5-430M (Arrandale) where I've seen
> turbostat saying:
>
>     cpu1: MSR_TURBO_RATIO_LIMIT: 0x00001313
>     19 * 133.3 = 2533.3 MHz max turbo 2 active cores
>     19 * 133.3 = 2533.3 MHz max turbo 1 active cores
>
> On the contrary, my laptop has an Intel Core i5-5300U (Broadwell, also
> 2 cores / 4 threads) and it has:
>
>     cpu3: MSR_TURBO_RATIO_LIMIT: 0x1b1b1b1b1b1d
>     27 * 100.0 = 2700.0 MHz max turbo 6 active cores
>     27 * 100.0 = 2700.0 MHz max turbo 5 active cores
>     27 * 100.0 = 2700.0 MHz max turbo 4 active cores
>     27 * 100.0 = 2700.0 MHz max turbo 3 active cores
>     27 * 100.0 = 2700.0 MHz max turbo 2 active cores
>     29 * 100.0 = 2900.0 MHz max turbo 1 active cores
>
> You can see above that the 4 cores turbo freq is declared as 2.7GHz even if
> it's nonsense because there aren't 4 cores. In any case, this cpu wouldn't
> trigger the bug, just as your skylake.
>
>
> Thanks,
> Giovanni

Hi again, Giovanni,

Thanks for the detailed and insightful explanation and sorry for not
replying earlier. This was indeed the bug I was hitting, as my
Arrandale laptop is now booting 5.7-rc3 just fine.

Best regards,
Rui
