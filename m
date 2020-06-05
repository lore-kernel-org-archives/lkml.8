Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A55208C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366676;
	bh=kFwCRCraMBRyepMZo+yl/SXXPj0zsoJ7YQUxEPQ2XHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rLO3Bfi/VwFCjmOusRqIHqTeRVVdp8wu8G94xCi1mh2eRYQ3vDTn5w70MmgbHRIf
	 SLnJ6P+gQDTqLLXabJGe0qG+/cZyn12Z5foWE9/TIYINrpobf05mu1u4ctlSE+dI2r
	 x3OmMakQYBa1ZE3JZqdceY6LqLbOQRr4h5hH8HsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFEORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgFEORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F3B208A9;
        Fri,  5 Jun 2020 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366664;
        bh=kFwCRCraMBRyepMZo+yl/SXXPj0zsoJ7YQUxEPQ2XHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3zhwa3uHosfLWDZTumKSC/+I6Sh1oLdzfua1Bd6jmJj14UokIFCHi8OhvTYwjFMD
         kxAJoyHQcrVYKs079Hh2/R6f2667+UKTOP2kFvShyXNrxoEl+DtzEyihOpCXkniKr6
         w/yGQX3SPHmxvICHlljwmUKxZnPwJu4qieliQCP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.6 39/43] mmc: fix compilation of user API
Date:   Fri,  5 Jun 2020 16:15:09 +0200
Message-Id: <20200605140154.569917110@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
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
 	/*


