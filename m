Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65197C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3416020738
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB2BHi2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCLRbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25210 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726676AbgCLRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqE4zS/LxR+EimcMQz0jtUe2ZYREIGioJp5hgp+aJLs=;
        b=RB2BHi2mSJKw3yQf2S1z+LNjlPt5bsTfwsxroLJTTATwrp4QV77bqNHB1RYAqbXRVfd7yQ
        ckKGXjLAfQBXmPEuJKJI6PQI9IcwlPLb6o3F+KfU0NOPu19G8iLMv6HOyFpK7jh0fJuO+F
        MElAiDCQqqRa7TBGlBqbmKc4XzC18n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-zQmvcaj7MRq5DZK7EeTa0Q-1; Thu, 12 Mar 2020 13:31:04 -0400
X-MC-Unique: zQmvcaj7MRq5DZK7EeTa0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CB458024FE;
        Thu, 12 Mar 2020 17:31:02 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D11E660BEC;
        Thu, 12 Mar 2020 17:31:00 +0000 (UTC)
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
Subject: [PATCH 07/14] x86/unwind/orc: Convert global variables to static
Date:   Thu, 12 Mar 2020 12:30:26 -0500
Message-Id: <63b5cab2e28b9c08854fc57f5b512a9ccf76ad95.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables aren't used outside of unwind_orc.c, make them static.

Also annotate some of them with '__ro_after_init', as applicable.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9cc182aa97e..64889da666f4 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -15,12 +15,12 @@ extern int __stop_orc_unwind_ip[];
 extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
=20
-static DEFINE_MUTEX(sort_mutex);
-int *cur_orc_ip_table =3D __start_orc_unwind_ip;
-struct orc_entry *cur_orc_table =3D __start_orc_unwind;
+static bool orc_init __ro_after_init;
+static unsigned int lookup_num_blocks __ro_after_init;
=20
-unsigned int lookup_num_blocks;
-bool orc_init;
+static DEFINE_MUTEX(sort_mutex);
+static int *cur_orc_ip_table =3D __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table =3D __start_orc_unwind;
=20
 static inline unsigned long orc_ip(const int *ip)
 {
--=20
2.21.1

