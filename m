Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A545C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C339B222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN1DJyXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCJVP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:15:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43825 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJVPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:15:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so6763453otb.10;
        Tue, 10 Mar 2020 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hNWBofucArT17MnCRXZQMQQdTzbenzVIK3M8zSgFrs=;
        b=dN1DJyXu9qxAGT5sUE6ZtOnH6zUyhErKldhJDm/7WbWLTndvrlMjzXlxKt0BofnnWE
         gH1NiZ39GxjP1zKwRIUjTFC78v6faijm/bXy1SykgDIiA9HQsxDhPDqfO0MbUk3w52cK
         NAPx3NUnmyHQqMvrs7UO60oNGKIM7di5I/ovX860fDPPgCrG+QntBATS4ZeoB5joKLJx
         VHIoh5WWDwrL+7hQIz6IlCuKhtLvjR66DH1AWCSMwwHVYrWSSThc/iQgU8Zsx5872Ouu
         FePQ3k15JNhQTQGFroMnrQZ/39pHC+lZr07mZXoOxcdm/2FlRaK/bwLZxC1FMUEW+aky
         47Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hNWBofucArT17MnCRXZQMQQdTzbenzVIK3M8zSgFrs=;
        b=iVg5n/hZ38osZbfrduoBelIC9KpV6DxUPws6lWComOSpUEonD64E60PVlSwdG6E1yE
         3gs8/jKgv7RuP+r0BYIQB4YAZewwNoIROF06SEwMszJZ8uE2jyBfTT+yqhMgy8rW0gHA
         69Z01+OTpMSdhPGlzA70dklUCgzTo7rh1sL7mN9fP6smNgkwyG1ecV4OKf/OcvKypDBf
         t3fQnm2fw1IghH1K5CRIyf373GI8iP70ERD5UUrjb+JCqS3+yiXReqV5wU1o7FBWVFZy
         HqRtkuILhS1kRekqyu5NjQiEKQUdgqN+32wOFhRrZbh88Mh8FAG2z7b/vG+fgybMuDqu
         mZmw==
X-Gm-Message-State: ANhLgQ21mnpoUdV8UTijW/iz7XdV/Wkt13F5SxITl7PrNybWaQpdEkRK
        lQ4rcWehQfUxKR2ysixMwyw=
X-Google-Smtp-Source: ADFU+vvjtpN/bwJQkI2vcndXaZbxD8dD0mCBVB9RhSu8g5NE5E5B4HBs9qwmz9bvppBuPjIrS4onDw==
X-Received: by 2002:a9d:6348:: with SMTP id y8mr687408otk.347.1583874924146;
        Tue, 10 Mar 2020 14:15:24 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j90sm205345otc.21.2020.03.10.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:15:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] remoteproc/mediatek: Use size_t type for len in scp_da_to_va
Date:   Tue, 10 Mar 2020 14:15:14 -0700
Message-Id: <20200310211514.32288-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang errors:

drivers/remoteproc/mtk_scp.c:364:14: error: incompatible function
pointer types initializing 'void *(*)(struct rproc *, u64, size_t)' (aka
'void *(*)(struct rproc *, unsigned long long, unsigned int)') with an
expression of type 'void *(struct rproc *, u64, int)' (aka 'void
*(struct rproc *, unsigned long long, int)')
[-Werror,-Wincompatible-function-pointer-types]
        .da_to_va       = scp_da_to_va,
                          ^~~~~~~~~~~~
1 error generated.

Make the same change as commit 0fcbb369f052 ("remoteproc: Use size_t
type for len in da_to_va"), which was not updated for the acceptance of
commit 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183").

Fixes: 0fcbb369f052 ("remoteproc: Use size_t type for len in da_to_va")
Link: https://github.com/ClangBuiltLinux/linux/issues/927
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/remoteproc/mtk_scp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 7ccdf64ff3ea..ea3743e7e794 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -320,7 +320,7 @@ static int scp_start(struct rproc *rproc)
 	return ret;
 }
 
-static void *scp_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len)
 {
 	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
 	int offset;
-- 
2.26.0.rc1

