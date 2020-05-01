Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1990C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991A52051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340773;
	bh=qRKLakTkNpBRDAmnVe8QB4b67u4G86AZBXWXJ2CFwIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjmJVIlPs/EPz4Dd8vAlJZfnszwUUYwNoCMVmoQZyzcPKlj3p+Kwhg0RdAW5oaDVm
	 eT+DKv0I1dLhWe/HT4bRjxyIijnAqgum3zi3NC4a4kAXpIktFieomuK3wJUEA5q8DS
	 twc1s0AXq+a34xJsR0HUR3DCoj/vtAwoo1+1uyw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgEANpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbgEANov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:44:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6612051A;
        Fri,  1 May 2020 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340691;
        bh=qRKLakTkNpBRDAmnVe8QB4b67u4G86AZBXWXJ2CFwIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxSUhR/Hpi+ahOD9WiR08tIAqp+7t82RMgO/iSHhIyGvcTlrzsNvDJ65d/TUIZuaE
         ypRn3YMZAwvAUCxNkpN4aJmf3CO8HNu+P+/AqnaeWLssbGRwzKZps6i+wapmy+R8/f
         TzTaTT+CuS80IP3ExclnSEaY1DhUblNAfXAUHTgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 097/106] taprio: do not use BIT() in TCA_TAPRIO_ATTR_FLAG_* definitions
Date:   Fri,  1 May 2020 15:24:10 +0200
Message-Id: <20200501131554.959277957@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 673040c3a82a7564423e09c791e242a846591e30 upstream.

BIT() macro definition is internal to the Linux kernel and is not
to be used in UAPI headers; replace its usage with the _BITUL() macro
that is already used elsewhere in the header.

Fixes: 9c66d1564676 ("taprio: Add support for hardware offloading")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/pkt_sched.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1197,8 +1197,8 @@ enum {
  *       [TCA_TAPRIO_ATTR_SCHED_ENTRY_INTERVAL]
  */
 
-#define TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST	BIT(0)
-#define TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD	BIT(1)
+#define TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST	_BITUL(0)
+#define TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD	_BITUL(1)
 
 enum {
 	TCA_TAPRIO_ATTR_UNSPEC,


