Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02DFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D1620706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHXMxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:53:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35914 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:53:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id c15so4409211lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=opAVrXw3eQDvTpV0W53NwZIY6sgRFUHXCXzJHzr2ZKQ=;
        b=W0QPIvDrxTyl6ruaNZiIorPQW+45YZ2IvtRXI8t//gVnDOxO9wTJzWO/1q0KyXKmI3
         rlZ7NzuxAw3SGzKlMOJcVMuq/4gpc+792LPR3UzBi4FTf459/LpRMXyQoo45SJxPO38z
         xS95PQQ8jm5ADGHksC0xw6hAjgtlq+aAAubJ/lwRwebbQl0FdCcgoo6LEfCyaBuPg6v2
         V8/F+Weyp35GdpSN7LzZMIsujo27T1Q9vcFJ2aSfx8RpNZ/7DlTJZOZWB7XetqMmKW0L
         y7BrDMZI4lmgbzvYw84P+YfcFk7ng+LxiexFyTCycwOFpEhJBhf/kNjiEPzxLBD6O5fD
         PmcA==
X-Gm-Message-State: AOAM533/eSLmFPRjt2jMDOhSU75cpx5/Nf9wMy0NrxBkVdz19QuaOBrp
        2143/JjR/SrECD4aBQC1zdg=
X-Google-Smtp-Source: ABdhPJz1IN1tvlfs5A3vsvZ3lm29lsMsfaBPUqE41cjyCqLHpLDARu4HY0bAvTp72VHAYEUV1lW61w==
X-Received: by 2002:a19:4081:: with SMTP id n123mr2558294lfa.198.1598273623152;
        Mon, 24 Aug 2020 05:53:43 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id e15sm2183452ljn.49.2020.08.24.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:53:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: vbox: Use current_uid() in vbg_misc_device_requestor()
Date:   Mon, 24 Aug 2020 15:53:30 +0300
Message-Id: <20200824125330.487083-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify vbg_misc_device_requestor() to use current_uid() wrapper.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 32c2c52f7e84..6215a688edaf 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -35,7 +35,7 @@ static u32 vbg_misc_device_requestor(struct inode *inode)
 			VMMDEV_REQUESTOR_CON_DONT_KNOW |
 			VMMDEV_REQUESTOR_TRUST_NOT_GIVEN;
 
-	if (from_kuid(current_user_ns(), current->cred->uid) == 0)
+	if (from_kuid(current_user_ns(), current_uid()) == 0)
 		requestor |= VMMDEV_REQUESTOR_USR_ROOT;
 	else
 		requestor |= VMMDEV_REQUESTOR_USR_USER;
-- 
2.26.2

