Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3BC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3A2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QTDUo0bG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgA2KbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:31:00 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45289 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2Ka7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:30:59 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so7731851qvu.12;
        Wed, 29 Jan 2020 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CpTiqcxWV5iDQ2s5evCgc1gRRqBLWioobZhV5wSYj6I=;
        b=QTDUo0bGuTwHNXi3V/KAu6Qa4swRJ0LKNvrq66Tv3MoqyfJp5RakVzJfD1luWeoqOp
         5EMyPmLBj0MmEEpQaLHxO9JWkzwsSy+O/nOfeUVkr6n22llnYnNjAvdVzbsXBTN4ZoMP
         MXSWzA2Cl3LUeAUj+OfkPAFiWPv0/JwfD4Wh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CpTiqcxWV5iDQ2s5evCgc1gRRqBLWioobZhV5wSYj6I=;
        b=Hmrvg+99wcwcjblrR/rpsDHGFWFUqQpf+HMhiZLk4O32ON7XATVrFmFeYc2JDtmrSt
         3tSkybHRTet5WvrvuAyk5F8Jiqf6KAS7OEK6I/gs9zrzJ94dOy+IvPaw1idXsjsA9Bfk
         lzYm2KHCS/50DmW9iErzX3/yc1BZVpFyibXmFgoSCtrbXgGmWrode6rKRu/rcvTgTwKn
         ImW12lBsYIVL7LpLsfADONmpwFAm72FDKKy5XhEFfRKs//AwvazVFhI0at5YxUKOxef+
         kguO3fb6xlHaS0CptN1M492VqnCbmzEX3PXTNDKTa2zS2SUZGpE0tgKGlW8PjUQOIspU
         Y1ZQ==
X-Gm-Message-State: APjAAAX3il5407Z79dXQBv5WGchw9i6oXFD1jCtGAD5mEbxV6NGM48NN
        Le2zZpwyiX9jTK901qmUsJ7i7Q5GJqBMr71lJQs=
X-Google-Smtp-Source: APXvYqxJ2EjFCv1OU1W6Tp44rEEcho24mfLeEG+kKYffhCtzKj4nHNWIEv1geC3rEaEUW9w56IwpnVL2lmxy7/06jD4=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr26593975qvo.20.1580293858276;
 Wed, 29 Jan 2020 02:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20191107094218.13210-1-joel@jms.id.au>
In-Reply-To: <20191107094218.13210-1-joel@jms.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 29 Jan 2020 10:30:46 +0000
Message-ID: <CACPK8Xebf0p07QsHEXxbEB2pQ9_Fe7JhMjZLL7-9HDXBKdCaSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] clocksource: Add ast2600 support to fttmr010
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Thomas, I noticed that this series never made it into the
timer tree. Are you able to pick it up?

https://lore.kernel.org/lkml/20191107094218.13210-1-joel@jms.id.au/

Cheers,

Joel

On Thu, 7 Nov 2019 at 09:42, Joel Stanley <joel@jms.id.au> wrote:
>
> This series adds support for the AST2600 timer.
>
> v2 adds r-b tags from Rob, Linus and C=C3=A9dric (who reviewed the patche=
s on the
> openbmc mailing list[1]). I made two small naming changes in this
> version that were suggested in review.
>
> [1] https://patchwork.ozlabs.org/project/openbmc/list/?series=3D140990
>
> Joel Stanley (4):
>   clocksource: fttmr010: Parametrise shutdown
>   clocksource: fttmr010: Set interrupt and shutdown
>   clocksource: fttmr010: Add support for ast2600
>   dt-bindings: fttmr010: Add ast2600 compatible
>
>  .../bindings/timer/faraday,fttmr010.txt       |  1 +
>  drivers/clocksource/timer-fttmr010.c          | 68 +++++++++++++++----
>  2 files changed, 54 insertions(+), 15 deletions(-)
>
> --
> 2.24.0.rc1
>
