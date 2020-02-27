Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7DC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C8621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWajb/K7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgB0AbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:31:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37455 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:31:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so492983pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MwKceVB/8T/fWJxXCvPWmKs+5MAIGdSRlEhKMQMaSM=;
        b=CWajb/K7LI9FjAaB0ca4YN4TLt9eR/If8M1yvhaNyiG6fGghZi0c8rTuJyMJjpny6R
         zlFiY3Czt/oeHzrLsGWTOz5PhcCoQF941tW9fR370DJobzH/WlSEhwCuiQNctzOtm3/n
         8uj6wSTdA5b8qWK7CXc2dJoPQFWNADxjn5Y8pRtYfjVYwZhV4wRkAfgQbGQT8xhG1wZo
         ge0eOtm0w49qYCGDiYbfkbBWEb8++va1VITOpE+CZSSN+XPdLgxqDk1ccXlWGKivtl6l
         seszXaJphBaiEX+gy2tPdTHkbCVxSOUknbnD+JZg6CYIE5/1EWxeQC8gMVV1nHVD2GKg
         77RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MwKceVB/8T/fWJxXCvPWmKs+5MAIGdSRlEhKMQMaSM=;
        b=iLuWTj/Npl3doa/mCtaZ8OZgc+vBYampd4QvLrozewlCvP7YIbbRupg/P2zluBEJBz
         imKNk7+6d678srfrHrnYmgBWnLvalYWgJ/gWZg/HPXGJ8JdVuE5uxAOka3Kuf/1l99LY
         Tw7B6JV8Ku/+F7k8EezpIsGeMCi4j1aIEHCqceienrm/iRPzvIQH1gXLnTDfW0RU+OBI
         yljO5RtsvWMVV5I+cX2nrAHFS0hRqJ3uwX3FbN0blCLW7iLw/uM/LV7Wm69rlYDiDvGK
         IN807OgMZjxbjwkPLImq2lWo346s7iCcZtdAIvkqSsGZc3P2w5sO6q93ww9ROkUocKKH
         CB3Q==
X-Gm-Message-State: APjAAAXSoLwaC3qF+1UUCU0IMMEMEtYEPvEWqd3zaH4iPYSZsA8xVrDf
        fipDw5UJXkuUMKd4r+rboh5bZ6ZN6vk=
X-Google-Smtp-Source: APXvYqy/7+8GLTujZKTC42dcivzJjldCPEFcGAmU/tIcSVJCbWe+v3OrlH0R3oIU05xe26KG1Ud3Qg==
X-Received: by 2002:a63:ed01:: with SMTP id d1mr1271350pgi.95.1582763467915;
        Wed, 26 Feb 2020 16:31:07 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id x65sm4612875pfb.171.2020.02.26.16.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:31:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:31:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 1/3] openrisc: Convert copy_thread to copy_thread_tls
Message-ID: <20200227003105.GF7926@lianli.shorne-pla.net>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-2-shorne@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:23AM +0900, Stafford Horne wrote:
> This is required for clone3 which passes the TLS value through a
> struct rather than a register.

[...]
 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index b06f84f6676f..6695f167e126 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
>  extern asmlinkage void ret_from_fork(void);
>  
>  /*
> - * copy_thread
> + * copy_thread_tls
>   * @clone_flags: flags
>   * @usp: user stack pointer or fn for kernel thread
>   * @arg: arg to fn for kernel thread; always NULL for userspace thread
>   * @p: the newly created task
>   * @regs: CPU context to copy for userspace thread; always NULL for kthread
> + * @tls: the Thread Local Storate pointer for the new process

This should be *Storage*.
 
