Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20650206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943966;
	bh=QJ3RDWOjBqYYBWf0SqEir9S94tmMdVCUZ0UnnTCgYmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NoArgDtGFPDfbJIVd8fg0DH3Ouig2Xs6121SSKaACFy3y8NaLpDaTQGGJM4RChywW
	 U3YBRlLtzk8qYc1eOpBFeC7hp0zbI3v9qsNX1dl1/aSMRp91lvcvVbBqFojiUBFPpA
	 voLRwL7Ibr1iHoxi8fTgrDk/nwMQDUGYyrIVnmgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgEHNTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgEHMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DA020731;
        Fri,  8 May 2020 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941733;
        bh=QJ3RDWOjBqYYBWf0SqEir9S94tmMdVCUZ0UnnTCgYmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WncnZphNKhTStOkTqjJTsenOOy5+noPhEFBtAZ/ITPN1kqvdcsEKgqHGwY+2aI+hR
         v+kS+WDe2nY7q+Ud4/6OdpbV11uywmUZ/KIE+UJpPIZAbZ0S+e/TjlyicmR8s5eg9L
         a0tjPjD6ltgLmYrDhEws2N8TDiZDobMdWDQHUrsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Devesh Sharma <devesh.sharma@avagotech.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.4 102/312] xprtrdma: xprt_rdma_free() must not release backchannel reqs
Date:   Fri,  8 May 2020 14:31:33 +0200
Message-Id: <20200508123131.690727201@linuxfoundation.org>
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

commit ffc4d9b1596c34caa98962722e930e97912c8a9f upstream.

Preserve any rpcrdma_req that is attached to rpc_rqst's allocated
for the backchannel. Otherwise, after all the pre-allocated
backchannel req's are consumed, incoming backward calls start
writing on freed memory.

Somehow this hunk got lost.

Fixes: f531a5dbc451 ('xprtrdma: Pre-allocate backward rpc_rqst')
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Devesh Sharma <devesh.sharma@avagotech.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/transport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -576,6 +576,9 @@ xprt_rdma_free(void *buffer)
 
 	rb = container_of(buffer, struct rpcrdma_regbuf, rg_base[0]);
 	req = rb->rg_owner;
+	if (req->rl_backchannel)
+		return;
+
 	r_xprt = container_of(req->rl_buffer, struct rpcrdma_xprt, rx_buf);
 
 	dprintk("RPC:       %s: called on 0x%p\n", __func__, req->rl_reply);


