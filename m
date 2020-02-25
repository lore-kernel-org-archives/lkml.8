Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79852C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D62082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKkLyZCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgBYRp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:45:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34060 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgBYRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:45:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so352832otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4W5yVK824wX/ACwE2yGPoPcMjZTyMfgcOXv/yEgNjeQ=;
        b=uKkLyZCUtPdgiKg3PGXf08p4v/Wr8tyhxNp18NjbvMyPzgm58MceHf4ZIpxrg6Wg5q
         SdfNub575PSu8R78Ys9EITNYTsGPg5Z20m7jlo42FdDf4GccxHi31AMkvf1ulDOHfHR8
         YxXf2ctZ4NO7l6SxSVxpYF4BVR4bHWg9IFG+Rq+jes56uxE5bQt8q7iYHGhqWh9rGNOV
         uMsUxfBQjewaDBhioiqEB4x3F/HXWepJbfvGw3TeHV5DKwjiZdSJln4ermrwjvJx3mPR
         rNgmxdKnsDBCXhFtjJXUN91jh6lsVeuZigljIzAOO2M7sUIPUVFWE/e4DJpXYKFsAfRT
         nf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W5yVK824wX/ACwE2yGPoPcMjZTyMfgcOXv/yEgNjeQ=;
        b=P3B9IQ1NnRY21XEKlo1m9YrN/9Bgfzmz8XGSUz0NHpNgjEpvstxkGLGJbUEEZhAhgy
         oe3cEcnjeSxiLd4oFJKKNR9oIzC8BoWcJL0GQeaEFju2qXgKZ4VjLm3jTFfdIz3pcrgb
         3Tqtr8sf/5exnKa9LbIk/RpZghPGnjAedNauGxMHy+TSaVnBHc4rzPKVW36uov6J/nD/
         +1RQDv67OelZ6R2wVobChAK9yFsZyD1Pok9tfhgTwUr54zzQWWU7QqvSxaeofhV7EnoL
         xmiWK23k2qayzFufzIx/lABj35tIoU/zGLe6VyCHN35kIDvRny3Nb7GXLN5q4TTVgG6z
         akQA==
X-Gm-Message-State: APjAAAWvwLQWmIRWUmuWxF9YjXFcrUBBP6HFzqHO/J2Ol/LOBon8SFzo
        VIgwtJLap0AFJL3HBQtDUlHNVsGeYa/Vvo4lr1lLjA==
X-Google-Smtp-Source: APXvYqytDZ822JdwgytUa3aflcsu3+aF5ibkKtr0TDDApdeO3lI9rr+7EmJu1Dz44Vm4BBkwPeLM15R88Rclo7Se15I=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr2217318otp.12.1582652727731;
 Tue, 25 Feb 2020 09:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20200224235824.126361-1-john.stultz@linaro.org>
 <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
 <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com> <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
In-Reply-To: <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 09:45:17 -0800
Message-ID: <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
To:     Joe Perches <joe@perches.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:50 PM Joe Perches <joe@perches.com> wrote:
> > Since I have a few kernel repos that I use for both upstream work and
> > work targeting AOSP trees, I usually have the gerrit commit hook
> > enabled in my tree (its easier to strip with sed then it is to re-add
> > after submitting to gerrit), and at least the commit-msg hook I have
> > will usually append a Change-Id: line at the end of the commit
> > message, usually after the signed-off-by line.
>
> Perhaps this is better:
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380..698c7c8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2721,9 +2721,9 @@ sub process {
>                 }
>
>  # Check for unwanted Gerrit info
> -               if ($in_commit_log && $line =~ /^\s*change-id:/i) {
> +               if ($realfile eq '' && $line =~ /^\s*change-id:/i) {
>                         ERROR("GERRIT_CHANGE_ID",
> -                             "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
> +                             "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
>                 }
>
>  # Check if the commit log is in a possible stack dump
>

Yep. This works well for me, catching Change-Id lines that are missed
by the current code.

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much!
-john
