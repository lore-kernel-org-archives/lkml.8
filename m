Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52202072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216973;
	bh=a5YYx2ZQyypM/51X9oNyFaPwgNPW3b4jNytdJ17wumg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CM43MyzAunzVbA5uk4eU5wkPWNyWtpjX4SbN5m8DrLnhth7wkhO/JzbeVXu/rs6XA
	 xVerVt+/t6/ozxl9v2kYGY7uaRijZ0cYGFJoJsjFlY2Se9HLtvs6VkzuTyJW++yGN1
	 Xzo7pl93z2GkDhLHKp4ql81F0DV8oeGXfCSjtli4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390948AbgAPXWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbgAPXWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4691E20684;
        Thu, 16 Jan 2020 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216961;
        bh=a5YYx2ZQyypM/51X9oNyFaPwgNPW3b4jNytdJ17wumg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpGgf2Tb23lIU8SdMnUnbTH6sxa+3kX+UJQxLB93Muds0OW/EHzvLnKV3+86/UWbr
         cUD7niGZeS+4u6WTFiKDXCc82YWWBFMo4gAZktD8mWQaKKSkNAFCTYwgDgiH63gpBR
         suR6NtMdMIQaKRi4MlpxA8uGkD+2C3Y7cKYdHdrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 065/203] RDMA/siw: Fix port number endianness in a debug message
Date:   Fri, 17 Jan 2020 00:16:22 +0100
Message-Id: <20200116231749.774888260@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 050dbddf249eee3e936b5734c30b2e1b427efdc3 upstream.

sin_port and sin6_port are big endian member variables. Convert these port
numbers into CPU endianness before printing.

Link: https://lore.kernel.org/r/20190930231707.48259-5-bvanassche@acm.org
Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/siw/siw_cm.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1867,14 +1867,7 @@ static int siw_listen_address(struct iw_
 	list_add_tail(&cep->listenq, (struct list_head *)id->provider_data);
 	cep->state = SIW_EPSTATE_LISTENING;
 
-	if (addr_family == AF_INET)
-		siw_dbg(id->device, "Listen at laddr %pI4 %u\n",
-			&(((struct sockaddr_in *)laddr)->sin_addr),
-			((struct sockaddr_in *)laddr)->sin_port);
-	else
-		siw_dbg(id->device, "Listen at laddr %pI6 %u\n",
-			&(((struct sockaddr_in6 *)laddr)->sin6_addr),
-			((struct sockaddr_in6 *)laddr)->sin6_port);
+	siw_dbg(id->device, "Listen at laddr %pISp\n", laddr);
 
 	return 0;
 


