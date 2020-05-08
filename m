Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB64208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944221;
	bh=Imwsq8Dk+5IJzjZMSRQZFWn6/nsVrYk/2ds6zEGRW/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/HP78TrtZ+e+iGXel+VrPI4yftR4Hx/xyv/kvit41gnPfGjL1CTGRmRiVnncDOZy
	 mE9PQJiN8B4IQwYSqLiV+3rYMT8qmaPP3NAbZu9PPe1IOJhcBO2psWLQm++SxfOOaD
	 B40AyceEq6mXQyWvjCLqB5CUih+ZXYXdsVb+aZ9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgEHNXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEHMh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F7B221F7;
        Fri,  8 May 2020 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941476;
        bh=Imwsq8Dk+5IJzjZMSRQZFWn6/nsVrYk/2ds6zEGRW/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSTxxUJSRva6aONpln7Y54Spwo+ydpqENyU3X4aPJq/4JhC+WqBL6J/k+TzjQBsfK
         2efW3R+ypfCI/vKWvZ0ja1PyuOsT6MQLnynBoRArdcexHS71CfOBsx+RwSRV3nL+Bd
         +I3r2IwhqAtletrqvapuos5e6NXeQeoUwNN8HGaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Thorlton <athorlton@sgi.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Travis <travis@sgi.com>, Nathan Zimmer <nzimmer@sgi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 047/312] x86/apic/uv: Silence a shift wrapping warning
Date:   Fri,  8 May 2020 14:30:38 +0200
Message-Id: <20200508123127.863583911@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit c4597fd756836a5fb7900f2091797ab564390ad0 upstream.

'm_io' is stored in 6 bits so it's a number in the 0-63 range.  Static
analysis tools complain that 1 << 63 will wrap so I have changed it to
1ULL << m_io.

This code is over three years old so presumably the bug doesn't happen
very frequently in real life or someone would have complained by now.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Thorlton <athorlton@sgi.com>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Travis <travis@sgi.com>
Cc: Nathan Zimmer <nzimmer@sgi.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: b15cc4a12bed ("x86, uv, uv3: Update x2apic Support for SGI UV3")
Link: http://lkml.kernel.org/r/20161123221908.GA23997@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/x2apic_uv_x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -648,9 +648,9 @@ static __init void map_mmioh_high_uv3(in
 				l = li;
 			}
 			addr1 = (base << shift) +
-				f * (unsigned long)(1 << m_io);
+				f * (1ULL << m_io);
 			addr2 = (base << shift) +
-				(l + 1) * (unsigned long)(1 << m_io);
+				(l + 1) * (1ULL << m_io);
 			pr_info("UV: %s[%03d..%03d] NASID 0x%04x ADDR 0x%016lx - 0x%016lx\n",
 				id, fi, li, lnasid, addr1, addr2);
 			if (max_io < l)


