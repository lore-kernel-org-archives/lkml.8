Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F3CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264CF2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgAaO1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:27:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:33544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgAaO1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:27:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6EC3EAB87;
        Fri, 31 Jan 2020 14:27:35 +0000 (UTC)
Date:   Fri, 31 Jan 2020 15:27:27 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200131142727.GB14851@zn.tnic>
References: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
 <20200130085134.GB6684@zn.tnic>
 <CAHk-=wje_k92K6j0-=HH4F5Jmr8Fv7vB-ANObqbQeGS_RsikWA@mail.gmail.com>
 <20200130173910.GK6684@zn.tnic>
 <CAHk-=wh9xdJzfcPU4e4diAZDtUJVg+SSocoYP+aVYWnDZd-UMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh9xdJzfcPU4e4diAZDtUJVg+SSocoYP+aVYWnDZd-UMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Josh.

On Thu, Jan 30, 2020 at 10:02:54AM -0800, Linus Torvalds wrote:
> Maybe with the exception that a short conditional jump inside the
> alternative code itself is fine.
> 
> Because a branch-over inside the alternative sequence (or a loop -
> think inline cmpxchg loop or whatever) would be fine, since it's
> unaffected by code placement.

Perhaps something like the below as a start.

The build becomes really noisy if the error case is hit because aborting
in handle_group_alt() really messes up objtool processing but that is
perhaps ok as the idea is to *see* that something's wrong.

---
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91c6d68..b4dfd625842d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -756,7 +771,9 @@ static int handle_group_alt(struct objtool_file *file,
 	last_new_insn = NULL;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
-		if (insn->offset >= special_alt->new_off + special_alt->new_len)
+		unsigned long new_offset = special_alt->new_off + special_alt->new_len;
+
+		if (insn->offset >= new_offset)
 			break;
 
 		last_new_insn = insn;
@@ -765,8 +787,12 @@ static int handle_group_alt(struct objtool_file *file,
 		insn->func = orig_insn->func;
 
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
-		    insn->type != INSN_JUMP_UNCONDITIONAL)
+		    insn->type != INSN_JUMP_UNCONDITIONAL) {
 			continue;
+		} else {
+			if (insn->offset > 0 && insn->offset + insn->len < new_offset)
+				ERROR("Subsequent JMP instructions are not alternatives-patched. Stopping.");
+		}
 
 		if (!insn->immediate)
 			continue;
diff --git a/tools/objtool/warn.h b/tools/objtool/warn.h
index cbb0a02b7480..652c7adc7650 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -40,6 +40,14 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	return str;
 }
 
+#define ERROR(format, ...)				\
+({							\
+	fprintf(stderr,					\
+		"%s: error: objtool: " format "\n",	\
+		objname, ##__VA_ARGS__);		\
+	abort();					\
+})
+
 #define WARN(format, ...)				\
 	fprintf(stderr,					\
 		"%s: warning: objtool: " format "\n",	\

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
