Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F30206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942789;
	bh=g24Uum1M4THSrqGNhm5O12w3DsdOF//UBnZNn3J0WaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vD4MkSxlWOFVH/oKh3pChdrerriiR6S8Gc+55AGCtrlE9vcmCQyqsQs7sJRmznIGc
	 m2xqIZUH2tsNeukgp7WSVtJrP0WUSwMXC91aKek3Mno2TpWIQl8h1XEtQP9X90wGJG
	 9iA0obI93pitVVQ2zAOrDR6gPFZJpiaD2JWL5ujQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgEHM7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbgEHMxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD4E218AC;
        Fri,  8 May 2020 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942382;
        bh=g24Uum1M4THSrqGNhm5O12w3DsdOF//UBnZNn3J0WaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwScqjMEEMM1CA1R6x1FfZ7wX3dVMFZN0rCfHam4NIjKZy/sQqRo8pn3dnJ9+VXTk
         YH4RyBAXo6LkMeL0DzS9YL4n8IDD+X3bnwNGz9ZYl7eoX9bMOh/iRb/sS+ELmHbTAk
         YlkMhOcJxA0hvC9Ah+brhq5SoSga4ehucZiJhzdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 22/50] cifs: protect updating server->dstaddr with a spinlock
Date:   Fri,  8 May 2020 14:35:28 +0200
Message-Id: <20200508123046.493519573@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit fada37f6f62995cc449b36ebba1220594bfe55fe ]

We use a spinlock while we are reading and accessing the destination address for a server.
We need to also use this spinlock to protect when we are modifying this address from
reconn_set_ipaddr().

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index bcda48c038821..52589ea4e3c05 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -371,8 +371,10 @@ static int reconn_set_ipaddr(struct TCP_Server_Info *server)
 		return rc;
 	}
 
+	spin_lock(&cifs_tcp_ses_lock);
 	rc = cifs_convert_address((struct sockaddr *)&server->dstaddr, ipaddr,
 				  strlen(ipaddr));
+	spin_unlock(&cifs_tcp_ses_lock);
 	kfree(ipaddr);
 
 	return !rc ? -1 : 0;
-- 
2.20.1



