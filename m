Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90344C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3914D20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="l254W5RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCQPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:03:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34127 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:03:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so32972425qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqOBm7bQCludye1SGv0KdSFELKwpbPDMXnv2Sugq1V4=;
        b=l254W5RQNfFLpxh3XTCQBj64u0gip2PXizITExpY6lAOsWn1MUvIebu1an3ADb11ac
         liTXMm06RwsmMDI7Qxiw9AwtmT5Pq9dzz7YOo1yY/xONZZxMl1/9GUt/YT/Do+pTSGdB
         LbzJPXVYWH5ymK7O98yRz+R6EsdJ99oOZtKTikglOEznI557wq65BJDifgceaq5MjBtM
         MD2ztt6vDgt+RFxsqrUaKeQAXdaibVSfiqFDy2rYCj+/W/jcbmIRuSoa7Bwg0O0V5Q0Q
         gUkz99+eQIieLq631DL+LXAbdAOqEbiyoIYUQDsB+lgYPHYbAecWPCKStQ6zNYLvYJeX
         UiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqOBm7bQCludye1SGv0KdSFELKwpbPDMXnv2Sugq1V4=;
        b=N/tG6mku+W/RR0MgGWvE2S5RIxXRHYSnAbUAperB/jOapNswYzhs0EPTl0EzCD59km
         3ijCJimx+Hc8GKKwQUQdOxJeOSW7etBOB3oeLkgRbXrl6h7A4BiqaGfS8u3aorWc5/K5
         w/AZUvNNr7meHHtrAjO0nEVMsDVV/DNswDzKlYHCetiuDYrZuuLJ5x92P88RyoOeUkCM
         IOt7wOtzDyxbz99xUQiDlMeuKshk9oDFWXHzd33xqXWXYKkVJ6a2L2tb6vaVnZ1ln6xv
         gkluAYP+DRqVBgZj+dh8z5rha5tQG7SAV0gPze+Fuo15rjQGTWL2151ToDWxyFd13F4q
         JoUw==
X-Gm-Message-State: ANhLgQ1DwfonQSlGtfqjT6wvLEvw/SWs61xVATVIfIh1i4yU5cZjomYF
        tsGH/b+osUJSm5uOjCBbLbj/Ey9G5dddVw==
X-Google-Smtp-Source: ADFU+vt5wqdAcnNu9Z6Fsgi+m9R2A9sC6GlSijeQ7cGL3zxioALaVGP0oa2V6N9J1JQpQHnNsM1vEQ==
X-Received: by 2002:a37:5b82:: with SMTP id p124mr5447016qkb.130.1584457415620;
        Tue, 17 Mar 2020 08:03:35 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n74sm2037090qke.125.2020.03.17.08.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:03:34 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
Date:   Tue, 17 Mar 2020 11:03:26 -0400
Message-Id: <20200317150326.1659-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmar_find_atsr() calls list_for_each_entry_rcu() outside of an RCU read
side critical section but with dmar_global_lock held. Silence this
false positive.

 drivers/iommu/intel-iommu.c:4504 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
 #0: ffffffff9755bee8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1a6/0xe19

 Call Trace:
  dump_stack+0xa4/0xfe
  lockdep_rcu_suspicious+0xeb/0xf5
  dmar_find_atsr+0x1ab/0x1c0
  dmar_parse_one_atsr+0x64/0x220
  dmar_walk_remapping_entries+0x130/0x380
  dmar_table_init+0x166/0x243
  intel_iommu_init+0x1ab/0xe19
  pci_iommu_init+0x1a/0x44
  do_one_initcall+0xae/0x4d0
  kernel_init_freeable+0x412/0x4c5
  kernel_init+0x19/0x193

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4be549478691..ef0a5246700e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4501,7 +4501,8 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
 	struct dmar_atsr_unit *atsru;
 	struct acpi_dmar_atsr *tmp;
 
-	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
+	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list,
+				dmar_rcu_check()) {
 		tmp = (struct acpi_dmar_atsr *)atsru->hdr;
 		if (atsr->segment != tmp->segment)
 			continue;
-- 
2.21.0 (Apple Git-122.2)

