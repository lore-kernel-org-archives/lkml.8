Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F2EC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A379A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/PIKqNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgDWMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728390AbgDWMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:52:25 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28211C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0LPOq6kuy6O1K32QsrMgcnJ+qO6SmUMAmC4PPFEY/AA=; b=U/PIKqNoE0I7TewkuBPlrLDig4
        /i0IbshIA5wXUHWIZwZfu5mXgcKcDSG4G60MWBf6bc3/b7gegk+nycA3/24mV+SIpa1+mS/ZP9TXK
        /87aODiIrnK1FI7RUCO6kRCsDbT9gsLyS6DJbNmPuHET1YmgfPGWbOOd5tjMWruqqORqQXNTnDql4
        DXV+ZIdJArlLNOhpTelkxIapISAMljv8a3m1Gi9AtjxfVJmA1AdWDMWbf7zXrfI0fJFmF5vh6d+Fv
        hTbH0GqrfAfe6V6b/p0LSswKqBMn5GPhU4JfHVS1hd1FCnEiynXlOx0fgBNSLGdRAPD9v2e2jGPFJ
        7qAHVAfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbKi-0007S5-Qu; Thu, 23 Apr 2020 12:52:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4914E30477A;
        Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 355BA201420C4; Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Message-Id: <20200423125042.556416884@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 14:47:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH 1/8] objtool: is_fentry_call() crashes if call has no destination
References: <20200423125013.452964352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com
---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1490,7 +1490,7 @@ static int decode_sections(struct objtoo
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;


