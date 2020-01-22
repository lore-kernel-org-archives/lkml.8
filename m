Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8A24697
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699540;
	bh=rVq4mOa/HPylGUTAZCFbhU3NDARoOXa54ONl8NbBoaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgdJI4sVLql9LY7g0B8CmdqU97KEJnergaJugPa5uOvZf7SsIVDXDD4KsA2LVNnZm
	 hcCG8t99aGu5L2HE+ErQnEAWXYbi9lJ/yr08dv/Dor7X0hQdc+y4ObgBOs/HMdJ1fk
	 A/9gkATv7MwpNQjkzkR4aLrfjzTMD5lTPOD7Z5T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgAVNZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbgAVNZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:35 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A552467B;
        Wed, 22 Jan 2020 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699535;
        bh=rVq4mOa/HPylGUTAZCFbhU3NDARoOXa54ONl8NbBoaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlPpeAtKHjSD8P90wUsHnY/drBx6DEJgNY7aekJO/HYq39L9h9Gn/hhdICPIyWLIh
         7e2BaFK31VoO+76R1sXAp2J92H5LwMfkxbfeFdD9zwuWYQ5uURLFS5lgb5+Di47kDb
         DwepPZqcjIFUfChMgRZo84kVdZT1j4rZC+Qqdpsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 175/222] cw1200: Fix a signedness bug in cw1200_load_firmware()
Date:   Wed, 22 Jan 2020 10:29:21 +0100
Message-Id: <20200122092846.230821180@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4a50d454502f1401171ff061a5424583f91266db upstream.

The "priv->hw_type" is an enum and in this context GCC will treat it
as an unsigned int so the error handling will never trigger.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/st/cw1200/fwio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/st/cw1200/fwio.c
+++ b/drivers/net/wireless/st/cw1200/fwio.c
@@ -320,12 +320,12 @@ int cw1200_load_firmware(struct cw1200_c
 		goto out;
 	}
 
-	priv->hw_type = cw1200_get_hw_type(val32, &major_revision);
-	if (priv->hw_type < 0) {
+	ret = cw1200_get_hw_type(val32, &major_revision);
+	if (ret < 0) {
 		pr_err("Can't deduce hardware type.\n");
-		ret = -ENOTSUPP;
 		goto out;
 	}
+	priv->hw_type = ret;
 
 	/* Set DPLL Reg value, and read back to confirm writes work */
 	ret = cw1200_reg_write_32(priv, ST90TDS_TSET_GEN_R_W_REG_ID,


