Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06838C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8307207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiHCcM4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgGWOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:01:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbgGWOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595512916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FNrI3J22ipRhrW25TFVKILW4WyC6tvsphPA0SNAITiY=;
        b=MiHCcM4ZVvUk+UUjUHNSuD4P+u7JvEATKnvVF0Uku7YNrxuTv3tQCObvnQ+aZeRtsY9jGR
        87/i6cdM/evo3z6Qs4gPTv+NKOmIRNzFZF7pbDCg6bDliPW1xyMUY09EqS4JDOXMVLkxfQ
        UzXTU8JxclhEIrnecp6B306zZ2bYhDQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-1VNfiPdAMV-o6p2huMOdxQ-1; Thu, 23 Jul 2020 10:01:55 -0400
X-MC-Unique: 1VNfiPdAMV-o6p2huMOdxQ-1
Received: by mail-qv1-f72.google.com with SMTP id w18so3607087qvd.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNrI3J22ipRhrW25TFVKILW4WyC6tvsphPA0SNAITiY=;
        b=tJIb2Fq4kGb/4OYXO5CxjhKNnjIKM4GrtfpoIbQbD3FPI5VHWuGop/r+08epkkoooL
         QrDOyMH7XP78ru9QLXcx/do9LXMzzT2rnhVPmTIygqh2HU/ykNNxrh5o6zo0RYAwdQBW
         nx4j7BW0MfuEVIBPMKTHi09XlKtLvDomoAjGoxQWyp7Gy9NsqKtc2yIJmeBVBD9g6rqC
         zyPE9IK546H5Nv1EgN8ZARuYCLCK8yomqPi6GovmE2SQxP3ozVydluBqx9Ed9LWJVj6w
         1AXmpTffvkUsIaJOZrTiVkNmd/w6qA0VBI/px8gcOrYLCePXVvuhgoBUHRf8FQyA7+7i
         Ydhw==
X-Gm-Message-State: AOAM530bnhUnxgGu5EKDqtWgR1CrwKP9GPdwlHNDkbHP6lU9JcFIXm4X
        fGe1BLpo36gDS8nroExy2XIcz5KPlbT9fll4PYIhPltFaE0o1VhY+ov1c+juOhGsH75RTp8+gTd
        Y6itcvYiT/FsBS3IVaajhuyZi
X-Received: by 2002:a0c:8583:: with SMTP id o3mr5013027qva.108.1595512914217;
        Thu, 23 Jul 2020 07:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4KIDq8nFjc8M+Ayc6oKKZhshXVGfh68xoXhfmaMHK6Mfi6bMcdpiPnoy+C+NIwEpmBPfoig==
X-Received: by 2002:a0c:8583:: with SMTP id o3mr5013000qva.108.1595512913943;
        Thu, 23 Jul 2020 07:01:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z60sm2534085qtc.30.2020.07.23.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:01:53 -0700 (PDT)
From:   trix@redhat.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: lpfc: add depends CPU_FREQ to SCSI_LPFC configury
Date:   Thu, 23 Jul 2020 07:01:36 -0700
Message-Id: <20200723140136.18367-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A compile error

drivers/scsi/lpfc/lpfc_sli.c:7329:26: error: implicit
  declaration of function ‘get_cpu_idle_time’; did you
  mean ‘set_cpu_active’? [-Werror=implicit-function-declaration]
   idle_stat->prev_idle = get_cpu_idle_time(i, &wall, 1);

lpfc_init_idle_stat_hb depends on CPU_FREQ

So add depends CPU_FREQ to the configury.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 571473a58f98..004dcda07d49 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1157,6 +1157,7 @@ config SCSI_LPFC
 	depends on SCSI_FC_ATTRS
 	depends on NVME_TARGET_FC || NVME_TARGET_FC=n
 	depends on NVME_FC || NVME_FC=n
+	depends on CPU_FREQ
 	select CRC_T10DIF
 	help
           This lpfc driver supports the Emulex LightPulse
-- 
2.18.1

