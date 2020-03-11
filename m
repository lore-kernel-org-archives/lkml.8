Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E6C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D4206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsHVNura"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgCKScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:32:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40658 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbgCKScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:32:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so3084683qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMlJ0CCM2ETRao/Z/x1Z86bkEWgQuSAvpITBlu5A7Ik=;
        b=GsHVNura2eRqqet/zqMCRx+4UATBBNXBlkdjyf760G2mIglKf0RCQsU2N9XDzUtMID
         QOG6zFpKUeZhp6O3MYB9yzjPslgY4XcfmdM/hdPwv5gb8UV/IKebOp+1qOGbfdzUbBPw
         9AR0C06BREbED/nGqz1/MikJY3hy6t/5at9PShhTx37TJf2aW491moWc/W0MZQUfSBsP
         vNpuR9okDgiyWAt8bpKK33D5Quc3CW1GlLXA3ov7/4oSEqyoKeP1Uu3Juf1/XHfbg0rM
         m2oeoGJS8K5ESND7Tz3zgE4yqVsVO5wLgraKFSg6iQlDt8VR/ZtS0TVptvtPiHFfYWf4
         C+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMlJ0CCM2ETRao/Z/x1Z86bkEWgQuSAvpITBlu5A7Ik=;
        b=eDt23OVp7mGDos2SjrYjiGeFHZ/3BGaLANjLQ4Uf6ESrLWVcL5ez87uzALh2cOcfiP
         yZvbqw0RP+3fXlhCgk+TCS+VxKtnZGVYhFJuCg9dfaQBzOG8jBua/9iX+neVvoeiAa2n
         IZuit8tDj03LnQkk84sGJUvao0xoTABZSGXvKFZFBDigIrHxcVMFJNTBXzKRu/5P9Eb+
         IwnecAUKtWN+H8VDNPxrZGyb9M/yRUFi77dCyEX5KCx5vnABcrgX5h+LlUAbVLX08AZt
         N1IC+TIrPpPqqQlHnGQMiIaPDD6CRZw4yv54v15LhUX6LEbkAgtfwKeR+iU9jC0bxUhr
         kn+w==
X-Gm-Message-State: ANhLgQ36TmpBLNoNzW2W5Pf/Es4uY6pRJb2w60pqkYxNsA58qy2F+HBM
        eM320MeHRY8YU3R4+R+M9oQ=
X-Google-Smtp-Source: ADFU+vuM3E1+agajz5s4tUI3265OjGZw2LgwOJgXOunpsr50yTdq+JhLk2aPugNEWTHtVYnSf1er0w==
X-Received: by 2002:a05:620a:1236:: with SMTP id v22mr4091581qkj.101.1583951563826;
        Wed, 11 Mar 2020 11:32:43 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p191sm9264884qke.6.2020.03.11.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:32:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Mar 2020 14:32:41 -0400
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20200311183240.GA3880414@rani.riverdale.lan>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200311033552.GA3657254@rani.riverdale.lan>
 <20200311081607.3ahlk4msosj4qjsj@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311081607.3ahlk4msosj4qjsj@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:16:07AM +0300, Kirill A. Shutemov wrote:
> On Tue, Mar 10, 2020 at 11:35:54PM -0400, Arvind Sankar wrote:
> > 
> > The rationale for MOVNTI instruction is supposed to be that it avoids
> > cache pollution. Aside from the bench that shows MOVNTI to be faster for
> > the move itself, shouldn't it have an additional benefit in not trashing
> > the CPU caches?
> > 
> > As string instructions improve, why wouldn't the same improvements be
> > applied to MOVNTI?
> 
> String instructions inherently more flexible. Implementation can choose
> caching strategy depending on the operation size (cx) and other factors.
> Like if operation is large enough and cache is full of dirty cache lines
> that expensive to free up, it can choose to bypass cache. MOVNTI is more
> strict on semantics and more opaque to CPU.

But with today's processors, wouldn't writing 1G via the string
operations empty out almost the whole cache? Or are there already
optimizations to prevent one thread from hogging the L3?

If we do want to just use the string operations, it seems like the
clear_page routines should just call memset instead of duplicating it.

> 
> And more importantly string instructions, unlike MOVNTI, is something that
> generated often by compiler and used in standard libraries a lot. It is
> and will be focus of optimization of CPU architects.
> 
> -- 
>  Kirill A. Shutemov
