Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF66C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656F62074A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeISQDIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgCKUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:32:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35066 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:32:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id v15so2660870qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1EPYYWs6HVF4jXQQJ+oocKs8ETWR2AXVndep1cXQyE=;
        b=QeISQDIoe7EIb0BquIvVIQDY2tWWGvFxd1AgSN87e3ljqPZ7kQB/I83xqIAXthJCtD
         M8nrFvW1nbg1mvE67QXFNqq+ymkmIVqyyQQPDGfNHS7/FvxHUWjKpsvroAfLVEvAhl0m
         MO7V5hvdqFhRKCVr0mUdgbDNj3pL7HyeExdQYva/Uy2G1ABuaHcs/nSD0WSkCWMToALe
         TA+z8CwLlbO23k0ZauRbPNqtO+lpvzUuYnaztQ/iovfp/3GcyLKDmut2Njk091o8aYH9
         IXwMz8aZiiO5JfENs6Yl4M4AR9BuueUvArvGrTRwgiyyWVISgenMnobBPVcrT2f8DGkd
         GlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1EPYYWs6HVF4jXQQJ+oocKs8ETWR2AXVndep1cXQyE=;
        b=l2OyLKrdgt24I5NwPP0hohgtn3xuE2iWkh5wNfGixrwgnhlb2jqHT/tVbnivMfFRMT
         6dMtJaMoWRDmIaCtYXyFRyeLYQaZijhjli/dh4DzlihpsroZOk0Yb9hUW/iwwJNpHAZ8
         QaGzyfwh/ylxAicgxyFmhXIQLtkUzAhjUKC8kGj/23uemlpPl5y/XuKr6El8zYsmmgVa
         3HLYKR6MvwAobf0tlmo3+j/8GcuBOXHvz5kd3xqWxbnf54wbZWpihCnNRx2HsD+qdhnH
         CTrS6Kxh83DYLbeF60V2e2f4gOw955IWuF91X/QBZS3qyIlcjlVKB3R1nrV+59YabGII
         IDNQ==
X-Gm-Message-State: ANhLgQ28VsF/+ERDVNYngydhycf7CF15OzDKyo3OhDXRQOsoB9oit5z6
        vZAV4lU4UUQ1z6yMuVXlv3JPMkFm1Nc=
X-Google-Smtp-Source: ADFU+vvjR1yY+nJq0VMWjBuJNtaZyLQOtkI59T2HLkM0lKo7OgEdsnmtG0yx4yW5iP/QYTWAOqiVPQ==
X-Received: by 2002:ac8:94a:: with SMTP id z10mr4439600qth.357.1583958769806;
        Wed, 11 Mar 2020 13:32:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z19sm12793225qts.86.2020.03.11.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 13:32:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Mar 2020 16:32:47 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200311203246.GA3971914@rani.riverdale.lan>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200311033552.GA3657254@rani.riverdale.lan>
 <20200311081607.3ahlk4msosj4qjsj@box>
 <20200311183240.GA3880414@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311183240.GA3880414@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:32:41PM -0400, Arvind Sankar wrote:
> On Wed, Mar 11, 2020 at 11:16:07AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Mar 10, 2020 at 11:35:54PM -0400, Arvind Sankar wrote:
> > > 
> > > The rationale for MOVNTI instruction is supposed to be that it avoids
> > > cache pollution. Aside from the bench that shows MOVNTI to be faster for
> > > the move itself, shouldn't it have an additional benefit in not trashing
> > > the CPU caches?
> > > 
> > > As string instructions improve, why wouldn't the same improvements be
> > > applied to MOVNTI?
> > 
> > String instructions inherently more flexible. Implementation can choose
> > caching strategy depending on the operation size (cx) and other factors.
> > Like if operation is large enough and cache is full of dirty cache lines
> > that expensive to free up, it can choose to bypass cache. MOVNTI is more
> > strict on semantics and more opaque to CPU.
> 
> But with today's processors, wouldn't writing 1G via the string
> operations empty out almost the whole cache? Or are there already
> optimizations to prevent one thread from hogging the L3?

Also, currently the stringop is only done 4k at a time, so it would
likely not trigger any future cache-bypassing optimizations in any case.

> 
> If we do want to just use the string operations, it seems like the
> clear_page routines should just call memset instead of duplicating it.
> 
> > 
> > And more importantly string instructions, unlike MOVNTI, is something that
> > generated often by compiler and used in standard libraries a lot. It is
> > and will be focus of optimization of CPU architects.
> > 
> > -- 
> >  Kirill A. Shutemov
