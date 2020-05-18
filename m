Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA2520657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826472;
	bh=pLKK1rWfKBUkBR8Z+9c0T7j+u/CPpMhUJDWsMDYB5aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rj0bDzXeWMqEwpY+wD2eT5uLTu+6fwJ/3xMbK9Jnm4DtobimNOyyvcWJxYkejqjxs
	 SzZ0hRffYCrrYV72swF4xAhrDC0jVJNsaCpdu76Nz80uF2kN7/FPTT4ABhUrTDcddy
	 cMu1a1zK9YwqWeyPw8dyeKVrgZUxbgany5tWgbmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgERS1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgERRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:43:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA61F20873;
        Mon, 18 May 2020 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823818;
        bh=pLKK1rWfKBUkBR8Z+9c0T7j+u/CPpMhUJDWsMDYB5aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M89gzHfeQl9Rm3aG91iZT9R0f9iFPNE+qhl+itWAdXIIX7kyso2H9NxNWUAUZTpdL
         xGD7aPOgGmt2YXcZ0FITKf5mLVXQudVCYwtVWqjm23j3M9XAcuYRxoEtsom+W50++3
         AxUnmp8zYhwGQ/4XhWDbKr9SNA5vZ0Tix1NGUREs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 48/90] cifs: Fix a race condition with cifs_echo_request
Date:   Mon, 18 May 2020 19:36:26 +0200
Message-Id: <20200518173500.990164419@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit f2caf901c1b7ce65f9e6aef4217e3241039db768 ]

There is a race condition with how we send (or supress and don't send)
smb echos that will cause the client to incorrectly think the
server is unresponsive and thus needs to be reconnected.

Summary of the race condition:
 1) Daisy chaining scheduling creates a gap.
 2) If traffic comes unfortunate shortly after
    the last echo, the planned echo is suppressed.
 3) Due to the gap, the next echo transmission is delayed
    until after the timeout, which is set hard to twice
    the echo interval.

This is fixed by changing the timeouts from 2 to three times the echo interval.

Detailed description of the bug: https://lutz.donnerhacke.de/eng/Blog/Groundhog-Day-with-SMB-remount

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 37c8cac86431f..3545b237187a8 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -551,10 +551,10 @@ static bool
 server_unresponsive(struct TCP_Server_Info *server)
 {
 	/*
-	 * We need to wait 2 echo intervals to make sure we handle such
+	 * We need to wait 3 echo intervals to make sure we handle such
 	 * situations right:
 	 * 1s  client sends a normal SMB request
-	 * 2s  client gets a response
+	 * 3s  client gets a response
 	 * 30s echo workqueue job pops, and decides we got a response recently
 	 *     and don't need to send another
 	 * ...
@@ -563,9 +563,9 @@ server_unresponsive(struct TCP_Server_Info *server)
 	 */
 	if ((server->tcpStatus == CifsGood ||
 	    server->tcpStatus == CifsNeedNegotiate) &&
-	    time_after(jiffies, server->lstrp + 2 * server->echo_interval)) {
+	    time_after(jiffies, server->lstrp + 3 * server->echo_interval)) {
 		cifs_dbg(VFS, "Server %s has not responded in %lu seconds. Reconnecting...\n",
-			 server->hostname, (2 * server->echo_interval) / HZ);
+			 server->hostname, (3 * server->echo_interval) / HZ);
 		cifs_reconnect(server);
 		wake_up(&server->response_q);
 		return true;
-- 
2.20.1



