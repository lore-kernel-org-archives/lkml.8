Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D285AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F1120801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDJTzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:55:04 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:34314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgDJTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:55:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 09712182CCCD1;
        Fri, 10 Apr 2020 19:55:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest74_490bbefb0e62d
X-Filterd-Recvd-Size: 3039
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 19:55:01 +0000 (UTC)
Message-ID: <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 10 Apr 2020 12:53:00 -0700
In-Reply-To: <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
         <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-10 at 12:46 -0700, Joe Perches wrote:
> On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
> > Le 08/04/2020 à 04:14, Joe Perches a écrit :
> > > This works rather better:
> > > Perhaps you could test?
> []
> > I'm looking at some modification done in the last month that could have 
> > been spotted by the above script.
> > 
> >      ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
> > 
> > correctly spots the 3 first cases, but the 3 last (line 202, 210 and 
> > 217) are missed.
> > I don't understand why.
> 
> It has to do with checkpatch's single statement parsing.
> 
> This case:
> 
> 	if (foo)
> 		dev_warn(...);
> 
> is parsed as a single statement but
> 
> 	if (foo) {
> 		dev_warn(...);
> 	};
> 
> is parsed as multiple statements so for the
> second case
> 
> 		dev_warn(...);
> 
> is analyzed as a separate statement.
> 
> The regex match for this missing newline test expects
> that each printk is a separate statement so the first
> case doesn't match.
> 
> Clearly the regex can be improved here.

So on top of the original patch:
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f00a6c8..54eaa7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5675,8 +5675,8 @@ sub process {
 
 # check for possible missing newlines at the end of common logging functions
 		if (defined($stat) &&
-		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
-		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
+		    $stat =~ /^\+\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
+		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
 			my $cnt = statement_rawlines($stat);
 			my $extracted_string = "";
 			for (my $i = 0; $i < $cnt; $i++) {


