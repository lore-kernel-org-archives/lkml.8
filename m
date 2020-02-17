Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BC9C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3BB2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBQHyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:54:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44963 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQHyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:54:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so19549663eds.11;
        Sun, 16 Feb 2020 23:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KR6FhQWcs0qNnsB7tbG/todYZCoVJm9lbx/mBjKE5fM=;
        b=qgjWzJ7Nv/Rq+Y6b/HQvItrGaJytyHXNwx+8sfW7CctKpDIa1ybqyaXOVzCA7RPJ3Q
         8FF1CCbwqYAQco/ZThzgINULWP2zTlYS3L+/jdB2Jc164gEPqURPcJhIaCkU0uaiOMlN
         pSG3CIS8WeZvIFnFFOW4rj2Ej6nsN8gUg1rlHkbDDJdvx7qQN2bsS8n7s+gqLUQWmx89
         DdqWSUJ7wuJUXihd57Cp77Qw9mOwEo9g2hW4kvH0qPeVY4DPVmPEVH1qliciGtmeLrh7
         JSudJOJTo/Ba/QsXBn+aZniYCCq1+Er3quEQ9dFaDyq7eY2/bsBegCuqPsKZbZ/+NTBG
         /jlQ==
X-Gm-Message-State: APjAAAVqGSwVoYEP0cGq+1NJiFsq5gXJlRQsddIbbiae19W5kz3ly21t
        KGG7fkODwnhR9/4FoI5Lt8GAy7vAMJM=
X-Google-Smtp-Source: APXvYqwBlGQmpgutjnv6W6/Fc7WIcgwZIXJwv/hA1GKiY6SY/54p/zLHaPvobXHd0aR0IV14ymPCXA==
X-Received: by 2002:a50:f612:: with SMTP id c18mr13109179edn.1.1581926082098;
        Sun, 16 Feb 2020 23:54:42 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id f25sm456008edt.73.2020.02.16.23.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:54:41 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id k11so18374179wrd.9;
        Sun, 16 Feb 2020 23:54:41 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr20401029wrs.365.1581926081266;
 Sun, 16 Feb 2020 23:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-17-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-17-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:54:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Af-gZxfrmCEg3Ltvy82Wb4M0RF17CR=jwazyTGy8L=g@mail.gmail.com>
Message-ID: <CAGb2v67Af-gZxfrmCEg3Ltvy82Wb4M0RF17CR=jwazyTGy8L=g@mail.gmail.com>
Subject: Re: [RFC PATCH 16/34] ASoC: sun8i-codec: Fix field bit number indentation
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Several fields have inconsistent indentation, presumably because it
> "looked correct" in the patch due to the additional character at the
> beginning of the line.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
