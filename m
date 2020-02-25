Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0045C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820282176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgBYSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:03:55 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:43896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726953AbgBYSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:03:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DD60E182CF66B;
        Tue, 25 Feb 2020 18:03:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven98_793e7f329cb3d
X-Filterd-Recvd-Size: 2865
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 18:03:53 +0000 (UTC)
Message-ID: <95aa867717aad711f66614d0daeab238c61a97da.camel@perches.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
From:   Joe Perches <joe@perches.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 25 Feb 2020 10:02:23 -0800
In-Reply-To: <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
References: <20200224235824.126361-1-john.stultz@linaro.org>
         <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
         <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
         <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
         <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 09:45 -0800, John Stultz wrote:
> On Mon, Feb 24, 2020 at 10:50 PM Joe Perches <joe@perches.com> wrote:
> > > Since I have a few kernel repos that I use for both upstream work and
> > > work targeting AOSP trees, I usually have the gerrit commit hook
> > > enabled in my tree (its easier to strip with sed then it is to re-add
> > > after submitting to gerrit), and at least the commit-msg hook I have
> > > will usually append a Change-Id: line at the end of the commit
> > > message, usually after the signed-off-by line.
> > 
> > Perhaps this is better:
> > ---
> >  scripts/checkpatch.pl | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -2721,9 +2721,9 @@ sub process {
> >                 }
> > 
> >  # Check for unwanted Gerrit info
> > -               if ($in_commit_log && $line =~ /^\s*change-id:/i) {
> > +               if ($realfile eq '' && $line =~ /^\s*change-id:/i) {
> >                         ERROR("GERRIT_CHANGE_ID",
> > -                             "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
> > +                             "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
> >                 }
> > 
> >  # Check if the commit log is in a possible stack dump
> > 
> 
> Yep. This works well for me, catching Change-Id lines that are missed
> by the current code.
> 
> Tested-by: John Stultz <john.stultz@linaro.org>

A negative approach to this is if the change-id is after
the "---" separator line but before any file diff, then the
"Remove Gerrit Change-Id" message will still be emitted.

Dunno if that's an issue.


