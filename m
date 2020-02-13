Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E079C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24B217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609881;
	bh=/O/Q4FG/rgon6u0qtaJpJXjl/VmEOXvI7NIDBPba6es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bd51WI0Xd8h5BFrueTqbVD+LU+dx+I7Am7+D8rWE3mYStdokEt2rKuMQR4rmFUIq2
	 SS9wx3QOzC8ycFM55QpAP2OpenYI4Qz0ayuBBeFVEbNR3xdaeeTRYjvd0MsyUXOEcg
	 CEoZPD0tthw6vGIbxo/V55FmuA4Hy2jJPlQT6EvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgBMQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgBMPYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:00 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71FE24699;
        Thu, 13 Feb 2020 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607440;
        bh=/O/Q4FG/rgon6u0qtaJpJXjl/VmEOXvI7NIDBPba6es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMLqP6/rG+F6bI7WTdE6d7xNw2eJnzF+DpeLGcsJDbpibyaFcBzFUOR9SZ6dfPlVs
         G2oIYCI+UJpSMUW/3TQ8Ycj4NdxS+zFnxQX/ka+QbVd8GFL253wVY3OrWwpTrttbHd
         p/mXWHtGH2FdugvltnAWhspoeTMrQW3JBatBjUsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Rangankar <mrangankar@marvell.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 060/116] scsi: qla4xxx: Adjust indentation in qla4xxx_mem_free
Date:   Thu, 13 Feb 2020 07:20:04 -0800
Message-Id: <20200213151906.283020734@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit aa8679736a82386551eb9f3ea0e6ebe2c0e99104 upstream.

Clang warns:

../drivers/scsi/qla4xxx/ql4_os.c:4148:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
         if (ha->fw_dump)
         ^
../drivers/scsi/qla4xxx/ql4_os.c:4144:2: note: previous statement is
here
        if (ha->queues)
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this
line.  Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: 068237c87c64 ("[SCSI] qla4xxx: Capture minidump for ISP82XX on firmware failure")
Link: https://github.com/ClangBuiltLinux/linux/issues/819
Link: https://lore.kernel.org/r/20191218015252.20890-1-natechancellor@gmail.com
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla4xxx/ql4_os.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4150,7 +4150,7 @@ static void qla4xxx_mem_free(struct scsi
 		dma_free_coherent(&ha->pdev->dev, ha->queues_len, ha->queues,
 				  ha->queues_dma);
 
-	 if (ha->fw_dump)
+	if (ha->fw_dump)
 		vfree(ha->fw_dump);
 
 	ha->queues_len = 0;


