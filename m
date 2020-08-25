Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2189C2074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="faCKmLSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgHYMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHYMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:23:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0565C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:23:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y2so13574829ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=npQSbmA+gXwC9a6IjiIfcuykqKuVSdMx81JKlqg6LVc=;
        b=faCKmLSOHN+SDX9nwhCKULE+3ckPn/FX17L731HHYj1kzOtAgwPlIDGKrVcCuoibq+
         Rpw4cT1mfRdK+vX/oFb23cmelGx0wHu0WU9m7zWCm/+TT++PB7PqQtSRPq3smaV3sRUq
         UFmuyxPxmRiLI5aT6bnjyu0wRwGcNWoiBlIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=npQSbmA+gXwC9a6IjiIfcuykqKuVSdMx81JKlqg6LVc=;
        b=JBjHYsUWvV96afR062o9VeAf/f7UQi4k6Al/VPmMesPv+byWaeObI+iGeFJ9iMNGzF
         Rho3ibbn7rPPZUY0uH5PVFz4seRvWWiO3FeFPZxFB7jfbrRK+Sya9l8Bf3zKgS7POSxl
         /jcnqHqSgc4P6MG4/JZxCM4pceixVdoVSRvxk9QyiS6qVr53U9YF4UzigxeVr6gIiuQT
         AZK1uqCkoqifnAxtYzTfysR2k6YSXzsuRuwVCnwYTAFnVbVBPQKt17OUYZP0jVy0ODEQ
         WJUMUEGWXm4U9N6q+/F92ZGvGMXEETiYHwL23s0rFfzYO0PAVGBo6x3r6xBjTIbBRj76
         0hlw==
X-Gm-Message-State: AOAM530vZclZJinCOjpRkpT6gRZiHE89ri5i4TmWqSga0JRXy3g2lF23
        aMKczxdoheVE7Q/nW9Mi7VLKZJEe9Y7Vq08eDYA=
X-Google-Smtp-Source: ABdhPJzqsff0vbHnrC8pAUxaFZOetxB7PKv2cQp94rq3UobfXU3FjiCo8ZD2qaCPMasRgVnrB0eq+g==
X-Received: by 2002:a2e:99d5:: with SMTP id l21mr4452887ljj.320.1598358187525;
        Tue, 25 Aug 2020 05:23:07 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 133sm2420706lfa.70.2020.08.25.05.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:23:07 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in git
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <234290e5-b8dc-22c7-d26f-60a02844ce0a@rasmusvillemoes.dk>
Date:   Tue, 25 Aug 2020 14:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2020 02.09, Joe Perches wrote:
> If a file exists in git and checkpatch is used without the -f
> flag for scanning a file, then checkpatch will scan the file
> assuming it's a patch and emit:
> 
> ERROR: Does not appear to be a unified-diff format patch
> 
> Change the behavior to assume the -f flag if the file exists
> in git.

Heh, I read the patch subject to mean you introduced a way for subsystem
maintainers to prevent running checkpatch -f on their files, which I
think some would like ;)

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 79fc357b18cd..cdee7cfadc11 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -976,6 +976,16 @@ sub seed_camelcase_includes {
>  	}
>  }
>  
> +sub git_is_single_file {
> +	my ($filename) = @_;
> +
> +	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +	my $output = `${git_command} ls-files -- $filename`;
> +	my $count = $output =~ tr/\n//;
> +	return $count eq 1 && $output =~ m{^${filename}$};
> +}

Isn't that somewhat expensive to do for each file? Why not postpone that
check till we're about to complain that the file is not a diff (haven't
looked at how such a refactoring would look).

Rasmus
