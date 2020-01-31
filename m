Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84F0206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXmQhx/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgAaQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:05:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729030AbgAaQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580486725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEcomJdnQm9uhP4G2ZgarE3vlUkg2zA8b8LUNcIzUTk=;
        b=RXmQhx/+koGlGYRwbY7Yy1/WPsE1P0TlVawYrPkhbowAF1WpoK8N5PztAUJ0s4wJsKobJG
        xfddAuSWHgR/nX2p1nWwza3k6/tmirhnygQ4RvkKZUAXlpah1dzkEg2XHZv4iRreQ+6dNJ
        9iC76Y+xET7YuT3op8hiUb+9oG8JhGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-LDkNTTaAPBWaExkSeGk4lA-1; Fri, 31 Jan 2020 11:05:23 -0500
X-MC-Unique: LDkNTTaAPBWaExkSeGk4lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99394107ACCC;
        Fri, 31 Jan 2020 16:05:21 +0000 (UTC)
Received: from treble (ovpn-120-83.rdu2.redhat.com [10.10.120.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D095D9E5;
        Fri, 31 Jan 2020 16:05:19 +0000 (UTC)
Date:   Fri, 31 Jan 2020 10:05:18 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200131160518.ou6zadyo5qvkr2xd@treble>
References: <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
 <20200130085134.GB6684@zn.tnic>
 <CAHk-=wje_k92K6j0-=HH4F5Jmr8Fv7vB-ANObqbQeGS_RsikWA@mail.gmail.com>
 <20200130173910.GK6684@zn.tnic>
 <CAHk-=wh9xdJzfcPU4e4diAZDtUJVg+SSocoYP+aVYWnDZd-UMQ@mail.gmail.com>
 <20200131142727.GB14851@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200131142727.GB14851@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:27:27PM +0100, Borislav Petkov wrote:
> + Josh.
> 
> On Thu, Jan 30, 2020 at 10:02:54AM -0800, Linus Torvalds wrote:
> > Maybe with the exception that a short conditional jump inside the
> > alternative code itself is fine.
> > 
> > Because a branch-over inside the alternative sequence (or a loop -
> > think inline cmpxchg loop or whatever) would be fine, since it's
> > unaffected by code placement.
> 
> Perhaps something like the below as a start.
> 
> The build becomes really noisy if the error case is hit because aborting
> in handle_group_alt() really messes up objtool processing but that is
> perhaps ok as the idea is to *see* that something's wrong.

[ Adding Julien as an FYI -- not sure how it affects arm64 ]

Boris, I made the check even broader than we discussed on IRC: it
disallows *any* relocations in the alternatives section unless it's the
first instruction in the group and it's a call or a jmp.

Untested, let me know if it works.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413bcbd6..382a65363379 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -782,6 +782,20 @@ static int handle_group_alt(struct objtool_file *file,
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
 
+		/*
+		 * The x86 alternatives code adjusts relocation targets only in
+		 * the case where the first instruction is either a call or a
+		 * jump.  Otherwise, relocations aren't supported by the
+		 * alternatives code (as there hasn't yet been a need for it).
+		 */
+		if (!(insn->offset == special_alt->new_off &&
+		      (insn->type == INSN_CALL || insn->type == INSN_JUMP_UNCONDITIONAL)) &&
+		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
+			WARN_FUNC("relocations not allowed in alternatives section",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
@@ -2509,8 +2523,14 @@ int check(const char *_objname, bool orc)
 out:
 	cleanup(&file);
 
-	/* ignore warnings for now until we get all the code cleaned up */
-	if (ret || warnings)
-		return 0;
+	if (ret < 0) {
+		/*
+		 *  Fatal error.  The binary is corrupt or otherwise broken in
+		 *  some way, or objtool is badly broken.  Fail the kernel
+		 *  build.
+		 */
+		return ret;
+	}
+
 	return 0;
 }

