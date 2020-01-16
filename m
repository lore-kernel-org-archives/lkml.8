Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F792072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218270;
	bh=N7VTVlXdao9/QnRa5Pq+e/5WQ6gubOhfw2gXsn5wv+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgQm+m6wUVx87ySIRtWQTB0v9cAFD+ImXyCvAl4SoB3ZwGUp6kUPFuOrqrxChqazF
	 qzXJj0Tr1YFaEIN4pR++2XIzF4syHkk0Il6q+kVRdSPLjd+YKoa841qrnQyZ6a0Lon
	 izTTjDW9G/NrmYNeP3T53inMCjqi4EkEdw7vbfcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgAPXo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgAPXYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695982072E;
        Thu, 16 Jan 2020 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217049;
        bh=N7VTVlXdao9/QnRa5Pq+e/5WQ6gubOhfw2gXsn5wv+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aP24NWQyzyKxf0KN9wBgkaDJsSZ55/4tPsZahpVd29QU6FUl7+7tnLHnskIbZ/vpi
         kvLXrN91ignhfZW6D3zXXg0ri8hOWqUvyeL7yElXtc7LDGvQ9o6mEEF0kyuwiwEWMD
         iW/LCsfaWtLu5Onjvdp5l6+CQlYbTIPTLAZXladw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gonglei <arei.gonglei@huawei.com>,
        virtualization@lists.linux-foundation.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 101/203] crypto: virtio - implement missing support for output IVs
Date:   Fri, 17 Jan 2020 00:16:58 +0100
Message-Id: <20200116231754.427447217@linuxfoundation.org>
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

From: Ard Biesheuvel <ardb@kernel.org>

commit 500e6807ce93b1fdc7d5b827c5cc167cc35630db upstream.

In order to allow for CBC to be chained, which is something that the
CTS template relies upon, implementations of CBC need to pass the
IV to be used for subsequent invocations via the IV buffer. This was
not implemented yet for virtio-crypto so implement it now.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/virtio/virtio_crypto_algs.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -435,6 +435,11 @@ __virtio_crypto_ablkcipher_do_req(struct
 		goto free;
 	}
 	memcpy(iv, req->info, ivsize);
+	if (!vc_sym_req->encrypt)
+		scatterwalk_map_and_copy(req->info, req->src,
+					 req->nbytes - AES_BLOCK_SIZE,
+					 AES_BLOCK_SIZE, 0);
+
 	sg_init_one(&iv_sg, iv, ivsize);
 	sgs[num_out++] = &iv_sg;
 	vc_sym_req->iv = iv;
@@ -571,6 +576,10 @@ static void virtio_crypto_ablkcipher_fin
 	struct ablkcipher_request *req,
 	int err)
 {
+	if (vc_sym_req->encrypt)
+		scatterwalk_map_and_copy(req->info, req->dst,
+					 req->nbytes - AES_BLOCK_SIZE,
+					 AES_BLOCK_SIZE, 0);
 	crypto_finalize_ablkcipher_request(vc_sym_req->base.dataq->engine,
 					   req, err);
 	kzfree(vc_sym_req->iv);


