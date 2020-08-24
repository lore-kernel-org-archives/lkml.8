Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A11C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CD6206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261724;
	bh=6MMbCXqfagcZ9W7odhsBBTu3VUzHdU8S+g9A2r9NvwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k4gb/vjp7RZiem0sCxzwVxu4ut1EJlEtEEU4qV17BYttSD4X/KDrUY6E7QEiSJqLQ
	 Yyv+rvPzyiDm6wS5q1P/KAUGcroO+wyX8nA2KV4wpmNtTk1WAArg2vGBkk4LDiWp2f
	 swM42RH8wj0hP26o9Im+VxmXxED0wfW/PLotaeZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHXJfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbgHXItH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CAF3204FD;
        Mon, 24 Aug 2020 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258946;
        bh=6MMbCXqfagcZ9W7odhsBBTu3VUzHdU8S+g9A2r9NvwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nc8h/Mm5/ZVE7UYs+hqXTx4Wz74sNv5LagZgCKnHcm+9Lj3XcmErnP2LlNEUFHvHD
         oSzDfo+g5xqhN+3VIy6gEbm7qDM4+VOARvvPYGfGwjl9H1qhFErpvLqXlcLOHkuT47
         xvvZm4ddGioH89jGEejpAhQl4+lZVPRw/wA1xqIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 101/107] net: dsa: b53: check for timeout
Date:   Mon, 24 Aug 2020 10:31:07 +0200
Message-Id: <20200824082410.082096924@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 774d977abfd024e6f73484544b9abe5a5cd62de7 ]

clang static analysis reports this problem

b53_common.c:1583:13: warning: The left expression of the compound
  assignment is an uninitialized value. The computed value will
  also be garbage
        ent.port &= ~BIT(port);
        ~~~~~~~~ ^

ent is set by a successful call to b53_arl_read().  Unsuccessful
calls are caught by an switch statement handling specific returns.
b32_arl_read() calls b53_arl_op_wait() which fails with the
unhandled -ETIMEDOUT.

So add -ETIMEDOUT to the switch statement.  Because
b53_arl_op_wait() already prints out a message, do not add another
one.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 14850b7fe6d7f..4bd66ba72c03c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1523,6 +1523,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		return ret;
 
 	switch (ret) {
+	case -ETIMEDOUT:
+		return ret;
 	case -ENOSPC:
 		dev_dbg(dev->dev, "{%pM,%.4d} no space left in ARL\n",
 			addr, vid);
-- 
2.25.1



