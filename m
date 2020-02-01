Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAD5C35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619AB20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580536190;
	bh=CG7WOtvzzyGloPtARiFMtaEJatWuWW9dB+HAs41pS48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GnHfnQdnbHnjfMFNI5SBJ0bYcYsYCP93X78s+jWPU7Cxm3mTwbKvEJRdlMGwXEA8P
	 lSN3ep8/dX1yEpFROE3W/IaZJQYaIgahoSOAHajz45GdpEfP81qqk4+Fn8ktTTe4pY
	 Uk6tb4aowNTvVN4DpPW63ONeoZm1jTJYosCIcfHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBAFtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 00:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgBAFtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 00:49:49 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225E420679;
        Sat,  1 Feb 2020 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580536188;
        bh=CG7WOtvzzyGloPtARiFMtaEJatWuWW9dB+HAs41pS48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p9Usk0+gm9NEW+/dTAIyo1KUr60gS2q+stHHvHeh5BWEfiKxVZ/kQixvmtBM2M9aW
         4M8sGEKicKQwAbYYy9OuRYzBynkz9J72kitjnxW3TtX3Os+G0d1G2O8p7bKDiYc2p8
         K8x492e3xpAleXH8WtgXd/WQDYERqDtQpZys4mlk=
Received: by mail-lj1-f178.google.com with SMTP id d10so9291917ljl.9;
        Fri, 31 Jan 2020 21:49:48 -0800 (PST)
X-Gm-Message-State: APjAAAUchSStkE1LDgA3Zmly/VYZjgUzusUgc5zclVV2kWUzvd8jyHTT
        0uP7GZUmM0mxg18U28ZkjdGesn4B8KWFQ5x0JDU=
X-Google-Smtp-Source: APXvYqyFBrAH+CbcmP5/8pUuAJaTgeOzUsajKQ0ozV92KB6+GpKRmlYfVIPxBqQWs+eDcdzH1d2OOELLh1/+sZmNgbQ=
X-Received: by 2002:a2e:3514:: with SMTP id z20mr7770785ljz.261.1580536186311;
 Fri, 31 Jan 2020 21:49:46 -0800 (PST)
MIME-Version: 1.0
References: <c554f9e8-fdc7-ada3-8b6e-70a3f3aef89f@infradead.org>
In-Reply-To: <c554f9e8-fdc7-ada3-8b6e-70a3f3aef89f@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 1 Feb 2020 13:49:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTM4-xJhY6Ter0n_b6Zu=yqA_N-FnHA2qL5vp5W+ZZqTw@mail.gmail.com>
Message-ID: <CAJF2gTTM4-xJhY6Ter0n_b6Zu=yqA_N-FnHA2qL5vp5W+ZZqTw@mail.gmail.com>
Subject: Re: [PATCH] arch/csky: fix some Kconfig typos
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked, thx

On Sat, Feb 1, 2020 at 9:52 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix wording in help text for the CPU_HAS_LDSTEX symbol.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200131.orig/arch/csky/Kconfig
> +++ linux-next-20200131/arch/csky/Kconfig
> @@ -77,7 +77,7 @@ config CPU_HAS_TLBI
>  config CPU_HAS_LDSTEX
>         bool
>         help
> -         For SMP, CPU needs "ldex&stex" instrcutions to atomic operations.
> +         For SMP, CPU needs "ldex&stex" instructions for atomic operations.
>
>  config CPU_NEED_TLBSYNC
>         bool
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
