Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E3C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CADF2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ZCnGyjz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgAJKGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:06:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33201 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgAJKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:06:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so1771104pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAhOey3cqiOp5/b6uTfIau2ZiRzs6yslTIYzXyRfd0c=;
        b=ZCnGyjz4JtzHSiIKTawQQFFawClt0WRij9NbnhP7RUUYZVdjjy1D9p2jpTH6nJ8Tmv
         jg14A971WglswnMZ4qFHpRKI3KbEv3y/J1PkACZdJhUJgE3VCR5rvKwXXJhvN478mZu7
         QAq9H4WCPHGe6yjVCU8a3QuVHEb9pl3jhxejEIX4dXJfgyuxGRnJd54LXW1hIVGT6+SB
         9XZUXRXaDfzBleyop6DCKdkSlL6sWtqlzy7cZ5P4pcZ2I7bjGAzFttaVcatZb+u8b3zu
         YiHN/37SOWbvCCiW2ndN5YG9eTyIuqeY6HCFMoSygQV6MPX3TdoauyvSqe+P/MJseMP1
         CqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAhOey3cqiOp5/b6uTfIau2ZiRzs6yslTIYzXyRfd0c=;
        b=VWFx9vCVqknoVDMPcwvQn5TvyDtSoPGkz7L6dxsE6m7eu/u5JS4kwubguibg0DvS3b
         Xm24cbv3XyhfvULwtVNnEfJZ04764rtqk6oXnvU8HFHvNCK82XiX8gW+gkruJG42z5FV
         XVaybj78shsjIdZS3b/bFK7VWLhXNlD4lwRJ0Iw+MyHbH5olt7spwybnRNGtdGBQ0yi1
         /gLdfDGlMBo2YUA866GJgZApkCCT3z+/YQb/i1GtdedslB5AfGTIzaPphLCrzcMO3XEf
         dXxXuMqnTa+wvcDMvx4O0lHFtblez3ksvSr9ZkkFZfRa4t0vhacYk29M7Bhuip1VjcDC
         um1g==
X-Gm-Message-State: APjAAAVpeLAltz6q+h5r+iBnT9v47Qrh764r2nmZhbcc3CeocxCjPWq9
        63TOPHx/TJGTowocUxnvCwnQsg==
X-Google-Smtp-Source: APXvYqyqnZ9lf3ppNVir68eoZT7u3buRR7s7HIwujRNHxEUEdVG6qsr88g9VM/pC+0jZaZIEUqzprA==
X-Received: by 2002:a17:90a:1b4d:: with SMTP id q71mr3653557pjq.82.1578650805378;
        Fri, 10 Jan 2020 02:06:45 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q21sm2179039pff.105.2020.01.10.02.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:06:44 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pbonzini@redhat.com
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, libvir-list@redhat.com,
        mprivozn@redhat.com, yelu@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
Date:   Fri, 10 Jan 2020 18:06:33 +0800
Message-Id: <20200110100634.491936-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110100634.491936-1-pizhenwei@bytedance.com>
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit 1 for pvpanic. This bit means that guest hits a panic, but
guest wants to handle error by itself. Typical case: Linux guest runs
kdump in panic. It will help us to separate the abnormal reboot from
normal operation.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 docs/specs/pvpanic.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc778..bdea68a430 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
 recognized by the device are set. Software should ignore bits it doesn't
 recognize. On write, the bits not recognized by the device are ignored.
 Software should set only bits both itself and the device recognize.
-Currently, only bit 0 is recognized, setting it indicates a guest panic
-has happened.
+
+Bit Definition
+--------------
+bit 0: setting it indicates a guest panic has happened.
+bit 1: named crashloaded. setting it indicates a guest panic and run
+       kexec to handle error by guest itself.
 
 ACPI Interface
 --------------
-- 
2.11.0

