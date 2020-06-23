Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C33C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE476217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945210;
	bh=U41RN4aeAcRu4k1KoSP9ilUKUcb4Ucgo2yRc6G7pc2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oszjJD9FKJ7EwLvCwCrqj1kfZ7qPpqEhDj+PN2wiT8OBPeJPlrDZXJ3owTK/6KhnM
	 TUCYuI9O1fPqNfc4/asezakxjZvYadFwMhrg48H1QUl0An2ewULwfG0QdUNrzepWM0
	 w45MfL//zXS3X4CnA6af6hkki81h+25xpNvsHDGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392868AbgFWUqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392861AbgFWUqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B062098B;
        Tue, 23 Jun 2020 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945203;
        bh=U41RN4aeAcRu4k1KoSP9ilUKUcb4Ucgo2yRc6G7pc2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TntuBSjXGB7bDWux/pAhZ1IdHKt6uHY34+cVVwcdBSIU6zMDIHJmsB9Io/ByIwr8I
         AM0DQPhiw2ZA88TZd2+re5NKSmtokjDCOYITmpQKxU5W1hGdRX29SMETIBpe/uiDNV
         AiGJeV3o94dBskvuSpkJQcepedfTfud2T1G6BDSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/136] NFSv4.1 fix rpc_call_done assignment for BIND_CONN_TO_SESSION
Date:   Tue, 23 Jun 2020 21:58:56 +0200
Message-Id: <20200623195307.726001886@linuxfoundation.org>
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

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

[ Upstream commit 1c709b766e73e54d64b1dde1b7cfbcf25bcb15b9 ]

Fixes: 02a95dee8cf0 ("NFS add callback_ops to nfs4_proc_bind_conn_to_session_callback")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4d45786738ab4..a19bbcfab7c5e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7309,7 +7309,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
-	.rpc_call_done =  &nfs4_bind_one_conn_to_session_done,
+	.rpc_call_done =  nfs4_bind_one_conn_to_session_done,
 };
 
 /*
-- 
2.25.1



