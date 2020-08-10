Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B67C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F19922CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073264;
	bh=ZTr/YgqpNPq1cmvv/g6haa7XXEQeVX52CPB5oRr7ugc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zwaEU99cYOHK3mBGSZSoRA+eSvzIYF0PLbhrZ9pYj0Xi9ZJSliagbORias12CjHQ1
	 sr/hMxrACn3otJGrGOoGxkMnih0mrAzu7uhOgLdIQZc65gLnU9g/IAkgYaG1d3V5/C
	 H0LsaEyAOouAe+zZRYMY/qYyidWM15Sc2u85Vzww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgHJP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgHJP1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC5D22BF3;
        Mon, 10 Aug 2020 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073258;
        bh=ZTr/YgqpNPq1cmvv/g6haa7XXEQeVX52CPB5oRr7ugc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UZ+AoDu2Pv1cga8ewl0Hszav8gHzT8+anGrmuQtBN55rsmnqWmnnXVGOFff3EjHD
         Ck1CQnumK0+/P81kuhDyBM0b1WqiTryvjAYhabrOtx+rMy8V0KIWkZCk1abw1nGW3w
         nGHG5YIxNW32iv+xDBthY7gKWrmeR4OKgqj+BLeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 41/67] firmware: Fix a reference count leak.
Date:   Mon, 10 Aug 2020 17:21:28 +0200
Message-Id: <20200810151811.463429784@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit fe3c60684377d5ad9b0569b87ed3e26e12c8173b ]

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Callback function fw_cfg_sysfs_release_entry() in kobject_put()
can handle the pointer "entry" properly.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200613190533.15712-1-wu000273@umn.edu
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/qemu_fw_cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 039e0f91dba8f..6945c3c966375 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -605,8 +605,10 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
 				   fw_cfg_sel_ko, "%d", entry->select);
-	if (err)
-		goto err_register;
+	if (err) {
+		kobject_put(&entry->kobj);
+		return err;
+	}
 
 	/* add raw binary content access */
 	err = sysfs_create_bin_file(&entry->kobj, &fw_cfg_sysfs_attr_raw);
@@ -622,7 +624,6 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 
 err_add_raw:
 	kobject_del(&entry->kobj);
-err_register:
 	kfree(entry);
 	return err;
 }
-- 
2.25.1



