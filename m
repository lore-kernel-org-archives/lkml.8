Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB716C33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0A324766
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196673;
	bh=2IwF142lJfl9HQGmkHpdxUMrDqxjO0dBTOpvzePVuTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+c50P8+JNOCWBYgXs6DgsPtHl+gkS+ssSparrmFX2aM0ykqSSQI2E0oJzooRPm0D
	 zmuhOwq0IHJtSRGGjsCatcCN8Hrf8gS4S3e4ldmu15qca6ryOVU0DSDhAnO7C65Dwi
	 iMGKKIZfbGKJcOkXAuXGoNJXKZ6K0zea48n7bisw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394189AbgAPRoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394101AbgAPRoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AB02475C;
        Thu, 16 Jan 2020 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196653;
        bh=2IwF142lJfl9HQGmkHpdxUMrDqxjO0dBTOpvzePVuTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tof8k+4kiLMK5ZnZwT+i4uyNS5ZI9s1punaR2vHy2S/yt342W28Ph8Hb2iRCO/sJN
         v6bhmOBIiEScgTGgQGF1CsQ50h5zsxqPhOnI70Hf9qKS2GiaE6+EkviV4muTG+oKVg
         Dqp0bP9nyx8h1sW+myVqlgg0z67W3PjFphzsrqwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 061/174] media: wl128x: Fix an error code in fm_download_firmware()
Date:   Thu, 16 Jan 2020 12:40:58 -0500
Message-Id: <20200116174251.24326-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ef4bb63dc1f7213c08e13f6943c69cd27f69e4a3 ]

We forgot to set "ret" on this error path.

Fixes: e8454ff7b9a4 ("[media] drivers:media:radio: wl128x: FM Driver Common sources")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 51639a3f7abe..0cee10cca0e5 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1278,8 +1278,9 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 
 		switch (action->type) {
 		case ACTION_SEND_COMMAND:	/* Send */
-			if (fmc_send_cmd(fmdev, 0, 0, action->data,
-						action->size, NULL, NULL))
+			ret = fmc_send_cmd(fmdev, 0, 0, action->data,
+					   action->size, NULL, NULL);
+			if (ret)
 				goto rel_fw;
 
 			cmd_cnt++;
-- 
2.20.1

