Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862262078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045252;
	bh=Jj+GGfDdlj3TRVPdVrSJJ8ezWc1W8N/aHDoly8TLtDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmwrYjEMUlqwFVaay1khQT21GKC1ApGbCbtGg6U06gRbihKeWZuPBsBBjEyXmLw7G
	 FyRyDVcQJjWB8FBMFCwH6nj9EqEM8L6A6ll6L/g1xNpFhTJI6Bz5B80meEOybbjV7m
	 cIiZFyNZS6DyRrb0hAs6t7lgEhH6D02XVMa7kv4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898624AbgDPNyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897469AbgDPNh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E64922201;
        Thu, 16 Apr 2020 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044247;
        bh=Jj+GGfDdlj3TRVPdVrSJJ8ezWc1W8N/aHDoly8TLtDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRVc2fPsDV+3qcXYS0p93sSRThWgwnI6PzEVcJD2PUkWBYnpLLkR2z1qwqszU0zcJ
         9qAio3gH4LtA/W2UdWRM/fC6dcOoIYnj0j3h3v9hLD/rbs5KcJz3Fi3JWpXdwChe4/
         A7vmFZNrG8M0OMQPkYp20UFIYvkeY3bvd2LTnpDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5.5 140/257] x86/entry/32: Add missing ASM_CLAC to general_protection entry
Date:   Thu, 16 Apr 2020 15:23:11 +0200
Message-Id: <20200416131343.933102371@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
@@ -1694,6 +1694,7 @@ SYM_CODE_START(int3)
 SYM_CODE_END(int3)
 
 SYM_CODE_START(general_protection)
+	ASM_CLAC
 	pushl	$do_general_protection
 	jmp	common_exception
 SYM_CODE_END(general_protection)


