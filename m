Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F849C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8DD20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648411;
	bh=zZkjALYNm/iv28baBIJ8a2vHEnhIRNk9OZoPGceCxOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCckBM6Qorn78uLrjlcEWzBsewHgmsbhWcHaH5MCfjE/4Axf2vBHrCrMIGPtcsw7c
	 sMn8oPDshdUjZIHg5+j6EIORZVnGIOtdcfXE7rfx3VWmH4Ed28F3m4M4vCPOG85LHF
	 GQI71W/wng93aZ/q/k+dKGN0mmkFR/IUV/QMGauw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHQHMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgHQHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:23 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9E122BED;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=zZkjALYNm/iv28baBIJ8a2vHEnhIRNk9OZoPGceCxOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R36bka6zgHYhROGUoGIGkzO3ilHbNb7fNpNd+P3BU2JuwinRqRUdspf19bLj4L8mw
         OdaaeA2nXR+LQWM0ge4P0B2it0v7ZQowd7NUyjZPevN9l8sGrmWaNUe/DUcSV4pz24
         syee/rlYvSRLmPUld22hfNXnhe9EJUrt0opcf4YA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdjt-FX; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/44] staging: mfd: hi6421-spmi-pmic: cleanup hi6421-spmi-pmic.h header
Date:   Mon, 17 Aug 2020 09:10:34 +0200
Message-Id: <3dbc3f3876275404153da52b84e5dcef09faf644.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several external vars that are defined there, which
are not needed anymore.

Get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/mfd/hi6421-spmi-pmic.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index e0a8b50f95fc..1f986dd5f31c 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -63,34 +63,9 @@ struct hisi_pmic {
 	unsigned int g_extinterrupt_flag;
 };
 
-/* 0:disable; 1:enable */
-unsigned int get_uv_mntn_status(void);
-void clear_uv_mntn_resered_reg_bit(void);
-void set_uv_mntn_resered_reg_bit(void);
-
-/* Register Access Helpers */
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
 void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
 void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits);
-unsigned int hisi_pmic_reg_read(int addr);
-void hisi_pmic_reg_write(int addr, int val);
-void hisi_pmic_reg_write_lock(int addr, int val);
-int hisi_pmic_array_read(int addr, char *buff, unsigned int len);
-int hisi_pmic_array_write(int addr, char *buff, unsigned int len);
-extern int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list);
-extern int hisi_pmic_get_vbus_status(void);
-static inline u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg) { return 0; }
-static inline void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val) {}
-static inline void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits) {}
-static inline unsigned int hisi_pmic_reg_read(int addr) { return 0; }
-static inline void hisi_pmic_reg_write(int addr, int val) {}
-static inline void hisi_pmic_reg_write_lock(int addr, int val) {}
-static inline int hisi_pmic_array_read(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_pmic_array_write(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list) { return -1; }
-static inline int hisi_pmic_get_vbus_status(void) { return 1; }
-static inline u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg) { return 0; }
-static inline void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val) {}
 
 enum pmic_irq_list {
 	OTMP = 0,
@@ -110,4 +85,3 @@ enum pmic_irq_list {
 	PMIC_IRQ_LIST_MAX,
 };
 #endif		/* __HISI_PMIC_H */
-
-- 
2.26.2

