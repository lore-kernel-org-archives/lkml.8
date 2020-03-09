Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC36C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9212C22522
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkDM6ZUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCIQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:49:34 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51486 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgCIQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:49:34 -0400
Received: by mail-pj1-f67.google.com with SMTP id y7so105036pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bNoFPXhpvMiuUF7F+uekItlbOQGQEdKTXJsSJYz6wNk=;
        b=kkDM6ZUxQYSDcpRCzqXBzl6yRdTxqvu7JFcn1rImw8v+HOQq5uEy+Sz/qwy5/3C+s3
         KUB+FBs5z4n/A5MqPulS4DKCuhgmvKIaNUHArlCnB0h/4FTfLx81RD+3NgPaOsTFI1sc
         Xht0fVFnt3MfGytquyliFmFlyCRFniOygfHi/nqq5EDEZIh0kzrbvrDR7LEVlhMc98eX
         29sgNmh17iEBtwdaaw3GPVgxtwO9+CmG5NxPouEQhUPQ9nIeCFBa/YA5/1Cb1Wws7s7Y
         +vU04Kr5himrgDw19nt8CDZj7ZuERB70/bdH97/T6iWuj6uLbmoM8YruSAMB5TCOsPlb
         8E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bNoFPXhpvMiuUF7F+uekItlbOQGQEdKTXJsSJYz6wNk=;
        b=laUvmWzMzPXvDDgmfLstkAGGpy+jCFI/IME8DKuHz3rlecad+Ptn4tEWZgbSoXEP6i
         A7HZdG6gTpI/0odOFfyr7OkW6yu6w5DOIcV/1sQcnH0TIvwX528ziNYfdWVHrFVg9Bm8
         R6ZA5+VR6ZlwoBpfCCiTjIMM+haMlKki+EOkN5TgftVUgtZyaqRRLn57rpHaD0R07e2e
         rI2bPttY283u8xd0hOXqYGd7dpMKfJFmb/1sDDFcZ2EbYDrKraLJQNIamqJAAWcCOh7O
         jwUCH+Im/mS61czWGHEcYcQXu0r3qGrmnVwNZE5D65f8R7s7S6NrkNOPD3inGhGjUXq2
         Rybg==
X-Gm-Message-State: ANhLgQ28oE267IDiqooD23xqDZ/+7n3h55O+blxQ6LyGilbwB7mlO6Yq
        nmteIn4ByRTjlNpO3co0UfM=
X-Google-Smtp-Source: ADFU+vt/onT9cxmuspJ5T+KCU952uWkieCbEwJO4adVK6fLUN8zSNRf6ArvXDJD1xRu8YQakUYup1A==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr105796pjb.139.1583772573044;
        Mon, 09 Mar 2020 09:49:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm42857301pgm.61.2020.03.09.09.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 09:49:32 -0700 (PDT)
Date:   Mon, 9 Mar 2020 09:49:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <20200309164931.GA23889@roeck-us.net>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
> On ARM, we currently only change the value of the stack canary when
> switching tasks if the kernel was built for UP. On SMP kernels, this
> is impossible since the stack canary value is obtained via a global
> symbol reference, which means
> a) all running tasks on all CPUs must use the same value
> b) we can only modify the value when no kernel stack frames are live
>    on any CPU, which is effectively never.
> 
> So instead, use a GCC plugin to add a RTL pass that replaces each
> reference to the address of the __stack_chk_guard symbol with an
> expression that produces the address of the 'stack_canary' field
> that is added to struct thread_info. This way, each task will use
> its own randomized value.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Emese Revfy <re.emese@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: kernel-hardening@lists.openwall.com
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Since this patch is in the tree, cc-option no longer works on
the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.

Any idea how to fix that ? 

Thanks,
Guenter
