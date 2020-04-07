Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27652C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BDE2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255173;
	bh=TorpH4uEST+U3yxKOkCZL/m53n9xz2lDBNqCEdKUsyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdtluH80s9Ocs7VHJL4TniBOWt4YtPLeQesUHarvJJ7AquN+xsjykD6BxrSQVaY/8
	 JCtTLEFxu/7omUWN8vUsyb9jL8MRkCs1jXWylSUELX3iK6pm3jw9Qu0Q094w00bAaQ
	 hS5khNUcPOiCHDRtn6+Ag6kA2c2w6Q5V00nCfv+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgDGK0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgDGK0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A49F2082D;
        Tue,  7 Apr 2020 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255161;
        bh=TorpH4uEST+U3yxKOkCZL/m53n9xz2lDBNqCEdKUsyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prSI+ab112bbw4dTnIPAXRWID7LqEeq8w1y44QgJnsxtTUqVm2GBxYxxE30p+3Lch
         FJ2FXftIukuLnP9wy11gHya54ztFJ4H/lIk9OAxoOiU4rpIEwrgWeiKnz/T9m6f+61
         qOvhx2mLemAdYAAabFdx7QAiDbVYyhj7I9DP7l2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.5 27/46] nvmem: check for NULL reg_read and reg_write before dereferencing
Date:   Tue,  7 Apr 2020 12:21:58 +0200
Message-Id: <20200407101502.416106818@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
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


