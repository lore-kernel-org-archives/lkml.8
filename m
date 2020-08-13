Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D75C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F38206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHnGjiSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMFS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgHMFS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:18:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB800C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:18:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so2232949pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAXoCZ+XEA3yt3zyCitojp+0S08f20bzr+BL+L7VJS4=;
        b=KHnGjiSfHWioqZdEDRRuaXo8k8MJZG7uowIdWWNO9LRM+E0cFkVgb1XSBVsiZ45xJg
         GKz2bgiUpf3j+DChfFupKb38XZ0TdcX7RWmq8hosjD/8dA5zMYqxlr27kdLfbQMy7YNB
         7n5qunwWjxoRKo0epR/BtOCXLqVcZPz66mPgEdmHkiKpG0Hh8uiKx2/0/Z8n6BeZ8T8G
         l8ctlbBdmN8m+PeEjSTPkWssx3Ds78mzRK9WF7dpubL7AiqJDJtMadeby1mKC4Nz2F1m
         pTJU9owjSZOPUJI/GdZMCMMPZ4G8vGyZyPtDvkvamK5CaD10mudgTQB8glql+v+yWqnm
         rEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAXoCZ+XEA3yt3zyCitojp+0S08f20bzr+BL+L7VJS4=;
        b=H7kKy+9kPqRyuARiAlZQ+qngsLFulmmD1oH3NuUPnHrhodbJuQYPQ2q+fXXZjLIPBv
         Cc2Wyy/211MaSNNy5IvdEgU/igEGMiUz6Q9IWrIivc4md56bgvLZhzwTyvmNvDSSIxrh
         OdvygRPaPHyckfk+U9Hel+8ooRgBDxhS5peS/zcG7KAP/Fjpfj15v9pdr46qE6Gx0Kcz
         lGaBV3EaDwE0MRgd6LoWAlZNsUXZz5muX9qix6OFNyH433BURJrEstjygUkTJVaxMwxs
         tLAKPVhFfMeIgNS5RIHXNfeDU+cHN960BMneLfknhPqer2aybTjZ9NvXOVcEbpYi+x+P
         l+eQ==
X-Gm-Message-State: AOAM5318LQdzuPsWI0CteN4pJtlPQdb2aBXvEMQuVJxodolieN3EQGzD
        FQ2TR9qSjfIrzuo4jKdV7Wc=
X-Google-Smtp-Source: ABdhPJwJWUrSepkhXvXKeqP5MXRf4uPZl9zin3pvRwhyv+6cVTTt+TDqQDkTst5Fz6ChTSmGxG2jDg==
X-Received: by 2002:a62:7ac2:: with SMTP id v185mr2734062pfc.277.1597295936321;
        Wed, 12 Aug 2020 22:18:56 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o63sm173961pfb.190.2020.08.12.22.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 22:18:55 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:18:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813051853.GA510@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9hn2y1p.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/13 02:30), John Ogness wrote:
> 2. I haven't yet figured out how to preserve calling context when a
> newline appears. For example:
> 
> pr_info("text");
> pr_cont(" 1");
> pr_cont(" 2\n");
> pr_cont("3");
> pr_cont(" 4\n");
>
> For "3" the calling context (info, timestamp) is lost because with "2"
> the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

This is not an unseen pattern, I'm afraid. And the problem here can
be more general:

	pr_info("text");
	pr_cont("1");
	exception/IRQ/NMI
		pr_alert("text\n");
	pr_cont("2");
	pr_cont("\n");

I guess the solution would be to store "last log_level" in task_struct
and get current (new) timestamp for broken cont line?

We have this problem now. E.g. early boot messages from one of my boxes:

6,173,41837,-;x86: Booting SMP configuration:
6,174,41838,-;.... node  #0, CPUs:      #1 #2 #3 #4
4,175,44993,-;MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/...
4,176,44993,c; #5 #6 #7

"CPUs: #1 #2 #3 #4 #5 #6 #7" is supposed to be one cont line with
loglevel 6. But it gets interrupted and flushed so that "#5 #6 #7"
appears with the different loglevel.

	-ss
