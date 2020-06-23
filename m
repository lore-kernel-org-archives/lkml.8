Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9DEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF852089D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948633;
	bh=8Mg5iclHO//7TZ7v/uSPnMsXEqV+zo87RlczKHrocKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ok8zxxHttJdrkGhRWIX4dYLGaii5JaM/pRIdRjv2f/4MPt7Vx8MIpyTHE5KmcqUaq
	 BM9+ENqlXEApmOnEeUnzW3IOR96tUD5Og6Nt+8r6Hk2KCjd9eDvBpjiBdMX6GHvn/M
	 YhvudIz8SfdXKSvk7k6VBQZ8wHjHB5kTpnLSg/tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392459AbgFWVnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbgFWUDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:03:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28A92078A;
        Tue, 23 Jun 2020 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942594;
        bh=8Mg5iclHO//7TZ7v/uSPnMsXEqV+zo87RlczKHrocKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0gAU0ZEcycmqpjVfFI6uENGrz/goBXzVa8mo3HiYGHAuhgsFpkElPW054sUA8Dhp
         u8ZzxusF8TVuhSFikhJ2Phcpu1zFnSz3OY75UI5ez2zLhD387I5xSKSF5lobMkUK08
         11xspoLNFcNQC26aRREoP+uH98n8rN/f/aH7lTWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 059/477] vfio/pci: fix memory leaks in alloc_perm_bits()
Date:   Tue, 23 Jun 2020 21:50:56 +0200
Message-Id: <20200623195410.404107128@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit 3e63b94b6274324ff2e7d8615df31586de827c4e ]

vfio_pci_disable() calls vfio_config_free() but forgets to call
free_perm_bits() resulting in memory leaks,

unreferenced object 0xc000000c4db2dee0 (size 16):
  comm "qemu-kvm", pid 4305, jiffies 4295020272 (age 3463.780s)
  hex dump (first 16 bytes):
    00 00 ff 00 ff ff ff ff ff ff ff ff ff ff 00 00  ................
  backtrace:
    [<00000000a6a4552d>] alloc_perm_bits+0x58/0xe0 [vfio_pci]
    [<00000000ac990549>] vfio_config_init+0xdf0/0x11b0 [vfio_pci]
    init_pci_cap_msi_perm at drivers/vfio/pci/vfio_pci_config.c:1125
    (inlined by) vfio_msi_cap_len at drivers/vfio/pci/vfio_pci_config.c:1180
    (inlined by) vfio_cap_len at drivers/vfio/pci/vfio_pci_config.c:1241
    (inlined by) vfio_cap_init at drivers/vfio/pci/vfio_pci_config.c:1468
    (inlined by) vfio_config_init at drivers/vfio/pci/vfio_pci_config.c:1707
    [<000000006db873a1>] vfio_pci_open+0x234/0x700 [vfio_pci]
    [<00000000630e1906>] vfio_group_fops_unl_ioctl+0x8e0/0xb84 [vfio]
    [<000000009e34c54f>] ksys_ioctl+0xd8/0x130
    [<000000006577923d>] sys_ioctl+0x28/0x40
    [<000000006d7b1cf2>] system_call_exception+0x114/0x1e0
    [<0000000008ea7dd5>] system_call_common+0xf0/0x278
unreferenced object 0xc000000c4db2e330 (size 16):
  comm "qemu-kvm", pid 4305, jiffies 4295020272 (age 3463.780s)
  hex dump (first 16 bytes):
    00 ff ff 00 ff ff ff ff ff ff ff ff ff ff 00 00  ................
  backtrace:
    [<000000004c71914f>] alloc_perm_bits+0x44/0xe0 [vfio_pci]
    [<00000000ac990549>] vfio_config_init+0xdf0/0x11b0 [vfio_pci]
    [<000000006db873a1>] vfio_pci_open+0x234/0x700 [vfio_pci]
    [<00000000630e1906>] vfio_group_fops_unl_ioctl+0x8e0/0xb84 [vfio]
    [<000000009e34c54f>] ksys_ioctl+0xd8/0x130
    [<000000006577923d>] sys_ioctl+0x28/0x40
    [<000000006d7b1cf2>] system_call_exception+0x114/0x1e0
    [<0000000008ea7dd5>] system_call_common+0xf0/0x278

Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Signed-off-by: Qian Cai <cai@lca.pw>
[aw: rolled in follow-up patch]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 90c0b80f8acf9..43b95f9cdaf7b 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1728,8 +1728,11 @@ void vfio_config_free(struct vfio_pci_device *vdev)
 	vdev->vconfig = NULL;
 	kfree(vdev->pci_config_map);
 	vdev->pci_config_map = NULL;
-	kfree(vdev->msi_perm);
-	vdev->msi_perm = NULL;
+	if (vdev->msi_perm) {
+		free_perm_bits(vdev->msi_perm);
+		kfree(vdev->msi_perm);
+		vdev->msi_perm = NULL;
+	}
 }
 
 /*
-- 
2.25.1



