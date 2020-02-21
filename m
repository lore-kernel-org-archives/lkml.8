Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8285C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F7420679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273561;
	bh=Dsh/Qd043VlBj8iAhdts5UbxfZgcXm4Hu4M2aPNVJ/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iofpoqlY8HQGBN4ewRLEesGTmOn/87m/BPiIdrTJkS62fQdo5Ad+U3z/Dvon3ijKu
	 8YAzU5MQktel9Lyo2/rId5CHT7ojbLrrBha3aj+x/td7A38Th+MHcZVXL3q1wsnHpv
	 YHSELyBMnFY9rQQfE6HzlWw/crzT2foH4xAdvTgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbgBUIYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388687AbgBUIYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA4A2469F;
        Fri, 21 Feb 2020 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273484;
        bh=Dsh/Qd043VlBj8iAhdts5UbxfZgcXm4Hu4M2aPNVJ/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pb5F8teg/hNA07G7BP3RS7poI6CLKXhERBNOc5gPk6wQNfjIobCcexZF6v80lApC4
         qG25xwOhXoW88lx6gXBweXar643/kKr9ZVbBOqIuX8jphyPNB41eP5qrpfZ8SnS2FA
         xSUJHuPOwLLYYnPqzYHwSrxK0RxRfoEiWlOvDd2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Oleg Kravtsov <oleg@tuxera.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 188/191] cifs: log warning message (once) if out of disk space
Date:   Fri, 21 Feb 2020 08:42:41 +0100
Message-Id: <20200221072313.381537875@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit d6fd41905ec577851734623fb905b1763801f5ef ]

We ran into a confusing problem where an application wasn't checking
return code on close and so user didn't realize that the application
ran out of disk space.  log a warning message (once) in these
cases. For example:

  [ 8407.391909] Out of space writing to \\oleg-server\small-share

Signed-off-by: Steve French <stfrench@microsoft.com>
Reported-by: Oleg Kravtsov <oleg@tuxera.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0d4e4d97e6cf5..e2d2b749c8f38 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3425,6 +3425,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				     wdata->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid, wdata->offset,
 				     wdata->bytes, wdata->result);
+		if (wdata->result == -ENOSPC)
+			printk_once(KERN_WARNING "Out of space writing to %s\n",
+				    tcon->treeName);
 	} else
 		trace_smb3_write_done(0 /* no xid */,
 				      wdata->cfile->fid.persistent_fid,
-- 
2.20.1



