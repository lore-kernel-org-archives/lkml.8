Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B410208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csLBG7MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbgEZSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389623AbgEZSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4772CC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:55:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so184522pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=mP6Cu0mgfRIdytKJmT/JbpqFGV5hti6hDDcYjXsp/n8=;
        b=csLBG7MWmFDFdyDmAAKhK0DYdONM8BHZYeFGTC879KpVj6Y5Xk9doyuUkTKGKdCiHi
         HfmAj4dC0cDcFBzY60F/ZTZbf47RRLBKsfVyQ+yGxEpMt/1nTlSUAcKXI8s+ieYL+zUU
         X8wuWyyDODagttgQCaEPsRv5TGBmu1cP5EwDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=mP6Cu0mgfRIdytKJmT/JbpqFGV5hti6hDDcYjXsp/n8=;
        b=IvPqnlSGmQ5uuf4X0jsHmU7jknaqRcdEyUPXvLWgLS/5G0rofZjwlMr3+mBZ9d9dL9
         ZL0W7658yMgzzkju9zAof7l04fkqczf0CXUM6wncXX1jat/Eh0f74GZa5H0XM8Na9aUQ
         rtZTCGs4xvYDXkK1reYzMdJSKV5pkjLoDwrh/OXVV5zLrko8Dz9+X2F21nAqPsAGVTew
         Jx+3ToDNSsJi7xD+sIwNAm+FSKRtXJ7ZFULLV6fyMH6uliIFN2rQ+pIC+3XFNQAu2bB5
         NhbqneBk50b8nZdHc+BasR2vr/WEUbigNzVizrHiVpsmfF8fPTaJ8GJi/vqyIiJLvjqw
         +QuQ==
X-Gm-Message-State: AOAM531V5JZHoArtoPaOx6tDzK1Wb7t+vW43La/2IiA/isJtFUeufaip
        wP8ya5m5J2JOGv0r+qkJWts3+g==
X-Google-Smtp-Source: ABdhPJwQICMwBntB9aeujLedOj2O9kL1o7DOX7kSwX8RdQ0FSeMECkQjs44736Z3YvI7DbRdr2NpLg==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr707865pjy.28.1590519344815;
        Tue, 26 May 2020 11:55:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x191sm263045pfd.37.2020.05.26.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:55:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200526173117.155339-1-ndesaulniers@google.com>
References: <20200526173117.155339-1-ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Date:   Tue, 26 May 2020 11:55:43 -0700
Message-ID: <159051934304.88029.10469584232447870375@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Desaulniers (2020-05-26 10:31:14)
> Custom toolchains that modify the default target to -mthumb cannot
> compile the arm64 compat vdso32, as
> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> always.
>=20
> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=3D1084372
> Cc: Stephen Boyd <swboyd@google.com>
> Reported-by: Luis Lozano <llozano@google.com>
> Tested-by: Manoj Gupta <manojgupta@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
