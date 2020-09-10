Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6A20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599760416;
	bh=jHH/wPFyXijfn4qbxAJDIqeZ9sIT7sZEqBqRbDpc3/A=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rb5wM3miZ4sFlyITLzgZYIRZS5o+BR5NxJ6YKb7877a20ew5HOTY7idtmD28pROs6
	 +qxsTmgR7EORB6BnWkg3WDoXlhD3O0cR1d8s7bTkS+fVUxa/2rPT3Bm4W2uy9fSC+T
	 Y0WK9VJYMfa3WmQB1KI9DHHw5M6Y/mxkr8eUdHMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgIJRxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIJQPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:15:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B991A21D79;
        Thu, 10 Sep 2020 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754370;
        bh=jHH/wPFyXijfn4qbxAJDIqeZ9sIT7sZEqBqRbDpc3/A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qk1/iZx66lsXxLsmC2V4WzgjUe+CyIlaK9/HXYcgdgQ/TbuzMlIM73Ba66GLi5CTy
         9Ggn5FVeGNBHmi1mMqhxN0bJiIfBLFllDWQHgfSk/caOcqo8cZ/HftJE/uhlSjGR7y
         fg9WOHc2MIk/LadzvUOQf66mFYQiXkSIcQ6vqqMY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-nfc@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 6/8] nfc: s3fwrn5: Constify s3fwrn5_fw_info when not modified
Date:   Thu, 10 Sep 2020 18:12:17 +0200
Message-Id: <20200910161219.6237-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910161219.6237-1-krzk@kernel.org>
References: <20200910161219.6237-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two functions accept pointer to struct s3fwrn5_fw_info but do not
modify the contents.  Make them const so the code is a little bit safer.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nfc/s3fwrn5/firmware.c | 4 ++--
 drivers/nfc/s3fwrn5/firmware.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 69857f080704..ec930ee2c847 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -348,7 +348,7 @@ static int s3fwrn5_fw_get_base_addr(
 }
 
 static inline bool
-s3fwrn5_fw_is_custom(struct s3fwrn5_fw_cmd_get_bootinfo_rsp *bootinfo)
+s3fwrn5_fw_is_custom(const struct s3fwrn5_fw_cmd_get_bootinfo_rsp *bootinfo)
 {
 	return !!bootinfo->hw_version[2];
 }
@@ -399,7 +399,7 @@ int s3fwrn5_fw_setup(struct s3fwrn5_fw_info *fw_info)
 	return ret;
 }
 
-bool s3fwrn5_fw_check_version(struct s3fwrn5_fw_info *fw_info, u32 version)
+bool s3fwrn5_fw_check_version(const struct s3fwrn5_fw_info *fw_info, u32 version)
 {
 	struct s3fwrn5_fw_version *new = (void *) &fw_info->fw.version;
 	struct s3fwrn5_fw_version *old = (void *) &version;
diff --git a/drivers/nfc/s3fwrn5/firmware.h b/drivers/nfc/s3fwrn5/firmware.h
index cf1a83a5a525..3c83e6730d30 100644
--- a/drivers/nfc/s3fwrn5/firmware.h
+++ b/drivers/nfc/s3fwrn5/firmware.h
@@ -91,7 +91,7 @@ struct s3fwrn5_fw_info {
 
 void s3fwrn5_fw_init(struct s3fwrn5_fw_info *fw_info, const char *fw_name);
 int s3fwrn5_fw_setup(struct s3fwrn5_fw_info *fw_info);
-bool s3fwrn5_fw_check_version(struct s3fwrn5_fw_info *fw_info, u32 version);
+bool s3fwrn5_fw_check_version(const struct s3fwrn5_fw_info *fw_info, u32 version);
 int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info);
 void s3fwrn5_fw_cleanup(struct s3fwrn5_fw_info *fw_info);
 
-- 
2.17.1

