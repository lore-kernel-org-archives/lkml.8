Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B0C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3792624683
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996194;
	bh=LbB7Csx7x/5VQGaUzYHoxWMPMWVZKDKqPZjC3U39p80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/nu07M/qX5KJMi7mRv7teVlYlVOTKWrmDPq6KqgRlK+jA7t5+fWMmoFcWdKL8saX
	 QA26sl8muSnx3URVpHuxLK+/76al4sVDzkAs1a4UrhoN/Y7Dbvo4ty3O0cwsH9vF93
	 IZ4GatCgJaRLeRRDDnahvoBIJu/ypP4HKTFJSIlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgANKDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgANKDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4042467D;
        Tue, 14 Jan 2020 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996191;
        bh=LbB7Csx7x/5VQGaUzYHoxWMPMWVZKDKqPZjC3U39p80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5zSVDAm3168DXmXTwu1/JceN4NpWgTD+u8l4/WgM9JoJdrIOMVa6ZnULUd2d2NO7
         nCfIp3xcpkaKtmmakGZ8zxXUK3KBsZErxl5ujeEiEv1K92B5ODWDWZGjul4wt3ctXG
         dHbK7L3UBJJA9lmfI/CdwLHc8iIQpAWM4ANq0DpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.4 12/78] tpm: Handle negative priv->response_len in tpm_common_read()
Date:   Tue, 14 Jan 2020 11:00:46 +0100
Message-Id: <20200114094354.348403483@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tadeusz Struk <tadeusz.struk@intel.com>

commit a430e67d9a2c62a8c7b315b99e74de02018d0a96 upstream.

The priv->response_length can hold the size of an response or an negative
error code, and the tpm_common_read() needs to handle both cases correctly.
Changed the type of response_length to signed and accounted for negative
value in tpm_common_read().

Cc: stable@vger.kernel.org
Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-dev-common.c |    2 +-
 drivers/char/tpm/tpm-dev.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -130,7 +130,7 @@ ssize_t tpm_common_read(struct file *fil
 		priv->response_read = true;
 
 		ret_size = min_t(ssize_t, size, priv->response_length);
-		if (!ret_size) {
+		if (ret_size <= 0) {
 			priv->response_length = 0;
 			goto out;
 		}
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -14,7 +14,7 @@ struct file_priv {
 	struct work_struct timeout_work;
 	struct work_struct async_work;
 	wait_queue_head_t async_wait;
-	size_t response_length;
+	ssize_t response_length;
 	bool response_read;
 	bool command_enqueued;
 


