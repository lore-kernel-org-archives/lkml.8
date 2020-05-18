Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FCDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4755B207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824087;
	bh=AeFZBRmeTTtLuC6Tx5BC9x0nD9peBw6WD9MVHRwM2IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SxIvAlIqCiRzKfsGMylDLrqeHjrdyPK+JKzX8F2zo0il2ridexn8xDC1jM+08GnKv
	 E1UHIu/RkVMVoXZa/DDR419/tx5D05S9gOSQ+ECij7T16uEW72hETRQJRMD5YSlJmh
	 EA+H13y4anf2DqbpZmS/Q9IhQranbTnko8n/RDV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgERRsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbgERRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD0B20715;
        Mon, 18 May 2020 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824080;
        bh=AeFZBRmeTTtLuC6Tx5BC9x0nD9peBw6WD9MVHRwM2IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwvI5tt5XChSKyMNe7iYcQbvbdOjveV2yqMAPnzrdH6DK/nB3HvhsX9jh3zDTI+/7
         sABhigvOfymLoxgmyjy0huIvuf+gJ33s0VVLA6W5HBBberh+g6dOjsfzGyBz+Xb1Tj
         dgGVUGzl+9hxcSUwFp5hAFkV5PHq1jRFxVEwTp08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/114] ipmi: Fix NULL pointer dereference in ssif_probe
Date:   Mon, 18 May 2020 19:36:35 +0200
Message-Id: <20200518173514.489706001@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit a8627cda7cfffe1792c199660c2b4f03ba2bd97b ]

There is a potential execution path in which function ssif_info_find()
returns NULL, hence there is a NULL pointer dereference when accessing
pointer *addr_info*

Fix this by null checking *addr_info* before dereferencing it.

Addresses-Coverity-ID: 1473145 ("Explicit null dereferenced")
Fixes: e333054a91d1 ("ipmi: Fix I2C client removal in the SSIF driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 0146bc3252c5a..cf87bfe971e6b 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1731,7 +1731,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
-		addr_info->client = NULL;
+		if (addr_info)
+			addr_info->client = NULL;
+
 		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
 		kfree(ssif_info);
 	}
-- 
2.20.1



