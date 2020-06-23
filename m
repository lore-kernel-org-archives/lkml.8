Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8FBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0A20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945602;
	bh=zs1Fsnj+WxD8z7ioOPR4f0U8x/ABY56oKNjP/7rKsb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xI8Rm69fAoiYY2NO9wtfzIeFCly+wM1W/q8fH9uA9XEjZ9vqh9qBOnzxsLUjAL51q
	 xoblWceSYHfgwwX8gT7kfp67pL5SAWXxorl+1+jq9f4RkkB8Y6L6jLEDlqZ5UDYoBx
	 DrBCPbBISTVnClyjlzK0yAPhOkrq9MECEEyTj674=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392878AbgFWUqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392857AbgFWUqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89F021548;
        Tue, 23 Jun 2020 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945201;
        bh=zs1Fsnj+WxD8z7ioOPR4f0U8x/ABY56oKNjP/7rKsb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2bhknq3AaDzHzfFFdbodNKP/gZX8SA0Pf/lAwWfnHE6oWdJ1Ro9cqUnVYVMiK+iw
         IfiOKNv1RcKfrBfBo1oO4mA7VdVC6hWkrJmvUXwGO3IFBdBbGaIIidHpUn1k4Hzg9B
         OEfb4/zbOpolIV1KWiMhs72zj3k9yRrWaAFFvzTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fedor Tokarev <ftokarev@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/136] net: sunrpc: Fix off-by-one issues in rpc_ntop6
Date:   Tue, 23 Jun 2020 21:58:55 +0200
Message-Id: <20200623195307.681534637@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fedor Tokarev <ftokarev@gmail.com>

[ Upstream commit 118917d696dc59fd3e1741012c2f9db2294bed6f ]

Fix off-by-one issues in 'rpc_ntop6':
 - 'snprintf' returns the number of characters which would have been
   written if enough space had been available, excluding the terminating
   null byte. Thus, a return value of 'sizeof(scopebuf)' means that the
   last character was dropped.
 - 'strcat' adds a terminating null byte to the string, thus if len ==
   buflen, the null byte is written past the end of the buffer.

Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 2e0a6f92e563d..8391c27855501 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -81,11 +81,11 @@ static size_t rpc_ntop6(const struct sockaddr *sap,
 
 	rc = snprintf(scopebuf, sizeof(scopebuf), "%c%u",
 			IPV6_SCOPE_DELIMITER, sin6->sin6_scope_id);
-	if (unlikely((size_t)rc > sizeof(scopebuf)))
+	if (unlikely((size_t)rc >= sizeof(scopebuf)))
 		return 0;
 
 	len += rc;
-	if (unlikely(len > buflen))
+	if (unlikely(len >= buflen))
 		return 0;
 
 	strcat(buf, scopebuf);
-- 
2.25.1



