Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A888F2076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utrycj8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDYAqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:46:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26539C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:46:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so5466722pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gpKno2/9LLrGnmiYliL+8wMwCd6lAiKJIbyOrb2sEM8=;
        b=Utrycj8RQ2UbQtaVOZjXa/vUTZrTgTGdApu6Ni+xsBeVxenNx+vRgS1eZAH+gTFA16
         h9pljuKHuzFekVMLEb60RB+F8peWekZUD896vDqZuL4MSPGJ+NM1ucL8auxZLr9wrx3V
         jg8AYjxpuL3aC0Nt4qDtfLGh0lERsK0tLxgD8Xk2ccGRHGKCbxSNc7geEkNUNBodWs7G
         r1Hfa6RLIzWn5Tv5tUFlLb4ZKJuuaXWgvnocLvFiIXJnlC3+i7SOpFptwNc/0NvyQwv6
         Ihco3KzBhjNo8ZfsYr2TWoYUE8NXF7n5TicPmu6BwX/8MoDIyf6LUpZ4ToyS4eDp4agf
         OsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpKno2/9LLrGnmiYliL+8wMwCd6lAiKJIbyOrb2sEM8=;
        b=gGKuVUfvSNTjyMf5mLXt2nQZsK3UUfoPs3RTf7ABW3Oa89RS9AN8Eptr+UXa3fathF
         nMEEPArg4GNZeZKYFhU+GIsq5CYOnSDOGdc/QSbbaA3kkvfi05e/KeUgYO6M6JvG8lMo
         /yKP202xJ/XiYVEhr/NsB5JU6OTvmL1cCNmSRpB9Abj2hcQOTG6faBfnzcFnW5dmUhCm
         l44zd1zKmwjKRhMj9DOzWRAmX7c9gDzytmaUkpkfOJZPktKtTlqHMVXYNa6WiIoFC3xy
         nY4tU6usvugBFdIOGwljOxp5eXSq4qdWuQsOAlFwXfoHxBWqGQPkHD2IzXINa0nI+S4h
         CnnQ==
X-Gm-Message-State: AGi0PuauTu7J96L7t8N+uMPL3cos2guo4JmNxTbgzhmQm0q2Tu/a2wUy
        KovaiTMaGTwfw+S7zGELCP4=
X-Google-Smtp-Source: APiQypL4ysxzEuNG2J1NXAZs5zgNM9JCMeNzVNztjunhETOY7aPU2N2uF6w2zSwIgVgv/tnlJ/WdUA==
X-Received: by 2002:a63:2ad1:: with SMTP id q200mr12244066pgq.252.1587775573608;
        Fri, 24 Apr 2020 17:46:13 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id n16sm6842158pfq.61.2020.04.24.17.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 17:46:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 25 Apr 2020 09:46:09 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200425004609.GE8982@jagdpanzerIV.localdomain>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/24 11:42), Tetsuo Handa wrote:
[..]
> @@ -19,6 +19,7 @@ static inline int printk_get_level(const char *buffer)
>  		switch (buffer[1]) {
>  		case '0' ... '7':
>  		case 'c':	/* KERN_CONT */
> +		case 'S':       /* KERN_NO_CONSOLES */
>  			return buffer[1];
>  		}
>  	}

So this means NO_CONSOLES_AT_ALL, slow + fast ones. I wonder if this
wants to be NO_SLOW_CONSOLES instead. Which then brings us to the
next question - can this be done with per-console loglevel setting?

	-ss
