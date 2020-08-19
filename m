Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6504FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BFC20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHSXH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:07:27 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:45566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726209AbgHSXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:07:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9A0AF181D3030;
        Wed, 19 Aug 2020 23:07:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: veil80_52063782702b
X-Filterd-Recvd-Size: 2464
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 23:07:24 +0000 (UTC)
Message-ID: <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
Subject: coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        cocci <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Date:   Wed, 19 Aug 2020 16:07:23 -0700
In-Reply-To: <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
         <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 14:22 -0700, Joe Perches wrote:
> There are commas used as statement terminations that should typically
> have used semicolons instead.  Only direct assignments or use of a single
> function or value on a single line are detected by this test.
> 
> e.g.:
> 	foo = bar(),		/* typical use is semicolon not comma */
> 	bar = baz();
> 
> Add an imperfect test to detect these comma uses.
> 
> No false positives were found in testing, but many types of false negatives
> are possible.
> 
> e.g.:
> 	foo = bar() + 1,	/* comma use, but not direct assignment */
> 	bar = baz();

Hi.

I recently added a test for this condition to linux's checkpatch.

A similar coccinelle script might be:

$ cat comma.cocci
@@
expression e1;
expression e2;
@@

	e1
-	,
+	;
	e2;
$

This works reasonably well but it has several false positives
for declarations like:

$ spatch --sp-file comma.cocci mm/huge_memory.c
diff -u -p a/huge_memory.c b/huge_memory.c
--- a/huge_memory.c
+++ b/huge_memory.c
@@ -2778,7 +2778,7 @@ static unsigned long deferred_split_scan
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list), *pos, *next;
+	LIST_HEAD(list), *pos; *next;
 	struct page *page;
 	int split = 0;
$

Any script improvement suggestions?


