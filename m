Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3C524684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685982;
	bh=qXgDHxOXuDZD5R4tdepu4dG3IdI8o0vQJkklPvnJ3Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UCNvoWpJOkvYUsYMGEIHicQ01FOQ+f7+SxgS+ROWOIIq97c52r+6d0czKCwgctP49
	 2zhxJ1iPWiG0XUowYAeNll/BkzOxiRaxg78tLC+hBebN8NYDZLLX3GBPrX3JRGPEHp
	 /VmUvzy32jP4N1kRZZy7f8ivlFwcVyA9ym+tE/nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbgAVJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733253AbgAVJji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7406624686;
        Wed, 22 Jan 2020 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685977;
        bh=qXgDHxOXuDZD5R4tdepu4dG3IdI8o0vQJkklPvnJ3Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylTtESgw0eRHBqQczoYIZwFb3ctb4fi+n0rN6eEptOvaZxFChL8QJMGvpjQ3ry1c9
         0mdbBZ/6KaDSEgb64BycMEgo+5VavbO/xSH/SxYEKEnEXa+YmlVKWtTMPtR6lUfzt1
         vAmwr+Dny4JnmLEUFJ+b44ddSuPS6949AjTS+e/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 58/65] scsi: qla4xxx: fix double free bug
Date:   Wed, 22 Jan 2020 10:29:43 +0100
Message-Id: <20200122092800.020756675@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

commit 3fe3d2428b62822b7b030577cd612790bdd8c941 upstream.

The variable init_fw_cb is released twice, resulting in a double free
bug. The call to the function dma_free_coherent() before goto is removed to
get rid of potential double free.

Fixes: 2a49a78ed3c8 ("[SCSI] qla4xxx: added IPv6 support.")
Link: https://lore.kernel.org/r/1572945927-27796-1-git-send-email-bianpan2016@163.com
Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla4xxx/ql4_mbx.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -641,9 +641,6 @@ int qla4xxx_initialize_fw_cb(struct scsi
 
 	if (qla4xxx_get_ifcb(ha, &mbox_cmd[0], &mbox_sts[0], init_fw_cb_dma) !=
 	    QLA_SUCCESS) {
-		dma_free_coherent(&ha->pdev->dev,
-				  sizeof(struct addr_ctrl_blk),
-				  init_fw_cb, init_fw_cb_dma);
 		goto exit_init_fw_cb;
 	}
 


