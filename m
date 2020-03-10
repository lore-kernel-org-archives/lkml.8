Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6DF24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844866;
	bh=oy+1dEgrOKr/hieGFcI5guQvbcYAsYuQWqh7Sylh2k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HVB5B/3FVo5Ql7oLd6G9nYX6ghl+c4+Kd31hpMCNVXFrGi81shSB86/Jye5iyvRmN
	 mNWY6JZXnArTTNR4YZN/aJxPo1JNuPszKqbJW/3FbFLbXi2I2yq9xAIc7Prb26XQdB
	 cvI+A0Hg7dLwxlQXsvrLwgsbJJWgKmol2D9MzJOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgCJMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgCJMyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B85A20674;
        Tue, 10 Mar 2020 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844857;
        bh=oy+1dEgrOKr/hieGFcI5guQvbcYAsYuQWqh7Sylh2k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oy+ETM9QCh6DxKTEy9TawoWlTndmWhrs/+W16MZjtq74oBZGMTZOFToloQip4ai+R
         094/rvUKp/Rxrk3V8JG6hOQ3j8QwPKLVDvXnomvBq5FhaTCKnPcWmo/LdIJ6Kfpfvb
         vKPi5wm+o+IwYg0x/ddfQzzedwLQ9jT2w1ut44/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 143/168] firmware: imx: Align imx_sc_msg_req_cpu_start to 4
Date:   Tue, 10 Mar 2020 13:39:49 +0100
Message-Id: <20200310123649.979498257@linuxfoundation.org>
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

commit f5bfeff44612d304deb100065a9f712309dc2783 upstream.

The imx SC api strongly assumes that messages are composed out of
4-bytes words but some of our message structs have odd sizeofs.

This produces many oopses with CONFIG_KASAN=y.

Fix by marking with __aligned(4).

Fixes: d90bf296ae18 ("firmware: imx: Add support to start/stop a CPU")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/imx/misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -24,7 +24,7 @@ struct imx_sc_msg_req_cpu_start {
 	u32 address_lo;
 	u16 resource;
 	u8 enable;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_req_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;


