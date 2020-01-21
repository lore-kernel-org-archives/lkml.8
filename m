Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9BEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD5217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdr6xS9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgAUQDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:03:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729504AbgAUQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579622583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R93kv0W0ESiBmPn+Fcdbi6eCG8MLqbjSKamhdoxhulg=;
        b=Tdr6xS9f8G0CbYZX9ciRlmIeVf+jNQNQynchgMPpyfk6/hporBnwBWbVhbzXxe/fXGHrlx
        zSh9OMLk2UW9+KzWMu5/b1H47VbyANavjCpDFjlp7gzdxReYgrETntjRAXFWagOmateigw
        5ZknbEvF+GB2ilpC5z7pK5TiHT9/1SA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-_gcyxaBqO327POIqDM-lJA-1; Tue, 21 Jan 2020 11:03:01 -0500
X-MC-Unique: _gcyxaBqO327POIqDM-lJA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1502868wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R93kv0W0ESiBmPn+Fcdbi6eCG8MLqbjSKamhdoxhulg=;
        b=b6wv43b204dQD6FQh2UkQ/fvjB9u7BtDAMTiE7/9OFXeVYhd7SqTcIhijJstkQaw/1
         CHR0mccHVSbUHCn8ZPGSXBnwcGFEjhaDizWgaiS1mYE372e9TyUyr561BsZT9p708z2t
         7cLsBeaDdcv+CV7hcbH4Pr/sSW+8joFjCBvjEc8QbqjgsRI1tXQt6kdKS/Tbe0Q4pOti
         2nN8vYzCTJMKIE8Zax3dBABJInuoldROGopM6IU1SNWZws28RXx7QHnVLO2yZrXP6BQ6
         d86gzz4G/0McOGXha1iYiY/mtFvxnqVl4aK1n9gHhe8NGBSJ5KYjh10CQHbAWppLvxXE
         yFQg==
X-Gm-Message-State: APjAAAVra3lj7yqylkYAGuOmBLKvGgOimEjUtpVWhaLgjIkGCW64ePyd
        /PkhpWxujt0JX4X0P6ms2Bsd5/VCdzAqPNay3mGmQ8ihigHqIX2FKWUsJChaY7DtpOv7/YsKmZE
        50Gnm4OZ73AayUPWGO0ArUaiI
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr5729610wro.375.1579622580562;
        Tue, 21 Jan 2020 08:03:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMHt2H+ShpdzeVhVrpHI6paJyzrz7FPhvqP5WICGqAsGn0xpsokZgxOLpYQcmGqfYCMCMYHQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr5729584wro.375.1579622580321;
        Tue, 21 Jan 2020 08:03:00 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c4sm4349792wml.7.2020.01.21.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:02:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC] x86/speculation: Clarify Spectre-v2 mitigation when STIBP/IBPB features are unsupported
Date:   Tue, 21 Jan 2020 17:02:57 +0100
Message-Id: <20200121160257.302999-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When STIBP/IBPB features are not supported (no microcode update,
AWS/Azure/... instances deliberately hiding SPEC_CTRL for performance
reasons,...) /sys/devices/system/cpu/vulnerabilities/spectre_v2 looks like

  Mitigation: Full generic retpoline, STIBP: disabled, RSB filling

and this looks imperfect. In particular, STIBP is 'disabled' and 'IBPB'
is not mentioned while both features are just not supported. Also, for
STIBP the 'disabled' state (SPECTRE_V2_USER_NONE) can represent both
the absence of hardware support and deliberate user's choice
(spectre_v2_user=off)

Make the following adjustments:
- Output 'unsupported' for both STIBP/IBPB when there's no support in
  hardware.
- Output 'unneeded' for STIBP when SMT is disabled/missing (and this
  switch_to_cond_stibp is off).

RFC. Some tools out there may be looking at this information so by
changing the output we're breaking them. Also, it may make sense to
separate kernel and userspace protections and switch to something like

  Mitigation: Kernel: Full generic retpoline, RSB filling; Userspace:
   Vulnerable

for the above mentioned case.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 3 +++
 arch/x86/kernel/cpu/bugs.c                    | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index e05e581af5cf..2b8a42d0c57b 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -385,6 +385,7 @@ The possible values in this file are:
     an x86 only feature. For more details see below.
 
   ===================   ========================================================
+  'IBPB: unsupported'   IBPB is not supported by hardware
   'IBPB: disabled'      IBPB unused
   'IBPB: always-on'     Use IBPB on all tasks
   'IBPB: conditional'   Use IBPB on SECCOMP or indirect branch restricted tasks
@@ -396,6 +397,8 @@ The possible values in this file are:
     only feature. For more details see below.
 
   ====================  ========================================================
+  'STIBP: unsupported'  STIBP is not supported by hardware
+  'STIBP: unneeded'     STIBP is not needed because SMT is disabled
   'STIBP: disabled'     STIBP unused
   'STIBP: forced'       Use STIBP on all tasks
   'STIBP: conditional'  Use STIBP on SECCOMP or indirect branch restricted tasks
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8bf64899f56a..d72a36fe042b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1496,7 +1496,10 @@ static char *stibp_state(void)
 
 	switch (spectre_v2_user) {
 	case SPECTRE_V2_USER_NONE:
-		return ", STIBP: disabled";
+		if (boot_cpu_has(X86_FEATURE_STIBP))
+			return ", STIBP: disabled";
+		else
+			return ", STIBP: unsupported";
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_STRICT_PREFERRED:
@@ -1505,6 +1508,8 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))
 			return ", STIBP: conditional";
+		else
+			return ", STIBP: unneeded";
 	}
 	return "";
 }
@@ -1518,7 +1523,7 @@ static char *ibpb_state(void)
 			return ", IBPB: conditional";
 		return ", IBPB: disabled";
 	}
-	return "";
+	return ", IBPB: unsupported";
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
-- 
2.24.1

