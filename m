Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E8C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88820637
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgBYGus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:50:48 -0500
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:35604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728984AbgBYGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:50:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4C602181D341A;
        Tue, 25 Feb 2020 06:50:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch82_40d5d0d782e2f
X-Filterd-Recvd-Size: 2642
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 06:50:45 +0000 (UTC)
Message-ID: <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
From:   Joe Perches <joe@perches.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Mon, 24 Feb 2020 22:49:15 -0800
In-Reply-To: <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
References: <20200224235824.126361-1-john.stultz@linaro.org>
         <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
         <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 20:48 -0800, John Stultz wrote:
> On Mon, Feb 24, 2020 at 6:13 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-02-24 at 23:58 +0000, John Stultz wrote:
> > > Quite often, the Change-Id may be between Signed-off-by: lines or
> > > at the end of them. Unfortunately checkpatch won't catch these
> > > cases as it disables in_commit_log when it catches the first
> > > Signed-off-by line.
> > > 
> > > This has bitten me many many times.
> > 
> > Hmm.  When is change-id used in your workflow?
> 
> Since I have a few kernel repos that I use for both upstream work and
> work targeting AOSP trees, I usually have the gerrit commit hook
> enabled in my tree (its easier to strip with sed then it is to re-add
> after submitting to gerrit), and at least the commit-msg hook I have
> will usually append a Change-Id: line at the end of the commit
> message, usually after the signed-off-by line.

Perhaps this is better:
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380..698c7c8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2721,9 +2721,9 @@ sub process {
 		}
 
 # Check for unwanted Gerrit info
-		if ($in_commit_log && $line =~ /^\s*change-id:/i) {
+		if ($realfile eq '' && $line =~ /^\s*change-id:/i) {
 			ERROR("GERRIT_CHANGE_ID",
-			      "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
+			      "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
 		}
 
 # Check if the commit log is in a possible stack dump


