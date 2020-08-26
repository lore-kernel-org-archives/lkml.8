Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6FD2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0WUt2Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHZKZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgHZKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:25:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8e7m1CkmXpgJBEIhBkOz8FSttb96UAPZGvqZLIsdgA0=; b=R0WUt2Nv3A5DmntgkldazUgIsg
        +wipts7wLWsx8Ee7V08Zf1SIPg+bl58SHK44F/NQGL4q1OY5eQiPjAQcbNISnhblKl6loFFtt8kfk
        sStiby/f6BiBrh4Y029E0Z+nD1M8HKbkK48mlqYY/hekPwLSlSiGIRb6N39Z5nocpmMaCm3AaxrB4
        Cnongp00g9pjTOTzECeVMET2NsTyL0mVLmmACRp3vccGpeAYi7ic9RQQb+DIxMIgIgDEHh2L05Ejm
        BbjUfz752681Q7l7WTCe9VXH2/T1iCNCJZEkUXoTqxFfGlWqL2eyib1U2pJk28DxKzljWfOuVnKTc
        3Xd73iTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAsck-0006eU-QK; Wed, 26 Aug 2020 10:25:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99111301A66;
        Wed, 26 Aug 2020 12:25:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 823BA2C016759; Wed, 26 Aug 2020 12:25:45 +0200 (CEST)
Date:   Wed, 26 Aug 2020 12:25:45 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200826102545.GF1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
 <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
 <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
 <20200826190041.2d0ff0fbe154ba62163b0c00@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826190041.2d0ff0fbe154ba62163b0c00@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 07:00:41PM +0900, Masami Hiramatsu wrote:
> Of course, this doesn't solve the llist_del_first() contention in the
> pre_kretprobe_handler(). So anyway we need a lock for per-probe llist
> (if I understand llist.h comment correctly.)

Bah, lemme think about that. Kprobes really shouldn't be using locks :/
