Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE772207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHfXp4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgHQJTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHQJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:19:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2CC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:19:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so14190042wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX871vE+FuBcMCwIyoO/B6faScex0KuAjvcf8gzD10o=;
        b=NAHfXp4UBf6Jibtr2eCLhEO9YoL8Wt0anDkAAE2K5TZU53xG1vkvMB2EgNCPhxmGx5
         5T32Kbcf1FdbzuearoAM/32+vKjxF0vhz64kmxZbU9ko7qcmNfkyTlqyF/GFcyxSVLrJ
         4AipYvBmctHdf5NScgCdQmoDe6GBXy6cl050KRWSjF4d85M4QevyefgyHJWjxGkWqVTS
         bbVXr1TUoX220i171lSN7bFYORPx8K6513VEN6ttGYOEkm+naSJ8p2UZxdk0z7fJNMaf
         FjjpeZuHmTS3NmdyQULQ9ufpXW+PaUMUhtPwUwlVvQxYUkLL8MOw27x70MEt5E9DxpzO
         VQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX871vE+FuBcMCwIyoO/B6faScex0KuAjvcf8gzD10o=;
        b=Bkh1ocXnUdqdbZ12mE37ljqHhf/2ciC5ARIXeW7VLA+ohacBe2klAk/MhGIN8m2WL0
         8TfOWIXcKy2pATOriLE/Mvpsd6TNh5Kze2e5/XjfO3dv97hPLbPbYK1jDLbhzDLogY6S
         fSkT2gA6DrotzytBdujQwLr/grz5kpJM9PR/R9rlNiBWBL4B/jsjIKoXmkM7pwXVvsfq
         VN2FbulfwXCWQkLo71zIEcNnTCKrWsgTeE5tXYpJ9vLpxThlJxzEH5JtQBQA3YcU+Buw
         rbyllRyisxC0KtsTI0wt7KPYpiYOs31W/88dbYZYnkb9JbYvN50yFMdSRRsszItBY+Wu
         wgCA==
X-Gm-Message-State: AOAM530Eb3Elg+yQraDwxBI+mcSWFTPWarr+uxO1jJHuSB7Uiyl4ko3w
        ujp4Nm0HD0iPWo1Mfr38Hc4PyAuVxYkp/za6r0I=
X-Google-Smtp-Source: ABdhPJyqCR0rK5Dp5nj1dXQBMsH1a4xuJvfOer49VOTuXmGUa+ctG1GwTxQ2v/dZNgABIn1M51tgRR3MnRWB5D7Osl8=
X-Received: by 2002:adf:b1dc:: with SMTP id r28mr14132586wra.242.1597655944611;
 Mon, 17 Aug 2020 02:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com> <s5hpn7pprl1.wl-tiwai@suse.de>
In-Reply-To: <s5hpn7pprl1.wl-tiwai@suse.de>
From:   Allen Pais <allen.cryptic@gmail.com>
Date:   Mon, 17 Aug 2020 14:48:53 +0530
Message-ID: <CAEogwTAGHOfBe4ztkx9To0gQGwHwFWzCBxn8nzWJP=wRJUJ56A@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, keescook@chromium.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Is this targeted for 5.9 or 5.10?

This is targeted for 5.9.

> I have a patch set to drop the whole tasklet usage in sound/*
> (destined for 5.10, to be submitted soon), so if that's for 5.10,
> it'll be likely superfluous.

 I have picked patches from your tree to adapt to this new API.
Those can be picked in 5.10 I suppose.

Thanks.
