Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8508BC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C7921D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xgsTOpMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634383AbgDPLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633963AbgDPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32829C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bgFMFAg40dNYVQqI8LTEoS+YHN0f3ekwso2Cq3yrjFw=; b=xgsTOpMRZAvGsSBFraJsfGW0FS
        KqHbs3/UOt1IONYdIEOP9hkj+wKaN8Qzim2GbhrTRm5cEcMseGCvi4ZPJOP9+1OwkvBEfoRF5W9Kg
        iIOQyd5vulwEFpa6aTAog4fUWAODKYyRyIJxVjX1z05Qt8poB7vqV6+H3g2m1FiVQsmYixfsQN0p/
        vkm2V+vVVRZtQBVkgUFnWZlPe0AU0/uXeAiXhNeQmB+AcZK8n/JZNDyfq+aB8mQLFynu2VnSnsIj5
        65wU7psfkXDN+5S7PNx3PPLHnE4ZPBktXaYlQoHpgWWDSa4lxTd/ynsH6zPiV4SuYQM3CdVJc3gKV
        htkFWQlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34G-0006jd-PC; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E9E3307890;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57D022B0DE4C4; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.346582716@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 14/17] objtool: Avoid iterating !text section symbols
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_functions() iterates all sections their symbols; this is
pointless to do for !text sections as they won't have instructions
anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2621,8 +2621,12 @@ static int validate_functions(struct obj
 	struct section *sec;
 	int warnings = 0;
 
-	for_each_sec(file, sec)
+	for_each_sec(file, sec) {
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
 		warnings += validate_section(file, sec);
+	}
 
 	return warnings;
 }


