Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AA220727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:07:02 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:44244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:07:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1C72D100E7B4D;
        Fri, 15 May 2020 19:07:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cake00_5a47450899a10
X-Filterd-Recvd-Size: 3250
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 May 2020 19:07:00 +0000 (UTC)
Message-ID: <9a18b611813bb409fef15bc8927adab79eb9be43.camel@perches.com>
Subject: [PATCH] get_maintainer: Fix unexpected behavior for path/to//file
 (double slashes)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 12:06:59 -0700
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

get_maintainer behaves differently if there is a
double sequential forward slash in a filename because
the total number of slashes in a filename is used to
match MAINTAINERS file patterns.

For example:

# (with double slash)
$ ./scripts/get_maintainer.pl -f drivers/gpu/drm//lima
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS,commit_signer:3/42=7%)
Qiang Yu <yuq825@gmail.com> (commit_signer:36/42=86%,authored:24/42=57%)
Vasily Khoruzhick <anarsoul@gmail.com> (commit_signer:26/42=62%)
Krzysztof Kozlowski <krzk@kernel.org> (commit_signer:5/42=12%,authored:5/42=12%)
Emil Velikov <emil.velikov@collabora.com> (commit_signer:4/42=10%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

# (without double slash)
$ ./scripts/get_maintainer.pl -f drivers/gpu/drm/lima
Qiang Yu <yuq825@gmail.com> (maintainer:DRM DRIVERS FOR LIMA)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA)
lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
linux-kernel@vger.kernel.org (open list)

So reduce consecutive double slashes to a single slash
by using File::Spec->canonpath().

from: https://perldoc.perl.org/File/Spec/Unix.html

canonpath()

No physical check on the filesystem, but a logical cleanup of a
path. On UNIX eliminates successive slashes and successive "/.".

Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Joe Perches <joe@perches.com>
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


