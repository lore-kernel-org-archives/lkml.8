Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DFF2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844857;
	bh=ZO8FwvmxBq4EK5HBjM/dWfdx3Zqag8CeMb7CbOYrfFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsAoLTBo8oV1s8N7BibuFyy5qIZxY16AaqqS09Dky+EdO3zzJsOdwtN4EOZ4KQ3V5
	 n9LvVztaIA7OQ9ttQH452M6tIrP55dc5OwOteHkCeFcaUSvx1kZ5AnArARzMAcViSt
	 plRP8LUSpWhkV1kwwu0eVwVn/+DYc1XTSqdfMUdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgCJMyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgCJMyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872502468E;
        Tue, 10 Mar 2020 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844852;
        bh=ZO8FwvmxBq4EK5HBjM/dWfdx3Zqag8CeMb7CbOYrfFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIVVqfjD11smJgi6jrnqZokL1I/oe3iCudS1jyI9jsqdGhWE6TuiJIX5QE6bLWDjK
         Gu06p9IoiQhPSKSbJHA2ZTkuDIUR00WBMRYSBP44GbZsOriSSI23NMIpIdEO7i8Dzq
         nbSpMvQ7E/Q058rKYlv41R9usIserNVxUWdzBt2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 141/168] firmware: imx: misc: Align imx sc msg structs to 4
Date:   Tue, 10 Mar 2020 13:39:47 +0100
Message-Id: <20200310123649.774083610@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 1e6a4eba693ac72e6f91b4252458c933110e5f4c upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y:

    BUG: KASAN: stack-out-of-bounds in imx_mu_send_data+0x108/0x1f0

It shouldn't cause an issues in normal use because these structs are
always allocated on the stack.

Fixes: 15e1f2bc8b3b ("firmware: imx: add misc svc support")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/imx/misc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -16,7 +16,7 @@ struct imx_sc_msg_req_misc_set_ctrl {
 	u32 ctrl;
 	u32 val;
 	u16 resource;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_req_cpu_start {
 	struct imx_sc_rpc_msg hdr;
@@ -30,12 +30,12 @@ struct imx_sc_msg_req_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;
 	u32 ctrl;
 	u16 resource;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_resp_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;
 	u32 val;
-} __packed;
+} __packed __aligned(4);
 
 /*
  * This function sets a miscellaneous control value.


