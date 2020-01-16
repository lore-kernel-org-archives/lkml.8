Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC53C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370C20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217941;
	bh=/1DJZ2OngrzS6T7AFTOajJaQs7/0OIr2Fjk95k3tHQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CpkaYWlaDXuMtDnituA/Bl8BTDc3TysONpcnPKQ6Tq5ZIt3TlosxcFQPVI1BEYsa+
	 AscUf7ou/VuPkSfhPjK0qnEwzhzLIfslHvy6KoQrKQuRGREVjKJNeOv6uNk40FQfWQ
	 Ly6Ackrb5VY2AiN+sTp6JuB7eMH56NBmTcPMXM2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391603AbgAPXjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389996AbgAPX2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:28:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61AFB20684;
        Thu, 16 Jan 2020 23:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217327;
        bh=/1DJZ2OngrzS6T7AFTOajJaQs7/0OIr2Fjk95k3tHQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGgcvkZWed9nKFFYp1STElQrFclO+9tSBZxBpT1HlZ8XXLyKM17OnL5haTb0DSqPl
         FeitLI8rj3D/io0YycoTFTHUm9ZYC1dHMD4+dIssnmPUD8sjK5cIGLWXcTaDGVfxlg
         /wMBN6vjVW+GgL2qmfOvgiZiNoPWeJvigqv1OqUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 38/84] scsi: sd: Clear sdkp->protection_type if disk is reformatted without PI
Date:   Fri, 17 Jan 2020 00:18:12 +0100
Message-Id: <20200116231718.252209088@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

commit 465f4edaecc6c37f81349233e84d46246bcac11a upstream.

If an attached disk with protection information enabled is reformatted
to Type 0 the revalidation code does not clear the original protection
type and subsequent accesses will keep setting RDPROTECT/WRPROTECT.

Set the protection type to 0 if the disk reports PROT_EN=0 in READ
CAPACITY(16).

[mkp: commit desc]

Fixes: fe542396da73 ("[SCSI] sd: Ensure we correctly disable devices with unknown protection type")
Link: https://lore.kernel.org/r/1578532344-101668-1-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2195,8 +2195,10 @@ static int sd_read_protection_type(struc
 	u8 type;
 	int ret = 0;
 
-	if (scsi_device_protection(sdp) == 0 || (buffer[12] & 1) == 0)
+	if (scsi_device_protection(sdp) == 0 || (buffer[12] & 1) == 0) {
+		sdkp->protection_type = 0;
 		return ret;
+	}
 
 	type = ((buffer[12] >> 1) & 7) + 1; /* P_TYPE 0 = Type 1 */
 


