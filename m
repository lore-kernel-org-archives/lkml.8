Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94954C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDEF21556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjyyG9at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCAFWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:22:25 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38088 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCAFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:22:23 -0500
Received: by mail-pg1-f182.google.com with SMTP id d6so3701532pgn.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 21:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HK1vzU5vvIBaejockOry64ZPx0jB3s54YWpqriTgeSE=;
        b=VjyyG9atwGjNmLS++K4PgL21FUipe7nIE+Gl0i6iS6+hGSEWE2lEgYrvqHwyYJle3L
         NrZqObcg0fwZNKU8jXflYpoYtGwF8+KgCtiLerVelANE8wQHIbcXTDtKkeTiQgQxrY/M
         Hgp4MzurYm5pOiNFKMkIxZondwUenKH+yW0o+6AmY5rERsM7icX3PuZ+fHc/hKW+KybR
         Xc37Ia0UgcSru24c9Ddp38Pxb4Jx1E6AId0X77dv+lLz9Zw7DOpgCBskvoOu3ocTInOD
         BcR4XSc8ILI9shcNT4VI94hzP8u8xHjOlm69NnpbZSUlh/2HghylAvsv6n03Xul72dRU
         tMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HK1vzU5vvIBaejockOry64ZPx0jB3s54YWpqriTgeSE=;
        b=KeMY+Zl9xq5otN0Q/6ROqRVDgCaFRefC59XLrA6nRfRjbF51sq+yNtePYf8mKx8w1O
         Kek395RU53mggx+nYzScEezzLSKPRuPxOGP+qp9+UtItpmoi4NLb7Lrp702XhP0rqpoD
         DrHF5FaKVPWdaXvuJEg4d/33KCik22wXcgtcJ41r6PH7JYe5DVXH/WGAYP7Znu89nKvu
         U2M89XlUJg9nEjUf4Kr1767wMHsDteW8RnKyjZNW00bJd7iej59P2rOmRiLcuoqwDV2x
         EcFl+6jYFSAvBmjD8ACUPOTI7QgSUvJb6oaTnURfMXm9AFxgRMKqhyFajIT779olXs5T
         gkeQ==
X-Gm-Message-State: APjAAAWoASThEWe6qPcUE4Y89+r6q5s33TOR1ndB5wS8xU/EVk8sK8iC
        RVliiXswGVW9EmeAmh68aiy8WpKk
X-Google-Smtp-Source: APXvYqwYZgO8wG3g2BmgbTLAwTyTeCTxr8bLyzGQeqVNWZdddS3p45g0AWLMsh//qTXhx41q/LL5gA==
X-Received: by 2002:a63:5b1e:: with SMTP id p30mr12451616pgb.71.1583040142240;
        Sat, 29 Feb 2020 21:22:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 5sm3680873pfw.179.2020.02.29.21.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 21:22:21 -0800 (PST)
Date:   Sun, 1 Mar 2020 14:22:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200301052219.GA83612@google.com>
References: <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
 <20200228105836.GA2913504@kroah.com>
 <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
 <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
 <20200228205334.GF101220@mit.edu>
 <20200229033253.GA212847@google.com>
 <20200229184719.714dee74@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229184719.714dee74@oasis.local.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/29 18:47), Steven Rostedt wrote:
[..]
> > > What do folks think?  
> > 
> > Well, my 5 cents, there is nothing that prevents "too-early"
> > printk_deferred() calls in the future. From that POV I'd probably
> > prefer to "forbid" printk_deffered() to touch per-CPU deferred
> > machinery until it's not "too early" anymore. Similar to what we
> > do in printk_safe::queue_flush_work().
> 
> I agree that printk_deferred() should handle being called too early.
> But the issue is with per_cpu variables correct? Not the irq_work?

Correct. printk_deferred() and printk_safe()/printk_nmi() irq_works
are per-CPU. We use "a special" flag in printk_safe()/printk_nmi() to
tell if it's too early to modify per-CPU irq_work or not.

I believe that we need to use that flag for all printk-safe/nmi
per-CPU data, including buffers, not only for irq_work. Just in
case if printk_safe or printk_nmi, somehow, are being called too
early.

> We could add a flag in init/main.c after setup_per_cpu_areas() and then
> just have printk_deferred() act like a normal printk(). At that point,
> there shouldn't be an issue in calling printk() directly, is there?

Sure, this will work. I believe we introduced a "work around" approach
in printk-safe because noone would ACK a global init/main.c flag for
printk(). If we can land a "per_cpu_areas_ready" flag (I've some doubts
here), then yes (!), let's use it and let's remove printk-safe workaround.

	-ss
