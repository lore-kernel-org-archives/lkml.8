Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B3C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C67B2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552704;
	bh=6YdfaL9CanGjWMKoi0iYRi2rB7H361ZUREXJglOHwNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ac99CgdVYQhBY2jgUV3vl7xWmJXXJL5y5wrR/2qtqW8h7RJ4qHXZNowt38jZgk6CL
	 LVMY1skmpcelOMxRgakfpfGYY/l5paokOk9mL0uFTYIhZ/gpNt8cdIj69zsHk1DWiX
	 1QcPiCVDUJ0mUrQHCoIeIP625btkEbcezm7l5+/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgDVKvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgDVKK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7542070B;
        Wed, 22 Apr 2020 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550258;
        bh=6YdfaL9CanGjWMKoi0iYRi2rB7H361ZUREXJglOHwNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iL7CfYKoEydFkzTlpKMacumG2h6tSTelTtfvLn37jKlrWVre6j/XEB64JfHDDwBPr
         G/s8rVc7f1d5y1SxPOLlKJHSU7T8DWdb0mOR0G5+HOGHh2l6Lhx8cZ7CofB05MzhP2
         NYwGTgWiVDuzQoWlem/R1WG3UGrutzuLJAkkt2EM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4.14 056/199] x86/entry/32: Add missing ASM_CLAC to general_protection entry
Date:   Wed, 22 Apr 2020 11:56:22 +0200
Message-Id: <20200422095103.870602810@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 3d51507f29f2153a658df4a0674ec5b592b62085 upstream.

All exception entry points must have ASM_CLAC right at the
beginning. The general_protection entry is missing one.

Fixes: e59d1b0a2419 ("x86-32, smap: Add STAC/CLAC instructions to 32-bit kernel entry")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200225220216.219537887@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_32.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1057,6 +1057,7 @@ ENTRY(int3)
 END(int3)
 
 ENTRY(general_protection)
+	ASM_CLAC
 	pushl	$do_general_protection
 	jmp	common_exception
 END(general_protection)


