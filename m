Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3AEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41A22067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726978;
	bh=HYg/oK6dZ3KBNE/5RfEG/bWIhWx8JyDZPz/txNutwuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOSd9XuR/2pxMdEZetUmchTmq/xmIKTuwHct7byNix2+A40c0vh6mNL4HdmCgPsej
	 VPCKoDSm4gsFP2SKLB/IpgUE6ofO5CNiAGbOHwzYRfkAs6TCzb2/2jW97eFbSFkUNE
	 WrF2epzpLfMqYt98iknf2TVuv/fnfA274Hlvvrjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbgFISW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732184AbgFIRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB786207ED;
        Tue,  9 Jun 2020 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724874;
        bh=HYg/oK6dZ3KBNE/5RfEG/bWIhWx8JyDZPz/txNutwuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNjCMRQgYVcSra34dQZNwXi9vB7ni5dUiAHPb8eJ2wYmfn5HX4Bj8JyRdGZxXGz9Q
         5YjN7zgpkkUHFzhn1aK7ryL0Fgdy2xqqLdSKyKHjDFlyUZTADmSd+3/8UpNN7kJz/C
         8TiTgziv3sEUfM/UPVuLivB/3HBZx715daAJFZ34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 17/42] mmc: fix compilation of user API
Date:   Tue,  9 Jun 2020 19:44:23 +0200
Message-Id: <20200609174017.345870933@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
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
@@ -2,6 +2,7 @@
 #define LINUX_MMC_IOCTL_H
 
 #include <linux/types.h>
+#include <linux/major.h>
 
 struct mmc_ioc_cmd {
 	/* Implies direction of data.  true = write, false = read */


