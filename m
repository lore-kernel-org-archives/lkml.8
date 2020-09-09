Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BF4216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mWJios1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIIJeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:34:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2A5C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:34:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z22so2543666ejl.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esyRenDJEgBolb6Hqrvg5tsBvHFlf/kzCPfFdPG5zpI=;
        b=mWJios1mOJgKkAkA4eRp40n/dOQeC2Zy+Hj976vMfmjXU9at16C6zJMNITV7PVOEGv
         gweG96JsvUKzoQd8a2VQE+YGOq56qzXwq9PJHJdl7+l6+Evbng1hF9qw4RBUz3zpiFQD
         juslqkdb3WKNd9ape3HDGLenKlj2NwwQ3bxWLZA+HQCGm2CPhXKoqPGHNHIfN+Pz71Jp
         l9b2gRB3C2bnlW+qNxF6hBuOfOKqcQwJV1WiV6yWb3ELIaalYPmq/Ph8QgLRMRlpffRr
         PajB+8LOtTMgpXSAQuOQ6T4Fhdk1IYLRApg75bKMPEAkX+bwUv4hD+LYB70FDCWii/ea
         XpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esyRenDJEgBolb6Hqrvg5tsBvHFlf/kzCPfFdPG5zpI=;
        b=iRwDej/oZJn3cD8uPxFHnxJh8gt28cCbHmCjruZZuVkdkUH2FjmP4C8ITdQrXAZB+K
         ENdEc66vhrjN0ZCpNN2k97puUPfuxFrLWfuzI+YWfdjwysaNlB9RgaAK3xAGX96hvwHS
         w0LcMEQJ8tEO7Lsn74alMYkW2eSk9tQY+/Qz0F6Xtzegd56YWqwZm6KOZOcxog7bLqe+
         fnQBb0mnVH3xPOxpcZ0rWh31zrEsSGcoVku1+ThskCuXDdk01RDCjbLyCQJg1qaQA4w4
         5A1Zycd1y/B6PkTQLla7s65F+GyoxNMZrjdPOVXmmyR6+6c0IqRQbqjWnRSYZMPC6x+q
         FnRA==
X-Gm-Message-State: AOAM531Nyz5g4PVs+1m3N9kxvESRZFbwyIaz/FRnehs5GPjynyggY+qp
        oy83BASI+85mW2KSed4e+6a3iF4tjtMdxEsss+nLVQ==
X-Google-Smtp-Source: ABdhPJwLdI7NOJ0Ax3dEuSTTuBR5icR1r1YUf7lEiNbyHg3z6PY1KX1uSsMFSEf0Znuus9qk7yc3I5hHLdostiCV6ho=
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr2677260ejb.516.1599644040095;
 Wed, 09 Sep 2020 02:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <1599118222-18990-1-git-send-email-dillon.minfei@gmail.com> <1599118222-18990-3-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1599118222-18990-3-git-send-email-dillon.minfei@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 11:33:49 +0200
Message-ID: <CAMpxmJVMMoH82qX=+k1-SN7XPKhaGocBctCJC5We5eH=BFFWow@mail.gmail.com>
Subject: Re: [PATCH: V2 2/2] gpio: tc35894: Disable Direct KBD interrupts to
 enable gpio irq
To:     dillon.minfei@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 9:30 AM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> On tc35894, have to disable direct keypad interrupts to make
> it as general purpose interrupts functionality work.
> if not, after chip reset, IRQST(0x91) will always 0x20,
> IRQN always low level, can't be clear.
>
> Configure DIRECTx to enable general purpose gpio mode,
> else read GPIOMISx register always zero in irq routine.
>
> verified on tc35894, need more test on other tc3589x.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---

Queued for v5.10.

Thanks!
Bartosz
