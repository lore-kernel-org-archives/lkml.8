Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78DE20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443126;
	bh=03xzoa24LTQ6z0+jZrl/hZ4inFdHU56AHL9eX4wVlTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bi9KSAU+cQqxus73AwkSGdjoBFJkVwUeLy/e2y1M3RouJ4swkkHkdIUSpLRgzwuII
	 De+RKBOL14D+Z1Jo8eAJkF2W43HgKI4Skrbo5hvbq+a9dAdcSiclXpSrEMfvoe07xD
	 Cegc9ZrMehQxc89CGvMzXLEk7ScpJBvnRYfW+p+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCQLFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgCQLFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E058620658;
        Tue, 17 Mar 2020 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443112;
        bh=03xzoa24LTQ6z0+jZrl/hZ4inFdHU56AHL9eX4wVlTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeppvnsgEIz/oGMpxA3cQOiyIkNOQo9co0568Tox+Y5zoYtlKF+bP0I9AmEjR5lTk
         PEcuazntfUslPZOdJD/taIfpkAyJgZkD9zFGLaLtXdkhS/5W/ZEQwaQ7Er1lEMNPbv
         FcOvarPNpBZDugGMo68E8DzuCrqqzRY+NEN7HY9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 100/123] pinctrl: imx: scu: Align imx sc msg structs to 4
Date:   Tue, 17 Mar 2020 11:55:27 +0100
Message-Id: <20200317103317.893198662@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
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


