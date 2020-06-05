Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C2BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFB620663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366855;
	bh=0Sdw19cZUj8gXdGRxHjvIBv37iyXz0YRfj4NGJbcFrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EazaktgM/Ce7kqhaBCHLS1IVjnG708sJUxADITv4dBReptvxN8WLw33ao2wXFigJt
	 6gtnhc837hH9H0gi4LYpe3v3CNWAAvkG2wuxcP1YSVlDq0muCE8VXxNA+J1CCIVxKS
	 ulTBvjLubYVcLVDkFa5vtJ7HZDQuH8EYP8YpksrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgFEOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbgFEOU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:20:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295912074B;
        Fri,  5 Jun 2020 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366826;
        bh=0Sdw19cZUj8gXdGRxHjvIBv37iyXz0YRfj4NGJbcFrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPOshHwGmSNKAS5YBXgaRnsH4OU0Vm4dPQEk00KZrxLzhGu7bcTbA64Mh1sE0Xcov
         Q3E09yfyTzb9N/l3Q0JBXMGZKvljSpPGW7R/CJP9hB9Y86UAkWwcpcDe0SHDng8pIY
         1SNnR3l91r4sPCn+hx2RDSvdmxKk+n/YsjKkTGtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 08/28] mmc: fix compilation of user API
Date:   Fri,  5 Jun 2020 16:15:10 +0200
Message-Id: <20200605140252.829389737@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.338635395@linuxfoundation.org>
References: <20200605140252.338635395@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

commit 83fc5dd57f86c3ec7d6d22565a6ff6c948853b64 upstream.

The definitions of MMC_IOC_CMD  and of MMC_IOC_MULTI_CMD rely on
MMC_BLOCK_MAJOR:

    #define MMC_IOC_CMD       _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
    #define MMC_IOC_MULTI_CMD _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_multi_cmd)

However, MMC_BLOCK_MAJOR is defined in linux/major.h and
linux/mmc/ioctl.h did not include it.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200511161902.191405-1-Jerome.Pouiller@silabs.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/mmc/ioctl.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -3,6 +3,7 @@
 #define LINUX_MMC_IOCTL_H
 
 #include <linux/types.h>
+#include <linux/major.h>
 
 struct mmc_ioc_cmd {
 	/* Implies direction of data.  true = write, false = read */


