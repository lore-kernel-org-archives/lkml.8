Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E199C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D33E2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4wzOSxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgG1R00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgG1R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:26:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B332C061794;
        Tue, 28 Jul 2020 10:26:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so739089plr.7;
        Tue, 28 Jul 2020 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s8CxIPWlau8UfBUUf1Zit/bYMskp+FR/Gd+ldXuH8Yg=;
        b=S4wzOSxXwDfGFg2NCSMoo/K0LdSBMO0r4Evck5FCh2ufocaD+t+u1uag149ihpgNNm
         wI7JAaNIpItm81KSwCxVThGounvWOCAWy1X5HMtDpRuWX9qMFbjYLYvER/frsHix/vSF
         /Jifal9mnrB2XcWnE1K2A9dQEXyiiQ3lmHpHeGUqHBUapyAalbreS0GuGPqtBvh5QZjX
         9grcWfEcA9cufRH5GvIU4pdIRfI4PeE0wZprpNarBHVh3ZW7HBY6a7adB9aUdyUfu68R
         w2QpxR4STpLO4dQP2pH5fohY0+GRCGQmBOz2BL32Il7NzMCf2S0QsUedCPec+ZtPKN9t
         GdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s8CxIPWlau8UfBUUf1Zit/bYMskp+FR/Gd+ldXuH8Yg=;
        b=F5VGuK9kP6FydXBNOOYnvl0J89df6aa7xSfETcUPUs4iIU7EB599BO3dTvPC2gvSGo
         ahOPGxdxVSDQuAG5GaauInrmun6ZcCgGJLVP4hi2YF1z+x3fhJy7jShIqOlQqiEW0iCS
         AMemHk6Vpgq834I7jatPQV5WJTIaHXQcnc1fgG5NsGepIuRjISl2fB7fPVBPKTK1USuE
         eTigG5ZgJKBCfHTQOMKolUrjd3OWf66zmVkcT2G/fRH8f4fDLaGpYu1BFsA8mW4+Ciwz
         HUK/mVH60tHuUvWDt0RH86BKqpkFFsqDKA5VtgWsw7aGdPMkdXawazsLrTrp6K2NIVrU
         KdIQ==
X-Gm-Message-State: AOAM531ztbNe5H2JaMyKCIlVyfbE/u6MbQT1Xue3crVix4cbtTU6UGqw
        RppCohUgULI8/UeIAUWr+e2mtzXTooS2gNDT9Zg=
X-Google-Smtp-Source: ABdhPJzdfHhS6L4t1jcHgJuUpezx+u/rVpyefG5mBGWG6CWr23hRVPrasPCQ6/5Sxh5clMW6uBMr/Db7MpAi4+2gkUg=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr5705366pjp.228.1595957185750;
 Tue, 28 Jul 2020 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200728170251.112484-1-zhouyanjie@wanyeetech.com> <20200728170251.112484-2-zhouyanjie@wanyeetech.com>
In-Reply-To: <20200728170251.112484-2-zhouyanjie@wanyeetech.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 20:26:10 +0300
Message-ID: <CAHp75VevCu2Diojjam1q76nSdOOsfB_3kXCYFLPMfwad8kHv+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix static checker warning.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Cercueil <paul@crapouillou.net>,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 8:09 PM =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
<zhouyanjie@wanyeetech.com> wrote:
>
> The commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
> Ingenic SoCs.") introduced the initialization function for different
> chips, but left the relevant code involved in the resetting process
> in the original function, resulting in uninitialized variable calls.
> This problem can be solved by putting this part of the code into the
> initialization function for each chip. Although the four processors
> currently supported have the same reset code, let us can solve this

'can' -> ''

> problem by adding the initialization of the reg variable to the
> original function, but when other processors with different reset
> methods (such as X2000) are introduced in the future, it will cause
> inevitable condition judgments to complicate the function, which
> violates the original intention of introducing initialization
> functions for each processor.
>
> Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
> Ingenic SoCs.").

No period at the end

>

No blank line in the tag block.

> Reported-by: Colin Ian King <colin.king@canonical.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

...

> +       /* Wait for PHY to reset */
> +       usleep_range(30, 300);
> +       writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
> +       usleep_range(300, 1000);

Instead of copy'n'paste 4 times, you may provide a helper function.

--=20
With Best Regards,
Andy Shevchenko
