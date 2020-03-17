Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C620658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443582;
	bh=03xzoa24LTQ6z0+jZrl/hZ4inFdHU56AHL9eX4wVlTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14Pruo0gFyAo7jg5fCw4SMUxV9hObT9JOdsctBtZRk51/t9+gFnC1uMLLuzg7kWJ9
	 faDele+s8O04n9ROc6t6yp6WIZn6zecw4Fuui6ECC2OLDzVqj30h7HkeVZvkiMuXNv
	 jIjt5xf3/8/n6jt9k/D682ZqdYnUIp3HPNx3/bKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCQLNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbgCQLMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:12:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A07D820736;
        Tue, 17 Mar 2020 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443575;
        bh=03xzoa24LTQ6z0+jZrl/hZ4inFdHU56AHL9eX4wVlTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpldZkCKexbgqKELEGUg7Zs6lRaLKaE53STDpQC83lMI5CDURfPvgHBvZlry0Vzmn
         ihnk2jRldU2rxHKuGI++8L2VrAyDlcqApqHGVA8u10U6xL1rL1zKavEUSXBcaWdiC5
         xwRAXNp+zejNidLAzuGxijead974BG9QsUKdNRn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.5 127/151] pinctrl: imx: scu: Align imx sc msg structs to 4
Date:   Tue, 17 Mar 2020 11:55:37 +0100
Message-Id: <20200317103335.462943963@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 4c48e549f39f8ed10cf8a0b6cb96f5eddf0391ce upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Link: https://lore.kernel.org/r/bd7ad5fd755739a6d8d5f4f65e03b3ca4f457bd2.1582216144.git.leonard.crestez@nxp.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/freescale/pinctrl-scu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -23,12 +23,12 @@ struct imx_sc_msg_req_pad_set {
 	struct imx_sc_rpc_msg hdr;
 	u32 val;
 	u16 pad;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_req_pad_get {
 	struct imx_sc_rpc_msg hdr;
 	u16 pad;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_resp_pad_get {
 	struct imx_sc_rpc_msg hdr;


