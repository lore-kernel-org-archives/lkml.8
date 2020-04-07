Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D065CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8E2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255155;
	bh=KN/RtJgBrXn5vFfRyb79eWSReJRlqg0mW2vgwy54kG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUAFfjpoXceIqfznA64U+qavCUGs0df0lnYHgcVSUTls7kzYbgh5SCNlGWOy96Kov
	 k0dsk0b/YT9Ch45k0GZ/5tSdNg0oSTVES+euwP3Ccpn37IKnbj1r1D8l7EcCb/aPu6
	 YSjlwPZpIs2m3aKIUB6y2M98ex4F72jZ22TiojOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgDGKZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgDGKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:25:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7101A20771;
        Tue,  7 Apr 2020 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255151;
        bh=KN/RtJgBrXn5vFfRyb79eWSReJRlqg0mW2vgwy54kG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3KvttlmP7fkaGFNrwPwacwI2ckQcbb0Il7awKLoJGDCmqEfaJjmbAEzS4FYn3nOB
         TXZh/iMWDiHJB5e4qBJ+maALQTc3NHOR764n+Ao2uGY7msLr0GBITabWnyVO6A2oll
         /wiobBnZHrR0d6S47jm5OU6Sa9g0aGTkIYgkWd0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 5.5 33/46] soc: mediatek: knows_txdone needs to be set in Mediatek CMDQ helper
Date:   Tue,  7 Apr 2020 12:22:04 +0200
Message-Id: <20200407101503.033372873@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

commit ce35e21d82bcac8b3fd5128888f9e233f8444293 upstream.

Mediatek CMDQ driver have a mechanism to do TXDONE_BY_ACK,
so we should set knows_txdone.

Fixes:576f1b4bc802 ("soc: mediatek: Add Mediatek CMDQ helper")

Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/mediatek/mtk-cmdq-helper.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -38,6 +38,7 @@ struct cmdq_client *cmdq_mbox_create(str
 	client->pkt_cnt = 0;
 	client->client.dev = dev;
 	client->client.tx_block = false;
+	client->client.knows_txdone = true;
 	client->chan = mbox_request_channel(&client->client, index);
 
 	if (IS_ERR(client->chan)) {


