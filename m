Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704D7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D8C214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322429;
	bh=ZCiPAtOxuxnCByGA3BqQ7UHBlJxuFSZWp1aLpHrCBmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klsEiw+t2pNl1YwDErQjO4Se5VIqbay3wZYYxNEoHmXUY5VsE5jgk/MtkLxdfLkOm
	 HdlrrF1cgNZFj51uACcIiEcUEWgaD1q1wTsIvwB/0f0MHA3cDCIQMPrmhBe6ve+5Ut
	 mEQnm+lmsgPTH2Qyf6Q14tqSsKTreHl35VkRJaJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgFPPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbgFPPrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E13F21475;
        Tue, 16 Jun 2020 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322422;
        bh=ZCiPAtOxuxnCByGA3BqQ7UHBlJxuFSZWp1aLpHrCBmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYyy372Ap0zMk5I+QzJeq1EIWR6OaQ0jhfBFMe4Jv1pIIwqW22Ssg0777K0sO4/zX
         4sOibt9ntWduVdx7CQ52kA88QxBrrFmYDut5UDNHyE1Gn5GTGhbhWJoaxhdJZLqq6C
         XwLehHOh13F0Wpoj+gpTYuE14mJrSJHyVL/hHwyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, LABBE Corentin <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Gonglei <arei.gonglei@huawei.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH 5.7 095/163] crypto: virtio: Fix src/dst scatterlist calculation in __virtio_crypto_skcipher_do_req()
Date:   Tue, 16 Jun 2020 17:34:29 +0200
Message-Id: <20200616153111.382472195@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng(Mike) <longpeng2@huawei.com>

commit b02989f37fc5e865ceeee9070907e4493b3a21e2 upstream.

The system will crash when the users insmod crypto/tcrypt.ko with mode=38
( testing "cts(cbc(aes))" ).

Usually the next entry of one sg will be @sg@ + 1, but if this sg element
is part of a chained scatterlist, it could jump to the start of a new
scatterlist array. Fix it by sg_next() on calculation of src/dst
scatterlist.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Reported-by: LABBE Corentin <clabbe@baylibre.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200123101000.GB24255@Red
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Link: https://lore.kernel.org/r/20200602070501.2023-2-longpeng2@huawei.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/virtio/virtio_crypto_algs.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -350,13 +350,18 @@ __virtio_crypto_skcipher_do_req(struct v
 	int err;
 	unsigned long flags;
 	struct scatterlist outhdr, iv_sg, status_sg, **sgs;
-	int i;
 	u64 dst_len;
 	unsigned int num_out = 0, num_in = 0;
 	int sg_total;
 	uint8_t *iv;
+	struct scatterlist *sg;
 
 	src_nents = sg_nents_for_len(req->src, req->cryptlen);
+	if (src_nents < 0) {
+		pr_err("Invalid number of src SG.\n");
+		return src_nents;
+	}
+
 	dst_nents = sg_nents(req->dst);
 
 	pr_debug("virtio_crypto: Number of sgs (src_nents: %d, dst_nents: %d)\n",
@@ -443,12 +448,12 @@ __virtio_crypto_skcipher_do_req(struct v
 	vc_sym_req->iv = iv;
 
 	/* Source data */
-	for (i = 0; i < src_nents; i++)
-		sgs[num_out++] = &req->src[i];
+	for (sg = req->src; src_nents; sg = sg_next(sg), src_nents--)
+		sgs[num_out++] = sg;
 
 	/* Destination data */
-	for (i = 0; i < dst_nents; i++)
-		sgs[num_out + num_in++] = &req->dst[i];
+	for (sg = req->dst; sg; sg = sg_next(sg))
+		sgs[num_out + num_in++] = sg;
 
 	/* Status */
 	sg_init_one(&status_sg, &vc_req->status, sizeof(vc_req->status));


