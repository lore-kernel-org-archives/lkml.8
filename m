Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52DDC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703A52070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mpdesouza.com header.i=@mpdesouza.com header.b="RfIyznYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgBKQOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:14:45 -0500
Received: from gateway23.websitewelcome.com ([192.185.47.80]:23995 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbgBKQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:14:45 -0500
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 11:14:44 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 9B31DED33
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:24:58 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 1XPGjTITeRP4z1XPGjvCTQ; Tue, 11 Feb 2020 09:24:58 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hm/23NW+SCo6nlE9b57ji0EYuqf5cV9tPkdyZTDdTQ8=; b=RfIyznYBariRuSfgxU4Tdx787H
        vM29DFGT+UBMC1lYUWWzG/2T+qhEPz8mu8sg4bbA1WCbn6+c6yIJjByz5rtNg2AkwaBcATwOY6Inm
        /8jkjJktneFBKgwqL6n+SS6HoU4zvVj1rkiT7U5s7MNWv+/+tmh5LKYdcPGs4O/fXW2m/zIJFutU6
        M/00Mk0nND/H4j+tWH6WFuRHzdLo+kakzwsYgRkp3Xh1/ZEbBn38HSqKpMtOEHzoRV1wL/pWbYRvO
        29yUGa6ESVLJ0LDgxihW2gKQLAR7XSTd9ELbEzmmgWIVVQRLSdAT56rNpY35/zOJRvpzZH0iCZMtd
        PwavwcaQ==;
Received: from [189.114.219.35] (port=33352 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j1Vj7-000xng-1U; Tue, 11 Feb 2020 10:37:21 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Subject: [PATCH] btrfs: ioctl: resize: Only how new size if size changed
Date:   Tue, 11 Feb 2020 10:39:57 -0300
Message-Id: <20200211133957.14399-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.114.219.35
X-Source-L: No
X-Exim-ID: 1j1Vj7-000xng-1U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [189.114.219.35]:33352
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 0
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to inform the user about "new size" if didn't changed
at all.

Signed-off-by: Marcos Paulo de Souza <marcos@mpdesouza.com>
---
 fs/btrfs/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be5350582955..fa31a8021d24 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1712,9 +1712,6 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 
 	new_size = round_down(new_size, fs_info->sectorsize);
 
-	btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
-			  rcu_str_deref(device->name), new_size);
-
 	if (new_size > old_size) {
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
@@ -1727,6 +1724,9 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = btrfs_shrink_device(device, new_size);
 	} /* equal, nothing need to do */
 
+	if (ret == 0 && new_size != old_size)
+		btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
+			  rcu_str_deref(device->name), new_size);
 out_free:
 	kfree(vol_args);
 out:
-- 
2.24.0

