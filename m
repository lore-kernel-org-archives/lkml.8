Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA53120787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPVI1/dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgEZJLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgEZJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:11:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE580C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2e5NXHGx7wnm7Pbp2AIyimNQk/VuymIdJNBxaSRbD1E=; b=fPVI1/dS5WYyPDxVtdVBcoztyN
        Rojdzyhejq+iCGndokjTFBod58VOqYbWbgaLQd5nJiVV49NN07q7lRqW6gu919smdhE9iARRxmxop
        bZu4XUu3cTr+E57Jy9SFhgq4GP/Jpeiaq/mj6I+7+7KWqtWANWvp4n7CMhrDw3qwzY94JFd+VhYLo
        dKV6kdPZNWmseW2PgN+kDFoMEiDQpngS7RWKprKVD8OSjNAyvnl7SnUUwuL76u9GsyQH9nuaszVsv
        Tc1r81orxm2Gi52XrxkEHpbiggKaY7RSbSHjXOQrW2l38DGQmL8yzZoTFIsZuC8l6ABexT3kmYMjT
        yCo5f/cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdVbk-0002nC-6O; Tue, 26 May 2020 09:10:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F021D304DB2;
        Tue, 26 May 2020 11:10:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D87012B0A2A27; Tue, 26 May 2020 11:10:45 +0200 (CEST)
Date:   Tue, 26 May 2020 11:10:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [RFC PATCH V2 5/7] x86/entry: don't shift stack on #DB
Message-ID: <20200526091045.GB325280@hirez.programming.kicks-ass.net>
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com>
 <20200526014221.2119-6-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526014221.2119-6-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:42:19AM +0000, Lai Jiangshan wrote:
> debug_enter() will disable #DB, there should be no recursive #DB.

should being the operative word.

I have similar patches but was still debating what to do about kgdb, I
think we'll just have to mark it BROKEN for now.
