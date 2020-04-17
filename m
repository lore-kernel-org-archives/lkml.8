Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF99C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECDA22209
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ddRbaJFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDQQy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDQQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:54:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:54:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l11so2367633lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUjmNpTkRUHjFQU3sZOC9N/p+7Qi1HmP8jwrqOUVxtQ=;
        b=ddRbaJFypSDnHxxSGThJ4HEJ2KvJRLqKBIxb9wqT/VQT/s5eBK5IpwBn96NG4HtT7t
         kFH8mrSVHxTuKeOeAiSYdQ81Dw98+WKMraTxm335md7MJqUPYvX17YMDw7zaQYY0PD4A
         2oSyQ/KPy3LJczhml0FWU+O5NYXqcMljE94r1H+c9fYoHd+b2oNMZ+xHC+yRwBdE8obM
         ufbss3EZSs+1TL4/e7nNhsRcD3ik56iMIVfAMyo4s4aveac8VXDZvn/K1uoqL3dEHwN/
         flRJSPWZ22wXUCLfkUaOG7kPbOtffAuMTSFASSA7stWu8UfnLXt3vTRMAzPDOius10l6
         VwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUjmNpTkRUHjFQU3sZOC9N/p+7Qi1HmP8jwrqOUVxtQ=;
        b=Uyw8eleQnXlXo5iz3jOmAZji6qRuf7ySkCdOGE78yYy3RA+TzoqW60xYNpEWsPdLd6
         7iNw279N7YaedJAH0WrvqVnspPF8i0L5XqjPBqu1QNdHm8r9CS4me2T8SyS1AnjtPNTI
         WgDt0wlf3eHY6zf/Koc1DN5l08ol27YDDygNYgcR7r9e68D/xoV3dIv4778rB5qUWz8O
         iZYfYpHSAvf4bBLqBv/Kpn5knPEU30I1yH8X78+9jjE84zJ6u7f5U0/bJzgcyfo8IfdN
         mswPsfhFnmlcyyDypEcJywiP+hd4Ajc5Ed7Q+1fGAt6JPTXZxkRrMbXuBepYHR8NrBO7
         6M1A==
X-Gm-Message-State: AGi0PubKdiU7f3KvBM6e4iGZ7bY1pI5g6J2o+UHZukSkBREbdFUPFDGi
        ChPyIzv58nmXZak/vfhPWLwqWA==
X-Google-Smtp-Source: APiQypISek1IPy+jAQOGlaH56xuChWRuYb25GbvP3uat/f4peaskDtn/5XiUSDZwhQjmFfcr8uVYFQ==
X-Received: by 2002:ac2:522e:: with SMTP id i14mr2628298lfl.140.1587142492816;
        Fri, 17 Apr 2020 09:54:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e8sm16891517lja.3.2020.04.17.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:54:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A16F9100AEA; Fri, 17 Apr 2020 19:54:51 +0300 (+03)
Date:   Fri, 17 Apr 2020 19:54:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417165451.y2mj7ta3rqtxjcdc@box>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <20200417154714.GI20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417154714.GI20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:47:14PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2020 at 12:32:29AM +0300, Kirill A. Shutemov wrote:
> > +static void cpa_restore_large_pages(struct cpa_data *cpa,
> > +		struct list_head *pgtables)
> > +{
> > +	unsigned long start, addr, end;
> > +	int i;
> > +
> 
> > +	start = __cpa_addr(cpa, 0);
> > +	end = start + PAGE_SIZE * cpa->numpages;
> > +
> > +	for (addr = start; addr >= start && addr < end; addr += PUD_SIZE)
> > +		restore_large_pages(addr, pgtables);
> 
> Isn't that loop slightly broken?
> 
> Consider:
> 
> 	         s                     e
> 	|---------|---------|---------|---------|
>                  a0        a1        a2        a3
> 
> Where s,e are @start,@end resp. and a# are the consecutive values of
> @addr with PUD sized steps.
> 
> Then, since a3 is >= @end, we'll not take that iteration and we'll not
> try and merge that last PUD, even though we possibly could. One fix is
> to truncate @start (and with that @addr) to the beginning of the PUD.

... or round_up() end. I'll fix it.

> Also, I'm afraid that with my proposal this loop needs to do PMD size
> steps. In that regard your version does make some sense. But it is
> indeed less efficient for small ranges.
> 
> One possible fix is to pass @start,@end into the
> restore/reconstruct/collapse such that we can iterate the minimal set of
> page-tables for each level.

Yeah, I'll rework it.

I just realized I missed TLB flush: we need to flush TLB twice here. First
to get rid of all TLB entires for change we've made (before
reconstruction) and then the second time to get rid of small page TLB
entries. That's unfortunate.

-- 
 Kirill A. Shutemov
