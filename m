Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E047120661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608719;
	bh=ykTPePhQ0hHddIuGcVzpNHQS8K4ncWoU9fS/eVv0JTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+y657Dh4w9Dh0FKdMdXJtlBiNB6Ni2VpATQrtd6eHcFSj7mMgiEV88MQjffGbkXL
	 cKIdiipIz665nk+p4NVbcD4TGk3HR6gTyE6iHzvv0JcG+bi3fUQCo5ju2gb8OMUcct
	 ILpdneXVKrvQapuql2ZkYhRrbfK/GCH17Yp6mnzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgBMPpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgBMP1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:33 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACAE20661;
        Thu, 13 Feb 2020 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607651;
        bh=ykTPePhQ0hHddIuGcVzpNHQS8K4ncWoU9fS/eVv0JTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x7jdKUAd4oFtswdvmpi5uzd0GRXXu3SdiKK6HCzZDlM6MEC++oo0aav121tka1Fbh
         O9AQn2CcAcVfv+uKtkZ35ISvUnQkjytKDNj/QZCASwUzfrdb4R2+Xs8iUMnnkhdqrL
         vAiJetIiU2PlBR2d69Tduk20NeZtL1ruVSp1WQVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 56/96] powerpc/papr_scm: Fix leaking bus_desc.provider_name in some paths
Date:   Thu, 13 Feb 2020 07:21:03 -0800
Message-Id: <20200213151901.020531511@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Jain <vaibhav@linux.ibm.com>

commit 5649607a8d0b0e019a4db14aab3de1e16c3a2b4f upstream.

String 'bus_desc.provider_name' allocated inside
papr_scm_nvdimm_init() will leaks in case call to
nvdimm_bus_register() fails or when papr_scm_remove() is called.

This minor patch ensures that 'bus_desc.provider_name' is freed in
error path for nvdimm_bus_register() as well as in papr_scm_remove().

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200122155140.120429-1-vaibhav@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/papr_scm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -342,6 +342,7 @@ static int papr_scm_nvdimm_init(struct p
 	p->bus = nvdimm_bus_register(NULL, &p->bus_desc);
 	if (!p->bus) {
 		dev_err(dev, "Error creating nvdimm bus %pOF\n", p->dn);
+		kfree(p->bus_desc.provider_name);
 		return -ENXIO;
 	}
 
@@ -498,6 +499,7 @@ static int papr_scm_remove(struct platfo
 
 	nvdimm_bus_unregister(p->bus);
 	drc_pmem_unbind(p);
+	kfree(p->bus_desc.provider_name);
 	kfree(p);
 
 	return 0;


