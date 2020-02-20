Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD3C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B85320659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSDjMOnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgBTP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:59:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbgBTP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clSHatG5ia5Xw2+IhpCP8KXnor3d1UGZTno0w+4svMM=;
        b=LSDjMOnhNivKgKlNKUAYMHym//QPZRb+ja8KzSYsmx9ZJItrvTBw413+WZ81u3H+772xOW
        PmKx12CNO0nRpAWXedWmVh85yji9dMsG0k1GeAAJfGv60+G99U6KXPDgsggr5QUW3LQ3Rz
        reoCZFBXr/XXDVmzGRiMVPJ1ZEFsayA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Y2w0sKgxN7qOaG0SWtlsIA-1; Thu, 20 Feb 2020 10:59:30 -0500
X-MC-Unique: Y2w0sKgxN7qOaG0SWtlsIA-1
Received: by mail-qt1-f197.google.com with SMTP id d9so2881239qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clSHatG5ia5Xw2+IhpCP8KXnor3d1UGZTno0w+4svMM=;
        b=Pk0G3YVMqVep7B9k97NMxpxUdzBsmpeSbhGV37NF2O99vx09NfpvoOWx2yFIWco2IT
         N4er1+BhjODDoie+HqEy1zjvJhu9+/AcvSw+1WwIklF7Oi5WslXoybY1/xTUCSyWLixS
         WHicP4YCLbGBLp8QmgCE1X0esPND6NHx2/mfZdePAmQKOVdVEADS6FIG2bXYCXptAjKE
         3FQkRoa/CH/87Sxl5FGYDgyfnVO6KIkiDS6MNA180Buc/vJR9ia96gDMnWKBZfc0QX8A
         6BCpt15GJiwtfoU6OPsvvMzSZfb5limq7B+Q5XABwwgNNEk+XNOH+ezkIblFPFrcNP4M
         nvog==
X-Gm-Message-State: APjAAAX8eRoOdveueQ9dEWE6SvD2QZ8+GR9f++VEGcO6/O5sSLj8Ev37
        aQxGRp1h34BjXc/FFgjeLwoxe3aHAPTmHms9bx503cS2UItntd+3fg/qIKZKcDWzKDl68ptYmXo
        YA5TFRc9YaaoCxR12HpWkbcGp
X-Received: by 2002:ac8:498f:: with SMTP id f15mr27215519qtq.123.1582214370319;
        Thu, 20 Feb 2020 07:59:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyd0Ii6YqQTuro4Ca0AkNt1/BWMO+NYngxZwnnSIE26fYpZaltQKEapAWU5vn2SxzQrYlBfBg==
X-Received: by 2002:ac8:498f:: with SMTP id f15mr27215485qtq.123.1582214370052;
        Thu, 20 Feb 2020 07:59:30 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id f2sm1705818qkm.81.2020.02.20.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:59:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH RESEND v6 06/16] arm64/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:59:27 -0500
Message-Id: <20200220155927.9264-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the arm64 fault handling to use the new fault_signal_pending()
helper, by moving the signal handling out of the retry logic.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 85566d32958f..6f4b69d712b1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -513,19 +513,14 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
 	major |= fault & VM_FAULT_MAJOR;
 
-	if (fault & VM_FAULT_RETRY) {
-		/*
-		 * If we need to retry but a fatal signal is pending,
-		 * handle the signal first. We do not need to release
-		 * the mmap_sem because it would already be released
-		 * in __lock_page_or_retry in mm/filemap.c.
-		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
-				goto no_context;
-			return 0;
-		}
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
 
+	if (fault & VM_FAULT_RETRY) {
 		/*
 		 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
 		 * starvation.
-- 
2.24.1

