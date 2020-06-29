Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE29C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1480A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462571;
	bh=6/4kCDrwLS0IfenpjfkUnT/YELglo3dU/0ir4CvFD50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyOaAy4Tp4yHxifgpTzXCMbz2DqbJvAWspdSEQ1wTYWE6Ta24GKJVijLsqOEVPE2W
	 Spwiju9rPpK8nl82iYstt5mVX9ICvqrcS1mrZalYiL5f37p2pV2wsrPU0zQzlKayIh
	 BsYv+lNchRQuD9/6yK6FRjIgYaFBKMMR0tB+Ttlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgF2U33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731875AbgF2TZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE9925423;
        Mon, 29 Jun 2020 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445373;
        bh=6/4kCDrwLS0IfenpjfkUnT/YELglo3dU/0ir4CvFD50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Y0GPCSe+UM0DPLy4acOd4r1c3wiZwiN98nT0ey/Yg20xa1L8UXEAwn7uVcKMemQB
         WOQlJwYNpnUwL8yec/srzEeFk4AV2FygDQAD5B16u6zx99ZkOR0DYT9swih0bDn19R
         E6FWzBLV73jqP1+xtAPMUYYjFqSbHjf+FTZbRfdQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 128/191] scsi: scsi_devinfo: handle non-terminated strings
Date:   Mon, 29 Jun 2020 11:39:04 -0400
Message-Id: <20200629154007.2495120-129-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

commit ba69ead9e9e9bb3cec5faf03526c36764ac8942a upstream.

devinfo->vendor and devinfo->model aren't necessarily
zero-terminated.

Fixes: b8018b973c7c "scsi_devinfo: fixup string compare"
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_devinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index d596b76eea641..aad9195b356a8 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -451,7 +451,8 @@ static struct scsi_dev_info_list *scsi_dev_info_list_find(const char *vendor,
 			/*
 			 * vendor strings must be an exact match
 			 */
-			if (vmax != strlen(devinfo->vendor) ||
+			if (vmax != strnlen(devinfo->vendor,
+					    sizeof(devinfo->vendor)) ||
 			    memcmp(devinfo->vendor, vskip, vmax))
 				continue;
 
@@ -459,7 +460,7 @@ static struct scsi_dev_info_list *scsi_dev_info_list_find(const char *vendor,
 			 * @model specifies the full string, and
 			 * must be larger or equal to devinfo->model
 			 */
-			mlen = strlen(devinfo->model);
+			mlen = strnlen(devinfo->model, sizeof(devinfo->model));
 			if (mmax < mlen || memcmp(devinfo->model, mskip, mlen))
 				continue;
 			return devinfo;
-- 
2.25.1

