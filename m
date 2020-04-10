Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A30AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AC8207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqHPtwF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJXVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:21:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46344 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJXVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 19:21:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id x2so1122105plv.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9rr1VKWyEALbXbYJDgG44N0IBV573QpeNjixpL7Fps=;
        b=EqHPtwF0RAZT4eXEJWBVBQ8dOXG6ulZO6UMNH2v/78ClluLlL1vDcoWJbif5qsSEtv
         x+GGmYWBdY7NxyF+21S9e8nWUPgoUvCYIvKu5SyN5KRq+A0M6v26neEPR7crnPd26js/
         mMl7XuvQYVvhBmiudRHFS07XxEpekk4ykegXOyi7Wn0+PQ9rEBb+ui26Nq4V7PKD011L
         fk7zwbd96BgSA8aKONpPbyw5p8fgyE81m/gHg+KW9bLxPM1UlClWV/lBEdCiUJyTA5OA
         6wstgUtZxzu8bk70wAafPGnD0ATSvpDk7oQhi925Q7mgId/X1MHAxX0SblDHujoOx3iw
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c9rr1VKWyEALbXbYJDgG44N0IBV573QpeNjixpL7Fps=;
        b=O+bzaxr04+BEDSYK+m2qw0yM9jifqN66aYhSd58Wl0e7p7+a7eROKHi+KOcZIvN7Ug
         T4Mgg2lfGCF8ZGa8AG1oU657RQb51gE6BDc/QSsNfj4L5ufhbEB/AkvMm8ca50KHXVs+
         nlHHFAvIGKCNR9NTZyA7p816Z74bO1JAVg/mR0koedofWUa6GBSYyWqiEYyIt+nHRuKT
         QNvnRZyQpJYB/QbldqgwQsyExPAf3kJqdaNlOvPIalyYv7Dgxm/nQ/n4mWYJk3c9NJQK
         tYGmaZdZ5bIQuX81LmHFuNxurdVCQG7F+Z7X4/GxKNdy3Q+/VveRce4LG4HKP6ClPS5y
         vCmA==
X-Gm-Message-State: AGi0PuaBWVTjLvNOR9TRbU+UdP8heAdhulcNfTdJVzNkJSHXSCPyUMyx
        /rQ7lgHxCvYQJPiKrSyD7Uo=
X-Google-Smtp-Source: APiQypILPAptqcOulWb0e7t8xSRyv3ELPqp+EdUIrsuLARwBeGrwGBfhkdn02rNxEBk8TS7LEGv/Fg==
X-Received: by 2002:a17:902:9b89:: with SMTP id y9mr240416plp.75.1586560905307;
        Fri, 10 Apr 2020 16:21:45 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id t3sm314439pgi.84.2020.04.10.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 16:21:44 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 11 Apr 2020 08:21:41 +0900
To:     Simon Kirby <sim@hostway.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>,
        Jann Horn <jannh@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200410232141.GA497@jagdpanzerIV.localdomain>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
 <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
 <20200305013014.GA174444@google.com>
 <20200305185348.GB2141048@kroah.com>
 <20200409192543.GA30816@hostway.ca>
 <20200410030704.GA20227@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410030704.GA20227@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/10 12:07), Sergey Senozhatsky wrote:
> On (20/04/09 12:25), Simon Kirby wrote:
> > This causes "dmesg -w" or "cat /dev/kmsg" to not print new messages after
> > dumping the current ring. I hit this on v5.5.9, v5.5.15, v5.6.3, and
> > Linus HEAD. This prints no "hi":
>

[..]

> I'm trying to land this patch. Give me a moment, I'll come back to
> you shortly.

Applied. Commit ab6f762f0f53162d Linus' HEAD.

	-ss
