Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8280C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB520880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgBWD3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:29:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39663 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWD3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:29:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so7572976edb.6;
        Sat, 22 Feb 2020 19:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CblN7nCexE9hCYpZuW6auACpdPiU3JSJPvxkqoB8jC4=;
        b=DEoPr+mt3SvIaOIaUYoFIgyCvRxXFTtl7qNEJ5F534lKnuysZ+3R9BNndN/Q1jcdeU
         N4qX/dxoCQGAuXUQjLwSU8dm15T3seKUuKuLqrma93RUkZKVxgUmPGPsaTG4mUjeYwI+
         9C4JbLL3R5pnyvBJJLma//3tBzX2qD2TL7qXgEzp4iEKX817KibVEVxWGS3bLTmP3RsQ
         5cgjOUeX3re5lO8+MjZOl+ugmwBTYtxYij5smqUpE9b28HX4gs42fpYEt0phmnUqe1Na
         ADziExO7twIRVQ0/UYsJ6HsPPdFNg3fEwoGEMtO43X9eiTITsX7eJ5xAYZGkohRnwOH+
         9h3g==
X-Gm-Message-State: APjAAAX6lkIUuMhlItDfQGHBskQ0z1D/qpdm0Qgqm1eZk1k/1ZYEMv3P
        Emzj8lMNmyuDXltgMlRSvg38wZTVRxI=
X-Google-Smtp-Source: APXvYqy49yhNpziUUkjyCjdOznX79xXUvu+/sLZ5iWM/pCYhLcJyotZ6Bn8sfQYvOe6Y9oUwDgx4wQ==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr39752353edv.296.1582428558947;
        Sat, 22 Feb 2020 19:29:18 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id q3sm583248eju.88.2020.02.22.19.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:29:18 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id m16so6342696wrx.11;
        Sat, 22 Feb 2020 19:29:17 -0800 (PST)
X-Received: by 2002:a5d:534b:: with SMTP id t11mr57232727wrv.120.1582428557465;
 Sat, 22 Feb 2020 19:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20200222214039.209426-1-megous@megous.com>
In-Reply-To: <20200222214039.209426-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:29:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v647zKVrDvnHeLvwNPEZLX+yTgPq-x7MJkp9=duzkQN3mw@mail.gmail.com>
Message-ID: <CAGb2v647zKVrDvnHeLvwNPEZLX+yTgPq-x7MJkp9=duzkQN3mw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-a83t: Add thermal trip points/cooling maps
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 23, 2020 at 5:40 AM Ondrej Jirman <megous@megous.com> wrote:
>
> This enables passive cooling by down-regulating CPU voltage
> and frequency.

Please state for the record how the trip points were derived. Were they from
the BSP? Or the user manual?

ChenYu
