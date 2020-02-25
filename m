Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB9C35E17
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA6520838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKQHW22g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgBYVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:33:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44062 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:33:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so797568oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQCk4Na+YlT3y6qiZ+Z3XHlxdsworui2iUk6aY8nlYE=;
        b=bKQHW22gH0PuXODit5RIwwuUC63vvGOO2cn9LQAjLkmVR7b6kWjlnlM/EBXa5C47EB
         NJ5CnHfZYlQAw05rhAixn+ef0rgVez7GtJkcF3EHXx/5KEUeSB5TV1JP/9G/aqj+G0w1
         zdBFo5j9vQ/abf3atxmIHj+gBhASNr3BM3ItmwhndnqtVxcdDPgo0abR6eJxJMNIns3E
         C1OSUzrfTMKa840PCfNo6zsr7TrbwWG+ss+RSGY5CkdXSJV+099Uxg60ofUpw5mF1UE/
         HXDob1NrM/mD4YcWZKw1LY+FJAHBvX8PpK+FcUmxLivlZYv8TPmcfqt8qTT9feLeUzcL
         jiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQCk4Na+YlT3y6qiZ+Z3XHlxdsworui2iUk6aY8nlYE=;
        b=WOV0ssMiYp2aDXfSWy1EdF1cMKoXCd1tXyYfKbNB4b6qbmvOf0sfruF3dMmFVsXCB+
         acfsAeJuIgAM+xBm+U2T89624ykv2xPCvSs2nF3kG1pLn/LM56uV455NNFCOuXkeWYaB
         RvJEHtxIGCrKZYSC1/nU//NZ73pZTp3slPXGrd3PqK9myhZ8Y15X6L1SLS2JiK4BDBhv
         5BtECe+bR7loAqYfYI681biQevYm2RNNRvfqDCYNB44uUIOs4X1Ogrcya+VpHZIZcASa
         /+KElfXb/ZXZdx5fsnod3FhbWrcGm7frzDJWVF2jgZtp0ttNO8lEhllBqhGOVZ7G50ha
         WmCw==
X-Gm-Message-State: APjAAAVHRCodpRFOxsy0bkpE/oZUY4RMwNQnk02YoJ0EDwsyb3tDHN+m
        u5S37wZbqeGmUj0mVkcrGTbnfRMGvNY6iegc145YvT9H
X-Google-Smtp-Source: APXvYqyhhzF0y0crJ6GT0xIVt27C2mJOcnPUMNElY7/GFan7z8i9P+x26qfjcMNj+4iS8QilKQfYsqRm6WCvHCO5a6o=
X-Received: by 2002:aca:c551:: with SMTP id v78mr691810oif.161.1582666418197;
 Tue, 25 Feb 2020 13:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20200224235824.126361-1-john.stultz@linaro.org>
 <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
 <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
 <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
 <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com> <8b25478b524f5d9de8e080edf84b2daf1313cb00.camel@perches.com>
In-Reply-To: <8b25478b524f5d9de8e080edf84b2daf1313cb00.camel@perches.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 13:33:26 -0800
Message-ID: <CALAqxLU4xgqiLrPOrMoH57ACVVUE4GD5+Ks6R4onyVyN9Uvvbw@mail.gmail.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
To:     Joe Perches <joe@perches.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2020-02-25 at 09:45 -0800, John Stultz wrote:
> > On Mon, Feb 24, 2020 at 10:50 PM Joe Perches <joe@perches.com> wrote:
> > > > Since I have a few kernel repos that I use for both upstream work and
> > > > work targeting AOSP trees, I usually have the gerrit commit hook
> > > > enabled in my tree (its easier to strip with sed then it is to re-add
> > > > after submitting to gerrit), and at least the commit-msg hook I have
> > > > will usually append a Change-Id: line at the end of the commit
> > > > message, usually after the signed-off-by line.
>
> I think this better still:
>
> ---
>  scripts/checkpatch.pl | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3d55d8a2a..d0f850e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2343,6 +2343,7 @@ sub process {
>         my $is_binding_patch = -1;
>         my $in_header_lines = $file ? 0 : 1;
>         my $in_commit_log = 0;          #Scanning lines before patch
> +       my $has_patch_separator = 0;    #Found a --- line
>         my $has_commit_log = 0;         #Encountered lines before patch
>         my $commit_log_lines = 0;       #Number of commit log lines
>         my $commit_log_possible_stack_dump = 0;
> @@ -2668,6 +2669,12 @@ sub process {
>                         }
>                 }
>
> +# Check for patch separator
> +               if ($line =~ /^---$/) {
> +                       $has_patch_separator = 1;
> +                       $in_commit_log = 0;
> +               }
> +
>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
>  # emit the "does MAINTAINERS need updating?" message on file add/move/delete
>                 if ($line =~ /^\s*MAINTAINERS\s*\|/) {
> @@ -2767,10 +2774,10 @@ sub process {
>                              "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
>                 }
>
> -# Check for unwanted Gerrit info
> -               if ($in_commit_log && $line =~ /^\s*change-id:/i) {
> +# Check for Gerrit Change-Ids not in any patch context
> +               if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
>                         ERROR("GERRIT_CHANGE_ID",
> -                             "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
> +                             "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
>                 }
>
>  # Check if the commit log is in a possible stack dump

This one works well for me too.
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much!
-john
