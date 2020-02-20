Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E488C11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EC924673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrCWY6F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgBTPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:54:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35651 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728602AbgBTPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=XrCWY6F+Ap676vKabppYeOI/HFR35R5yPNA7Tr+SwJ5/DpHv8ZgTSYu6Fbu3DNwOl2DTT6
        LBFOvibm7RL4PTalMW4xzi7gClWC8eI7Ybz1znEHX8qop/0Fm28fe3nPSrmXpfOgqvx1WT
        VeNbVjBdcapgDMwsCutUoy1iJVerm2k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-yaqCZDlTOxyx1LO4_uJ8fQ-1; Thu, 20 Feb 2020 10:54:07 -0500
X-MC-Unique: yaqCZDlTOxyx1LO4_uJ8fQ-1
Received: by mail-qt1-f198.google.com with SMTP id t4so2885424qtd.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cu+nCrF0vUC0DWPMISJ46Dyo+A/qgWPAj0jcXPlop0=;
        b=Ez4ASygG4u04JqMMc6N0s8padNLHlEFr3ESHqKSOcl8yMQt+xraKAAL8Bu/oqY9IkB
         UrjeeAQfC+JfxiI824rcBvCeFKarhoVfeMpHmwFkucjTPI/lJCSit44VWsVL+oCUOf8c
         L5N715JUdfqnw7wxdVW6+gGmYk5JIJ61wfC9QEtakCVPh+njWh7sbbliwR2vC/GFEr8r
         O0a+/iwHFDIGJtH++lI8lO8Wz7saAFA8oqOXYJjzFH63g4DV66u6k0S5bCxuqcbM/uke
         8Scg7lm4Ns5LT22oI5pNIvSr4i4Vcd+1d6V8fLEidAkv8l3V/YHlsivENRoCvlGBJpa4
         drrw==
X-Gm-Message-State: APjAAAWTn6bbIvDd3vy8/xKlR5eyaWwxdceHtGbESg+yrxFPdFH5LNfV
        YqT1rvFk+uOBVZmTSi/gjs7e2eekEiGnYRKn43gawRsUxxDZwAgNvBU93ilHETeR7IGcOyh/U5h
        6Z2aSJm1v8TaSMWzF2Zd/oal/
X-Received: by 2002:ae9:e003:: with SMTP id m3mr8332088qkk.250.1582214044027;
        Thu, 20 Feb 2020 07:54:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqBbfVrw6oW5Uq7giseK/Asl8XiArti83tm8uh5tXmEmh2Vf3Qyj45T3Pp+ZWIGYPfmKisVw==
X-Received: by 2002:ae9:e003:: with SMTP id m3mr8332062qkk.250.1582214043787;
        Thu, 20 Feb 2020 07:54:03 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id h20sm1807430qkk.64.2020.02.20.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:54:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH RESEND v6 04/16] x86/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:53:41 -0500
Message-Id: <20200220155353.8676-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: <20200220155353.8676-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the fatal signal check even earlier so that we can directly
use the new fault_signal_pending() in x86 mm code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa4ea09593ab..6a00bc8d047f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1442,27 +1442,25 @@ void do_user_addr_fault(struct pt_regs *regs,
 	fault = handle_mm_fault(vma, address, flags);
 	major |= fault & VM_FAULT_MAJOR;
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, hw_error_code, address, SIGBUS,
+				   BUS_ADRERR);
+		return;
+	}
+
 	/*
 	 * If we need to retry the mmap_sem has already been released,
 	 * and if there is a fatal signal pending there is no guarantee
 	 * that we made any progress. Handle this case first.
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		/* Retry at most once */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(tsk))
-				goto retry;
-		}
-
-		/* User mode? Just return to handle the fatal exception */
-		if (flags & FAULT_FLAG_USER)
-			return;
-
-		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
-		return;
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 	up_read(&mm->mmap_sem);
-- 
2.24.1

