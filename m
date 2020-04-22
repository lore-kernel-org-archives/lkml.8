Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97198C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7162076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kPVI68HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDVNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:13:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:44338 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgDVNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:13:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7D41424BBCE;
        Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LivSnvv1xuAw; Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2934E24BCB4;
        Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2934E24BCB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1587561199;
        bh=XxfwCStd65W3SUVeYq1AfAiyjAtX6BLtoIdBlLjGZM4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kPVI68HXH+9CBE9fhZpJKo2/qo0O6pESqyfaUwVc7J0wy/nI4nOjcbrkY2ISX9Gja
         PZQ6NamnA+k+St4TA0IcppITqrESnC+fQnrgaQbIUkj7f+AjgQudGKf0JHIIazYS02
         bRQnhcB2czeuJrklHyqquJFM3xcDovjW1ffeNyggCvgiD6MiRFSIKEnXA4XV0y/y5o
         MPzJtjiT3jsskcrx02pLUCzhWQI9LR+SUOgSGNIqcv4WhtH2VrkP85/JyBsypSPs6B
         aFIwgt8/4+XzCtD4f7jkz5JxvcLcWGnGR4ZJxu6Lp8tDgdLSA1OvkTju61TMdi/yjE
         ZFBkINZQt+5kA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zJR-EsYqK08y; Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1BAEA24BBCB;
        Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
Date:   Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1277451188.63391.1587561199034.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.12.1, 0.11.2, 0.10.3, 0.9.7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Index: FXK0zFflj44usWFd7MeHID9rQ7EAUg==
Thread-Topic: Userspace RCU 0.12.1, 0.11.2, 0.10.3, 0.9.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the liburcu project. Those releases
are bugfix only releases within each of the currently supported
branches: 0.12.1, 0.11.2, 0.10.3, 0.9.7.

Note that the 0.9.7 and 0.10.3 releases mark the end of life of the
stable-0.9 and stable-0.10 branches. Users should upgrade to 0.11.x
or 0.12.x for an actively maintained liburcu.

* Noteworthy in these releases

One relevant fix included in all of those releases applies to tls-compat.h.
It fixes use-cases where liburcu is compiled with a compiler detecting that
_Thread_local should be used for TLS, but an application using tls-compat.h
uses an older compiler which does not support _Thread_local.

The 0.10.3 and 0.11.2 releases include a fix for a hang when using the
RCU lock-free hash table with the signal-based urcu flavor. (urcu-signal)


liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
