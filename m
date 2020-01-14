Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B0C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B382075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dzjkhB7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgANIQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:16:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgANIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=odA+tFP7l1GwMPN2Ax0P1dKHoeXZOri6fw8gHlJOJzw=; b=dzjkhB7PZCJJHtJXu6DvYj4Lg
        slQezV7GczgJFa8UbUt32mpc5n5qurmQChKM6LCIf2GvtzG7QkrwCBzyJzsEv6V/CsnA1AbRnH8/c
        MCZucWny875ODFUNI8DmpsE/4p3UWhrBDKoffLVCaaVRRj+AqybRopGBR7VEDm9z3kTEqVQaeW0sn
        R7OvH0l74pzTWUGsmY8ptYeVI4gqIQoOKmdt6q9qam1Bwmo7te5UamQu9WQrY94fQLgMDjRE8FYjR
        dSKWYB2siF6SQLK6pkXTZH0YbtDJ866mWKQEWS8NAVYULEKQsfPaeaWfYzC2TgDOZNUIgLiB7ADrr
        PL7LJ9HpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irHNP-0004hA-LB; Tue, 14 Jan 2020 08:16:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B4FA300130;
        Tue, 14 Jan 2020 09:15:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5F822B6A58BF; Tue, 14 Jan 2020 09:16:36 +0100 (CET)
Date:   Tue, 14 Jan 2020 09:16:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     xiexiuqi@huawei.com, huawei.libin@huawei.com, rostedt@goodmis.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] x86/ftrace: use ftrace_write to simplify code
Message-ID: <20200114081636.GH2827@hirez.programming.kicks-ass.net>
References: <20200114015217.9246-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114015217.9246-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:52:17AM +0000, Cheng Jian wrote:
> ftrace_write() can be used in ftrace_modify_code_direct(),
> that make the code more brief.
> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>

None of the code you're patching still exists. Please see tip/master.
