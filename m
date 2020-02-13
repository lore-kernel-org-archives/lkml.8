Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05852168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdHLNwR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgBMMCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:02:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37300 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgBMMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:02:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so2342341pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRXMjUNw+xleND16yc9+iBGDSDnAovrhaKwTKWLvH4I=;
        b=OdHLNwR411oe2vSXB1qG3m0im5YFGhl4JzmYcPiV42wya/We0CecqYAW7NJYKzrQEf
         cEm54DZEJ7CAyStJT/+OXURPcmmO+khiVuz0nRfJkk/G9rGFZOKxLNkGZ9w26bmTwL7m
         P4VzPfvmxBJY7u6i7kRfsQU9I7HoiVC08PEr6B1BCbLLmRrIfySlYhjzxy+YpyroDhZN
         zRKXldy68/Au+jJoW6j5YeTugxJvOPYNKLwnEldc+8F4gq6hyMqvCAw0q3oaw5YzonxS
         LygOvDyb3Vs4Kqh/A21lonAAm0zZNugoNwUyO0kFwjCUZIvayHAnLmEwmWANZeYpKGLm
         xabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRXMjUNw+xleND16yc9+iBGDSDnAovrhaKwTKWLvH4I=;
        b=tfe7Z033fcrXVQX5dkzQSRYK1JqbPN/7z3SgQnKDUmo4vMGjd9RxCo8doYUfn0HpJb
         eaXFAWnEUr7WsJdjIJnK/F7IvE6vPqiBQp6AXX54KkC2AZJLLJKTn5C8+JztWAuIsRwS
         gRFrCT/fqVkAQgdvkbfU8f0uCytg4jqW362Ku61jmSHWCasd/6H+fyrj4Ff/6Egz083L
         GvU3bfviL8x3UBhlLRxfrqN5I4rah9Jl17v87VfuMIYw8MITpeXUUYFvJqOpsc2bQ7h6
         Wqdj2XMDSD3x19DLXW/47/L/BAmUbhO37s3woiaoL3wOadiGSYKQnxhcwQ1f8z+59e0O
         h/mg==
X-Gm-Message-State: APjAAAWAtsgqN/pyBPWoRzZjc1VBxVoewEY7vm4eRNxXr5IpfOhMtaSx
        GPPiDdfLeEwdavvxrp1YmL4=
X-Google-Smtp-Source: APXvYqx25fBCeoQmJT3ALdvBFc9+HSoTj4ZG4KZ2G1+KI8gABA/wtnot1/1oCw2OKmzF+m7QH9+/2w==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr13884178plp.323.1581595337260;
        Thu, 13 Feb 2020 04:02:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id q187sm2909317pfq.185.2020.02.13.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 04:02:16 -0800 (PST)
Date:   Thu, 13 Feb 2020 21:02:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200213120214.GD36551@google.com>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
 <20200212013133.GB13208@google.com>
 <20200212140355.56drih2wfcryjjtl@pathway.suse.cz>
 <8736bfdgsz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736bfdgsz.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/12 15:24), John Ogness wrote:
> On 2020-02-12, Petr Mladek <pmladek@suse.com> wrote:
[..]
> >> I can take a look at dev_ksmg.c/proc_kmsg.c option, unless
> >> someone else wants to spend their time on this.
> >
> > It would be lovely from my POV. I am only concerned about
> > the lockless printk() stuff. I would prefer to avoid creating
> > too many conflicts in the same merge window. Well, I am
> > not sure how many conflicts there would be. Adding John
> > into CC.
>
> I would also love to see these changes. But can we _please_ focus on the
> lockless printk ringbuffer merge first?

Agreed.

> The patches already exist and are (hopefully) being reviewed.
				^^^
				are (hopefully) being tested.

	-ss
