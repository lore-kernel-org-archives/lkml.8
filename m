Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE73422CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915498;
	bh=G4UhC8H1peBQskffRrkzMTllBPjEVDEGDpsAV47tnfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RL/PIww2zhmlTUn7+72CyrONg744HMNsTIJUzflTGe96YxoxLVP8cYoFADlba7Ejx
	 /0xaDD2Wm0RuI08dVn/pjMi370wvX6fm5tyO3pyJ2nS+7MG4JQ8ojue0l4JBOyXcfF
	 kE0uEl86v6cIr9THGcQpLM7hYdvGlh94cuFRr5t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTJYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgHTJYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:24:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFF422CE3;
        Thu, 20 Aug 2020 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915479;
        bh=G4UhC8H1peBQskffRrkzMTllBPjEVDEGDpsAV47tnfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vim5y6IoNsWUtxm/pijrqaEb0jUUX6quTjm01peiRkTzWB3XV9xmm8lNlGsUvIWFh
         gjm4i28gO0Oz2bN3U7jEL3aD5sXFwNSRSJytMxTQAniCSjMIzFevwAcY4vkAR1dqpu
         gHbWakovBor9+otWwF9lpElMepYIjF5008KwLQUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.8 003/232] SMB3: Fix mkdir when idsfromsid configured on mount
Date:   Thu, 20 Aug 2020 11:17:34 +0200
Message-Id: <20200820091612.869750725@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit c8c412f976124d85b8ded85c6ac3f760c12b63a3 upstream.

mkdir uses a compounded create operation which was not setting
the security descriptor on create of a directory. Fix so
mkdir now sets the mode and owner info properly when idsfromsid
and modefromsid are configured on the mount.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org> # v5.8
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -115,6 +115,7 @@ smb2_compound_op(const unsigned int xid,
 	vars->oparms.fid = &fid;
 	vars->oparms.reconnect = false;
 	vars->oparms.mode = mode;
+	vars->oparms.cifs_sb = cifs_sb;
 
 	rqst[num_rqst].rq_iov = &vars->open_iov[0];
 	rqst[num_rqst].rq_nvec = SMB2_CREATE_IOV_SIZE;


