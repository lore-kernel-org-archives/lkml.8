Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3AEC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAB720724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAB4762+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgBLBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:31:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38307 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgBLBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:31:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so324197pgn.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+DK3X5s5bAedOsctDapXXhz9ixgced4ShaVeh1Nqq2I=;
        b=dAB4762+JGtjVgDtbWgl6TV1oc/2qyuIF85pCzS7p9b9WdxpKj8ThZD7/UeTOV2e24
         S6YvHkv1/5FrtrQGoU3Fd2Q2MIPUDGt2qPIk5vwrhYMG/JqajxXPB4Mv6GDx054ayrjh
         U7Xhx1EG9og17M3a6l5NJNiEqrRzUWLSNt9YHXDyh7DJpYCpqEbV3k4WgT8eAgseNRRg
         ltc79n5Opl7aCrARS3bZhht/ILrJJ7KlTHdUSx+6/MtCWzs2dk2eNgN+mCNlMTuGgG9v
         zLv09C8bxWhILUPV0mXb01xHQxrW+xH8BqA50B+hEhmbRf9dvOz8bfDpG/MRXvP4d+Jq
         iaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+DK3X5s5bAedOsctDapXXhz9ixgced4ShaVeh1Nqq2I=;
        b=Vj79wDns7PCaTFQAd3earp/nj+cDklwK2c050comx9lJPjF2yaJthu1wQyq4bkxm+K
         hZ3LI8jPHkBKMZo84vG8nu3TVDX1RXQ+RZiMqiXf0KkAZ8Ag3I2BxeS413kXrp0gU4LN
         86DIMoeHXm3im6X/WLwRMCx2VoWml+a6ulMzgGBOPcINESIaQXuv7wMz7+Fq1v/VXHt8
         1EetSFUc5vKeSvo8DITgMNtC7mHGNtofmAf+gRmFTt4MfN5f7Bw5O4Li/tyEN4Vxji1E
         NYl9zT0ZG551OOxF47i9BbeyEP+aAsvqAmORINXbSl06N8aciyAzLtGZVlWeB0mbnywi
         kkRw==
X-Gm-Message-State: APjAAAUckPt96JXfreZdzKx3u3yPHA7wKyotXSgdFIsZKcvwc+EI4YvI
        fAwppukz5HBnV+JC3qt7tRE=
X-Google-Smtp-Source: APXvYqwnTkkD+C5w4tbCrNIWOpC85746oTzvOp46YedvqglJXCvBRk7WLzjqZ0zPC1C4zKkrXZ/C/g==
X-Received: by 2002:a63:d0d:: with SMTP id c13mr5816064pgl.388.1581471095840;
        Tue, 11 Feb 2020 17:31:35 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id r198sm5871499pfr.54.2020.02.11.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 17:31:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:31:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200212013133.GB13208@google.com>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/11 13:43), Petr Mladek wrote:
>
> Even better solution might be to move fs/proc/kmsg.c to
> kernel/printk/proc_kmsg.c and declare printk_log_wait only
> in kernel/printk/internal.h. I think that this is what
> Sergey suggested.

Yes, right.

> Another great thing would be to extract devkmsg stuff from
> kernel/printk/printk.c and put it into kernel/printk/dev_kmsg.c.

Yeah, can do, I would still prefer proc_kmsg to "move in".
Either both can live in printk.c (won't make it much worse),
or in kernel/printk/dev_kmsg.c and kernel/printk/proc_kmsg.c

I can take a look at dev_ksmg.c/proc_kmsg.c option, unless
someone else wants to spend their time on this.

	-ss
