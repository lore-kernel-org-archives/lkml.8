Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA60D2468A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 05:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIhRZZ/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgB2FrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 00:47:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38645 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgB2FrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 00:47:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so2827455pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzjQfiyBaI95K3lk74duJ7hSEngiyDv1IIK2CSJpD0U=;
        b=FIhRZZ/U4PsaL7I1/OKBE6qkqx4Lcz77kJVE0ZH7NLU1WaT1Rmpq9Wg+hWiaeAkuNx
         kOHNhHGlGz70H6WjYV+NnYsANqVqP+sxzVf5O8k2/Pty1vfdDUqk6qJP25eyUMbAFTqT
         P4VHOyjsE2WIncbzdgBEQJ9pu6tJ1VeMWeBw/+okBYoqWYnu3RsaJP15MrCMIpavt5df
         aF3Fmm02gsY0VM1mIE3S01hSizKqjWFyC7AlSMy0m3DxE90YU2yldHXDc1iADvD0qX0P
         Bc5NXWWswEvhChJBpr6F9VBXYTwGUgc2kUwDmJ2VZhS1JV+VCHqMXx0Zkgp2p7305jQW
         07rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzjQfiyBaI95K3lk74duJ7hSEngiyDv1IIK2CSJpD0U=;
        b=hn765Ka4wJxg7jS393ne+0yCoCO7wtqbtJzfVru+bPDfVyI5UodiRAy+ZhvieaTyh4
         WK2Geu9p7ksTY5+amlZ1NQESKbtEIOsudh4ZaAG+NNtY7jpftIwh7icapS2jMmBEtSYm
         Dgq58EsF8bgDgONZojC3qwRzqCTYXdJO8sNJRjnkOypj6fknj5XcVuvrDGL/ETGkTWF8
         QprPOYbLW6g5w6c13Xp+RPJniGYg/zQDFP4oeFigKwzr2zJZlblhly+d6zZ9Y4jVigKa
         a0PKQuLrQHLub8JZsA5a6UkXff3V3I7KDbl6wKiROZ+Jh3Elw9M0MOEvXJ02JxhwBZCW
         aQqw==
X-Gm-Message-State: APjAAAUJ2liBF2Me1qDjA+1BxXtzoo/OhnkOF9RmhIF8r6y7qq+yerLt
        L+Wz0WUm3Wu5On986y8dnLE=
X-Google-Smtp-Source: APXvYqyQIhbtEe/ZbsEy6P4+aahXlqLVF9alAhmoOeP9JccuU/5H+2ULGQ9BYYIQgVgmGS9alq9SVQ==
X-Received: by 2002:a63:4282:: with SMTP id p124mr8563287pga.59.1582955227314;
        Fri, 28 Feb 2020 21:47:07 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id y18sm12647940pfe.19.2020.02.28.21.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 21:47:06 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 29 Feb 2020 14:47:03 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
Message-ID: <20200229054703.GA561@jagdpanzerIV.localdomain>
References: <20200213095133.23176-1-pmladek@suse.com>
 <20200217130308.GA447@jagdpanzerIV.localdomain>
 <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
 <025fe463a37a01a39e8b988530b36ce79210897b.camel@kernel.crashing.org>
 <20200228145820.6k4ddp457kf4e6c4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228145820.6k4ddp457kf4e6c4@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/28 15:58), Petr Mladek wrote:
> > > 
> > Do you plan to send any of this to -stable ?
> 
> Good question. I would prefer to wait until 5.7 gets release or even
> longer. Changes in console registration order are prone to
> regressions. People then complain that they do not longer see console
> after reboot.
> 
> linux-next and rc phase has only pretty limited number of users.
> Released kernels hit much bigger user base, for example, via
> OpenSUSE Tumbleweed.

Agreed. Let's not rather rush it.

	-ss
