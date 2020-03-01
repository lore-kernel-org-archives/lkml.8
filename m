Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93417C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666A62072A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DADKTDqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCAGNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 01:13:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46939 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCAGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 01:13:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id y30so3719236pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 22:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adtXDOF8q93RKc7Fdg0vhPYRjwvZE/M4lWYuzaWxw2U=;
        b=DADKTDqYabDe8pHek52fRXJrBEqyx6tf3VFhYxSUNX6TJGt0a10fKs6hQFyrq3iY6U
         9Hs2fz64HPv+DpPx9t9wYxF8I7VMlorkMClqhkAmp9GpDeGNFXvdfg7MxttI7F79sy+u
         BD5KjVjerq93Lo96YgWHpM8sYIsg9u9vhxV81n80Kjrs87ToVYozYVnKG7PZkBOV/thj
         ZAf3NOyl5GeBS5GckBDK33yY2Vzv2c/dNR2/omQOkCd7bXaXRFMn21JAj+slpBNdMJ2j
         DD0rv9azrtvhDZg7OoP7hKADy1fIgC/2O/nKQKzkc/ILN7o6Wv6VW1InU3uFD8nNY2LM
         7pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adtXDOF8q93RKc7Fdg0vhPYRjwvZE/M4lWYuzaWxw2U=;
        b=eoCSrZo1jo8MfjSpTgeRmHEUA5m+5UwW2DhKkqgJ5Jim9LbXbrfBBO6v70RC9CU6/s
         Fbk5Ssq5iQsxXT1oldJ2YBb+Jnegfb78IU1kt9ascIN/+Joy0aRSzMjki/B54ce7L21n
         4w91YS0vje9En0Gm1S60K8WbpZhtEAy/faMIN9yQ7JJ1zDjBDZNJ0U6nBc0HdEs/urez
         3qqimAkDA18bQwEmT4m+b0IaR0gR9dSGERZAojJ+Pw3NnSIKzc3CDs6EIgslbg4quOtE
         FavzkXx7mkdwWKZpPntJx8156EIYSrx7ElibOQXwhUmJtJrQev/CwEjgZGVBz8zIFkUp
         O8ZQ==
X-Gm-Message-State: APjAAAWxrDJgLzVdmSd2wZQ12ymCdtFLCIXHN8wNiLaxPghibauH4Jip
        AsmMsPiMVEwaGzdOtgh1gtU=
X-Google-Smtp-Source: APXvYqzvEBQQuLLSOkvqS3Z/Xr3qCAU++sJgswCmT0czGi22mVOoBEtaQW2o1jpSItZbvsgH4iTf9Q==
X-Received: by 2002:a63:d0b:: with SMTP id c11mr12535161pgl.296.1583043210548;
        Sat, 29 Feb 2020 22:13:30 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id c15sm15231747pgk.66.2020.02.29.22.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 22:13:29 -0800 (PST)
Date:   Sun, 1 Mar 2020 11:43:27 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200301061327.GA5229@afzalpc>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
 <20200229131553.GA4985@afzalpc>
 <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
 <20200301010511.GA5195@afzalpc>
 <alpine.LNX.2.22.394.2003011337590.15@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.22.394.2003011337590.15@nippy.intranet>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 01, 2020 at 02:26:33PM +1100, Finn Thain wrote:

> BTW, how do you distinguish between "new code" and "legacy code"?

setup_irq() was used in olden days, nowadays request_irq(). Though
there are exceptions of trying to use setup_irq() even recently, but
there has been pushback when people notice it like Thomas had done
[1], and i saw recently one in mips smp support series & suggested not
to use it (that code iiuc they had it out of upstream for a long time).

So existence of setup_irq() in general i have considered to be legacy
code.

> And why would you choose to do that when you are writing a tree-wide 
> semantic patch?

The way i came up with this series is that while trying to understand
irq internals, came across [1], so then decided to do cleanup and i
thought scripting it would make it easy & also had been wanting to
get familiar w/ cocci, so decided to try it, but also realized that i
cannot fully automate it (Julia said my patch is okay, so i felt cocci
cannot fully automate w/o investing considerable effort in cocci), so
even w/ this v2, there are lot of manual changes, though cocci made it
easier.

> I took Geert's comments to be architecture agnostic but perhaps I 
> misunderstood.

And Thomas suggested to make improvements over script generated o/p [2]
and only consider scripting as an initial first step. So the way i am
making changes now is to take suggestions from Thomas to be applied
treewide, at the same time also take care of suggestions from
arch/subsytem maintainer/mailing list in the relevant patches, since
arch maintainers are the ones owning it.

Sometimes had a feeling as though the changes in this series is akin
to cutting the foot to fit the shoe ;), but still went ahead as it was
legacy code, easier & less error prone. But now based on the overall
feedback, to proceed, i had to change.

Regards
afzal

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
[2] https://lore.kernel.org/lkml/87sgiwma3x.fsf@nanos.tec.linutronix.de/
