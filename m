Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D93C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7BE206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfKcDMyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGWUyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:54:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C7C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:54:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7so5678326ybl.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kdI8VUHfhgihOmQy3Iyr0hZYwpxzmdhJFeUTHTnZFGA=;
        b=nfKcDMyPVy6NhFDMWTrUuajEjaivWMTHnhcCslK0roB8C/wpec1UXvKA8nvv5E/g2I
         Ik52Is34VC3xAIW94icyp0k1pP7F6+0P2OM0YV7shMnYAxZoXpjspjteyNJUsMfCjG9E
         rRPLBUMOeWUkBIt+EGUOeuIfMmZU0vJpvRckH5UjnoRjR2Fmq6/sOhBpNc7gF9ajXqg5
         gIGmeZknjvxOY20tTtMclA22ysTEPGwbNJj+oIllnH0+fI4qBYHM17bVfjww/SjkerM8
         3Yc+27PwSUy03KTNEAfsBngMdZjz3RDAmOYqVi+N2qAAengHadOy/te6Y69tyNhgPvvT
         rVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kdI8VUHfhgihOmQy3Iyr0hZYwpxzmdhJFeUTHTnZFGA=;
        b=W3/urMiSdOQpnk/vSzIt4aAMtplPlBPVpWHD8s2Ie6hAWsSGpsdcuaFUHtwloTPNY4
         0g19mD7MfmsswH+Yy+hSt6YtaOddXro3kbO8OkuIBQTm/ihFc9BCf3i/J963d7AAwQup
         +80AN62kTXcKJrMoEGQ9EmDIem0X+hqxFwVmJCrhvZQuKB1MGks3duzGNP775rsdcBf3
         XSNFrrGZJ/+gXo27V3//vwx52TpOlQHZEjsaRFSrfls608s/PuYgXocvPUlBdhOUaKPR
         YSS+pbff+7fQ97M/lhYsCQkWrxdRdoUANosAIuv3mUMlEGurvk3+ajidBbF+HKoMGBZq
         2CcQ==
X-Gm-Message-State: AOAM531+3gXnUGQE4/n4JAjlzGN7mLT/rToOHSSUKG4YnIbj1fEg6coz
        OxVivPck/IUAKMVSLuL7o1VkvKAaz8B94PNcKwc=
X-Google-Smtp-Source: ABdhPJzTomNZmxQkDKDUaOgi6iM6xnjutxLFdDnNFS0z2K8+f1arYg36P6fZg+r/T6x0QA8VvBHLCOUnJXhbuCSovlE=
X-Received: by 2002:a25:4c45:: with SMTP id z66mr9855584yba.175.1595537646880;
 Thu, 23 Jul 2020 13:54:06 -0700 (PDT)
Date:   Thu, 23 Jul 2020 13:53:41 -0700
In-Reply-To: <20200723205341.1099742-1-ndesaulniers@google.com>
Message-Id: <20200723205341.1099742-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200723205341.1099742-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/2] tracepoint: used attribute definitions from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small cleanup while I was touching this header.
compiler_attributes.h does feature detection of these __attributes__(())
and provides more concise ways to invoke them.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/tracepoint.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 3a5b717d92e8..598fec9f9dbf 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -116,8 +116,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __TRACEPOINT_ENTRY(name)					 \
 	static tracepoint_ptr_t __tracepoint_ptr_##name __used		 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name
+	__section(__tracepoints_ptrs) = &__tracepoint_##name
 #endif
 
 #endif /* _LINUX_TRACEPOINT_H */
@@ -280,9 +279,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define DEFINE_TRACE_FN(name, reg, unreg)				 \
 	static const char __tpstrtab_##name[]				 \
-	__attribute__((section("__tracepoints_strings"))) = #name;	 \
-	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"), used)) =		 \
+	__section(__tracepoints_strings) = #name;			 \
+	struct tracepoint __tracepoint_##name __used			 \
+	__section(__tracepoints) =					 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
 	__TRACEPOINT_ENTRY(name);
 
@@ -361,7 +360,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
-#define __tracepoint_string	__attribute__((section("__tracepoint_str"), used))
+#define __tracepoint_string	__used __section(__tracepoint_str)
 #else
 /*
  * tracepoint_string() is used to save the string address for userspace
-- 
2.28.0.rc0.105.gf9edc3c819-goog

