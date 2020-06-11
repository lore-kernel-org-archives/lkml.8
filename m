Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A66207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BT9A2lvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgFKSXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:23:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:37074 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:23:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A23B62BA671;
        Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gQ1Sym7G9dKw; Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5DB8C2BA99B;
        Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5DB8C2BA99B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1591899797;
        bh=jOKBe/0E3EYLXcGvdI/M1PC+Z90hue4/xvMoPXX8tpY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BT9A2lvl9QSP+OQgKL49g47uYwN9u5GxIHwZcR1nR2lPU/7CTFbKXpJ7Rb87awFJt
         DbLVdKVm5ZE6zWk+ZBvC1J+7ZwZUNP2fZUMrYJyHBQAR+DuTfK/RBR2lYbAtdfVz61
         3D0fegWaBE/KbGCJxPHClZ+B8aAO3bO+JlAkh8cSsZQfjkVKXWBlBZcvtjSi8snObh
         l3W18SvOymb1MjGM+7w5WuBVlMZXsefnBSeVwoduV8Ssofx4bSi5BssI3yBcqcnx7X
         4SQvh6sbi2Tn1wpDadXqm/ymwOnKJbphirwXoD95BTaZrybnl5pBzwnravGZ5FN7rP
         nmXQEyyAuBavA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kYHgZbsWHz8C; Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4CD3A2BA742;
        Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
Date:   Thu, 11 Jun 2020 14:23:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Message-ID: <1094083824.1256.1591899797181.JavaMail.zimbra@efficios.com>
Subject: rseq.2 Restartable Sequences man page updated
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Index: rku/xbONicv+r1VsS7GZrhVGS3DC1Q==
Thread-Topic: rseq.2 Restartable Sequences man page updated
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I took the liberty of updating the rseq.2 man page based on your
last round of comments:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2

Soon, rseq support will be integrated into glibc, and the maintainers
there want a stable link to documentation of the rseq system call.
Documentation is pretty much the only remaining blocker for integration
of rseq support into glibc.

Ideally it should land into the man-pages project, but since it's been
more than a year since I heard back from you, I am tempted to host it
myself within the librseq project, even though it's far from ideal for
hosting a kernel system call man page. Unfortunately, I suspect that
hosting it in two locations (librseq and man-pages) will eventually
create much confusion.

Can you look into the updated man page please ? I can do the edits
if you have further feedback.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
