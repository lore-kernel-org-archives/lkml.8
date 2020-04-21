Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A4C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AvoLb6Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDUVJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:09:05 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35740 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:09:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 496GQR4XBHz9vCD5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 21:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id moJxc8Ynzn_B for <linux-kernel@vger.kernel.org>;
        Tue, 21 Apr 2020 16:09:03 -0500 (CDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 496GQR3Rrqz9vCFT
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:09:03 -0500 (CDT)
Received: by mail-qk1-f197.google.com with SMTP id v6so305283qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W230/sPUtrSZ9ChaTDlVXjpS2KjEcvhlwm/p53ONQvg=;
        b=AvoLb6Ieal43ACfvqYH880cV9d+xFvKYLVpWPUEur08gn0owG/q4oVdMu9+JKefMRS
         qrvwUh9FamMtxKj8hXcp7iEUpZj1An04ckZ0PoOu/yUEQsc7lI7fxZE0srTFziyx4J9r
         FM6gLG/9OfV+CTlEMPlz5MkjxuTABowbbbEzDgOTksvQbcNN8de/wFYlxHhi6OO00G4Q
         st+P3/lxaXPyitgwiOXxbCBYQsJINtOBs975NKt/pSGDB7wD/ZXHelWF63B68Ro6KcC3
         oa03+fLq2hcxZHOW76sXjtOGhypo4mGKv9smNuAYCZMtu80DwYfpsxJP4khssv4bvXJS
         Pl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W230/sPUtrSZ9ChaTDlVXjpS2KjEcvhlwm/p53ONQvg=;
        b=umoGWutBJnCgKJH4f31esJMI0pUVj1PS+oV099mWBqAbNmkPlwUBC5hKeYZ/ydfLzw
         E47dkNocEdiVDkSN0rHi8cMx6/r/EN0Roazu90pqLaNCI3ifl8ecuPxJ2v416O8OvQyX
         r0EJsee0xItTeIUJq0kjwrVGe0dW47fFt8oAxm8gVrp7v9CZDA1EBREh7woFyUtJtTNE
         x/X+4CT8cBFKSpVf0i44j3RpVWgA1WfbsZ/48xAGfLuXq/4+fC9vTnMynq2ZZBBswbGM
         Bv5NVCc9G9EkVxsbTQEWHiKWzQ9vELl0FDk0qPTkFXok9UAjQRFhmkLEmdI+QSRY2ypn
         f1KQ==
X-Gm-Message-State: AGi0PuZP1HGmQ6CkV/RIbuVK2seZq1Ul7XbhUX97CkIMqNMGVCp4CNwX
        QRUv5VrHUCECS5vqEpAV9RM73VW7o+dfLagPhcxnuZnPw5gaVvTx5pRj5JQ6x2zynZjWUauIpsn
        pXVv/wXPrLgqMHWTS/U1/Aug7Baz7
X-Received: by 2002:aed:2ac4:: with SMTP id t62mr23981529qtd.381.1587503342773;
        Tue, 21 Apr 2020 14:09:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLdR3F1Di5Dew+F3+Kr/c7o2DI0FiW0dSLJ1NG40UhZMsxQKBkOwhJHe3/Hmrcpl4D4OAcL0Q==
X-Received: by 2002:aed:2ac4:: with SMTP id t62mr23981500qtd.381.1587503342361;
        Tue, 21 Apr 2020 14:09:02 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id z40sm2641551qtj.45.2020.04.21.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:08:37 -0700 (PDT)
From:   wu000273@umn.edu
To:     jejb@linux.ibm.com
Cc:     QLogic-Storage-Upstream@qlogic.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] scsi: qla4xxx: Fix a potential race condition.
Date:   Tue, 21 Apr 2020 16:08:22 -0500
Message-Id: <20200421210822.18994-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In the function qla4xxx_eh_abort, we should use lock protect both
kref_get() and kref_put(), because we must serialize access where a
kref_put() cannot occur during the kref_get(). Otherwise, the object
"srb" may not remain valid during the kref_get(), and a race condition
can happen.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/scsi/qla4xxx/ql4_os.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 5504ab11decc..a1400cadb91a 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9222,8 +9222,10 @@ static int qla4xxx_eh_abort(struct scsi_cmnd *cmd)
 		    ha->host_no, id, lun));
 		wait = 1;
 	}
-
+
+	spin_lock_irqsave(&ha->hardware_lock, flags);
 	kref_put(&srb->srb_ref, qla4xxx_srb_compl);
+	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	/* Wait for command to complete */
 	if (wait) {
-- 
2.17.1

