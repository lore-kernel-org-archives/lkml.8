Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F123DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B577320708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBFOHRn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHNDe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:34:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9439C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:34:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so3748903pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rv7H7JQG44l7QlXl6c1SFGZslN2t4Z38fCpQx61T4KM=;
        b=DBFOHRn9GVpjC5TKtm4ZrguB6zIcH7BVvJJYHPEn+V1jEFRW9q0eA3ofbjrB5NwOvn
         g29sD1XZdw0d7dkPuDXZRYcxS3uzuCRz5AKwPsaZfyEhDN3x+sIU9vfylwonzQhhHpuV
         hgIcpo3yoCpSzxL7rWnCa6H28f84cRr18ZKvwDTDK82EWAI5yjA0jdJdWy527h0nAyhQ
         xfc1NpqA5VIQxVnzzv41UoiI68w8txi6lRUeapcx5OWRoQzYCEoY54M+kmL1LDaN4rg8
         xHjHRScKhEulI9iRQKCdjiWzeAL/cZBJfIZ4P6fYc5crFRAcbC9l30og0w5evdu8ZMJP
         B22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rv7H7JQG44l7QlXl6c1SFGZslN2t4Z38fCpQx61T4KM=;
        b=Cdv4NV7oVAeT1ci3VLdPqsya7wdrjosNqPL4DrF2gnUtmvzBtoxc2LiQnOFEP6r/kI
         pXSD/ynCCoMPGcgxQaGxligI6xwJm3n1S0XCRQ8AId37goZliozMX7YNJgqkcc60XDth
         XdB58ekHbOS1uzJfGb0cHRnLaGgpGEx1mpRzKE+KCXcAbi9PGiVuvf8kYGpVZZ/2K63B
         I53VSkytWEQAqjkBa9BOnXBzTOdBpGiHYoDMi7inQvPKCJPgwOXex9Oblqiaw6bd5Wad
         NFmPf7yj+0IPFkmmAtMqVOjnaYIk1gytRtwTKAvO+K/KLTU9k11GrGQKVaAI+Y8wznyA
         qrDg==
X-Gm-Message-State: AOAM531zary4lVNahExquqrzVRsNmTahmzY23tTA8idXkx7XHBoH/9GU
        adREuAFiNtYp4IuEbygHa5Q=
X-Google-Smtp-Source: ABdhPJy+oaY0x71lX2fewiQc9Sgn5Be6w2lPo9j6F74SkESXupDT8FejCzxQyaEO2JknUfzn2awG4g==
X-Received: by 2002:a17:902:59c7:: with SMTP id d7mr661584plj.316.1597376068221;
        Thu, 13 Aug 2020 20:34:28 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id t10sm6631452pgp.15.2020.08.13.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:34:27 -0700 (PDT)
Date:   Fri, 14 Aug 2020 12:34:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200814033424.GA582@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9hmrg84.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/13 12:35), John Ogness wrote:
> I believe I failed to recognize the fundamental problem. The fundamental
> problem is that the pr_cont() semantics are very poor.

The semantics is pretty clear - use it only in UP early bootup,
anything else is broken :)

  /*
   * Annotation for a "continued" line of log printout (only done after a
   * line that had no enclosing \n). Only to be used by core/arch code
   * during early bootup (a continued line is not SMP-safe otherwise).
   */
  #define KERN_CONT	KERN_SOH "c"

> I now strongly believe that we need to fix those semantics by having the
> pr_cont() user take responsibility for buffering the message. Patching the
> ~2000 pr_cont() users will be far easier than continuing to twist ourselves
> around this madness.

I welcome this effort. We've been talking about the fact that pr_cont() is
not something we can ignore anymore (we have more and more SMP users of
it) since the Kernel Summit in Santa Fe, NM, but the general response back
then was "oh my god, who cares" (pretty sure this is very close to what Ted
Ts'o said during the printk session).

> Here is an example for a new pr_cont() API:
> 
>     struct pr_cont c;
> 
>     pr_cont_alloc_info(&c);
>        (or alternatively)
>     dev_cont_alloc_info(dev, &c);
> 
>     pr_cont(&c, "1");
>     pr_cont(&c, "2");
> 
>     pr_cont_flush(&c);

This might be a bit more complex.

One thing that we need to handle here, I believe, is that the context
which crashes the kernel should flush its cont buffer, because the
information there is relevant to the crash:

	pr_cont_alloc_info(&c);
	pr_cont(&c, "1");
	pr_cont(&c, "2");
	>>
	   oops
	      panic()
	<<
	pr_cont_flush(&c);

We better flush that context's pr_cont buffer during panic().

Another example:


	pr_cont_alloc_info(&c);

	for (i = 0; i < p->sz; i++)
		pr_cont(&c, p->buf[i]);
	>>
	   page fault
	    exit
	<<
	pr_cont_flush(&c);

I believe we need to preliminary flush pr_cont() in this case as well,
because the information there might be very helpful.

	-ss
