Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D67C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694F8207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBISZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 13:25:33 -0500
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:49147 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727761AbgBISZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 13:25:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 39301181D3026;
        Sun,  9 Feb 2020 18:25:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: death76_6a32f430d9727
X-Filterd-Recvd-Size: 5793
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Feb 2020 18:25:29 +0000 (UTC)
Message-ID: <3f8a8a2f89bfd2d4cca9ac176ef41abf3a0ed4ab.camel@perches.com>
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        sean.j.christopherson@intel.com
Date:   Sun, 09 Feb 2020 10:24:15 -0800
In-Reply-To: <20200207123334.GT14946@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 13:33 +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 01:30:35PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 07, 2020 at 01:11:54PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Feb 7, 2020 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Fri, Feb 07, 2020 at 11:56:40AM +0100, Geert Uytterhoeven wrote:
> > > > > WARNING: Missing Signed-off-by: line by nominal patch author 'Peter
> > > > > Zijlstra <peterz@infradead.org>'
> > > > > (in all patches)
> > > > > 
> > > > > I can fix that (the From?) up while applying.
> > > > 
> > > > I'm not sure where that warning comes from, but if you feel it needs
> > > > fixing, sure. I normally only add the (Intel) thing to the SoB. I've so
> > > > far never had complaints about that.
> > > 
> > > Checkpatch doesn't like this.
> > 
> > Ooh, I see, that's a relatively new warning, pretty daft if you ask me.
> > 
> > Now I have to rediscover how I went about teaching checkpatch to STFU ;-)
> > 
> > Joe, should that '$email eq $author' not ignore rfc822 comments? That
> 
> Argh, that's me hitting on the wrong 'nominal' in checkpatch.pl, same
> difference though.
> 
> > is:
> > 
> > 	Peter Zijlstra <peterz@infradead.org>
> > 
> > and:
> > 
> > 	Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > are, in actual fact, the same.

Maybe this?
---
 scripts/checkpatch.pl | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f3b8434..17637d0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1132,6 +1132,7 @@ sub parse_email {
 	my ($formatted_email) = @_;
 
 	my $name = "";
+	my $name_comment = "";
 	my $address = "";
 	my $comment = "";
 
@@ -1164,6 +1165,10 @@ sub parse_email {
 
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
+	$name =~ s/(\s*\([^\)]+\))\s*//;
+	if (defined($1)) {
+		$name_comment = trim($1);
+	}
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
 
@@ -1172,7 +1177,7 @@ sub parse_email {
 		$name = "\"$name\"";
 	}
 
-	return ($name, $address, $comment);
+	return ($name, $name_comment, $address, $comment);
 }
 
 sub format_email {
@@ -1198,6 +1203,23 @@ sub format_email {
 	return $formatted_email;
 }
 
+sub reformat_email {
+	my ($email) = @_;
+
+	my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
+	return format_email($email_name, $email_address);
+}
+
+sub same_email_addresses {
+	my ($email1, $email2) = @_;
+
+	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
+	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
+
+	return $email1_name eq $email2_name &&
+	       $email1_address eq $email2_address;
+}
+
 sub which {
 	my ($bin) = @_;
 
@@ -2618,17 +2640,16 @@ sub process {
 			$author = $1;
 			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
 			$author =~ s/"//g;
+			$author = reformat_email($author);
 		}
 
 # Check the patch for a signoff:
-		if ($line =~ /^\s*signed-off-by:/i) {
+		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
 			if ($author ne '') {
-				my $l = $line;
-				$l =~ s/"//g;
-				if ($l =~ /^\s*signed-off-by:\s*\Q$author\E/i) {
-				    $authorsignoff = 1;
+				if (same_email_addresses($1, $author)) {
+					$authorsignoff = 1;
 				}
 			}
 		}
@@ -2678,7 +2699,7 @@ sub process {
 				}
 			}
 
-			my ($email_name, $email_address, $comment) = parse_email($email);
+			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $email_address));
 			if ($suggested_email eq "") {
 				ERROR("BAD_SIGN_OFF",
@@ -2689,9 +2710,7 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if ("$dequoted$comment" ne $email &&
-				    "<$email_address>$comment" ne $email &&
-				    "$suggested_email$comment" ne $email) {
+				if (!same_email_addresses($email, $suggested_email)) {
 					WARN("BAD_SIGN_OFF",
 					     "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
 				}


