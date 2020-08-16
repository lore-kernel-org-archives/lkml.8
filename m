Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EABC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222EA204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qKGBnTIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgHPVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 17:05:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:35876 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgHPVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 17:05:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DAA9B2CD070;
        Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mXJFxJKv4xmv; Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 834D12CD2DA;
        Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 834D12CD2DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597611922;
        bh=UJk0iDK6i/D5vytzbwL67FL+4Gn317iKgz3d3kMyssI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qKGBnTICgxQ2itmJABPx7EhVNoBmOY04vtFZoexbu0cirnpu3hoA+YGgRwUFfBlyQ
         /jjfofteztn/IqOZWdCCCVVWqznZOocCy966A7Y+YhbIy/DE0omCikrMjx2h2XVx12
         gn2HWEOctGt4nF8+8FI583vErmPiIkKQ4WCJGkgbkjntQGIs5Rr4dCh1D8zygoo642
         V3SUJaKScG1TIY4DANiVYWrlqzksHXdxiabva451mwVal9qUqfLxPc1f8LE8g2eDRH
         e3bEOiD1kASIQyACLqhNUigPPTXe/qB6HVhBDOmlR8XDB0ipXQ66+pOl8wod5gtHoc
         EfAvfzA7NJ9qw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9hMwMGCXnLHo; Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 527F52CD179;
        Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
Date:   Sun, 16 Aug 2020 17:05:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>
Message-ID: <833020242.9878.1597611922236.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200816070932.10752-1-hdanton@sina.com>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com> <20200816070932.10752-1-hdanton@sina.com>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: membarrier: cover kthread_use_mm (v2)
Thread-Index: rImpRoT9yXbFw6ZT6L56QCI7o+oPnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2020, at 3:09 AM, Hillf Danton hdanton@sina.com wrote:

> On Fri, 14 Aug 2020 12:43:57 -0400 Mathieu Desnoyers wrote:
>> 
>> Given that no prior kthread use this guarantee and that it only affects
>> kthreads, adding this guarantee does not affect user-space ABI.
> 
> Can you expand a bit on why kthreads like ksoftirqd have to ack the
> IPIs from Dave who's not CAP_SYS_ADMIN.

Do ksoftirqd kthreads ever use kthread_use_mm() to access user
processes' memory ? If not, then they won't be disturbed by any IPI.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
