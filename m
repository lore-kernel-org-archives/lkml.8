Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E04AC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3F320772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwiSXOsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgF3UqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30751 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgF3Up4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QmKrOvMWqrUVt7J9PTTUHlaMQYpm2NLJh4q6ELyuhdM=;
        b=JwiSXOsQYqjAgYWc0LQIvWC9Ik1Yzc7W3Mxp48IOFDEuSXLYEHxLbJ309jv9um1YUOm3cD
        tNrirYLdClplwYR2pMhmzCg62q5jCQ9TNNCVwoURC34d7dfXHowxSX4rVv5e++pb3pAfGv
        oSCMXG7DKOcyDlLp6OK9IZlI5VxPREQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-rn6iRG4gN5-bbQrdzKijWg-1; Tue, 30 Jun 2020 16:45:51 -0400
X-MC-Unique: rn6iRG4gN5-bbQrdzKijWg-1
Received: by mail-qt1-f198.google.com with SMTP id s30so15264359qts.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmKrOvMWqrUVt7J9PTTUHlaMQYpm2NLJh4q6ELyuhdM=;
        b=XCqEPsRu0FQBebH0S5R6dzclIFxpNSpTmDzeEla5kpWSZX/R3aN+rySW+cKGBXke5x
         MjarZgPEnano5QLd2m82gDdt0KNVwGqJaRpSKOJb7rnEsb6/0WmmPpHlShwz8/syKqrW
         T7bjfGcJn7sjfXWBsRZPV8w8VqdaVHn0KMJ2WiMjIoWWlDadJ7KsrgBF+c52BwAyKfwm
         boiScgBDirFJw0aPryrM15aG74SSP4Yt2AFPGpXWaETKaU+ngS028yQeGZqIi7sL90jR
         2bEI1GMzD/D6oOOK4spsdXzrKyCWpWdoBhj1zpFWii2vpyW9m4ZJqjQrYL8VRYclnBRN
         rPEg==
X-Gm-Message-State: AOAM5337T7TzZYzkjnGOf70SN2/UteF6KhpAtW+BcE5rhqAFmLIYukOU
        H7SSrH/oyb3hLBpBVqGEDFXKZlTuffD+/FeKJ2AR6OBVcEOCmDk63KwiCRH3/1fWW1+qnDTJ+8U
        gxh/OBT0PIUj8JXlvR9CTiwb3
X-Received: by 2002:aed:25fd:: with SMTP id y58mr22804775qtc.310.1593549951208;
        Tue, 30 Jun 2020 13:45:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/hkCkeODL2Wy8DJkssVjFyiyJsWkeyAfUcqwLI37xKcbykEL4x8zUn+pbQH01QHAlweYYdg==
X-Received: by 2002:aed:25fd:: with SMTP id y58mr22804761qtc.310.1593549950997;
        Tue, 30 Jun 2020 13:45:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d79sm4006344qkb.101.2020.06.30.13.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 18/26] mm/s390: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:48 -0400
Message-Id: <20200630204548.39342-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index fc14df0b4d6e..9aa201df2e94 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
 			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
-- 
2.26.2

