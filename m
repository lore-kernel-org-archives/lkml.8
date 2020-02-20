Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3082C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5520658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BststaqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgBTQCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:02:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47390 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728620AbgBTQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZV5sRyntf0+M2WjfLiyPs+XgTlCWnjkOIA0alCn5h7M=;
        b=BststaqZdMi7noN1+a8Oy6uBxprcTISqjGdXlzf7ejlSAO+5yqrPCA2siujzBwdPu5YAnU
        feBJMkgLAt446rV/QFSCZaVFaL9G/uFmCROoe9Kno6CUVeRms+h5JQwZ/hRw5vRs/YLmE5
        m9Vi05UyvqejUMPgi82SPb+nco1CLUk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Vokvh5G4MRqzJEjgFJtF2A-1; Thu, 20 Feb 2020 11:02:33 -0500
X-MC-Unique: Vokvh5G4MRqzJEjgFJtF2A-1
Received: by mail-qv1-f72.google.com with SMTP id v3so2877742qvm.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZV5sRyntf0+M2WjfLiyPs+XgTlCWnjkOIA0alCn5h7M=;
        b=bX/U2WK5qb5gDzBGOxRVVBFwL356c0ziXudAB/mh8UIa9WzJDw0oRvIBqmx/0wxrC6
         yajcvGZXCkhmTnKqFB0Z/xbS8yrGIngj2Nz0W8gMtn3vDw4UB89QSgjRXKLb2SOkIlh/
         SHELisefIC3ngwcLLrntj4jKuLm/RKXF4FjVlVoGApVL6AMAggajdgPXPd6DumZDHtfV
         OlqUyEsYe15RrWw60DbwV+Q/fmv9yYrok8tnSeUfG0HPCPO8CSMyQJugE8eTwuXL+gTw
         FWVbmgml3DFkgaYp9iid7F8INDzwrFKmPIpB1bcB1fWlCqy0G6negV963zn7zVzwcviO
         fb+g==
X-Gm-Message-State: APjAAAWGuTOrIIt5ZTnfEnYtVnhE9aQZStsHEpMfWpQtTAEHlRlUzEdA
        jn5bRz2kQ25+0aUgEKvFgzAMpif2OuH9W2fmI3PB+gEnMtnbtwkXnMoMKSr8HrFPU9FuTdiRTZj
        I4mGj1foYX1dXMlRWLadlj7Dm
X-Received: by 2002:a37:714:: with SMTP id 20mr28851963qkh.347.1582214553471;
        Thu, 20 Feb 2020 08:02:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZHO0FXZai3X5wFkgabOPgehys+9qPT+3+TrtyslPTs5BnSW78NcqKByQgATBzv4ScYKwjog==
X-Received: by 2002:a37:714:: with SMTP id 20mr28851937qkh.347.1582214553239;
        Thu, 20 Feb 2020 08:02:33 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id g18sm2301qki.13.2020.02.20.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:32 -0800 (PST)
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
Subject: [PATCH RESEND v6 09/16] mm: Return faster for non-fatal signals in user mode faults
Date:   Thu, 20 Feb 2020 11:02:30 -0500
Message-Id: <20200220160230.9598-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea comes from the upstream discussion between Linus and Andrea:

  https://lore.kernel.org/lkml/20171102193644.GB22686@redhat.com/

A summary to the issue: there was a special path in handle_userfault()
in the past that we'll return a VM_FAULT_NOPAGE when we detected
non-fatal signals when waiting for userfault handling.  We did that by
reacquiring the mmap_sem before returning.  However that brings a risk
in that the vmas might have changed when we retake the mmap_sem and
even we could be holding an invalid vma structure.

This patch is a preparation of removing that special path by allowing
the page fault to return even faster if we were interrupted by a
non-fatal signal during a user-mode page fault handling routine.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 4c87ffce64d1..09d40ce6a162 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -379,7 +379,8 @@ static inline bool fault_signal_pending(unsigned int fault_flags,
 					struct pt_regs *regs)
 {
 	return unlikely((fault_flags & VM_FAULT_RETRY) &&
-			fatal_signal_pending(current));
+			(fatal_signal_pending(current) ||
+			 (user_mode(regs) && signal_pending(current))));
 }
 
 /*
-- 
2.24.1

