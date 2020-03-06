Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6B2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ul/MkeLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFKa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:30:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17414 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgCFKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:30:56 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026AORpl008903;
        Fri, 6 Mar 2020 11:29:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=IukcALM/LFo7ZNhzI6tBOK/8vY0XhfAkNL6xF8zqy74=;
 b=Ul/MkeLhpH/q64O3k75Vdqz6ozVq6MZJjG2A7UeOrtjCIz9waVVko9idTMLpfpjusg/J
 UOa/+IlwZ0GlIh5dTy0lzI3lu5B+d7aFo5TYbtJBgJKVRtg8VyawXtPh8G2shSHd7Lpc
 KAUnURftrnyBRwjm21SBUz70eeacDbadq3fVsC5djJ/oXRmhyzy1CEUJYDDCa8TzsBgo
 IjMsSvXhKKU0gt93iv2EpQYaqFSAtzFSSUKgZSdctAuXwbGWi40k2bzjhhCUpuP2ae97
 BbeXCHs3IzwgRmDgICtCSzKnEhWXj1pdSbmFhQWMThjmR1OlrJiQsK3rP0oF/WzlX6xX GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfea7ej2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 11:29:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72D69100038;
        Fri,  6 Mar 2020 11:29:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4781D2A76CB;
        Fri,  6 Mar 2020 11:29:40 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Mar 2020 11:29:39
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <emil.l.velikov@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: vm: Clean up documentation
Date:   Fri, 6 Mar 2020 11:29:34 +0100
Message-ID: <20200306102937.4932-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_02:2020-03-05,2020-03-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel doc comments to avoid warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_vm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 64619fe90046..aa88911bbc06 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -102,7 +102,7 @@ static pgprot_t drm_dma_prot(uint32_t map_type, struct vm_area_struct *vma)
 	return tmp;
 }
 
-/**
+/*
  * \c fault method for AGP virtual memory.
  *
  * \param vma virtual memory area.
@@ -192,7 +192,7 @@ static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
 }
 #endif
 
-/**
+/*
  * \c nopage method for shared virtual memory.
  *
  * \param vma virtual memory area.
@@ -225,7 +225,7 @@ static vm_fault_t drm_vm_shm_fault(struct vm_fault *vmf)
 	return 0;
 }
 
-/**
+/*
  * \c close method for shared virtual memory.
  *
  * \param vma virtual memory area.
@@ -294,7 +294,7 @@ static void drm_vm_shm_close(struct vm_area_struct *vma)
 	mutex_unlock(&dev->struct_mutex);
 }
 
-/**
+/*
  * \c fault method for DMA virtual memory.
  *
  * \param address access address.
@@ -329,7 +329,7 @@ static vm_fault_t drm_vm_dma_fault(struct vm_fault *vmf)
 	return 0;
 }
 
-/**
+/*
  * \c fault method for scatter-gather virtual memory.
  *
  * \param address access address.
@@ -435,7 +435,7 @@ static void drm_vm_close_locked(struct drm_device *dev,
 	}
 }
 
-/**
+/*
  * \c close method for all virtual memory types.
  *
  * \param vma virtual memory area.
@@ -453,7 +453,7 @@ static void drm_vm_close(struct vm_area_struct *vma)
 	mutex_unlock(&dev->struct_mutex);
 }
 
-/**
+/*
  * mmap DMA memory.
  *
  * \param file_priv DRM file private.
@@ -513,7 +513,7 @@ static resource_size_t drm_core_get_reg_ofs(struct drm_device *dev)
 #endif
 }
 
-/**
+/*
  * mmap DMA memory.
  *
  * \param file_priv DRM file private.
-- 
2.15.0

