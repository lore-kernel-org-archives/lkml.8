Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4FC20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580688;
	bh=Ai+rXpiLCM2HOmHhqAwjX8/Uqr7oSxre2HP7sX8sHR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkAHf/EpXARm7JNNjhqP8GZegb4ekzcb+GJ1Px7TlG8wTnQ5G3sQEt46zkB06l3dc
	 yrlu0N1auxteuEU6TRHPdKAKj8k3Xll2AnPUDhbiXYIWfveuulSIQ/02Bwe2/GGDdT
	 8VrxQn9x42mrhnnpZII0DNGcc4sKO0wOsD6gQe9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393830AbgFSPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393799AbgFSPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B832166E;
        Fri, 19 Jun 2020 15:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580674;
        bh=Ai+rXpiLCM2HOmHhqAwjX8/Uqr7oSxre2HP7sX8sHR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLGbFW/hDPBH2NRFEP2UCK4nElDs4ba1+Qp2CxsjltfEB9el8BG2bd6TWyssTbrlM
         ESK+379dm93kRYZ+625jzGheaQTjS8vI+X089btZtgzXPGySHy8+G+aMa+zRxZBAv4
         cDbn8Zy6CNR1RyM5O665aewlpvVhxN2S8OwoSQZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 5.7 312/376] EDAC/amd64: Add AMD family 17h model 60h PCI IDs
Date:   Fri, 19 Jun 2020 16:33:50 +0200
Message-Id: <20200619141725.105933893@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Monakov <amonakov@ispras.ru>

commit b6bea24d41519e8c31e4798f1c1a3f67e540c5d0 upstream.

Add support for AMD Renoir (4000-series Ryzen CPUs).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20200510204842.2603-4-amonakov@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/amd64_edac.c |   14 ++++++++++++++
 drivers/edac/amd64_edac.h |    3 +++
 2 files changed, 17 insertions(+)

--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2319,6 +2319,16 @@ static struct amd64_family_type family_t
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F17_M60H_CPUS] = {
+		.ctl_name = "F17h_M60h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
+		.max_mcs = 2,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
@@ -3357,6 +3367,10 @@ static struct amd64_family_type *per_fam
 			fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
 			break;
+		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
+			fam_type = &family_types[F17_M60H_CPUS];
+			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -120,6 +120,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F0 0x1448
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F6 0x144e
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
@@ -293,6 +295,7 @@ enum amd_families {
 	F17_CPUS,
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
+	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
 	NUM_FAMILIES,


