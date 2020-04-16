Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD8C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C135421D82
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047043;
	bh=Jj+GGfDdlj3TRVPdVrSJJ8ezWc1W8N/aHDoly8TLtDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecddzkJlcPRrRIgxL9KpGBPL+3PYYcJ4aM6xdMxxivDF0tW5T4TM0z4Jm4BHkS9qU
	 r0CEKPnxPG+llf7QBfyIRwpOocCfuZL6bO6frMdm+VmN3oON6vK5Tzj7Op7ODMowcc
	 aMJgg9S1LH3afqIhEkTXkdceo3TZfOiQc32Ad9TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407681AbgDPOYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441850AbgDPN5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:57:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F6621744;
        Thu, 16 Apr 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045425;
        bh=Jj+GGfDdlj3TRVPdVrSJJ8ezWc1W8N/aHDoly8TLtDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSmVI604vlfeSvlUAGL6IP6pi2wI35K+G3eLn2I5l2HMU5KRjzicAt1WHTTRp5TZD
         R2E6jmXK97K8RASp+PTI1yLaQyLJBVysyBXZkHmP76JSWggfjnguKGQ7aKQSHACKr5
         DFCusWDzgj1NSCTz0C6OW4UlA1ER/g1irqNZQMwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5.6 128/254] x86/entry/32: Add missing ASM_CLAC to general_protection entry
Date:   Thu, 16 Apr 2020 15:23:37 +0200
Message-Id: <20200416131342.428037434@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
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


