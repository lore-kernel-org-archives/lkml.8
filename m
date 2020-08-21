Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC60C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4382420720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHUSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:05:09 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:48354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgHUSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:05:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B3AE71801A4D9;
        Fri, 21 Aug 2020 18:05:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boot46_2f0fb7c2703b
X-Filterd-Recvd-Size: 2124
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 18:05:04 +0000 (UTC)
Message-ID: <2bacb0a9c06fbb6d56a43bf930e808c74243c908.camel@perches.com>
Subject: [PATCH V2] get_maintainer: Exclude MAINTAINERS file(s) from
 --git-fallback
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Aug 2020 11:05:03 -0700
In-Reply-To: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS files generally have no specific maintainer but are updated
by individuals for subsystems all over the source tree.

Exclude MAINTAINERS file(s) from --git-fallback searches so the unlucky
individuals that update the files the most are not shown by default.

Signed-off-by: Joe Perches <joe@perches.com>
---

V2:

Remove --git and --git-blame from the exclusion.
Someone who _really_ wants that info should get it.

 scripts/get_maintainer.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..7ea461dc208e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -954,8 +954,10 @@ sub get_maintainers {
 
     foreach my $file (@files) {
 	if ($email &&
-	    ($email_git || ($email_git_fallback &&
-			    !$exact_pattern_match_hash{$file}))) {
+	    ($email_git ||
+	     ($email_git_fallback &&
+	      $file !~ /MAINTAINERS$/ &&
+	      !$exact_pattern_match_hash{$file}))) {
 	    vcs_file_signoffs($file);
 	}
 	if ($email && $email_git_blame) {


