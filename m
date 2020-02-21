Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2203C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A420578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tl+Wcnr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBUQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:26:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36291 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:26:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2545341wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2BdX92xgRchLZuvXrE5DZZXcR5Fu/6x6cjykr2bzRwI=;
        b=Tl+Wcnr0riRLBzKhr/XZ6K0ULSRj25/7iZ8DHKd9FX+3LliCzYSarv+/SgKHOQt+4K
         gPK+hPheEGvwkCtoJbFK/70K0516UgQt3dahuEmVkPI3Wf8+B8twXnzBq9DJXiAtxrcS
         Ou+cg0vouJ+VoIFwYl8hpzZcz3umOgHHiVUhKe+Fc1EE//zQ/OBkEcGxOZDMoVjoSUyU
         qwX7UH/lo2cJ1Cc+PApw4McwpEo3dxOylecu/9h7X14e09fygUEBKkFRPw1E41nq1niQ
         NOPDAzP7gLEL2sTxSaYp2gz5AM5YXsgkpV9x3pg3QljcIzW/mN7AUYSdKd/QZC6nnXk5
         bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BdX92xgRchLZuvXrE5DZZXcR5Fu/6x6cjykr2bzRwI=;
        b=RgKrrCdTmmUH2lKaza30E4uPy+tqMx4K/IoUjU/BDQ7LeYqGmEMuA4mneXMOqCRvL5
         whsoLe0vsWg9IVU+tqNF2CrnTuFoeMg5iTXmFRH390wdBjbYc502ytPFIXOBtMPMSrek
         5+KLSqAh9RCBV778CTnoJCWnDDZkF69DD0c/0Cxuik8fV8+95oQA1aLWLjMgf4ELpXI9
         3EKWSs8M4ohOqaB20iri/kI0Jza4t2t3h6bQg4x5FEZ3VpDc+jGsVnVRTuYSqNA1iP7X
         b655TIo2QJ2+MHIXOG2Q1p55JbGQt8CaSFlVxUeqIG9A4GgVifP9Pu8spCATyyxmSpzh
         N6Kw==
X-Gm-Message-State: APjAAAX6q48yKs79PiNZw2b/OAuzDkOMXOSyLsG1TJoD0qZbr9d4pRMG
        HKtvV3k3xcAZN3AcxuW4o86gcw1WkCY=
X-Google-Smtp-Source: APXvYqyvBUBZTjvzYHftJDf7R7zgHYhntNVAbh0GAbga+SU4mu4JdymttGxOe8i7pn6oh2wv6IBZEw==
X-Received: by 2002:a1c:451:: with SMTP id 78mr4456446wme.125.1582302359764;
        Fri, 21 Feb 2020 08:25:59 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id w15sm4587017wrs.80.2020.02.21.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 08:25:59 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:25:55 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Will Deacon' <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/3] Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200221162555.GA81612@google.com>
References: <20200221114404.14641-1-will@kernel.org>
 <d31bc2e2718247a7b1db38593564262e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31bc2e2718247a7b1db38593564262e@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 Feb 2020 at 15:41:35 (+0000), David Laight wrote:
> From: Will Deacon
> > Sent: 21 February 2020 11:44
> > Hi folks,
> > 
> > Despite having just a single modular in-tree user that I could spot,
> > kallsyms_lookup_name() is exported to modules and provides a mechanism
> > for out-of-tree modules to access and invoke arbitrary, non-exported
> > kernel symbols when kallsyms is enabled.
> 
> Now where did I put that kernel code that opens /proc/kallsyms and
> then reads it to find the addresses of symbols ...

Sure, but the point of this patch IIUC is not to make it totally
impossible to find the address of symbols in the kernel. It is just to
not make it utterly trivial for out-of-tree modules to bypass entirely
the upstream infrastructure for exported symbols.

All in all, I really don't see what is the benefit of keeping
kallsyms_lookup_name exported upstream. Especially since we don't have a
good use-case for it.

So, for the whole series:

  Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
