Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98AC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D796206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgBWD3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:29:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46210 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:29:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so7530006edy.13;
        Sat, 22 Feb 2020 19:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzrJPJHbDzjpmj6nIkEirFiKtRK7tw47tQwrQN5NH4w=;
        b=RGr5llGQPUy3IjSDY+OKcCWYMIt0BpY/YD8j69UpO6L/MPeTEK1Z13gkqrtNeN6glE
         JQGhZN6e1yQX4PtynoX7a89Vnx3ZO1YEQnDtFnA728Qmk+n5Eax0iN+GlgWadFMrzZ5p
         LuftC7W6NlrjujR6araIC8bjZ1jNRzCiAxRjFouTF+lCLnSfqf68FlbqKnT/292t/7Uy
         bIRxIcSQ6mwb0rIyyn4U2pnFZlt31G6rWBYb72plQkTyp/2w81Ir4dm6PuJh4lb4L0fJ
         UcpUkCx1JAGkItWmCn8nRxIieUJlP9/atLAbWn5SJD7lSLG1Mfb4iJivoXrxq8koCiHz
         JofQ==
X-Gm-Message-State: APjAAAWVltvut4UPyykZq5+WNd+DANS7Id8I9Fi0z8ddOJSGROKmsBuG
        SEMFq2dg3A1WbU/ojuGLSmcQ3x3oOsA=
X-Google-Smtp-Source: APXvYqzR/rVmkWHDCu5wQCLlnHzHxSH58UxvKIzbY0DUoRpoNF7fCq3o576Jj3bxbxHJ2gh6RhY66g==
X-Received: by 2002:a17:906:bc51:: with SMTP id s17mr42976664ejv.137.1582428582495;
        Sat, 22 Feb 2020 19:29:42 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id i11sm579691ejv.64.2020.02.22.19.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:29:42 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id t23so5654187wmi.1;
        Sat, 22 Feb 2020 19:29:41 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id l18mr13201969wmd.122.1582428581680;
 Sat, 22 Feb 2020 19:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20200222214224.209860-1-megous@megous.com>
In-Reply-To: <20200222214224.209860-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:29:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v671FS+k07xWRbr1+3XWNKAsVx2AaWKOrDfyYpt2Lf-gtg@mail.gmail.com>
Message-ID: <CAGb2v671FS+k07xWRbr1+3XWNKAsVx2AaWKOrDfyYpt2Lf-gtg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Add thermal trip points/cooling maps
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

On Sun, Feb 23, 2020 at 5:42 AM Ondrej Jirman <megous@megous.com> wrote:
>
> This enables passive cooling by down-regulating CPU voltage
> and frequency.


Please state for the record how the trip points were derived. Were they from
the BSP? Or the user manual?

ChenYu

> Signed-off-by: Ondrej Jirman <megous@megous.com>
