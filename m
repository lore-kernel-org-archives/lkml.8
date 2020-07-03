Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6535C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8151720BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFKe6gk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGCVbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgGCVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:31:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54D5C061794;
        Fri,  3 Jul 2020 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/fO4/hmFMoiOQP8iLdETcl2Byk5DH3S8KLS6LllNdIE=; b=KFKe6gk8nMAYfLG3p8luz75F6C
        IH/ChQIEyUYCLyOUCwG9EY32zuhkOoWeI0JPCsq6HAy9oRdlDDYufg2A8BmFu+JNX5ZGIVBcSlYl3
        c24QpWI+ynFfvdJp3k2pWYNEKTetOw+Q+qoSg5NurRdu+ulVotIyPEAl9rWctB5+ZOO1UdH0x6TBZ
        sbZTyMKa8RKX1dWp3WjxpGcodappkEqIcR7dYNig8qGsjPhr541U7bQ6HMGKS18BGMhXxha4dh3vB
        gEKCYGpmFr1AD3BOcFMS38JlBrN+L2NHEGSK6jgyb2neWkRD4V9C8dl+BHRIhd8eBy0VIFiO/YLwL
        bxZtKnZQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTHA-0006Rx-Jz; Fri, 03 Jul 2020 21:31:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] Documentation: x86: earlyprintk: drop doubled words
Date:   Fri,  3 Jul 2020 14:31:06 -0700
Message-Id: <20200703213107.30758-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213107.30758-1-rdunlap@infradead.org>
References: <20200703213107.30758-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 Documentation/x86/earlyprintk.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/x86/earlyprintk.rst
+++ linux-next-20200701/Documentation/x86/earlyprintk.rst
@@ -8,7 +8,7 @@ Mini-HOWTO for using the earlyprintk=dbg
 USB2 Debug port key and a debug cable, on x86 systems.
 
 You need two computers, the 'USB debug key' special gadget and
-and two USB cables, connected like this::
+two USB cables, connected like this::
 
   [host/target] <-------> [USB debug key] <-------> [client/console]
 
