Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD17C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7702F22AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752597;
	bh=SVDxlP2uLDDOHzFOKptNsOHDJMLgiSIc7YutqWD0JoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aHGTSrd/VGDGnz7nbihUN23d04IHt3x03m7F7n2IRC70q/aF15GK0SFqMdNnqL4GR
	 fpXnX/7tNrP4vGt0ep0LMzz+186OvSdPf5gBUAXmikdZqwy3a18eLewUezhHxh5ya0
	 TqR9DBTQqXyBKcj+Cq35Sekzgq66Lt+cUJ+PFBFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgGNSt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbgGNStv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6ABC22AAA;
        Tue, 14 Jul 2020 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752591;
        bh=SVDxlP2uLDDOHzFOKptNsOHDJMLgiSIc7YutqWD0JoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFirly/S+lCGcZxK2CMn0N3zf3tjeuzICxBQ3FwVyeo40Pp7byez2BS0zfZtu1lDl
         Fh+ZTTwPLMZNlAVeLkUtSGIh/tYTDsBii+NBm7wmI/EwqgxlbcEzTXtTa10bAqguqx
         j2+VI4KjRXLV3dAg0EvygFiRL9fdFan2Xh21/BHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        syzbot+b8fe393f999a291a9ea6@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 035/109] net: qrtr: Fix an out of bounds read qrtr_endpoint_post()
Date:   Tue, 14 Jul 2020 20:43:38 +0200
Message-Id: <20200714184107.201437055@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 8ff41cc21714704ef0158a546c3c4d07fae2c952 upstream.

This code assumes that the user passed in enough data for a
qrtr_hdr_v1 or qrtr_hdr_v2 struct, but it's not necessarily true.  If
the buffer is too small then it will read beyond the end.

Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reported-by: syzbot+b8fe393f999a291a9ea6@syzkaller.appspotmail.com
Fixes: 194ccc88297a ("net: qrtr: Support decoding incoming v2 packets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/qrtr/qrtr.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -259,7 +259,7 @@ int qrtr_endpoint_post(struct qrtr_endpo
 	unsigned int ver;
 	size_t hdrlen;
 
-	if (len & 3)
+	if (len == 0 || len & 3)
 		return -EINVAL;
 
 	skb = netdev_alloc_skb(NULL, len);
@@ -273,6 +273,8 @@ int qrtr_endpoint_post(struct qrtr_endpo
 
 	switch (ver) {
 	case QRTR_PROTO_VER_1:
+		if (len < sizeof(*v1))
+			goto err;
 		v1 = data;
 		hdrlen = sizeof(*v1);
 
@@ -286,6 +288,8 @@ int qrtr_endpoint_post(struct qrtr_endpo
 		size = le32_to_cpu(v1->size);
 		break;
 	case QRTR_PROTO_VER_2:
+		if (len < sizeof(*v2))
+			goto err;
 		v2 = data;
 		hdrlen = sizeof(*v2) + v2->optlen;
 


