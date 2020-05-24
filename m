Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8272076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYn3XCh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgEXS6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 14:58:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34630 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbgEXS6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 14:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ywdpDsyEeOdIC3u+1kMdolXQv8cEi/Fq0UPFNBjeBYU=; b=DYn3XCh5NWZza7qNhG8mvgP8kc
        KLAjbzNg0GFKkei70OtbXqo7hqP/TnlKmxCRXsTfGgYAGduMtowuxbXcxvzAjcyX2pGHFmXqgWBa4
        F3tF6dDjhvvoMG3dwbDrt4GKjGl+IuYJ90BEuhsBdTTaooTS++3zbIgrSbX42ULhRY9PQNleZQjux
        wJNgtxuLyOKY6bKAAtICdPQGsq82SNVoYk3ng1ccCtiwKDgM71I4DnRhiKsyMoiKRDRC+xCdWY8vQ
        vwKqFpHzmQk0hF61rejEGmVCJnBYSPoTU82c9291qLZGIb/Z6Bap9XhgzTgvjlFuRZOS2BTBoDt8f
        yB8dK3Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcvp4-00010O-ME; Sun, 24 May 2020 18:58:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 552953011E8;
        Sun, 24 May 2020 20:58:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CC3621462C28; Sun, 24 May 2020 20:58:00 +0200 (CEST)
Date:   Sun, 24 May 2020 20:58:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC problems with Acer TravelMate 5735Z
Message-ID: <20200524185800.GV325280@hirez.programming.kicks-ass.net>
References: <a8c0c572-6dba-8d35-69bd-5e7b19bf6aba@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c0c572-6dba-8d35-69bd-5e7b19bf6aba@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 07:09:18PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I got my hands on an old Acer TravelMate 5735Z (Intel GM45/Cantiga) and
> installed Debian Sid/unstable with Linux 5.6.7 on it.
> 
> Booting the system it takes a long time, and the systemd units fail to
> start. The logs contain that the TSC is unstable. Adding `tsc=unstable` to
> the Linux kernel command line fixes this.

It fixes nothing; it just doesn't get you the warning because you told
it upfront.

> Do you have an idea, what might cause this? 

Yes, but you didn't include the dmesg of the affected case. IIRC it
actually spells it out for you.

> Do you have an idea, what might cause this, 

It's a Core2, Core2 doesn't have stable TSC.

> and how it can be fixed?

Use a 'better' CPU :-)
