Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC27C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ADF24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfasCkiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgB0MGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:06:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54990 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgB0MGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:06:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1044188pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DLH6Acix5M1BKEcvLfWo58JWvq9L0Umgbaen22R2Dyk=;
        b=WfasCkiK0AFHSjOixeBAKtVxYMbxrTBLRfpwbS+uUi7bvimfuNjq7Dn0bkdAvVxw+v
         OiMRfyzNwS/ZDBNkTtaiYH+wNXar8pDhjmiajDFOMDXUrTFq/v1aLiyWPkOsAW+MheNl
         en9VcpHYhqcCft+pnKLNdMgwTHi8F8qFRPg2rPBjbzVqsnzHG30vetWnf6GKQXdFfPJP
         ytYKiEhUL+dGI/ve7l/LU6RKm0+47nZcZZhRNI6Jpgch14fqCORyKmUI16FR/hDcbaRL
         3GZ/NpLf215mlZE6xnxfAsVkBW/n4gCp7Pp2qA7+NLLU5WtTJk0iKzUdPk4uFibj+mHa
         h5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DLH6Acix5M1BKEcvLfWo58JWvq9L0Umgbaen22R2Dyk=;
        b=WMdSSKuiqJqdPotISx7RheNdRUR7rx7nN+VimHyLkv9vTDUUTLUHeqYRmHDAM1GMaJ
         j1g18uLrOQesbtLQePI2Uj7HlKFZAlP5tJCfj7eC5Cj9DCe7Bz5XribUvkqwbkRqqVEg
         8FKG5LbYEiyWgb8BsiBZJ3+tLJP/MDa5gpA5awePiC7iboJ/Ooz0Vi0BfkBtGHM5rsfL
         /H99lkvmZHnkgrp2IBc8nTlHBa+jUmGgDsGlJozgnpZlI03ELysSSMCDqw7C8zaa9FQu
         Xl1HZDcoloUc0LjIhj2OS1hvLuajanb3OS/VS/a9yL9cvLEilhCFBA8QHC2uM4XGh6Vv
         NE3Q==
X-Gm-Message-State: APjAAAV0MaR7gLotRgvj9KLQElE4sM0qjlSxcp969aUaNattVNyGCPop
        H35ajutppDkdcWYh8k//TThT/HkTYJU=
X-Google-Smtp-Source: APXvYqzEfHfVjc2c1PIpktDjHKHPcQRxdEYB7naUpkCw0Jk2Qx6OorAJxyUJZxN7ffmrHDvAX86wCA==
X-Received: by 2002:a17:902:348:: with SMTP id 66mr4232424pld.137.1582805181014;
        Thu, 27 Feb 2020 04:06:21 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id a9sm6759999pfo.35.2020.02.27.04.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 04:06:20 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:36:18 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200227120618.GA6312@afzalpc>
References: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
 <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
 <20200227081805.GA5746@afzalpc>
 <CAMuHMdWVVWaoHA1Tie5APYBq3Pa3s4BAoWN1jAACAZZS65UA7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWVVWaoHA1Tie5APYBq3Pa3s4BAoWN1jAACAZZS65UA7w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Feb 27, 2020 at 09:32:46AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 27, 2020 at 9:18 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > Since most of the existing setup_irq() didn't even check & handle
> > error return, my first thought was just s/setup_irq/request_irq, it
> > was easier from scripting pointing of view. i felt uncomfortable doing
> > nothing in case of error. Also noted that request_irq() definition has
> > a "__much_check", so decided to add it.
> 
> Most (all?) of the code calling setup_irq() is very old, and most of the calls
> happen very early, so any such failures are hard failures that prevent the
> system from booting at all.  Hence printing a message may be futile, as it
> may happen before the console has been initialized (modulo early-printk).

The main reason to at least acknowledge the return value was due to
__much_check in request_irq() definition, though w/ the compiler that
i used, there were no warnings, i feared that it might warn w/
some other compilers & in some cases (may be W=[1-3] ?).

Also as most are tick timers, if request_irq() fails, system would die
in that case. But i have seen (iirc in MIPS), in the same execution
sequence multiple setup_irq() invocations, so every instance might not
be unavoidable for system boot.

For tick timer cases, a BUG() might be suitable, but i didn't even
think of that option as that is a recipe for getting trashed from head
penguin (though he would not care trivial patches like this), same
scenario w/ adding warnings.

> Just my 2 €c.

That is my 2 paise, but per exchange rate it will be far less ;)

Regards
afzal
