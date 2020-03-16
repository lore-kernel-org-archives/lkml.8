Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA6C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9852074D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DVYsWyDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgCPQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:02:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbgCPQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:02:57 -0400
Received: from zn.tnic (p200300EC2F06AB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4A011EC0CD6;
        Mon, 16 Mar 2020 17:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584374575; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptJgasnrxloCG4yGG7+HyLV3y2hHUDJ/lNDTl67zOFQ=;
        b=DVYsWyDBgWlqpjBapVGAfJWq7eA1r6wX8jXn2mO0QnkObtK5ai2cLwYoDKFL/E3VXII9IH
        aA82RsSLSv/jXDo5ULmdKSz8OP4AEOy4+i8gGa697IMpD8lwZGwngEX9u31UGyjDskke5r
        m58QyUYAU1hYqFW3gJn6VYqtkAhYKVo=
Date:   Mon, 16 Mar 2020 17:02:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200316160259.GN26126@zn.tnic>
Reply-To: x@vger.kernel.org
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115122458.GB20975@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long overdue patch, see below.

Plan is to queue it after 5.7-rc1.

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 16 Mar 2020 16:28:36 +0100
Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23

The currently minimum-supported binutils version 2.21 has the problem of
promoting symbols which are defined outside of a section into absolute.
According to Arvind:

  binutils-2.21 and -2.22. An x86-64 defconfig will fail with
          Invalid absolute R_X86_64_32S relocation: _etext
  and after fixing that one, with
          Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve

Those two versions of binutils have a bug when it comes to handling
symbols defined outside of a section and binutils 2.23 has the proper
fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html

Therefore, up to the fixed version directly, skipping the broken ones.

Currently shipping distros already have the fixed binutils version so
there should be no breakage resulting from this.

For more details about the whole thing, see the thread in Link.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110202349.1881840-1-nivedita@alum.mit.edu
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index e47863575917..7a842655142c 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
-binutils               2.21             ld -v
+binutils               2.23             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
