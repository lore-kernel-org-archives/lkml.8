Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE51C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37EE20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E25NuS5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgBTQC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:02:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbgBTQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbwtB78+GrmjAgtuBkp/5M+dteqsFUb6HTGdpyT5C/M=;
        b=E25NuS5ebfIMLKILPg6vRYWy6yd8/J+PZUWQakBlV6zC0b0ojXeCGUV0plcEH/AV8X6u/a
        teJ1SbF6Ew9yV22tvOMC/pG42DcpSOkhRVGnye7kYsZJtERDVnATdfjpe+Un154aNB0Ikz
        R85VuPIqkk4dzAD3OgQLq0UeeGdYbXE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-zVQUZuQdPJyasWjmKePQWw-1; Thu, 20 Feb 2020 11:02:25 -0500
X-MC-Unique: zVQUZuQdPJyasWjmKePQWw-1
Received: by mail-qk1-f197.google.com with SMTP id v81so3039198qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbwtB78+GrmjAgtuBkp/5M+dteqsFUb6HTGdpyT5C/M=;
        b=FMjjdJDNPqjIgwB5KBa5kXPRFzXOMBI4KW2m56jmoy2IrLS6uvwzmyE4I2YnYp2WoD
         Pf3c+v3HoSdEB2W5Rocqmk3K/UNEfgYs1Fq8Jy+xLkbTA8mt+CYhIfQt8VG2+RInsXYa
         o3TIfGS4Omk+vp9UJu+nJAWxjsPpkkmSkS0RMrUJv/YZfStNWBPCs+DSlcnXqLjU8xJi
         8iQppt3sWP/qq4wBc/Go++aD5xaUvwT+z7dn4/zXyiy52KCA6OEXQktS6fLmoz3XUsQ8
         uwdShi/H11JHyi4ZgkDGzC80LP78vhNADNtAH6px1HdhPPKCfq5RaIknynohOlcNbrIO
         jlEQ==
X-Gm-Message-State: APjAAAW5hNXmzw+EE3qE2O/KIUhcIandET289MBb/aK1GSljjQ/g/CDE
        AjZ6G7vWX8d1J2ONgGaoYx7IWiTZLeQb5pRI/Ij2+N3nn62ZcnGYVkS7X0iX9hBrckM9qerWLyu
        mtS+gE6IwZ/EGl/Kpa9fIrUbn
X-Received: by 2002:a05:620a:1656:: with SMTP id c22mr29866249qko.144.1582214545474;
        Thu, 20 Feb 2020 08:02:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAKv5wpNeJTADqrEPJkZSXqFJ+Srl5Hx+rjfv0aI9xLkhXUkuB0gk2HFLl4PavjsFYL99WWg==
X-Received: by 2002:a05:620a:1656:: with SMTP id c22mr29866224qko.144.1582214545238;
        Thu, 20 Feb 2020 08:02:25 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id d206sm1816478qke.66.2020.02.20.08.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:24 -0800 (PST)
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
Subject: [PATCH RESEND v6 07/16] powerpc/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 11:02:22 -0500
Message-Id: <20200220160222.9422-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let powerpc code to use the new helper, by moving the signal handling
earlier before the retry logic.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/fault.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8db0507619e2..0868172ce4e3 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -582,6 +582,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	major |= fault & VM_FAULT_MAJOR;
 
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+
 	/*
 	 * Handle the retry right now, the mmap_sem has been released in that
 	 * case.
@@ -595,15 +598,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			 */
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(current))
-				goto retry;
+			goto retry;
 		}
-
-		/*
-		 * User mode? Just return to handle the fatal exception otherwise
-		 * return to bad_page_fault
-		 */
-		return is_user ? 0 : SIGBUS;
 	}
 
 	up_read(&current->mm->mmap_sem);
-- 
2.24.1

