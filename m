Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479762072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bCOGh4IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgEVBSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgEVBSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:18:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6FC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:18:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m44so7136602qtm.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Puv1BV91r6SjZkjuOU7H5cmGIu56s9jB/MY9elYkgSk=;
        b=bCOGh4IBnzxtvHN6uHYYXFvOkvGLA05aypKg9VveLlImf/EjhsiWQEZqEaDxx0hFBw
         oS/O9Js/qJmDaoEi1Vf9HnVAjgflpNI5PzXwdpd0f6UqWPphMZ8DSMUZPdUd0fnSf90a
         G6H4rG0ew2DZu7LNTTIOriEl4v0aZi3QI5AXLz2PZxxszXiGSBiS4g+L56Yr0QIrKuLw
         ezr/H1TDBLZi3n/LG/7H206p26KCSI3+wsjmT5k/IRnUlDysOU1c57Hxfe/Cbyzp/jd7
         5t8GNCOgNNYyprLix4KNSCg3rmb8EzxhGaqXe6iqofMcf/RxC6yGeoL1L4pqHcthN8+k
         i3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Puv1BV91r6SjZkjuOU7H5cmGIu56s9jB/MY9elYkgSk=;
        b=NrShtHJU6q7eWUtDNJWusVb7TzVchkHXalJiZ6RdBTTvTP53xb/7FsEuIuODBJsmpH
         3uFaP+gnsdnKGIWfWx3F978Iv/ifiTA8jYCWHxtEfPx9m3uRtNWFqn4faymAx9/RjtiG
         NwO6oCm0bIrCbjmpYTZo4sym/ccq8yw60/xmm02w3lqQu2a4SKMQQg11w9YoXkFeTOg2
         61x3ukRoADKYGz5TptWu2kSCZx4VHzOPWVOnSZEYP3tG7L/g6XIaD0yo7qt6Axxc2Pb9
         CScXjy7Efuq00boyA8vuCbSuyPCKB7mm0KM5vtBxlAn+aZiguuHPq10avq3H0fbF7sZa
         J+nQ==
X-Gm-Message-State: AOAM533mxfMTMJ3SaIUQzfK4+gevzXC7RUjvHvbg34fFGbjcSlGcQ4gW
        oSai5bDd3JZOGv5RS1EQ4YCAAg==
X-Google-Smtp-Source: ABdhPJwMoUeBYjRzyp9R0VCrKxKw3AszW5mQi04RCM1s4y0bzosHq3N+Y/7dGmnHCVVDXVF3pf9Tqw==
X-Received: by 2002:ac8:b48:: with SMTP id m8mr13649501qti.206.1590110319843;
        Thu, 21 May 2020 18:18:39 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f43sm60212qte.58.2020.05.21.18.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 18:18:39 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     alex.williamson@redhat.com
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] vfio/pci: fix a null-ptr-deref in vfio_config_free()
Date:   Thu, 21 May 2020 21:18:29 -0400
Message-Id: <20200522011829.17301-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible vfio_config_init() does not call vfio_cap_len(), and then
vdev->msi_perm == NULL. Later, in vfio_config_free(), it could trigger a
null-ptr-deref.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 RIP: 0010:vfio_config_free+0x7a/0xe0 [vfio_pci]
 vfio_config_free+0x7a/0xe0:
 free_perm_bits at drivers/vfio/pci/vfio_pci_config.c:340
 (inlined by) vfio_config_free at drivers/vfio/pci/vfio_pci_config.c:1760
 Call Trace:
  vfio_pci_release+0x3a4/0x9e0 [vfio_pci]
  vfio_device_fops_release+0x50/0x80 [vfio]
  __fput+0x200/0x460
  ____fput+0xe/0x10
  task_work_run+0x127/0x1b0
  do_exit+0x782/0x10d0
  do_group_exit+0xc7/0x1c0
  __x64_sys_exit_group+0x2c/0x30
  do_syscall_64+0x64/0x350
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: bea890bdb161 ("vfio/pci: fix memory leaks in alloc_perm_bits()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/vfio/pci/vfio_pci_config.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index d127a0c50940..8746c943247a 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1757,9 +1757,11 @@ void vfio_config_free(struct vfio_pci_device *vdev)
 	vdev->vconfig = NULL;
 	kfree(vdev->pci_config_map);
 	vdev->pci_config_map = NULL;
-	free_perm_bits(vdev->msi_perm);
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
2.17.2 (Apple Git-113)

