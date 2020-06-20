Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB856C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6C32073E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzdGRb37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgFTVk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:40:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43352 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgFTVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:40:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id n24so15260130lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDGZJrN+zxg9kIEWpfiOHaUMYjaY018dhr2ry8AoDSo=;
        b=CzdGRb37kVsYau41jwtDVNhfyYBgY3d0+7sNN0OqWFwk0qEouWLrm4IA+xwhjI1UQt
         QGiP+tYVl4+4RNuPXkMCSXXvX+Zp3DCziRbHJrxIOY18WRXSmZRnMQ6j93S/oYkoF4US
         c0Qsv1YND4xPcwn5Kb8kcQd8rZYZir9ce6KCsivlD069ARvPvTBajld3H9xjfI1FCllX
         3ZXAgdc/3xu2k/pKzKhzR6NT6Rd/oPi4UlH+aacp/fM2yx7nWO5+wvdHGY5cRyRmNa8I
         /yZkt+FBE7pWfHh2aBeORIAx0yu0x3x3cN5ULDhChdnMWRATlQk8xOPvG1v6bjD9WlLB
         tmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDGZJrN+zxg9kIEWpfiOHaUMYjaY018dhr2ry8AoDSo=;
        b=UL6MI6dPRNa/STgCPs2u1fzh9oVVtAsO0Etl15SKH2Vd4B/vHSiOJUqaQQnp7pvTXE
         vlWNBNuMV9LTfg4R+EXuxsUNrJs5swqVnfojD8QTX5toSY8xonY7gvvgdxdlmIFO6uwu
         9TjljE9ufXEwlhRWiRLAIfRc9QzZ3xkLKvyMddMhSp7Kbf6AuU00v5diiiwn5oy0EalG
         m/VjYrzJYGBQiWKLVfzkMr5c24LOcmEQMaud1aG04Vx967pRp/9lmTRgFUAxPIMQV5/3
         20XXZA8Pkvw6RHSYhLO6GD8ezSWQdcl7TJLmPLsUZrarGx4ThoGq7z15/G2iYAdLsRTM
         lBSQ==
X-Gm-Message-State: AOAM532eTNpz61y6NBHaA3L2GOhJBWGCC7kQ/7XEiuwA2huk6Wc3oQCp
        5YsC8gs1BqUCf4HUhoj9/Qa1bGoFOfiaNE35j7ILJQ==
X-Google-Smtp-Source: ABdhPJxAa1VzCVlzrh0h7Fjw2j+ZkUnwO3O+sZYxyg7hx+dcgKgbw8afJXNyQtB4JkQJJZ827jwqG3BbejMYNSUh+Ac=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr5249034ljc.100.1592689165295;
 Sat, 20 Jun 2020 14:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616223353.993567-1-lkundrak@v3.sk> <20200616223353.993567-2-lkundrak@v3.sk>
In-Reply-To: <20200616223353.993567-2-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:39:14 +0200
Message-ID: <CACRpkdZ4_cRPMyA6=-qqWX-GpJ0DQXdj=EbFEkoFqi8w6AahXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: gpio: Convert mrvl-gpio to json-schema
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>, linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:33 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> This converts the mrvl-gpio binding to DT schema format using json-schema.

This looks about right to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect Rob will apply it when he's happy with it, else poke me once
he ACKs it.

Yours,
Linus Walleij
