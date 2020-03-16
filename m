Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D0AC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58520736
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="taXVWD1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgCPM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:58:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbgCPM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+inKfQ3VgHu5paErkgtXkNqAspSEW/EhOE+XjXJGMIo=; b=taXVWD1GCXB9WYcNaVRYtdfzHA
        wxPYWBSqOLCijI5ewwY5az56KPWAZzZ0flBG9Fnz3yk6QbUUGEewX8hU/rleUlD2400YnpeM4Oqb2
        +FnDOzYjRyLZkRSW03MlQRXdaiyHDej98OCXhO+CGgjMJONt4JMNYP9Evqvd0vB9n6fkunS45qVK4
        0LGCnIqZ9+8aem1YmP8M0z5js/ORSXDPsVazqbFrILWbZO7mmQ9KvkwQAGxx0kgo3EBJiF3dUVi1u
        LIf/iubqSzdcWasoXAbdT0T/A3J7FYHzf8F9WLwG1NhNITyimYB3grIvm8D6ri3SMuDV01YRyf1X+
        GDCy1DqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDpK6-0008DU-GN; Mon, 16 Mar 2020 12:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F65C302544;
        Mon, 16 Mar 2020 13:58:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A1220B151F4; Mon, 16 Mar 2020 13:58:24 +0100 (CET)
Date:   Mon, 16 Mar 2020 13:58:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gilad Wharton Kleinman <dkgs1998@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/module: Fixed bug allowing invalid relocation
 addresses.
Message-ID: <20200316125824.GB12561@hirez.programming.kicks-ass.net>
References: <20200314213626.30936-1-dkgs1998@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314213626.30936-1-dkgs1998@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 11:36:26PM +0200, Gilad Wharton Kleinman wrote:
> If a kernel module with a bad relocation offset is loaded to a x86 kernel,
> the kernel will apply the relocation to a address not inside the module
> (resulting in memory in the kernel being overridden).

Why !?

If you load a bad module it's game over anyway. At best this protects us
from broken toolchains.
