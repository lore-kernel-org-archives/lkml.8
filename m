Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9086EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EDD20732
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDCNCC8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBCW0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:26:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46852 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726992AbgBCW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580768798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bipqZYiQsQOfSn9eev8SYRXHv6uesR09OSvUzeqSz34=;
        b=dDCNCC8cyosA7bm/FGsfODZwvj+yaWX88kw7+qFRihVxV7vuHwmPiuPysd1VMn7cphICVn
        HyQYYbEp90ENAqHUN185dbtxP6y9WQpZjIHsVPYBAAOUKBgN7nl6lvhFELEkY3kmF828Bt
        vLE0sOuDjtxa+fCsfLU1h6qGjQSQpAE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-hASaOIK7NQKFW6LPsebsOA-1; Mon, 03 Feb 2020 17:26:36 -0500
X-MC-Unique: hASaOIK7NQKFW6LPsebsOA-1
Received: by mail-pj1-f70.google.com with SMTP id d22so423161pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bipqZYiQsQOfSn9eev8SYRXHv6uesR09OSvUzeqSz34=;
        b=kdtYTA+WC+hyTcjfRhXHxYWxcOtrMK00ckTBipCZL3ygkXGdXzXEnpah4cN63RW29T
         Q8uoECkSKa0cbAgTWScY8yET5xkX5dPCkGHGnqSiSngjgt7WXl3fWgxiW1a79192Au59
         T6YQY2Pq4F/WaawD6S9Z7JgKIMc7pUE54OGczOchwIh1GYOs9BFZfL7cnzMl80uALgX/
         21h1JMJ9JT0pEihtE3uyt+Gp4bLgzEPYpd+ncZ+Pm4fJLfyizBH8ANs3CnVb2fcKwqkF
         haytoz4mv3yprlcRDm8pusDBk4AE0rAXDI6p7C1ZW1u1goobYh85ozDNc4xXte4YaDU4
         8rYA==
X-Gm-Message-State: APjAAAXNQ2Tq1h7lkfRGdzb8kyHXJNrKEeqIrAydsOegVWALL4uNGNq0
        2pDzYpGRAFNBYSp0hLRtxLx84IqyZR87ntt5/yFWRxBZ0RQhlPGrhPGgCWc19fPL+7K9F4E47pg
        oWLtYe9ipxVKx773Oasa17ASf
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr1622315pjp.114.1580768795553;
        Mon, 03 Feb 2020 14:26:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzxd87NdsQ631gX3nIUFpl0YEYV17TA2JfUwibDWFfUrwRjr/zN2Yix+goiedAfyYB7KQ8PQ==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr1622294pjp.114.1580768795328;
        Mon, 03 Feb 2020 14:26:35 -0800 (PST)
Received: from localhost ([122.177.227.116])
        by smtp.gmail.com with ESMTPSA id n4sm21155444pgg.88.2020.02.03.14.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 14:26:34 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bhsharma@redhat.com,
        bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/2] hw_breakpoint: Remove unused '__register_perf_hw_breakpoint' declaration
Date:   Tue,  4 Feb 2020 03:56:23 +0530
Message-Id: <1580768784-25868-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
References: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

