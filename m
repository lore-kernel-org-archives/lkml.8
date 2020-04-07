Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE15C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E542074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255265;
	bh=TorpH4uEST+U3yxKOkCZL/m53n9xz2lDBNqCEdKUsyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qz7V5EDp88qQOaQIzA+uOjRI0FGDZnwjjLmxa3oCnkZbu6n4GLVo1o0LRpJ92YkUW
	 1O/eqhpZ0LSTXEtD8i8vqAoi6lTr4HqxCQOK6aBB2WogsIOIa7YDWE3iE0kOnL2sKC
	 vQVIEdCAMJN4A8jHy1nqlMhHPGOh4/aRaWqS8a3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgDGK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgDGK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B79F2074F;
        Tue,  7 Apr 2020 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255197;
        bh=TorpH4uEST+U3yxKOkCZL/m53n9xz2lDBNqCEdKUsyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jiPTpMzHDbG7C2TyPedRaBPxNc+MC9WjyHr1Q8mb3UC/FTp48MaFHFeG55FobEV9
         PnmLpGdHZZKbIhA95b27iOCm5eHQXo+j1873zCvB7hTiLntcgvyVtH/NCZeieD7lta
         PSxLkwjWRyoQhbpshT46QFA/UY/v0F7J9xbMOq/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.6 22/29] nvmem: check for NULL reg_read and reg_write before dereferencing
Date:   Tue,  7 Apr 2020 12:22:19 +0200
Message-Id: <20200407101454.761010846@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

commit 3c91ef69a3e94f78546b246225ed573fbf1735b4 upstream.

Return -EPERM if reg_read is NULL in bin_attr_nvmem_read() or if
reg_write is NULL in bin_attr_nvmem_write().

This prevents NULL dereferences such as the one described in
03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem file is
read")

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200310132257.23358-10-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvmem/nvmem-sysfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -56,6 +56,9 @@ static ssize_t bin_attr_nvmem_read(struc
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_read)
+		return -EPERM;
+
 	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
 
 	if (rc)
@@ -90,6 +93,9 @@ static ssize_t bin_attr_nvmem_write(stru
 
 	count = round_down(count, nvmem->word_size);
 
+	if (!nvmem->reg_write)
+		return -EPERM;
+
 	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
 
 	if (rc)


