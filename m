Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DBC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B833222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846707;
	bh=d++i2rxskDMNAcTw7Q5XEt6x9MQycNx2Ds0IINKJFzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdbI/NOLoHGnCfsomD2N9kwXpDagmR/6m57DL2cZ/IyW/c/IqwGK+NyCoEj8TDyco
	 Xce9T0eYaAgGMgk9UPx9uEibedVfspPiuWhWEm5r/ajxdWin4ycdmeDv/yEXHUY07A
	 Jqn9SBPx2+g8k4wJIoiquso8+vm/JxAHI/iBgAPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgCJNZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgCJM6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:58:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B900E20674;
        Tue, 10 Mar 2020 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845090;
        bh=d++i2rxskDMNAcTw7Q5XEt6x9MQycNx2Ds0IINKJFzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeJSP2HUHkVlNVKW40HgECkMVGCSxZMphobV2sMQ1xo/OycuuWw1fmwW8Amxu4025
         fc6ouoW8Wa4cNcxNVrhs3/ozSl6AjZOjE83hSmEnSxn3B/1gGxeLF/fJYj/OWK4VIG
         HL+m+BEF1FtnyX3qZPVUVbNeV4IMX0IzSXpLUgOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        ": Oleksij Rempel" <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.5 058/189] firmware: imx: scu: Ensure sequential TX
Date:   Tue, 10 Mar 2020 13:38:15 +0100
Message-Id: <20200310123645.453176342@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 26d0fba29c96241de8a9d16f045b1de49875884c upstream.

SCU requires that all messages words are written sequentially but linux MU
driver implements multiple independent channels for each register so ordering
between different channels must be ensured by SCU API interface.

Wait for tx_done before every send to ensure that no queueing happens at the
mailbox channel level.

Fixes: edbee095fafb ("firmware: imx: add SCU firmware driver support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by:: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/imx/imx-scu.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -29,6 +29,7 @@ struct imx_sc_chan {
 	struct mbox_client cl;
 	struct mbox_chan *ch;
 	int idx;
+	struct completion tx_done;
 };
 
 struct imx_sc_ipc {
@@ -100,6 +101,14 @@ int imx_scu_get_handle(struct imx_sc_ipc
 }
 EXPORT_SYMBOL(imx_scu_get_handle);
 
+/* Callback called when the word of a message is ack-ed, eg read by SCU */
+static void imx_scu_tx_done(struct mbox_client *cl, void *mssg, int r)
+{
+	struct imx_sc_chan *sc_chan = container_of(cl, struct imx_sc_chan, cl);
+
+	complete(&sc_chan->tx_done);
+}
+
 static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
 {
 	struct imx_sc_chan *sc_chan = container_of(c, struct imx_sc_chan, cl);
@@ -149,6 +158,19 @@ static int imx_scu_ipc_write(struct imx_
 
 	for (i = 0; i < hdr->size; i++) {
 		sc_chan = &sc_ipc->chans[i % 4];
+
+		/*
+		 * SCU requires that all messages words are written
+		 * sequentially but linux MU driver implements multiple
+		 * independent channels for each register so ordering between
+		 * different channels must be ensured by SCU API interface.
+		 *
+		 * Wait for tx_done before every send to ensure that no
+		 * queueing happens at the mailbox channel level.
+		 */
+		wait_for_completion(&sc_chan->tx_done);
+		reinit_completion(&sc_chan->tx_done);
+
 		ret = mbox_send_message(sc_chan->ch, &data[i]);
 		if (ret < 0)
 			return ret;
@@ -247,6 +269,11 @@ static int imx_scu_probe(struct platform
 		cl->knows_txdone = true;
 		cl->rx_callback = imx_scu_rx_callback;
 
+		/* Initial tx_done completion as "done" */
+		cl->tx_done = imx_scu_tx_done;
+		init_completion(&sc_chan->tx_done);
+		complete(&sc_chan->tx_done);
+
 		sc_chan->sc_ipc = sc_ipc;
 		sc_chan->idx = i % 4;
 		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);


