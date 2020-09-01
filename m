Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54863C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12650206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOE8ZZG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9DYqbM2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIAL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:57:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:48:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mu7ioO9Pn7GowyT0LUwR/VHW/c7mXGsEv+VPrBnihhI=;
        b=tOE8ZZG1QGK+aADUz9KNiOTEe3Ck51PWs51ru/zzf5ZzWnd/FdH/xJmmMuqurpZE8Q0K/Y
        DjItYiMU9SF06r/z9qPGzZsdQom6WjLs6BfQgh3AlpWLzqKAOk/CifgVka1G2tLkV1DzYB
        Dk1ao5GuoPRPAWxGM46CZv7K6q2A0o+vcinu6iVx/NW/85DP884KEaBecMd0W3Ae9r06oJ
        qQ7b0V9RmH72QYQQjFXreZlfiEWuqGbKOCdrQGvXva/BQuOmD0at3+cB+nS9OxC/lyKL8Y
        QhQDMhwWtU8dBS6fpfhLddRTbFCaQdCsZrLa9g1jMl2WfvL8NhaDGxh6BJeDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mu7ioO9Pn7GowyT0LUwR/VHW/c7mXGsEv+VPrBnihhI=;
        b=9DYqbM2+6kErZYaVq9CRmvkzUgKvd+BHHzbJJes7YvA3XLQkLdEjXIc7wb8XJcXgMmYa0Q
        gnmsC4YQGnlWquDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Handle tail-calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.101186767@infradead.org>
References: <20200818135805.101186767@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088374.20229.4926395571390516128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     5b06fd3bb9cdce4f3e731c48eb5b74c4acc47997
Gitweb:        https://git.kernel.org/tip/5b06fd3bb9cdce4f3e731c48eb5b74c4acc47997
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:06 +02:00

static_call: Handle tail-calls

GCC can turn our static_call(name)(args...) into a tail call, in which
case we get a JMP.d32 into the trampoline (which then does a further
tail-call).

Teach objtool to recognise and mark these in .static_call_sites and
adjust the code patching to deal with this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135805.101186767@infradead.org
---
 arch/x86/kernel/static_call.c           | 21 ++++++++++++++++++---
 include/linux/static_call.h             |  4 ++--
 include/linux/static_call_types.h       |  7 +++++++
 kernel/static_call.c                    | 21 +++++++++++++--------
 tools/include/linux/static_call_types.h |  7 +++++++
 tools/objtool/check.c                   | 18 +++++++++++++-----
 6 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ead6726..60a325c 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,15 +41,30 @@ static void __static_call_transform(void *insn, enum insn_type type, void *func)
 	text_poke_bp(insn, code, size, NULL);
 }
 
-void arch_static_call_transform(void *site, void *tramp, void *func)
+static inline enum insn_type __sc_insn(bool null, bool tail)
+{
+	/*
+	 * Encode the following table without branches:
+	 *
+	 *	tail	null	insn
+	 *	-----+-------+------
+	 *	  0  |   0   |  CALL
+	 *	  0  |   1   |  NOP
+	 *	  1  |   0   |  JMP
+	 *	  1  |   1   |  RET
+	 */
+	return 2*tail + null;
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, func ? JMP : RET, func);
+		__static_call_transform(tramp, __sc_insn(!func, true), func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, func ? CALL : NOP, func);
+		__static_call_transform(site, __sc_insn(!func, tail), func);
 
 	mutex_unlock(&text_mutex);
 }
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 0f74581..519bd66 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -103,7 +103,7 @@
 /*
  * Either @site or @tramp can be NULL.
  */
-extern void arch_static_call_transform(void *site, void *tramp, void *func);
+extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
@@ -206,7 +206,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	cpus_read_lock();
 	WRITE_ONCE(key->func, func);
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 	cpus_read_unlock();
 }
 
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 408d345..89135bb 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -17,6 +17,13 @@
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 97142cb..d98e0e4 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -15,8 +15,6 @@ extern struct static_call_site __start_static_call_sites[],
 
 static bool static_call_initialized;
 
-#define STATIC_CALL_INIT 1UL
-
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
 
@@ -39,18 +37,23 @@ static inline void *static_call_addr(struct static_call_site *site)
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
 	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+}
+
+static inline bool static_call_is_tail(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -104,7 +107,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 
 	key->func = func;
 
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 
 	/*
 	 * If uninitialized, we'll not update the callsites, but they still
@@ -154,7 +157,8 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 				continue;
 			}
 
-			arch_static_call_transform(site_addr, NULL, func);
+			arch_static_call_transform(site_addr, NULL, func,
+				static_call_is_tail(site));
 		}
 	}
 
@@ -198,7 +202,8 @@ static int __static_call_init(struct module *mod,
 			key->mods = site_mod;
 		}
 
-		arch_static_call_transform(site_addr, NULL, key->func);
+		arch_static_call_transform(site_addr, NULL, key->func,
+				static_call_is_tail(site));
 	}
 
 	return 0;
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 408d345..89135bb 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -17,6 +17,13 @@
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f8f7a40..75d0cd2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -516,7 +516,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		}
 		memset(reloc, 0, sizeof(*reloc));
 		reloc->sym = key_sym;
-		reloc->addend = 0;
+		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site) + 4;
 		reloc->sec = reloc_sec;
@@ -747,6 +747,10 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else {
 			/* external sibling call */
 			insn->call_dest = reloc->sym;
+			if (insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -798,6 +802,10 @@ static int add_jump_destinations(struct objtool_file *file)
 
 				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
+				if (insn->call_dest->static_call_tramp) {
+					list_add_tail(&insn->static_call_node,
+						      &file->static_call_list);
+				}
 			}
 		}
 	}
@@ -1684,6 +1692,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
@@ -1716,10 +1728,6 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_static_call_tramps(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
