Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23797207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824451;
	bh=4obmFbAA/DVvTb4BHmCCLVDrga54rTsJEGqlCpJWLQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QBfunHAs9PdrosBOe7+77knWXnMzm00DW1mc+3Sbgi4nZUPXVQiK1Ami9Bi1wSEOX
	 o0b94KTvPC3r+mq1KBBuPkF0O9x6yxROdyAxBtRaho7AXZXzWyJwY50uJrq9heDHrS
	 gefVpQ0WEacyAYJ9jSJMYf/BET7Uy0IIVmlp2gX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgERRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgERRyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:54:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A1A207F5;
        Mon, 18 May 2020 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824445;
        bh=4obmFbAA/DVvTb4BHmCCLVDrga54rTsJEGqlCpJWLQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkC/N9BpkSKpXnqehgmT9JJDWzw4sYiDJfWjibwMgeG1iiVIckHcxhym18OzcqSRX
         8TDSi6nC62KUMoLkVimx048vtWwnOzyJFD8g6ikmGzzECkkuXonqB1IGWPZIdT+/0T
         g20LSjRDJdkXXFpZ95ChUPIBLyDm/4gCxCB1Y9iE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>,
        Wu Bo <wubo40@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.4 015/147] scsi: sg: add sg_remove_request in sg_write
Date:   Mon, 18 May 2020 19:35:38 +0200
Message-Id: <20200518173515.636749011@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

commit 83c6f2390040f188cc25b270b4befeb5628c1aee upstream.

If the __copy_from_user function failed we need to call sg_remove_request
in sg_write.

Link: https://lore.kernel.org/r/610618d9-e983-fd56-ed0f-639428343af7@huawei.com
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[groeck: Backport to v5.4.y and older kernels]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -689,8 +689,10 @@ sg_write(struct file *filp, const char _
 	hp->flags = input_size;	/* structure abuse ... */
 	hp->pack_id = old_hdr.pack_id;
 	hp->usr_ptr = NULL;
-	if (__copy_from_user(cmnd, buf, cmd_size))
+	if (__copy_from_user(cmnd, buf, cmd_size)) {
+		sg_remove_request(sfp, srp);
 		return -EFAULT;
+	}
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
 	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there


