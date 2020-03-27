Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A38C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0831F20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKe4Cb+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgC0DLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:11:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0DLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:11:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so3807356pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwbAigggUNd8s8wlvmD42Hd/jDOiySJ0YCfP2HFlXH8=;
        b=hKe4Cb+9FHsvY/cpadeaQU35hJbKCOxpEzJNJ9aF6A7def9HmJIvFwtI1NZ4eIFwkT
         oPA2no/UVcViJBVgER3a9yM53DBqxrBr8J6QNpj/iz1YkYjmucEXBBd/qL8IwiFUsAJp
         XDZpfLReg7CWKF1FveGhAyPtWiCfaZ6k/hEos1QvfybIxUTwwfbUwRD2Sp30UtJgTttV
         Rb3Ls0aCHK0Klf7PgJbyLUN+5RaR0WXqxsvVeXu1jA4CxvTscXHTwCnWsI1YEeGgUksl
         UnFFMmz0aS0XQI0fqkiFi03on3yZkBIK2nYg4XJLDwZtfNi+VMYDzejQBAQoYUBpkWdY
         EMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwbAigggUNd8s8wlvmD42Hd/jDOiySJ0YCfP2HFlXH8=;
        b=kyqcapt8EDy4nDJRP91B2IjFx1nP70fmCu0mow2zq+OsnzatS9xleVHYUWGntzBZlE
         LOnphfdUGRA+gpN3b7ysUZGCvvtdemRDWu6raYdshfiLppxmDLSDlGpWyqGq56nfFVTY
         Z0+yDhnQGLSPQv35VLlxQ+T/3NwDKK8ua1TTbYtVbtltunFFSFVyLPSM0opyVGPCzHzk
         cGbg5EYNeyv5rheWcPQbc7kS8jO/ubDO/IJ9j32HjyT/eTG4Y3pwj6EywwCr2ZDMYVqk
         G/xOl/L4MfMObHkwAN4TPI7ermHMrlS/NwGvSs/hEq89Efg3Va+EteII32zX7DbDlNFm
         Jv+g==
X-Gm-Message-State: ANhLgQ1b6R2r1Uwl9aabh7S64c8JYVn5gRWGNgV3gu//sDKUsVZXq32G
        d50hI3Kzy3QdCIKMIwZvEglXxzyK
X-Google-Smtp-Source: ADFU+vuyfi1/i/H7t4OsC/ew3rGB8isu7qVa9CQNRSW40fBV+vhvhQo9PlafiwdSHXHQ2mGoCByF7g==
X-Received: by 2002:aa7:8750:: with SMTP id g16mr11952129pfo.83.1585278670538;
        Thu, 26 Mar 2020 20:11:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 8sm2906317pfv.65.2020.03.26.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 20:11:09 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:11:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 0/2] Make printk_deferred() work properly before percpu
 setup is done
Message-ID: <20200327031107.GA239054@google.com>
References: <20200326163245.119670-1-jannh@google.com>
 <20200327024500.GA211096@google.com>
 <CAG48ez32cmGxHfijeK1YJLU8WdYv=qooXDYE+PSD7-Wwjg4DuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez32cmGxHfijeK1YJLU8WdYv=qooXDYE+PSD7-Wwjg4DuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/27 04:05), Jann Horn wrote:
> > Hi Jann,
> >
> > I believe we have a patch for this issue
> >
> > https://lore.kernel.org/lkml/20200303113002.63089-1-sergey.senozhatsky@gmail.com/
> 
> Ah, thanks, I didn't think of searching the list archives for an
> existing pending patch...

No worries! Is there any chance you can check if that patch addresses
all of the issues you've been running into?

	-ss
