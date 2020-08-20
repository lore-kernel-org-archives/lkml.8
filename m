Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD269C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D12075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3yEqigV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHTWRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHTWRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:17:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9838C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:17:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y6so1565088plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdaSqiYtFrEiaJmZIAOdnXuw3UlSm403gFoNqHFcjWU=;
        b=W3yEqigV/dj93cJojaPdaTOecMAefU9610jFytl8EkkPtXkFf0tmW/J/G7Qh5fUYgX
         7QppgKpj3dPvMwONZlEhxo++TX+uuVSvPI8FtrvjGGW2zYhngo9H3jCLiz45k8uqxmpi
         rMtzvxQYApj3Fe5tehwe0LmGovlfKsmTOspEqd3bLs1XIDWBtIdt6GaX9X2qEqyHf5zp
         o3Yc8I/4o2c1D/H4NnQRKlGq1yi6umBvHDuUzpfMfisREVV3F7Y4OiE30xaqPtBkUJyF
         PulOFVJHl4XfO9Cb9V+/8CGQ+xG9VYr4vwPO3e1eshQ1CpMSqXfq20rnO1Az3by9+TwU
         Qamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdaSqiYtFrEiaJmZIAOdnXuw3UlSm403gFoNqHFcjWU=;
        b=tJvMP8v43NvXNBgTs5dc0/xQPbM4nDMd2bZaF7RhqlbpuMhb1ty5mxK2ojSE6GTS+I
         myRdUYBBBE5ROc9fYvnU2zrzVnuA/iYgc8X747ZLconHCV6lKOB8pUA+vNvVKzraA6bZ
         2d2AAFTH9H1AVQA5Agvmgq07bk++PNikKkLwiUxP+wxZH6xnzvlSUzBgp3fS2M4kmaYx
         o2d2y+JQKYaNzaSpz2IaXxjo83y2qzTonC7nFjiPmUO8mZRxUluGLcVVyE9jgFX0U+FL
         HlqZCPVs3zXpQfZlG0OHHSzukI/TVzD+C9fLeo0g09ES4r20p7hc+GkBKuzrybScjYQ6
         eyZw==
X-Gm-Message-State: AOAM53009yIUTxsvEb+vr71iglD0QZrYUwTjF+SbB3+1jiX30d4PZjSP
        VhrP5H62gJgs21oqRKhK4T4=
X-Google-Smtp-Source: ABdhPJw4aZVAZETWut72PGNlfy5kusZv1r+KgXMPQyoajwide9tLPP342XTzQp2eL0Gje0mTzXOLzw==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr401005plr.27.1597961836259;
        Thu, 20 Aug 2020 15:17:16 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.77])
        by smtp.gmail.com with ESMTPSA id t14sm30350pgb.51.2020.08.20.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:17:15 -0700 (PDT)
Date:   Thu, 20 Aug 2020 15:17:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     gustavoars@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        clang-built-linux@googlegroups.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: fallthrough pseudo-keyword macro conversions for 5.9-rc2
Message-ID: <20200820221714.GA10326@Ryzen-9-3900X.localdomain>
References: <20200820220210.GA14894@embeddedor>
 <20200820221511.3328330-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820221511.3328330-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:15:11PM -0700, Nick Desaulniers wrote:
> 
> Hi Gustavo,
> Just noticed this on lore.  I'm curious if you'd had a chance to test your PR
> with e2079e93f562c reverted?
> ~Nick

There will still probably be a decent amount of noise due to
https://github.com/ClangBuiltLinux/linux/issues/636 but it is certainly
worth exploring if this gets merged.

Cheers,
Nathan
