Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B91207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6gYU3BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHVE3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgHVE2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a79so2054563pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqBr/lnoyyjrVPbppt18J/CaYj+H3LTptFWomD24EK8=;
        b=k6gYU3BQoMFCaQD+AlH0UdJa7EouME7f09Wr67RQ0UgSnQtksUl9M/XY9lpiDXJEDE
         eqsBxJ21y3hKfagcR87kOSVqxwdBQ6XMKzHOzWNykOAhqOlwThPzkYmJWKfC0xP0o2p7
         r3NbPu7gJKcMUICczwCpP02cNZxiMgTSg/TC5RK3W4eaALSDJi0Zwo3xeIvjxJDnL2lp
         PHada2DmX90mA9176PXGI//LblawMwTjFkvN/t5kWwrBHZ4ZZtQDX6caj/1/3B5dJnpB
         wZf7vueze3b+pmTZbvhWexQxEBZSO6C44UZSgMGZETqAVZ8YKNkd4hNY8J/ogHLEqJ5i
         G5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqBr/lnoyyjrVPbppt18J/CaYj+H3LTptFWomD24EK8=;
        b=ZFeIZz2kwoCdufS1ytwVQwVjj9US93wuGbczRHq+EP7WcMrNmUQC/SJtJ2f8dTAt8K
         fKfik7Z/p83QeKG/q5xK1Rc/ovdDE7QsVEJLwVBclIa2z6i17Eb76jRLeOdPF6Hho8ep
         72MGIF6Cg8idcreebBTPnN6K7XcssjAUQJYQo0lCTHmmzKrGdQGoSA9F8Tcu7oBtaak9
         4D9kOu4ZwImBpXnGm5DE3e2kdgIX9xSHOMRsTjx2y+hjHa3v23Mb0GLwyj8+CI9U1ncy
         gQdK0g2qBYPLiO8S7N8SnmA9Yfwst2MslqvO5zS48OgSC6aZv075W+MGLyYmmbYpGAD5
         MSHw==
X-Gm-Message-State: AOAM532+OMERL9Mi9A4VGr/WCSdwSwJDIODUtfPkdeZfpggCL4+BAcrx
        UtJeMiOp4d5rtvgZLWmZOao=
X-Google-Smtp-Source: ABdhPJw+Y9gmCJ//53qiUrfo5XJC0rxQJ+ex61YOdl0PD+gHIbZUDNi4Sx226cKTe4jeWjVgPh0TRg==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr4896468pfp.57.1598070513961;
        Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 8/9] iommu/vt-d: Send IOASID bind/unbind notifications
Date:   Fri, 21 Aug 2020 21:35:17 -0700
Message-Id: <1598070918-21321-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Scalable I/O Virtualization (SIOV) enabled platforms with
ENQCMD in use by the guest, KVM must establish a guest-host PASID
translation table prior to the issuing of ENQCMD. PASID translation
table also depends on the IOMMU PASID entry, which is configured during
the guest page table bind time. This patch adds a notification event to
the IOMMU driver such that KVM can be notified when a new guest-host
PASID mapping is established or demolished.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 600e3ae5b656..d8a5efa75095 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -471,6 +471,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	}
 
 	mutex_unlock(&pasid_mutex);
+	/*
+	 * Notify KVM new host-guest PASID bind is ready. KVM will set up
+	 * PASID translation table to support guest ENQCMD.
+	 */
+	ioasid_notify(data->hpasid, IOASID_BIND, IOASID_NOTIFY_SET);
 	return ret;
 }
 
@@ -510,6 +515,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * and perform cleanup.
 				 */
 				ioasid_attach_data(pasid, NULL);
+				ioasid_notify(pasid, IOASID_UNBIND,
+					IOASID_NOTIFY_SET);
 				kfree(svm);
 			}
 		}
-- 
2.7.4

