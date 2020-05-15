Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1AD20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOMbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:31:13 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:49356 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgEOMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:31:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6142F182CED5B;
        Fri, 15 May 2020 12:31:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: elbow04_7edc9eac87751
X-Filterd-Recvd-Size: 1930
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 12:31:11 +0000 (UTC)
Message-ID: <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
Subject: Re: get_maintainer.pl: unexpected behaviour for path/to//file
From:   Joe Perches <joe@perches.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 05:31:10 -0700
In-Reply-To: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
References: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 11:52 +0100, Emil Velikov wrote:
> Hi Joe,
> 
> Recently I've noticed that get_maintainer behaves differently if there
> is a double, sequential, forward slash in the path.
> 
> AFAICT there should be no distinction between the two. Or at least many
> existing applications and scripts consider them one and the same.
> 
> I've tried fixing this, although my perl isn't quite up-to scratch.
> Is this some weird bug or some intended feature?

Not really an intended feature.
The code counts slashes for directory depth.

I suppose it might be simpler to do this:
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6d973f3685f9..eaaf9373dbcf 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -538,6 +538,7 @@ foreach my $file (@ARGV) {
 	} elsif (!(-f $file)) {
 	    die "$P: file '${file}' not found\n";
 	}
+	$file =~ s@//@/@g;	# compress file double slashes
     }
     if ($from_filename || ($file ne "&STDIN" && vcs_file_exists($file))) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path

