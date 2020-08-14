Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E14520771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYChkY22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHNWNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNWNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:13:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B39C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:13:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b22so9422684oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YU5kgUEDzxyOMT9rzgRH7KQsCrrC/AMgf4MvEBjYqSc=;
        b=nYChkY22lU50rLV7b9nv0rXxQPMAplE8whIy4wX+YDdfkpl5bkJdoownt03q6o3oJH
         5PKRmzqjAA4Wm7kStjerqBL2FQ7Lp+uOYg+d+zOcdbBQmJa7PYkByPcpiXvATsMOlcU/
         SNCQbDoaRdcivLYrdXpUUZHBGj9RniVch9cGXACewSF8kk9WQou9qJip8nSriIj8WZk/
         2TjUl94ia3EyVnjELzeXTMKkCjftGcH4/K8w+//rrTFeVB/sA0qi/0dG8sW1AkpX5Vno
         jly2O2hkMl0hdYkA1Ya3KXWWka0cXRMgOvMQwUTlyGwDNqd3zWBwLW2f1TaAy25w64Iq
         XJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YU5kgUEDzxyOMT9rzgRH7KQsCrrC/AMgf4MvEBjYqSc=;
        b=Jl6qUYDYx6Nb+BHBhQRbn5aBg6msuvMK5KFLNYV0CaZXjqa/lAcpRAVe9v3pKxvIP5
         e0IncronHO3e40rWJAJI2tSu5X+HPuZkYqJg976dXfyoqGEJdnvdxFw5OdJZsmZh0HeH
         G5BtwTi9hpEbs93pUn3y9gHMB123ZsGvZyZHnr9eTa3AGliDjqm0leu42T3lnyn3mV64
         hZg0Gi71k1/QRcDzfej4wN0vIkTpc4c2NiuqqzJD69PCkvVrFj89pWXdLWsI2IMunu4x
         VchO/F4aMBh9O/KZ4W7b750aKpQP+ile3QIA21WujcTtW2Ezi+afF2rGmAZZE+VSyLB7
         XOTg==
X-Gm-Message-State: AOAM530iIG8+jq2jZSXhJ44Si430owUYQ+rbT8AR7Tztu8No0qJi7KbL
        B0+bUbp/ZiFDAr0dap8ITkf/Dg==
X-Google-Smtp-Source: ABdhPJwi07+q4De1leK1kwaoeRMb3m/eApDhDsZ6VRKOOd0v1IPUfrLquHEUtRL8j2SBF/BnIMK0LA==
X-Received: by 2002:aca:5642:: with SMTP id k63mr2771385oib.42.1597443213626;
        Fri, 14 Aug 2020 15:13:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w30sm1948549oow.36.2020.08.14.15.13.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Aug 2020 15:13:32 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:13:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Hugh Dickins <hughd@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] khugepaged: adjust VM_BUG_ON_MM() in __khugepaged_enter()
In-Reply-To: <alpine.LSU.2.11.2008021217020.27773@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008141503370.18085@eggly.anvils>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils> <alpine.LSU.2.11.2008021217020.27773@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot crashes on the VM_BUG_ON_MM(khugepaged_test_exit(mm), mm) in
__khugepaged_enter(): yes, when one thread is about to dump core, has set
core_state, and is waiting for others, another might do something calling
__khugepaged_enter(), which now crashes because I lumped the core_state
test (known as "mmget_still_valid") into khugepaged_test_exit().  I still
think it's best to lump them together, so just in this exceptional case,
check mm->mm_users directly instead of khugepaged_test_exit().

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v4.8+
---

 mm/khugepaged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- v5.9-rc/mm/khugepaged.c	2020-08-12 19:46:50.867196579 -0700
+++ linux/mm/khugepaged.c	2020-08-14 14:24:32.739457309 -0700
@@ -466,7 +466,7 @@ int __khugepaged_enter(struct mm_struct
 		return -ENOMEM;
 
 	/* __khugepaged_exit() must not run from under us */
-	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
+	VM_BUG_ON_MM(atomic_read(&mm->mm_users) == 0, mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
 		free_mm_slot(mm_slot);
 		return 0;
