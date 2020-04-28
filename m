Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75215C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513DF206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kk+rwk4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgD1Iwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:52:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbgD1Iwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588063955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=T9gujxmIA52XJjJIjJGj47W5lD5i+d6CSCHpkidbk00=;
        b=Kk+rwk4M+WPS2cCuCa3+ShTfBi4C4/iYrdSkUSsvvG7577sfkELqXTHmjN32giOyK5V6fa
        9ZfNy3Hp1rATM0Y/TCJy6xZYwlk8rcd9lYRdwsFukXy7UsHYcRaubRQ38y8GgLtk5fDxSe
        GaZJ/V8mSULiP9ZK3L+waKy8rU8y6xk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-k0ZH4S0DPzWjNO3XOhHNBw-1; Tue, 28 Apr 2020 04:52:33 -0400
X-MC-Unique: k0ZH4S0DPzWjNO3XOhHNBw-1
Received: by mail-pj1-f71.google.com with SMTP id bt3so1879462pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T9gujxmIA52XJjJIjJGj47W5lD5i+d6CSCHpkidbk00=;
        b=J2FQX6wqtWpX3ZCg1fJ4QM1qXLH9CIiTGlZuWN/2zh2ilVw0bCiG++Dz3UFylDqVRz
         BTp+WUwkjIrH3xvVd0Q0O2Wjo1IiA79E6FFMpHTknbda9E2qXo78E7UmXtHbcY3f/KEI
         j6rdi6bdPdDUSibOA1PANe7Wp442xUNAgyVrGODJOGFPDJ596eEpXuEawkTWLXl9AuvB
         3WJgUqx6szEpSFeuFVAjQmiPrPrFkad8g+3UEd0Lr/Rk/CybK5zmYIL/A2OYcPMPovdO
         EKTnAHcXTqT8/jLQVvjShXBEY9eCG0a/YAfpldkaBca0NVQcfzroD0kiHIgwxfepJJdE
         KgJw==
X-Gm-Message-State: AGi0PuZs86rH0Zu4S04CXrzPjEUiPcsYI6z6U7g6fio7xRUTYAsdR9k+
        1mj4CiZohajE4/iwc57O7KfcGsLtQt+fj63aZ/TgNILyfzJ6Gc/wVui8dbkJIqomoj38q7zbAtM
        zQVc7nXdR1BaDK/eJqac9kZOr
X-Received: by 2002:a63:de49:: with SMTP id y9mr26209870pgi.435.1588063952403;
        Tue, 28 Apr 2020 01:52:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypIW6MPibMiV6lAF4LqnxCmnL0EBPSZPDuGJO/nMe0Ss11xXTYM3/1M7PkWt8OTp5foTs/Jpog==
X-Received: by 2002:a63:de49:: with SMTP id y9mr26209808pgi.435.1588063951198;
        Tue, 28 Apr 2020 01:52:31 -0700 (PDT)
Received: from localhost ([182.69.228.151])
        by smtp.gmail.com with ESMTPSA id g43sm1544780pje.22.2020.04.28.01.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 01:52:30 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bhsharma@redhat.com,
        bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] hw_breakpoint: Remove unused '__register_perf_hw_breakpoint' declaration
Date:   Tue, 28 Apr 2020 14:22:17 +0530
Message-Id: <1588063937-5744-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b326e9560a28 ("hw-breakpoints: Use overflow handler instead of
the event callback") removed '__register_perf_hw_breakpoint' function
usage and replaced it with 'register_perf_hw_breakpoint' function.

Remove the left-over unused '__register_perf_hw_breakpoint' declaration
from 'hw_breakpoint.h' as well.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 include/linux/hw_breakpoint.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 6058c3844a76..fe1302da8e0f 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context);
 
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
-extern int __register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
 
@@ -115,8 +114,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    void *context)		{ return NULL; }
 static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
-static inline int
-__register_perf_hw_breakpoint(struct perf_event *bp) 	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
 unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
-- 
2.7.4

