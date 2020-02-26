Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27731C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9CC222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582697442;
	bh=R9LlPcV86K6VwyNb9WxW6LQP26kK/7yUQy8uFYTGrb4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xTEQRUprWso5aanpLZZQdSvZ3tw+ZWOQ/E/WsPAQPY2m0oJcSP6+1YbM5Df61OVuP
	 WRj2Itd88WAcoFJEjk782wPlDEgb32QWWdGQzOvmXXbY6gycpZ9TMoYJ1zr10YhYKZ
	 jHoNPDEYFN8u0yczbqqpm76IqQ0rqa5JvdUg027o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBZGKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:10:40 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:37223 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgBZGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:10:40 -0500
Received: by mail-pg1-f171.google.com with SMTP id z12so780172pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 22:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EieKQqDaeLawD7xM597kae4qB4q65HrUhOb9sNTPZNA=;
        b=BGgpFkPPvKalz5QQpOxuKAU6OgUgjwgQfeRidLx9q8tkcqsa6MJ5lVIn/bN/4dTJci
         X018BjI0FJKJKctEr+EhMC2PwkW5aR7oUI0cOl2xM9gGLw2SRAsEKe13CHW/gd6h2SKM
         WSDtG0uKBo2RQPL446bPOtVjzCUfUIpQHAtAghpxT1o5N2YsNT/3/u1cz1UZlejlutVB
         7cafltRRK1H14uVU1WJFjN6mKRKMdFqQIsAZ2Qm3e8AQE5w9w/aGXlYZS2Gmq97OnYTm
         K37XejzC5VnJqLrZpEYzZ0JQdls2U3S1iZmvslewDWaprwYL3fXAOnHuDnQppIFOx5HU
         CrVw==
X-Gm-Message-State: APjAAAWW06hSouhIYxiyXsatjQJGdbeXSe4cleiWVWnNqx7rojxVwu99
        ufH4/NJcSRmBWJKEFXnaY8s9LIhJ+/E=
X-Google-Smtp-Source: APXvYqzYCkrpGHGQSQoQQnZqu07Kp4kqPBOrAKzV8hhNV6gb5Mjjnk/6nnbgMrOgkS25fJnTFvi9pw==
X-Received: by 2002:a62:f251:: with SMTP id y17mr2749490pfl.204.1582697439253;
        Tue, 25 Feb 2020 22:10:39 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id q25sm1211099pfg.41.2020.02.25.22.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 22:10:38 -0800 (PST)
Subject: Re: [patch 05/15] x86/entry: Provide IDTEnTRY_SYSVEC
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225224719.950376311@linutronix.de>
 <20200225231609.412892623@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <49a8589f-de01-d08a-69f0-b98106e8b715@kernel.org>
Date:   Tue, 25 Feb 2020 22:10:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225231609.412892623@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:47 PM, Thomas Gleixner wrote:
> Provide a IDTENTRY variant for system vectors to consolidate the differnt
> mechanisms to emit the ASM stubs for 32 an 64 bit.

$SUBJECT has an obvious typo.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/entry_32.S       |    4 ++++
>  arch/x86/entry/entry_64.S       |   19 +++++++++++++++----
>  arch/x86/include/asm/idtentry.h |   25 +++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1261,6 +1261,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
>  SYM_CODE_END(asm_\cfunc)
>  .endm
>  
> +.macro idtentry_sysvec vector cfunc
> +	idtentry \vector asm_\cfunc \cfunc has_error_code=0
> +.endm

irq_stack?

--Andy
