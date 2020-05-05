Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E13C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230B3207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fkWDJP1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgEEPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbgEEPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:45:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D775C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:45:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q7so2764383qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WENNWj1ilE/s6sjTVfLYURVMvEjy8DNjQO3IRhPKbwM=;
        b=fkWDJP1jacFRz7YWV0+ueBQGqTgxAU2InbrfW9H8wK3DlOnGgc6JwiJ7ZV8m+VgnTI
         Sx1E77KXnqJqkNK2MpzkqmdGuHYRSU3bb9mdRfelU7uOTMwlCMNIlgujakO7Rznd4rX1
         5a9p9DH+hzQrTmqlhSH4uPiHDgPwfbsGL/gec9u8tRxh8Lx+m3bX757G3KCS5YJnKDwk
         0J7qPSSc8WJw9SR49ffv9Na3vRSL39jBpARdxJOwfqj0WpcTrXXUxYyEMhtgIAaQtioB
         KvxWy0FXRSkIx1wYMhkPvYMCMB49FaihY7hjk30PETikKcR8ZoFiLSJYgloCZXb9hc+4
         TTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WENNWj1ilE/s6sjTVfLYURVMvEjy8DNjQO3IRhPKbwM=;
        b=foXzB7HtcT9+njUYGKNYEm8xk452xq7+DUuzQBHomzltp9uorIaOAPh4kPc/aHgcY1
         xhQ3801R+tNpHiTSACTc4OqmQcuno/usMRyYIyt4dd27/4Xvgj2AgOAyPpQYgxNyKdVm
         SCePfcyQyxxPlQ+TP6Fim10xWarbpMAKzZKAN7A7V63yfoYnuMCz2z12bpeCAqMt+Fit
         IgVcE2KyJ8TJ9q9B5UMU51qyYI9i5Knu4jJrx3FNR6+LQ+YvHjpk/xA5StcMXUIaRN6Y
         tby+3TfHEg3IdG9x2iUZJ2M/Z79Fyxit/glvqKOK04jM0VzjbeZpqefbEyunPWSbDe2u
         qh4g==
X-Gm-Message-State: AGi0Pub+cPep2h06aTUTWLwBjbjoPidmIs8/RJ47jHRNPxwNwVQXCnUt
        Mkgu/pNJAVEfwCJlqjA8J9125A==
X-Google-Smtp-Source: APiQypLY8f70x1GWXd4kilpdfqPTwR5Br126dbhXR6Twlcb2nKB75CR0gJ+IenUk06DOdY7ESkgZtQ==
X-Received: by 2002:a05:620a:49e:: with SMTP id 30mr3965253qkr.294.1588693520486;
        Tue, 05 May 2020 08:45:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x7sm2122407qkx.36.2020.05.05.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:45:19 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] ramoops: add max_reason optional field to ramoops DT node
Date:   Tue,  5 May 2020 11:45:10 -0400
Message-Id: <20200505154510.93506-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505154510.93506-1-pasha.tatashin@soleen.com>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it is possible to dump kmsges for panic, or oops.
With max_reason it is possible to dump messages for other
kmesg_dump events, for example reboot, halt, shutdown, kexec.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index 0eba562fe5c6..886cff15d822 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -30,7 +30,7 @@ Optional properties:
 - ecc-size: enables ECC support and specifies ECC buffer size in bytes
   (defaults to 0: no ECC)
 
-- record-size: maximum size in bytes of each dump done on oops/panic
+- record-size: maximum size in bytes of each kmsg dump.
   (defaults to 0: disabled)
 
 - console-size: size in bytes of log buffer reserved for kernel messages
@@ -45,7 +45,13 @@ Optional properties:
 - unbuffered: if present, use unbuffered mappings to map the reserved region
   (defaults to buffered mappings)
 
-- no-dump-oops: if present, only dump panics (defaults to panics and oops)
+- max_reason: maximum reason for kmsg dump. Defaults to 2 (dump oops and
+  panics). Can be set to INT_MAX to dump for all reasons. See
+  include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump values.
+
+- no-dump-oops: deprecated, use max_reason instead.
+  if present, and max_reason is not specified is equivalent to
+  max_reason = 1 (KMSG_DUMP_PANIC).
 
 - flags: if present, pass ramoops behavioral flags (defaults to 0,
   see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
-- 
2.25.1

