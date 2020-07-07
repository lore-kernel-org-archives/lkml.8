Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E357C433E4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D54E206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQs8aM6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgGGLrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgGGLrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:47:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838FC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:47:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so24527909lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H31qO9mIhZa8mYSQsZNVqE+31tdLenCwSf5kmSoOfwM=;
        b=sQs8aM6fKHIQiqDAeBYhbK8/IcCikVwpSJBAz8Vm7OIXiet8/MSv6Wig5gdT7jXE7Z
         A3cQubcZ8i8CnqiA6c+JlRxHdO9bIc7UTSwvW9YAGOPdW8xSDteGUMk1iE55ryLq1zhw
         /Q5xc06TFPTkJIdNNz5jC5AvdkUcnM2+SzoS1YH7efa/5XMMAwLNC5In+xwUuDKQ1Ui6
         iG8vYYzHC5y/duMI7TEKx67+xsDQiCIMNeYdjEdtFE8sGxgvQjXkjk8B0or94UzwPHhT
         oFSUjIBLiQVtCZzci0PpKrd6w7c4huuUd06SJZf9b8rH8azxPsbCjGIhH74lbC8MLlAj
         s53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H31qO9mIhZa8mYSQsZNVqE+31tdLenCwSf5kmSoOfwM=;
        b=hSdKHb3+Nrb05le1H/65uFx6DJnWmoIFzpmEGqDTYlp5R/CjTFgyOkET/uSBRxXMtB
         U9Gl9i34Og8CFUwjy8ym4Jd1USEdQ1b1ceN5utUGhUDi4tEEEI5J1wjgJrQPhjRLYXUV
         7Hoy9BkRansTE6t7nXCnrA3w8nqYV7Eqa5I8VGxlQkEuacpOtlEKS4LLu8zmhyDcXSVE
         e7NJj9iEis9+UeyjQ+GSuImXi5mS+9tHVgTSP3SmPQjgPXpFXSBM8/L+NoW2gcHu5hXC
         QLbLvrsf4l84szmtxeHmz/DfXbdsb6lblxpAOSJ8o3EeNZS7XzvvzupVVLmlWaEjEukt
         jb4A==
X-Gm-Message-State: AOAM533kojNb35KdkbRvs5Qu8swm9pQ3NfZHq1k4P2nTbrWKWGA3xmol
        /siKglKydm9cFg1XIrZQd5BN2uomn3J3pTKRIS4+VqRh9hM=
X-Google-Smtp-Source: ABdhPJxvak0DTuQbCCiRuOe2HWkQ0l0ImblSKrDKYrp0nX4jzJvM6lIpOEX1oqU3vLADw7kPGiebDvdnOG4Pw/ijD6g=
X-Received: by 2002:a19:745:: with SMTP id 66mr32853284lfh.77.1594122464864;
 Tue, 07 Jul 2020 04:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <TZHZBQ.SOVDZ4DJB30O1@ixit.cz> <87tuz8b4gv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87tuz8b4gv.fsf@nanos.tec.linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:47:34 +0200
Message-ID: <CACRpkdYVQzdBJkAwB=uB6AFm2dC_tzpMRhefYWbVfGcAVxJ2pw@mail.gmail.com>
Subject: Re: [PATCH] irq: Request and release resources for chained IRQs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     20181129133119.29387-1-linus.walleij@linaro.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 8:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> David Heidelberg <david@ixit.cz> writes:
> > is there chance to get this patch included or could be this issue
> > solved with different approach?
>
> Included into what? This patch is incorrect as I pointed out in review
> here:
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1812071143480.14498@nanos.tec.linutronix.de/
>
> So why are you even asking?
>
> I recommended to switch this away from chained handler and then the
> whole story ended with this mail:
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1812071404140.14498@nanos.tec.linutronix.de/
>
> I have no idea how the GPIO people solved that problem, but certainly
> not by applying this.

We didn't solve that problem.

The reason is that changing the platform from chained to regular handler
involves of course changing all the other drivers in the irqchip hierarchy
since chained is an all-or-nothing approach, and that needs to happen
over the whole set of Qualcomm drivers.

Sooner or later I guess I will get to it unless Bjorn or Brian or someone
else beats me to it.

Yours,
Linus Walleij
