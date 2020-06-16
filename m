Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0ED8207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323604;
	bh=lz0QmYUpdiPvamXMQCfnRLqqLSzc8DlZx7YXj9CHO6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OnL5O4Sqk+DSci2pbBAJuyO4fSOBD/bJDNLgC92WlZB/ibEpWANB3rXwsqp9vlSAW
	 l137M6bglnndH065XUrriR4Khs/+dQbxAiynZ8CLmBj4oTLFiVQ0Kx2hmemyqz0akI
	 SPapDnLim0YzBtMIMXwQ5lzj09JyC0c9972QTtgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgFPPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbgFPPrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2F82071A;
        Tue, 16 Jun 2020 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322450;
        bh=lz0QmYUpdiPvamXMQCfnRLqqLSzc8DlZx7YXj9CHO6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6M5sPhiV4z/NuL53QFDqRROpd2iXtw9lDCUKUgNGfVKK2Q5dhMNoNZqw77C+UjAx
         IiN3aqEpUz2vAHvnukOcbBt4Nai1kIiHd8fpx7FE5thhy/KAS86CFHMqHNksW8zTJn
         R/o0qrZvuu4t6+70mLM0YJytJhT2j4rqToKM5sSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.7 137/163] scsi: megaraid_sas: Replace undefined MFI_BIG_ENDIAN macro with __BIG_ENDIAN_BITFIELD macro
Date:   Tue, 16 Jun 2020 17:35:11 +0200
Message-Id: <20200616153113.372442068@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

commit b9d5e3e7f370a817c742fb089ac1a86dfe8947dc upstream.

MFI_BIG_ENDIAN macro used in drivers structure bitfield to check the CPU
big endianness is undefined which would break the code on big endian
machine. __BIG_ENDIAN_BITFIELD kernel macro should be used in places of
MFI_BIG_ENDIAN macro.

Link: https://lore.kernel.org/r/20200508085130.23339-1-chandrakanth.patil@broadcom.com
Fixes: a7faf81d7858 ("scsi: megaraid_sas: Set no_write_same only for Virtual Disk")
Cc: <stable@vger.kernel.org> # v5.6+
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas.h        |    4 ++--
 drivers/scsi/megaraid/megaraid_sas_fusion.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -511,7 +511,7 @@ union MR_PROGRESS {
  */
 struct MR_PD_PROGRESS {
 	struct {
-#ifndef MFI_BIG_ENDIAN
+#ifndef __BIG_ENDIAN_BITFIELD
 		u32     rbld:1;
 		u32     patrol:1;
 		u32     clear:1;
@@ -537,7 +537,7 @@ struct MR_PD_PROGRESS {
 	};
 
 	struct {
-#ifndef MFI_BIG_ENDIAN
+#ifndef __BIG_ENDIAN_BITFIELD
 		u32     rbld:1;
 		u32     patrol:1;
 		u32     clear:1;
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -774,7 +774,7 @@ struct MR_SPAN_BLOCK_INFO {
 struct MR_CPU_AFFINITY_MASK {
 	union {
 		struct {
-#ifndef MFI_BIG_ENDIAN
+#ifndef __BIG_ENDIAN_BITFIELD
 		u8 hw_path:1;
 		u8 cpu0:1;
 		u8 cpu1:1;
@@ -866,7 +866,7 @@ struct MR_LD_RAID {
 	__le16     seqNum;
 
 struct {
-#ifndef MFI_BIG_ENDIAN
+#ifndef __BIG_ENDIAN_BITFIELD
 	u32 ldSyncRequired:1;
 	u32 regTypeReqOnReadIsValid:1;
 	u32 isEPD:1;
@@ -889,7 +889,7 @@ struct {
 	/* 0x30 - 0x33, Logical block size for the LD */
 	u32 logical_block_length;
 	struct {
-#ifndef MFI_BIG_ENDIAN
+#ifndef __BIG_ENDIAN_BITFIELD
 	/* 0x34, P_I_EXPONENT from READ CAPACITY 16 */
 	u32 ld_pi_exp:4;
 	/* 0x34, LOGICAL BLOCKS PER PHYSICAL


