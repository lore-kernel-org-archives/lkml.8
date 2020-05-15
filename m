Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD220727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEORWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:22:54 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:38548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEORWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:22:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0812D182CED5B;
        Fri, 15 May 2020 17:22:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: able05_3631f4c4af504
X-Filterd-Recvd-Size: 2261
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 17:22:52 +0000 (UTC)
Message-ID: <ba9cbced1ccb0e7da5593b587bb179328cecd80e.camel@perches.com>
Subject: Re: get_maintainer.pl: unexpected behaviour for path/to//file
From:   Joe Perches <joe@perches.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 10:22:51 -0700
In-Reply-To: <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
References: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
         <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 05:31 -0700, Joe Perches wrote:
> On Fri, 2020-05-15 at 11:52 +0100, Emil Velikov wrote:
> > Hi Joe,
> > 
> > Recently I've noticed that get_maintainer behaves differently if there
> > is a double, sequential, forward slash in the path.
> > 
> > AFAICT there should be no distinction between the two. Or at least many
> > existing applications and scripts consider them one and the same.
> > 
> > I've tried fixing this, although my perl isn't quite up-to scratch.
> > Is this some weird bug or some intended feature?
> 
> Not really an intended feature.
> The code counts slashes for directory depth.
> 
> I suppose it might be simpler to do this:

Or perhaps a better alternative is:
---
 scripts/get_maintainer.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6d973f3685f9..484d2fbf5921 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -19,6 +19,7 @@ my $V = '0.26';
 use Getopt::Long qw(:config no_auto_abbrev);
 use Cwd;
 use File::Find;
+use File::Spec::Functions;
 
 my $cur_path = fastgetcwd() . '/';
 my $lk_path = "./";
@@ -532,6 +533,7 @@ if (!@ARGV) {
 
 foreach my $file (@ARGV) {
     if ($file ne "&STDIN") {
+	$file = canonpath($file);
 	##if $file is a directory and it lacks a trailing slash, add one
 	if ((-d $file)) {
 	    $file =~ s@([^/])$@$1/@;


