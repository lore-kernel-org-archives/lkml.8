Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA201C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B92074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU7NZ5lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEOKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEOKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:24:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:24:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so728433pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PGybp4d555g//9H3GiWo4hvFh60jsI+s9m8Oige6iHM=;
        b=mU7NZ5lTbT5eBu8L5irKydmLWQdyjrqCs7Ncjj9uLohQKJ+Sh7nq+Cqcks/IQjyMdv
         UY4CkOMjWuf/EhUm8Nrme9nle0BqJSr4o/wrW5VM61L8fiQb6STCQ6g9aMEZvrOYO5r1
         hr7orQ8oqmedWZ9EuLxi0lBJDoPtlhJ0CvoRL65sUXi3tgyd7Y8O9/dc4DZF4FSmsB3Z
         a4icTgldsj7/BpPxyMOQbVqmglv6HatFAXiryJA0Y2q05fOSETGzE6Mi0zafN585zwGp
         NQQRqo2xZtOkjOPmHaqHwwt/krpwfxFW2+yh1lWvBNr6GIDjXhbVmyFVfXxUz5raBCSe
         IXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PGybp4d555g//9H3GiWo4hvFh60jsI+s9m8Oige6iHM=;
        b=Ph+TsMMgRbTQ6+GNA37JVmyBRnopCqo6w1ZYMxlWOk/mFtk5P6bfRwgJO1vOsMgu6c
         qV5slcTfksvxfaUidqNSHgwMjfyGabI4DfjzekhOyxyyYTQ/B5RHB7aI+sslxZGCVJxP
         WIRyMY7RxAI5Nxad35GMBzgI2N+90UQQARcHLrgfWHCQI4uJ0MvLoCxCEGHqrLjhN9n5
         NemDMa/eccnizyjuRqA+q6XzDVmja7wVEL3NmQZ9EnWV1tn/+CYiqsCajVKc0A0G3/1Z
         fHX9NWWzcRjPt/pfZHCXEiu2YJ1moDyua+HNiDXBFaqO2zvXNkc3fq6fxlOqOHyb4I+5
         heGg==
X-Gm-Message-State: AOAM532uzFpOaTFl9If/7pVsNs/j5btFYm8WK3a7kZnCsCIldotie3Cl
        3ay3CwPKJojFSHTjpJCglAG9K3t/
X-Google-Smtp-Source: ABdhPJyNmjuyT3RDx6u+RHl1lI/BSy3F2aEZvDw9NwTz8Dsv0aIVB/7o/9VsJm7v+zskOFPCOOoCGA==
X-Received: by 2002:a17:90a:e147:: with SMTP id ez7mr2724356pjb.128.1589538270185;
        Fri, 15 May 2020 03:24:30 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id gn20sm1301945pjb.24.2020.05.15.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:24:29 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 15 May 2020 19:24:27 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: replace ringbuffer
Message-ID: <20200515102427.GB42471@jagdpanzerIV.localdomain>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501094010.17694-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/01 11:46), John Ogness wrote:
> Hello,
> 
> Here is a v2 for the first series to rework the printk subsystem. The
> v1 and history are here [0]. This first series only replaces the
> existing ringbuffer implementation. No locking is removed. No
> semantics/behavior of printk are changed.
> 
> The VMCOREINFO is updated. RFC patches for the external tools
> crash(8) [1] and makedumpfile(8) [2] have been submitted that allow
> the new ringbuffer to be correctly read.
> 
> This series is in line with the agreements [3] made at the meeting
> during LPC2019 in Lisbon, with 1 exception: support for dictionaries
> will not be discontinued [4]. Dictionaries are stored in a separate
> buffer so that they cannot interfere with the human-readable buffer.

I'm willing to bless this. The code looks good to me, nice job guys.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
