Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16090C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E172078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgDKFtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:49:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39120 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:49:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so4875659edf.6;
        Fri, 10 Apr 2020 22:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AY1eYwYb01uBMfY6y8bPl9jYwISh1gazEUotw3JX4RI=;
        b=Ip3lFVXbXHNAy5tzlvmAVCiPKkDSvL994yk0K3umEDBvO6622P7XdjIact/PAF/Op/
         Uw85i9AB+G3DwkHt4t3+ViHrGiE1lhoMNr4Y9hUMA63JCPnc+FnsYftjwqnpf7Rm8P5D
         +whhIhHKQN9Iqdwe3EzfRkm3eOSb2VYLHXkRwmBnLXGvgaRdnCSDKWFbLDw5UH2D1XD/
         oq2fKVG9cnLbo9SCMW6NYESUn3prkJUd6s4c6b+BkXr6bqM05sqqHMYx3V5IY1eVvKCY
         6G7MwY1o9G2ahvgBNiu8ADjgT5SAEqBRck9r73diI/2GnrFD3i2DtnjY1pFBQ9RZdN9I
         tmEQ==
X-Gm-Message-State: AGi0PublwRkCv2Gjldbt6mJz5bJGsfgz6U8djqaGwUXFfacCA6wPoEM4
        XnmjOOo7SEFYGje+8q5RO+CYRv5WXGg=
X-Google-Smtp-Source: APiQypJ7oFhouDHDadC3nwvBvW54o/0m/R0u1EorTHw1rhVuT8PUY7kOUJ4mqZ9M3ld4hCD9eHrErg==
X-Received: by 2002:a50:c850:: with SMTP id s16mr7973044edg.90.1586584152905;
        Fri, 10 Apr 2020 22:49:12 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id g15sm542500ejk.77.2020.04.10.22.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 22:49:12 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id z6so4706450wml.2;
        Fri, 10 Apr 2020 22:49:12 -0700 (PDT)
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr9012661wml.189.1586584152093;
 Fri, 10 Apr 2020 22:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586414867.git.gurus@codeaurora.org> <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
In-Reply-To: <436e1a50e603eefb24c8e7b2bd7f7e4838b90e12.1586414867.git.gurus@codeaurora.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 11 Apr 2020 13:49:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67r_esaqANauo7YOVjSVVt5z+jyuneZe0FLrjgDxnDjzA@mail.gmail.com>
Message-ID: <CAGb2v67r_esaqANauo7YOVjSVVt5z+jyuneZe0FLrjgDxnDjzA@mail.gmail.com>
Subject: Re: [PATCH v12 08/11] pwm: sun4i: Use nsecs_to_jiffies to avoid a division
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:53 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using nsecs_to_jiffies() which
> does away with the need for a division operation.
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
