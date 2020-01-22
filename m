Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB942467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685838;
	bh=EwXiR3OAHCKqfa2wQBGY7nZhL1E2myYAN/IcWN8jdxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kzIVq/qcoTH6gYdDpiHo5XYhoKfXYXrC5DJj32cwX+O14vwaI4YwPZVwRUR+Ag6Lv
	 T94foZGIwWzDRZGx77NI6AnEMy8Sc2VTJm0SKmLA6eTjsWHNDGn+sPbafe51RnZHnT
	 LwtZYkIqEtRRyUbB2DU39cZnB21FJZey8IXc+l1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgAVJhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730935AbgAVJhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45E32467F;
        Wed, 22 Jan 2020 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685833;
        bh=EwXiR3OAHCKqfa2wQBGY7nZhL1E2myYAN/IcWN8jdxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnxT37qxgmcyj79H+EhwDv0SgtqcG8r97Rj48SwgR9HxO/jBVnAKJl+7hUo8Ysokr
         wi78Oe1SoEHaYYmfdkRj0FTqTOnrt2KiARfaZw5A+aINSjTAQI7QKaCbGJHTwDEq5X
         f87Axtb4qjOkZmPzUeEm8Tpcsdz0dVkEBmHCIUk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 91/97] scsi: esas2r: unlock on error in esas2r_nvram_read_direct()
Date:   Wed, 22 Jan 2020 10:29:35 +0100
Message-Id: <20200122092810.775887489@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 906ca6353ac09696c1bf0892513c8edffff5e0a6 upstream.

This error path is missing an unlock.

Fixes: 26780d9e12ed ("[SCSI] esas2r: ATTO Technology ExpressSAS 6G SAS/SATA RAID Adapter Driver")
Link: https://lore.kernel.org/r/20191022102324.GA27540@mwanda
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/esas2r/esas2r_flash.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/esas2r/esas2r_flash.c
+++ b/drivers/scsi/esas2r/esas2r_flash.c
@@ -1197,6 +1197,7 @@ bool esas2r_nvram_read_direct(struct esa
 	if (!esas2r_read_flash_block(a, a->nvram, FLS_OFFSET_NVR,
 				     sizeof(struct esas2r_sas_nvram))) {
 		esas2r_hdebug("NVRAM read failed, using defaults");
+		up(&a->nvram_semaphore);
 		return false;
 	}
 


