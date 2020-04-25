Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78948C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557E320714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEx2UJrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDYKDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26736 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726138AbgDYKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6Ig2eppmsbO17FXR49uSOjWUJZ37OfJgqKcCxWCa84=;
        b=jEx2UJrZtYF+xhtsH8uDc4xWtcrdz05JtdiSSRijTN9daasCeBUCeHC2rrHjMzKmWjWzJr
        lwRDXp1yb0UuzKu2UWT7W9EH27P0GgUDObibbQ8yNoRXah+IiJT2f487VKgSO3WbSaCFGa
        0kG0pMufaOyud9N06FFmptkFLTDQFTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-0URwTm21MWC7NzV9_DyFRg-1; Sat, 25 Apr 2020 06:03:29 -0400
X-MC-Unique: 0URwTm21MWC7NzV9_DyFRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ACB680B70B;
        Sat, 25 Apr 2020 10:03:28 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFAFF60627;
        Sat, 25 Apr 2020 10:03:26 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to static
Date:   Sat, 25 Apr 2020 05:03:05 -0500
Message-Id: <43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables aren't used outside of unwind_orc.c, make them static.

Also annotate some of them with '__ro_after_init', as applicable.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
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

