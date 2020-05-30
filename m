Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3AC20722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgE3XKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:10:40 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:39632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729520AbgE3XKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:10:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F30E9181D3026;
        Sat, 30 May 2020 23:10:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: game74_0c0153226d70
X-Filterd-Recvd-Size: 2434
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 May 2020 23:10:38 +0000 (UTC)
Message-ID: <a8d399d956bff24382caeda9a37d85cf3581fa99.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: check for trivial sizeofs
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 30 May 2020 16:10:37 -0700
In-Reply-To: <20200530212129.7498-1-efremov@linux.com>
References: <20200530212129.7498-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-31 at 00:21 +0300, Denis Efremov wrote:
> sizeof(char) and its variations in most cases doesn't make code more clear.
> It only makes code wordy.

There are about 1000 of these uses in the kernel.

Not sure I like this though as many/most of the uses
seem _less_ readable with a 1 in their place.

$ git grep -P 'sizeof\s*\(\s*(?:(?:unsigned\s+)?char\s*|(?:__)?u8|u?int8_t|[us]?byte(?:_t)?)\s*\)' | wc -l
970

Try the grep without the wc and see if you agree.

And if this is actually going to be used, I'd prefer
using a separate $typeChar for the search.

Maybe something like:
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dd750241958b..de2e9242350b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -466,6 +466,13 @@ our $typeTypedefs = qr{(?x:
 	$typeKernelTypedefs\b
 )};
 
+our $typeChar = qr{(?x:
+	(?:(?:un)?signed\s+)?char |
+	(?:__)?u8 |
+	(?:u_|u)?int8_t |
+	[us]?byte(?:_t)?
+)};
+
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
 
 our $logFunctions = qr{(?x:
@@ -6106,6 +6113,16 @@ sub process {
 			}
 		}
 
+# check for trivial sizeof(char) == 1
+		if ($line =~ /\bsizeof\s*\(\s*($typeChar)\s*\)/) {
+			my $byte = $1;
+			if (CHK("SIZEOF_CHAR",
+				"sizeof($byte) could be the constant 1 instead\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/sizeof\s*\(\s*\Q$byte\E\s*\)/1/;
+			}
+		}
+
 # check for struct spinlock declarations
 		if ($line =~ /^.\s*\bstruct\s+spinlock\s+\w+\s*;/) {
 			WARN("USE_SPINLOCK_T",


