Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA5BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC902086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuPmM2Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgBNNHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:07:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41885 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:07:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so4938999pgf.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWFS4TNhJKgHZrDSECdzXUZNDwqr6aFn1S5mWIDwQBk=;
        b=OuPmM2ZtbzcJifbGfpmNJkAMu7JOjVo8qf78dtwRyCp6R9h4aGUAY238tzIDq/PZTJ
         2mad+QBySu6AOzjHTA3LsQibYqLqm4Vc+2OJOKxeojb5tVv9XGGIJuxUYLcAA3PlEwf7
         MhSVK7TgpSzcdtwZ5CsJzDSyYcfK8Y/vovIrhknpUE3Oh9Y1ZNlvo7JhSEPO8uMCN2S/
         OyiR/czzDgBCUJ8WTd6mO5iSsv/JoMX0r00Ne4BP6HmsW9ZaeACbBMekiupO5Fmg3ANC
         h8IUY4bbld8TPM65KUSCLv6r/d4DirfpiLyn2ede9FFO5516l4akjhv8Iw2rmGMqLfXR
         O+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWFS4TNhJKgHZrDSECdzXUZNDwqr6aFn1S5mWIDwQBk=;
        b=my6YOlIZtc8VtS2ikWhJdUn20Kr0JGDViMTb/I6i4zqt7KACHWcOnmYo8+jMRL7uMb
         1SlZvJtBlg7hyR7b3Y1VZz7vYv/BIeZSAXBsL+Dsn9h3ku4pzQ3xc8N2juaUNl7lSkyl
         IonMAgotlBgPj6gRjNNVbbobp/w2kKh+rsGHa215ME7wPNmmwaz87cUpzHIwdOAShWdJ
         olaQqN6tRjZep+yNgh3+kQycLN5h56tX+c2dw4sKmT9xJO38+zXMYtcJAG19JIG7EJrM
         7/LFp2z2bfNZaw1WA40VctnS+wevX+aX2YgQ5YV0zUf21AGv1qt+HcT8TKq6rI6EruOs
         vUmA==
X-Gm-Message-State: APjAAAVVUI01jcuAm3TXDIvC2c/ooFdynMuM3lmsyBXRds6OKT+YTBfO
        VsFuVG5+2/nu/hW4+mt4FHU=
X-Google-Smtp-Source: APXvYqw3lNsRSUEHDuHqCpxq1u9xqLkNp7mqqa6f68ukq8YcUBTUSvo7LiRC6M0bWJpLzU4kVuHp6A==
X-Received: by 2002:a63:691:: with SMTP id 139mr3563463pgg.325.1581685634099;
        Fri, 14 Feb 2020 05:07:14 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id s13sm12576162pjp.1.2020.02.14.05.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 05:07:13 -0800 (PST)
Date:   Fri, 14 Feb 2020 18:37:10 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200214130710.GA5675@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <1941c51a3237c4e9df6d9a5b87615cd1bba572dc.1581478324.git.afzal.mohd.ma@gmail.com>
 <bfb9c0bb-0c16-5516-d788-bbd2ca86fc58@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb9c0bb-0c16-5516-d788-bbd2ca86fc58@linux-m68k.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 13, 2020 at 05:11:17PM +1000, Greg Ungerer wrote:
> On 12/2/20 6:03 pm, afzal mohammed wrote:

> > diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> > index 71ddb4c98726..7a55d664592e 100644
> > --- a/arch/m68k/68000/timers.c
> > +++ b/arch/m68k/68000/timers.c
> > @@ -68,12 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
> >   /***************************************************************************/
> > -static struct irqaction m68328_timer_irq = {
> > -	.name	 = "timer",
> > -	.flags	 = IRQF_TIMER,
> > -	.handler = hw_tick,
> > -};
> > -
> >   /***************************************************************************/

> Remove this comment line as well. Nothing left to separate
> between those comment lines with the struct initialization removed.

i will remove above as well as the similar ones.

Because  you mentioned, i checked cocci o/p (change above was provided
as is by running cocci). Cocci by default removes the comment line you
mentioned. Initially that was the way cocci was run, but then it was
observed that in another file in addition to removing associated
comments, it was swallowing other unrelated comments that were living
together. Also sometimes associated comments had to be retained, just
that it had to be relocated near added code (that is not applicable in
this case). So i ran cocci w/ "--keep-comments" option & decided to
manually handle comment related, in this file i failed noticing the
unneeded comment line during self review.

> I tested this out on ColdFire hardware I have, worked fine.
> All defconfigs still compiled too.

Thanks for testing

Regards
afzal
