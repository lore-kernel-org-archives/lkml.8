Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD3C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6768520780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552369;
	bh=OB6uo/HCyFxTsaJ3MtSPMJJb5ck8q2hYb6nWW83YjS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqjZsF8fXUWSrFPtgOYCQ3D/qCoj0s5zdp6nrTze+18IjFJuqq1qQV1HcuiBu+myH
	 ex0Sy4QdGT2xRh5p7Gn+c1NIs0sfnF7mrdF8ntKP3rYrinTLH36uhMhD88eP4+16aU
	 LdQcH5jsfsxBX0siEzzAGYfLBEpSpGEHazYj+m/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgDVKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgDVKRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55352070B;
        Wed, 22 Apr 2020 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550645;
        bh=OB6uo/HCyFxTsaJ3MtSPMJJb5ck8q2hYb6nWW83YjS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrHhI+1uBi6QJB7871pwDdLc66nbI8NDM8uVOI/e25eY4vRdQcito0PCT7951zrOt
         EqiUvpyxLA3XYLW8ky22E96zuyBzQlHMTfPyAGn/+fV48oDYEGKYPwG0ZgxcbcpPge
         Yh03RJS6RKovdoqmQO18dw+5tZA+XF1h44IAEih0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/118] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date:   Wed, 22 Apr 2020 11:56:35 +0200
Message-Id: <20200422095037.497701884@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

[ Upstream commit 7f11a2cc10a4ae3a70e2c73361f4a9a33503539b ]

If kmsg_dump_register() fails, hv_panic_page will not be used
anywhere.  So free and reset it.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Link: https://lore.kernel.org/r/20200406155331.2105-3-Tianyu.Lan@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 593107c20e977..40f6b73dae940 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1401,9 +1401,13 @@ static int vmbus_bus_init(void)
 			hv_panic_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret)
+				if (ret) {
 					pr_err("Hyper-V: kmsg dump register "
 						"error 0x%x\n", ret);
+					hv_free_hyperv_page(
+					    (unsigned long)hv_panic_page);
+					hv_panic_page = NULL;
+				}
 			} else
 				pr_err("Hyper-V: panic message page memory "
 					"allocation failed");
@@ -1433,7 +1437,6 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	free_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.20.1



