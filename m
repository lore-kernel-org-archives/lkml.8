Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28C6C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A25F2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736735;
	bh=IUY4U44esFWbfleDsjrVa7BP0ZvlKMaCIMck05qsgsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HEIcKG7PqABMNXeChEcqzIxp9xSgfi9y2j96qpnNzIqnxrh0IbVaeKgatNbJabDPy
	 6k3WLnKtI6eGnbiVQ2spedDwU3/Ml9oEsfcl6yzGXq/UeW7kW9I/bRVBVn5VCrePLd
	 9EMRibN7FKo843+qKZ6Hn5eEs1A3rQ67owvjPNPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAKJ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAKJ6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:58:53 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2337220848;
        Sat, 11 Jan 2020 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736732;
        bh=IUY4U44esFWbfleDsjrVa7BP0ZvlKMaCIMck05qsgsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJN1vOPAcPqxmL3eZqVtkvk4PQyk4I6nd4klMU0dV2+mW1+LyM/TfNRHeJrataIk/
         A7eY09X2qNQFR5C7rAJgaOPqnSMBOUwsRVqd9+YpLMHRfxuu0XnIt7oNlsP2oxsUvZ
         lxoLTt6G4hzvxoLdjTaIYCw1eAjdhg1pB3jkPkus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/91] scsi: iscsi: qla4xxx: fix double free in probe
Date:   Sat, 11 Jan 2020 10:48:58 +0100
Message-Id: <20200111094845.672920775@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit fee92f25777789d73e1936b91472e9c4644457c8 ]

On this error path we call qla4xxx_mem_free() and then the caller also
calls qla4xxx_free_adapter() which calls qla4xxx_mem_free().  It leads to a
couple double frees:

drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->chap_dma_pool' double freed
drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->fw_ddb_dma_pool' double freed

Fixes: afaf5a2d341d ("[SCSI] Initial Commit of qla4xxx")
Link: https://lore.kernel.org/r/20191203094421.hw7ex7qr3j2rbsmx@kili.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index d220b4f691c7..f714d5f917d1 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4285,7 +4285,6 @@ static int qla4xxx_mem_alloc(struct scsi_qla_host *ha)
 	return QLA_SUCCESS;
 
 mem_alloc_error_exit:
-	qla4xxx_mem_free(ha);
 	return QLA_ERROR;
 }
 
-- 
2.20.1



