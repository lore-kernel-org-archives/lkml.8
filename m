Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64865C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA68206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624029;
	bh=tyQhYD7L0c6Qy7Pp19sm+Wi3FjaWbpivNpHwnNv5eh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oygUEH7GLVxc3i0Dce9nTE9IKDe0INZ95a18MgqKWjzqwiEUwJTdOxl/cBlDh6XZ+
	 5wQx7ceBddSqoVp5Rm90GIJ1F9qTp8F5CPt74WabHjOJPeYh4j+z1cl6SHCkNEIwP6
	 9+1y0Wo2FILRPHSO9VmkKAHVk+d87NQowbmdECus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgCSNU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbgCSNUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:20:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB00206D7;
        Thu, 19 Mar 2020 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624025;
        bh=tyQhYD7L0c6Qy7Pp19sm+Wi3FjaWbpivNpHwnNv5eh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VI2G2q0c+ABjSHGyo0OvUXgV4BWblcVTqG5FvOiqzeAWi85v6IxMxZ0iELImQHHIH
         CWgCPP3Q81igqWAtJ7Fc5HeXnOalllT9Qof3zopUPXyTvtMOptLURtWXtQG83RkPr1
         ng0ZGEhyZAe6gezKZJpCZXPdMkKK0g7hUjUb7EM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/48] mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
Date:   Thu, 19 Mar 2020 14:03:49 +0100
Message-Id: <20200319123905.533106814@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 18d200460cd73636d4f20674085c39e32b4e0097 ]

The busy timeout for the CMD5 to put the eMMC into sleep state, is specific
to the card. Potentially the timeout may exceed the host->max_busy_timeout.
If that becomes the case, mmc_sleep() converts from using an R1B response
to an R1 response, as to prevent the host from doing HW busy detection.

However, it has turned out that some hosts requires an R1B response no
matter what, so let's respect that via checking MMC_CAP_NEED_RSP_BUSY. Note
that, if the R1B gets enforced, the host becomes fully responsible of
managing the needed busy timeout, in one way or the other.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200311092036.16084-1-ulf.hansson@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f1fe446eee666..5ca53e225382d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1901,9 +1901,12 @@ static int mmc_sleep(struct mmc_host *host)
 	 * If the max_busy_timeout of the host is specified, validate it against
 	 * the sleep cmd timeout. A failure means we need to prevent the host
 	 * from doing hw busy detection, which is done by converting to a R1
-	 * response instead of a R1B.
+	 * response instead of a R1B. Note, some hosts requires R1B, which also
+	 * means they are on their own when it comes to deal with the busy
+	 * timeout.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
+	    (timeout_ms > host->max_busy_timeout)) {
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
 		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-- 
2.20.1



