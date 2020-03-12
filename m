Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EAC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB3F206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU5lFMF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCLRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60216 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgCLRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmbFDh1nLx6DN6vwuRgIFrbjI6/U3p21MibXGchguxc=;
        b=VU5lFMF7VoOLhN/YTmV26n1b5dAirp9jeSdHhyGCEbzdFuhb3cV2JV5tlrXHR2QfnrU2Gv
        3RtVpTuyjW/zlJ5MExDK1AOFjWM2Q59aSb/+9Rh5GM+N8pD3Rd+vmYsX6q7WRbbs9hI88t
        13JwQfw7iCC6B4Cx1/xqj9Jg1GuaM30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-EV0Jz1RyMwK2ZfM6rvlAXA-1; Thu, 12 Mar 2020 13:31:09 -0400
X-MC-Unique: EV0Jz1RyMwK2ZfM6rvlAXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741BE10BEC32;
        Thu, 12 Mar 2020 17:31:07 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4089260BEC;
        Thu, 12 Mar 2020 17:31:06 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/14] x86/unwind/orc: Fix error path for bad ORC entry type
Date:   Thu, 12 Mar 2020 12:30:30 -0500
Message-Id: <ee453efaa7b1149545d5bb6600320ead3aa8259b.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ORC entry type is unknown, nothing else can be done other than
reporting an error.  Exit the function instead of breaking out of the
switch statement.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index cb11567361cc..33b80a7f998f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -537,7 +537,7 @@ bool unwind_next_frame(struct unwind_state *state)
 	default:
 		orc_warn("unknown .orc_unwind entry type %d at %pB\n",
 			 orc->type, (void *)orig_ip);
-		break;
+		goto err;
 	}
=20
 	/* Find BP: */
--=20
2.21.1

