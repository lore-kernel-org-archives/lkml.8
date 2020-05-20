Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923AA207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrWi5oHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETLRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:17:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:17:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so1390020pfy.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9jhMLSlbbRWBPFkiGcwNA69qHZJzJ0AW02rtZSNSek=;
        b=HrWi5oHJs6KG0TnjQSTOJ04Qm8KbWmxtVcZBF5c3JhUMZljPumg7wlWtu1EQ2ff2ht
         THAOlS5+DB9E9yy2+PSvNvTVKUbHSGfzo07tr2CCCE8heT/cQUrLzll+kvrKdclThJIL
         q2LtnI5Cj81ZgJXMwt28k3gfzCenwzUr0nNrBr2J5LoUsLsdhaq6ziDgdo+E47vhGEi7
         AAOUewCCwVkCtQ7tWlDu4NWo6Wl03kRXAVcRfv0IAwjaIyQSOPPsjXTeasjYVs1N1cYg
         PLJ3+lB5K4RMqHe0Md7C9BYx7xGQr2bJo2m3eOl+aTdqd97v9Sr5cLMNj/TriqWwpY0Z
         PPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9jhMLSlbbRWBPFkiGcwNA69qHZJzJ0AW02rtZSNSek=;
        b=N5mt299/i8kKob/wgY8REyCfoKIYCkA0W/Uh/KmClE9cqgYGGd+qRgWK+wJyjO5GPq
         sKYoAZGDu/hlkraMLJj6Zt3LfcuJkAyceYeLU/BCZkjQsMowxVk2j244iJDyW5LEgs+O
         uDJCWW2cm+CHK/wEK0W1S3q2XRmgy2s0YTbbbPOBIr0c9YAw4n2WE7R5W+5GOtw14HKZ
         qIVTrYq5V7imc1h6wBy+XFXBVph/ZRjPHPg6YGVQ5ebDGq44/XR89btdk+wEwIzNEwhI
         2ceY8wo6RkKhJDN8HaDvxL3+3bR0Cb0/8YYZbuUe3fpdPJqs5QgiavWGm6keOudBaUDQ
         BU7w==
X-Gm-Message-State: AOAM532Td5eACNBUIszsVdV9cQg+N6nylP36ICy4I2m/dmHv/lN0rlFA
        3r73eEJLjT1q6ARXg7ZEsA0=
X-Google-Smtp-Source: ABdhPJyX44rVAqEouWz5zdqFz0iyoiBYEjg0TYxUEUAoXZr9buZWGPmsQvjC9HGlkPRy7cTN8md9Bw==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr3500311pgn.81.1589973468726;
        Wed, 20 May 2020 04:17:48 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q7sm1709586pgs.13.2020.05.20.04.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:17:48 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 20:17:46 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200520111746.GB520@jagdpanzerIV.localdomain>
References: <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
 <20200518092139.GK7340@linux-b0ei>
 <20200520042102.GA938@jagdpanzerIV.localdomain>
 <20200520093557.lwwxnhvgmacipdce@holly.lan>
 <20200520102233.GC3464@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520102233.GC3464@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/20 12:22), Petr Mladek wrote:
> kdb has to get messages on consoles even when the system is stopped.
> It uses kdb_printf() internally and calls console drivers on its own.
> 
> It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
> global variable to redirect even the normal printk() into the
> kdb_printf() variant.
> 
> The variable "kdb_trap_printk" is checked in printk_default() and
> it is ignored when printk is redirected to printk_safe in NMI context.
> Solve this by moving the check into printk_func().
> 
> It is obvious that it is not fully safe. But it does not make things
> worse. The console drivers are already called in this context by
> db_printf() direct calls.
> 
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
