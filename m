Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC38206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457825;
	bh=AxbPEgbjbhu00BZrYyKzXqeSbXTSV9k7xXKS6HpVfi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2VpLXEfzu9jQZ4zL4khtVC/mXYXhZuIjG47kqbg6tTLFswG9+1G0r62IQbBYgRsb9
	 PyrVNk67755Fx5orZzH8+FcD2JjfF37fpTzxRVU7tW6727aOpwhk1bN+f0sJ/9N6vZ
	 UNie7yka93QhBrKwE8EPduvP3+OK8bKKkF3UuEa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgF2TKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgF2TKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19B0254B7;
        Mon, 29 Jun 2020 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446010;
        bh=AxbPEgbjbhu00BZrYyKzXqeSbXTSV9k7xXKS6HpVfi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhwLgnytBj132lFINGRIcqQlhoZcUwL4ZlDgOh0gGEX9ZAjMqTvaeojcPRMAYo48x
         vLslJR+iz7rxc1P36tYhrAvXWyGix+BuDgSRGHIT8EgnnRXK4x0jdwHkbO0gWQH9LQ
         bL6LEoOniUVQrQQSvQIlylnfN+FO3D9z+OrHBbPk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Arlott <simon@octiron.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/135] scsi: sr: Fix sr_probe() missing deallocate of device minor
Date:   Mon, 29 Jun 2020 11:51:11 -0400
Message-Id: <20200629155309.2495516-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Arlott <simon@octiron.net>

[ Upstream commit 6555781b3fdec5e94e6914511496144241df7dee ]

If the cdrom fails to be registered then the device minor should be
deallocated.

Link: https://lore.kernel.org/r/072dac4b-8402-4de8-36bd-47e7588969cd@0882a8b5-c6c3-11e9-b005-00805fc181fe
Signed-off-by: Simon Arlott <simon@octiron.net>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 5dc288fecace4..7dd4d9ded2491 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -746,7 +746,7 @@ static int sr_probe(struct device *dev)
 	cd->cdi.disk = disk;
 
 	if (register_cdrom(&cd->cdi))
-		goto fail_put;
+		goto fail_minor;
 
 	/*
 	 * Initialize block layer runtime PM stuffs before the
@@ -764,6 +764,10 @@ static int sr_probe(struct device *dev)
 
 	return 0;
 
+fail_minor:
+	spin_lock(&sr_index_lock);
+	clear_bit(minor, sr_index_bits);
+	spin_unlock(&sr_index_lock);
 fail_put:
 	put_disk(disk);
 fail_free:
-- 
2.25.1

