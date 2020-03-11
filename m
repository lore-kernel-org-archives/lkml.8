Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC1C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9096206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPPdLR3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgCKVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:46:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbgCKVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JWWrLpMPfuXSLxuL+fBzfMQH6uO+44dWeHXReAxO5I=;
        b=MPPdLR3PfRfMtBWNAImxhUu0IcAEOB2ogJOnOixzbUbgTlAxfEjv5tgTEFhZe92AqiqumJ
        UH46sQMrm6t1D2dYT77ptPnsEGKLjuVbCAAIwKRGgyn539ct3kPIJGvAbp67GceM0r8+yH
        oBch1qz2j5KRJGLdH+zjtiWqri0DMPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-mPfppP5iNCeyNw-8P1U3iw-1; Wed, 11 Mar 2020 17:46:07 -0400
X-MC-Unique: mPfppP5iNCeyNw-8P1U3iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAA81005510;
        Wed, 11 Mar 2020 21:46:06 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F46591D63;
        Wed, 11 Mar 2020 21:46:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] x86/purgatory: Fix missing ftrace_likely_update symbol
Date:   Wed, 11 Mar 2020 22:46:00 +0100
Message-Id: <20200311214601.18141-2-hdegoede@redhat.com>
In-Reply-To: <20200311214601.18141-1-hdegoede@redhat.com>
References: <20200311214601.18141-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the purgatory code having a (silent, not reported) missing
symbol reference to ftrace_likely_update when CONFIG_TRACE_BRANCH_PROFILI=
NG
is enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-This is a new patch in v4 of this series
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..c1bd85d6392d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -25,7 +25,7 @@ KCOV_INSTRUMENT :=3D n
=20
 PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
 PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding -fno-zero-initiali=
zed-in-bss
-PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN)
+PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
=20
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. =
That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and=
 not
--=20
2.25.1

