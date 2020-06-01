Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E41FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84B3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzo7RFzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgFASqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgFASqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:46:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBFC03E96B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:46:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so563986wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WpZyj796ryAXOy5jG9QU2yR5Ej+vR4ZGFFVDCYg9LOs=;
        b=hzo7RFznw6P4fV7/+dxSJ16wEpI7L5zZ8rska4xe7o0vhife9k7JzwqaqQNwIJN+ZS
         9M/h57JJi3FKMApsvFEok8PAniX17hi76Op9oGATsgnFm3aIkng6gRUCasQVcsFJM9nh
         MNOzhFRNZoNGhI684Xoey38LdlBoex0yF4TNQML6+nKeFA2XvGhsloa8A/fykHf1nrKG
         SSslbeKRRvAqBt2mcRo/dyKcsqhpr97lj/6xXFNkvY9TV8koGH6pkAEHom6a8wdx9OJa
         9HclkizEh6jkU1qNr+kPUxuuW8BcX0hr8GtkyB2wkZbGU9T6Dl/5pjyRHcuzyPsnHDYt
         vHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpZyj796ryAXOy5jG9QU2yR5Ej+vR4ZGFFVDCYg9LOs=;
        b=fd5HneIzOBs3q3j3/+elv2h9qi6zROt7mq95MiYFMxam9btOU4e5JumgP2QL3axvRn
         Yk4SgPtfQept5KXVOmpuIblplPOxAISPzB4Hi5tjPbHsrOO6F53G+hhWPKsZYQob5KUY
         UWwLLgrnUCz6BM+BcOX9rW9apxP/W8K32zMnxnDusDpqrQKbc7kceaf0twf7QkLTYoWb
         edwqTxstiK2EZ8ZfjgH1wMoRoOPpBxSXYQg72KVga6pQac7v9grwAT+pPmMIIlqHFxhr
         9hZ45JxNfhib/xs6E4Svru7vj9WphJFl8hPD45SrIUX8nSd4YVFWQ263ijyCvOXMs7Sb
         NzBQ==
X-Gm-Message-State: AOAM533oDyVOm5sNwu5Z6m/Iq0V92dUnM67tqjl7SM51j55lVmuKmfeu
        szdYu5R8oCslhbqqsty1GDMN0FPz6++v
X-Google-Smtp-Source: ABdhPJwngaL14/ZqlySoQUEbCGnaaf4IUJq4TE71jfy5AXv8gmPfPoEjUPK4lc6mZMeheododQzFGQ==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr595760wmf.46.1591037174401;
        Mon, 01 Jun 2020 11:46:14 -0700 (PDT)
Received: from earth3.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.googlemail.com with ESMTPSA id 23sm302229wmg.10.2020.06.01.11.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:46:13 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/5] x86/ftrace: Add annotations for ftrace_arch_code_modify_prepare() and ftrace_arch_code_modify_post_process()
Date:   Mon,  1 Jun 2020 19:45:51 +0100
Message-Id: <20200601184552.23128-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200601184552.23128-1-jbi.octave@gmail.com>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings

warning: context imbalance in ftrace_arch_code_modify_prepare()
	- wrong count at exit
warning: context imbalance in ftrace_arch_code_modify_post_process()
	- wrong count at exit

The root cause is that even if
 the annotations on the function are correct,
mutex do not support annotation
This makes Sparse to complain.
To fix this,
__acquire(&text_mutex) and
 __release(&text_mutex) annotations are added
inside ftrace_arch_code_modify_prepare()
and ftrace_arch_code_modify_post_process()
respectively.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 37a0aeaf89e7..737c07ab2e07 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -46,6 +46,7 @@ int ftrace_arch_code_modify_prepare(void)
 	 * ftrace has it set to "read/write".
 	 */
 	mutex_lock(&text_mutex);
+	__acquire(&text_mutex);
 	ftrace_poke_late = 1;
 	return 0;
 }
@@ -61,6 +62,7 @@ int ftrace_arch_code_modify_post_process(void)
 	text_poke_finish();
 	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
+	__release(&text_mutex);
 	return 0;
 }
 
-- 
2.18.2

