Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CFC20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tsje6rQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHKTuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:50:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:58192 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:50:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DAE422CFA31;
        Tue, 11 Aug 2020 15:50:11 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YVx5N7hH33_8; Tue, 11 Aug 2020 15:50:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 947262CFB20;
        Tue, 11 Aug 2020 15:50:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 947262CFB20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597175411;
        bh=DwqrTLQnS6fjFlO1mJ2lCxMpXY3v8dVZG7vx/OeBnAs=;
        h=From:To:Date:Message-Id;
        b=tsje6rQnilZZGtjqq2xh8rjcJGMfZCpTyroUDD9Emz5I1+Af2MOw1Wz3qK3tfGl/N
         KJmsPeLlwsfaT1cinv2l1hRhgXNhzJ6fXSH5aHh5Olm5UFdwHGx8oHISCHZXMkCTjr
         iOQE5IjQiW2DaXlgHoLP91m68g7xnnDlB5omw24MAH6k11UyS7iZD3tpe9MDpI6a9s
         JhV0rfZhsvJ2GvX3H3cjcLrwAQu8ys/Hv2sM6kslxCb3PgDDLtf0ad3cd/TWBT5KB4
         rbrpex1WlP8WAXAiyo9WNd6wsmaiR1cqEED+fa3CKht2cdbgNl+7ylRalEiMfPhZGc
         pjy7ut//JfpsA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gjib0gfB4uCE; Tue, 11 Aug 2020 15:50:11 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 56E012CFB1F;
        Tue, 11 Aug 2020 15:50:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Ahern <dsahern@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/3] l3mdev icmp error route lookup fixes
Date:   Tue, 11 Aug 2020 15:50:00 -0400
Message-Id: <20200811195003.1812-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of fixes for ipv4 and ipv6 which which ensure the route
lookup is performed on the right routing table in VRF configurations.

It includes a test for both ipv4 and ipv6.

The series has been rebased on the net tree.

Thanks,

Mathieu

Mathieu Desnoyers (2):
  ipv4/icmp: l3mdev: Perform icmp error route lookup on source device
    routing table
  ipv6/icmp: l3mdev: Perform icmp error route lookup on source device
    routing table

Michael Jeanson (1):
  selftests: Add VRF icmp error route lookup test

 net/ipv4/icmp.c                               |  15 +-
 net/ipv6/icmp.c                               |  15 +-
 net/ipv6/ip6_output.c                         |   2 -
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/vrf_icmp_error_route.sh     | 429 ++++++++++++++++++
 5 files changed, 456 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/vrf_icmp_error_route.sh

-- 
2.17.1

