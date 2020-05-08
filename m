Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9010424964
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943858;
	bh=zU/KGDWSH/GSGW/PVSMIQOZ9CrPdwXtgZfYDOAMPFpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAHGp//A3l5LOPwPGukyjXe44BHoINcpec53CZNJLB/RZHmVQsQQ5766L3ljwv4TD
	 wp+fPhQv052EDyfVV8nGPAVoDWDRa+x3eKGa4lpH0oe3Nyu7TUzCsOv8Qm3cLAxPqV
	 rRVxyJ0/xaHumZtCLl3aFttGwdp2B7WqDYrbDDd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEHNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgEHMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA39207DD;
        Fri,  8 May 2020 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941832;
        bh=zU/KGDWSH/GSGW/PVSMIQOZ9CrPdwXtgZfYDOAMPFpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgWiLwD3EiT/oY2aOvlrPdkfOzNrr02u9VLtiT2Emff7ZnSk2tcE226NfUQXQuiCV
         RZwf79EcX1NFOwR94GT8TfpRo0rIVRlSpCttZvJrZcvS5+VWxBgJrlmo/2ogX0Xpkf
         iKFJEb3yZDq9KEidkX2pRzufkdAhgR7TjIb/1ERE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.4 150/312] sunrpc: Update RPCBIND_MAXNETIDLEN
Date:   Fri,  8 May 2020 14:32:21 +0200
Message-Id: <20200508123135.008266264@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit 4b9c7f9db9a003f5c342184dc4401c1b7f2efb39 upstream.

Commit 176e21ee2ec8 ("SUNRPC: Support for RPC over AF_LOCAL
transports") added a 5-character netid, but did not bump
RPCBIND_MAXNETIDLEN from 4 to 5.

Fixes: 176e21ee2ec8 ("SUNRPC: Support for RPC over AF_LOCAL ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/sunrpc/msg_prot.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -158,9 +158,9 @@ typedef __be32	rpc_fraghdr;
 
 /*
  * Note that RFC 1833 does not put any size restrictions on the
- * netid string, but all currently defined netid's fit in 4 bytes.
+ * netid string, but all currently defined netid's fit in 5 bytes.
  */
-#define RPCBIND_MAXNETIDLEN	(4u)
+#define RPCBIND_MAXNETIDLEN	(5u)
 
 /*
  * Universal addresses are introduced in RFC 1833 and further spelled


