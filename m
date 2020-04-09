Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84120679
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vKHHk/Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDIS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:59:57 -0400
Received: from mail.efficios.com ([167.114.26.124]:58028 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgDIS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:59:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8384F280B8C;
        Thu,  9 Apr 2020 14:59:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AA718D2CbxR3; Thu,  9 Apr 2020 14:59:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 051852809CE;
        Thu,  9 Apr 2020 14:59:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 051852809CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586458796;
        bh=RDpWCzi/lEXrMjgDK6LybKq2VKIZ5+Pktdu64dB8R4c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vKHHk/OiJx0YoN0KjYnN+UkTLk5j0AJkaS4qXc79d1lBFFMeXTkHlf6nLVZTBOaPn
         YXokE4EIetxRXPPeXNEiVESI+UMU7OOT/gPBrz2PyPhF73GNBAy6XC8iNu0bsczU9y
         Oa7jKkBHDJawope1/8wpa869/DyxX3I8F7FDhqWUx5SyWUYLnMTBW6ktz9hEMJhSeM
         nYNwXl24JnLEXk0CbWEbKJf9wGA8TPIUHCBzkVWV93ga8ubjFfF3D8Z1U4jTcU7O3a
         Ss6EG8L4G7dXeLoMmybBkOfRAHdfZRcOwVmuAhjcsEP+NCmgJ3SET3IgwUpMc/oVkF
         BKiWLXai+Gb9w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id teKYe98a5BxA; Thu,  9 Apr 2020 14:59:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EA520280D06;
        Thu,  9 Apr 2020 14:59:55 -0400 (EDT)
Date:   Thu, 9 Apr 2020 14:59:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>, lwn@lwn.net,
        Alex Xu <alex_y_xu@yahoo.ca>
Message-ID: <605758779.29080.1586458795931.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Index: o8M5X1q78DYT11zBboKSUh+eR0QZwg==
Thread-Topic: Userspace RCU 0.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This announcement introduces the 0.12 version of liburcu.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

* New in this release:

This 0.12 liburcu release is mainly done to add a DEFINE_URCU_TLS_INIT
macro to the urcu/tls-compat.h API. There is a very recent unfortunate
situation where a major user of liburcu (lttng-ust 2.12) added a use
of DEFINE_URCU_TLS such as:

  DEFINE_URCU_TLS(ino_t, cached_net_ns) = NS_INO_UNINITIALIZED;

Which builds and runs fine for CONFIG_RCU_TLS, but fails to build for
!CONFIG_RCU_TLS. Fixing this required to extend the API and add a new
DEFINE_URCU_TLS_INIT() which could then be used in this way:

  DEFINE_URCU_TLS_INIT(ino_t, cached_net_ns, NS_INO_UNINITIALIZED);

Support for FreeBSD and DragonFlyBSD is also added in this release,
contributed by Alex Xu. It uses _mutx_op() to implement the liburcu
futex APIs on FreeBSD.

Finally, a noteworthy change has been done to the urcu-bp flavor:
urcu_bp_register_thread() now performs the underlying lazy registration
of the caller thread rather than being a pure no-op. This is useful
for some real-time use-cases (e.g. Xenomai) which require to perform
urcu-bp thread registration early in the thread life-time before it
starts performing real-time tasks.

Thanks,

Mathieu

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
