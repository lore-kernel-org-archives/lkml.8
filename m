Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCE720890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xMIOMhfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgGCVbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGCVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:31:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9084C061794;
        Fri,  3 Jul 2020 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=J3kyirEKv+fVXi6BKVKxdVL5gJBG/uLnw5IK1dy98z0=; b=xMIOMhfEPWCaNDcVy9h8Hkpfxu
        J3mYESCsSIpk7MCQ1JjL0g1uv0TPJcMxba8bbszQqZUB2ZQZGssrCbBy3+OZ+8yHNOFifwvPFTtwg
        fpNbtkwB3HF6s5h56XckaksNC8Ft1+roX0P1IMAxRPS8CxYoMqL8hwbrVX75nr1iFuGRNo3porMQ2
        yFRnmMRG+Z6LH/TfKPMiqZTXhLTYa3eg2MXzQh9h998n/XpmjQZYApku3w/OKKImVtUCAvbMjf5SU
        pIdgn1mQdQLaC3TkjVAqmxfjL6ZE14oKhZOMCe/clBhB1iGt+fAzT9o0/R3Qbb2lwRaGEuDmwvS44
        nj1IxP2A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTHD-0006Rx-QV; Fri, 03 Jul 2020 21:31:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] Documentation: x86: machinecheck: drop doubled words
Date:   Fri,  3 Jul 2020 14:31:07 -0700
Message-Id: <20200703213107.30758-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213107.30758-1-rdunlap@infradead.org>
References: <20200703213107.30758-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "see".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 Documentation/x86/x86_64/machinecheck.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/x86/x86_64/machinecheck.rst
+++ linux-next-20200701/Documentation/x86/x86_64/machinecheck.rst
@@ -81,5 +81,5 @@ TBD document entries for AMD threshold i
 For more details about the x86 machine check architecture
 see the Intel and AMD architecture manuals from their developer websites.
 
-For more details about the architecture see
+For more details about the architecture
 see http://one.firstfloor.org/~andi/mce.pdf
