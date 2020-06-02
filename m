Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB43C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A3C20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FYsG3oRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgFBUlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgFBUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:41:08 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D2C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:41:08 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v25so80246uau.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVYyMcSjnY3DuRRAEtT7qSzzRscOr9lxW6mXOV2xasY=;
        b=FYsG3oRfmrsRcDXZ/KWnWuTlpM499kKjm22ELuoiYyFcRqV+DouPNMpOn60f9gQ+fR
         1TvRZ4la0xj5YwiudOHKVg7Lao+c/dgsQlc3xRnLT5FG1/hv8MI04/dbKUBnKOL22cLC
         57DYrAh4B8gPtiuwRYJqG9R5GyVgZZlTxVs4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVYyMcSjnY3DuRRAEtT7qSzzRscOr9lxW6mXOV2xasY=;
        b=Rv+v95ZJBDXQ96HiiPTjbCjG5nvHZqCeGQXUQ+0fDYaVr78fabWKV1r8eogqqKJz/S
         OAcV70rOs0G1DWnODSgkUStbMopk9mFKzS28NA0E32TPET5h1PweHB75PAKYT+3B7PhB
         KMKome9hRJn3GHqzUPZt94eCE9JhNPc9mpfnxkSZ80wZaRNI6ro5aRDK7ubdPXYmj2u6
         OIYqA+3Tw1854CUSTzt+mY+psN7u6iNnh1nz7VCV0ye0tTjJbijlSoFemRTvvg3uVNFK
         whEw4hwPPRoI6UpBUBTxtlAzG0U+Ix0179yeDyThLlYgO+xQnwr/SD+IqFba3JmFq9UV
         YeLA==
X-Gm-Message-State: AOAM531+phLdY+pFWCV2CQqZAJDDHIKUrXlh/QahXrc5WC2/keUNXyq1
        hFuQZyVloWGopVRAXxbq4FP3Aa/7jcc=
X-Google-Smtp-Source: ABdhPJwYa4EoF0JV7MQEwJI1y22tE0avMX5b2Zjp2T7JhN8Hz2S3W91rhJer+YWCmM6H3ro+tP6dZw==
X-Received: by 2002:a9f:3e45:: with SMTP id c5mr13000718uaj.130.1591130466225;
        Tue, 02 Jun 2020 13:41:06 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id u4sm468376uaq.16.2020.06.02.13.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 13:41:04 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id z13so59169vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:41:04 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr20199765vsx.169.1591130464160;
 Tue, 02 Jun 2020 13:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200531110015.598607-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200531110015.598607-1-christophe.jaillet@wanadoo.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jun 2020 13:40:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOp9yVGt9hosO6fGTSqstjqO=nddTLr5tD04cfvHHL7A@mail.gmail.com>
Message-ID: <CAD=FV=WOp9yVGt9hosO6fGTSqstjqO=nddTLr5tD04cfvHHL7A@mail.gmail.com>
Subject: Re: [PATCH] arm64: debug: mark a function as __init to save some memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 31, 2020 at 4:00 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'debug_monitors_init()' is only called via 'postcore_initcall'.
> It can be marked as __init to save a few bytes of memory.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/arm64/kernel/debug-monitors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
