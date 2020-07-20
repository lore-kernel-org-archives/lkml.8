Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BFC43445
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D24C22CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281071;
	bh=6IiCZJSCazxGZ+S4y95kWx0DvTpmrq6GMeSZMEbfpyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vgSsGMBHDYsX79b4AxijWHac7O3Y5ZoaLkwVZHG1GTsoz9J9ENQOtMTlNJWdIMM+9
	 raZpttYP7Bv09tCGnCEVTI6fCiuQ0/xN9psaRHwuZol0GNtC0faK6esUQxb/2cZvra
	 YZaFcCFRyAkRNia3GMsF1AqvcTy4m6orFFLj6Mws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGTVhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGTVhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF49922CF7;
        Mon, 20 Jul 2020 21:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281065;
        bh=6IiCZJSCazxGZ+S4y95kWx0DvTpmrq6GMeSZMEbfpyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSNYyOtQazvpOaNAYgWZ+q+QPJC+0BqwT9eNQiFGhBSaMiYIZp1omU5tOXQ5tNO38
         mWfx+TfK2/MaqgahibaJN6c6vw5VUogJWZjAo2CWFV2XFxsiNIbxGAvPfDy/Xt31B+
         slNi6Tu6RqH5BWYlmDOjAZiEw8hLY025l7dR2pKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Chen <peter.chen@nxp.com>, kbuild test robot <lkp@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 24/40] usb: cdns3: trace: fix some endian issues
Date:   Mon, 20 Jul 2020 17:36:59 -0400
Message-Id: <20200720213715.406997-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

[ Upstream commit 65b7cf48c211ece5e2560a334eb9608e48775a8f ]

It is found by sparse.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
index 755c565822575..0a2a3269bfac6 100644
--- a/drivers/usb/cdns3/trace.h
+++ b/drivers/usb/cdns3/trace.h
@@ -404,9 +404,9 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 	TP_fast_assign(
 		__assign_str(name, priv_ep->name);
 		__entry->trb = trb;
-		__entry->buffer = trb->buffer;
-		__entry->length = trb->length;
-		__entry->control = trb->control;
+		__entry->buffer = le32_to_cpu(trb->buffer);
+		__entry->length = le32_to_cpu(trb->length);
+		__entry->control = le32_to_cpu(trb->control);
 		__entry->type = usb_endpoint_type(priv_ep->endpoint.desc);
 		__entry->last_stream_id = priv_ep->last_stream_id;
 	),
-- 
2.25.1

