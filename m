Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449B21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G5E6yCVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAWJjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:39:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=md0ZAk3FQElHi7XKV64Hv8xf0dK+/8lwA6XrQZmfofk=; b=G5E6yCVWS3GRTr6UKlwVnV6af
        qCnyJhNhT8PUON1JNDidqpblUj1Fn++0bPz8/SfRDfSe3Xp9WrQN673jD4O14VPhL6cniwYnjbKam
        CPpH2oEjhHv1IKSlmC8zSvG6zjzJTHSW/85N/xc6v2gPZVj6ijzGEFf3daci6NPYXU5z4g4KPFhhW
        nVunhbWNVSPwdTyd56xWu8x4MfbHYCbZb+VvUqOhpdeQoxxDvvcVXq/zTItkK2PYKH/SN40UVXZmc
        y9kCP5QA+tFinoR7Q/LB7mlyzTGi+9VuAdbHbOt+UcVlnpiIVec3H/mtamQGiWeHPKK/RCSNDek8B
        LXGatyHHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuYx8-0003iU-Tx; Thu, 23 Jan 2020 09:39:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29A463042BC;
        Thu, 23 Jan 2020 10:37:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 264782B713024; Thu, 23 Jan 2020 10:39:05 +0100 (CET)
Date:   Thu, 23 Jan 2020 10:39:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200123093905.GU14914@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 06:54:43PM -0500, Qian Cai wrote:
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 1f7734949ac8..832e87966dcf 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>                  * wait for either @lock to point to us, through its Step-B, or
>                  * wait for a new @node->next from its Step-C.
>                  */
> -               if (node->next) {
> +               if (READ_ONCE(node->next)) {
>                         next = xchg(&node->next, NULL);
>                         if (next)
>                                 break;

This could possibly trigger the warning, but is a false positive. The
above doesn't fix anything in that even if that load is shattered the
code will function correctly -- it checks for any !0 value, any byte
composite that is !0 is sufficient.

This is in fact something KCSAN compiler infrastructure could deduce.
