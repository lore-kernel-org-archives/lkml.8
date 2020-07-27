Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A5E20792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFIlcTtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgG0Ueu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgG0Uet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:34:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D56C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:34:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g11so6638083ejr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YkkYId0qfscEeVLanlp+9fO+1FJwDeA+iuhChUKUNzw=;
        b=TFIlcTtpMEaEdu6Obq566fed0LcNw+s440FAiZQNexu+CUbPGjDfb6nfXkHqleRqLN
         tFOWBKFUPOfYQfMhOzBu1gwFG3/lFKYYHAtzejaA3o80NVCQQBpWunZMbprtdV95VAQA
         7oKbk07ix9uEjSfcBHu33BiBYrp3JewmWGPWZFc9dIxvibmjsf6sfVqun4jW2E0wdQRJ
         6N/qH4NmO8N0JLZ/mlcOFUe3MiIrJ42nBaluJFCeseAgOhsthgqyN6YGACf7IyPgTRYe
         vIln5m6LNeabOu9Cqhn4yO+CltTQS9EN1HRs5zy5Iu+rdho1AvMPfbPTMtwTQg1AHDG5
         necQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YkkYId0qfscEeVLanlp+9fO+1FJwDeA+iuhChUKUNzw=;
        b=Cvk15LzChc916kNkOgQQk5SqUeiLXR0uec3ErzQPMu2xhFNS5pFLQySwnjJPE86vSm
         ImBKmJNc1qlOQRW2TkEm2Am3NUU4zd92CVj0bi7dzhmrCZNrhYm8+cJojUOX8tL5xOOm
         oW0E9on5wAVC32BVBALlcYLpZ9PEckzPlKEXNxghtBHxznRME9Gf/alX7CFS9DMfENhY
         4L+/Y9WiF/O8LjSYzoxLtr3QrQsDN0ZN1BwhCLIT7xCw4bACo59BpU7lc6y/36jrutFX
         EYSO2oQaBSZW9WTbIq5bvSAyOtOOtrYIJRHqXYVj+QsRVi8m3GOY7UjCIAQt7tb8LlTw
         5uuw==
X-Gm-Message-State: AOAM531U6SEs/WEr+Sfrqq4WR/i4m2V6+2itONYaVwWGe3sdpS1jCiLN
        3J2h5qtjL+ot2QRK86gmzMU=
X-Google-Smtp-Source: ABdhPJylqd2aCo4OdWacO1NzkdhKrkGlngvsgTCA2pPxab/QetyviXICeIv/c4d1XODXuH8f7xOATw==
X-Received: by 2002:a17:906:60d0:: with SMTP id f16mr22112045ejk.17.1595882087821;
        Mon, 27 Jul 2020 13:34:47 -0700 (PDT)
Received: from felia ([2001:16b8:2daf:f700:54de:db5:3d20:437c])
        by smtp.gmail.com with ESMTPSA id q6sm7758159ejn.30.2020.07.27.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:34:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 27 Jul 2020 22:34:37 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Nachiket Naganure <nachiketun8@gmail.com>
cc:     Joe Perches <joe@perches.com>, apw@canonical.com,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] checkpatch: disable commit log length check warning for
 signature tag
In-Reply-To: <20200727071159.GA595854@endurance>
Message-ID: <alpine.DEB.2.21.2007272229280.15655@felia>
References: <20200727055458.559558-1-nachiketun8@gmail.com> <66bbaec73d8f69541535db5390c0f12b304c0467.camel@perches.com> <20200727071159.GA595854@endurance>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Jul 2020, Nachiket Naganure wrote:

> On Sun, Jul 26, 2020 at 11:14:42PM -0700, Joe Perches wrote:
> > On Mon, 2020-07-27 at 11:24 +0530, Nachiket Naganure wrote:
> > > Disable commit log length check in case of signature tag. If the commit
> > > log line has valid signature tags such as "Reported-and-tested-by" with
> > > more than 75 characters, suppress the long length warning.
> > > 
> > > For instance in commit ac854131d984 ("USB: core: Fix misleading driver bug
> > > report"), the corresponding patch contains a "Reported by" tag line which
> > > exceeds 75 chars. And there is no valid way to shorten the length.
> > > 
> > > Signed-off-by: Nachiket Naganure <nachiketun8@gmail.com>
> > > ---
> > >  scripts/checkpatch.pl | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 197436b20288..46237e9e0550 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -2806,6 +2806,8 @@ sub process {
> > >  					# filename then :
> > >  		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
> > >  					# A Fixes: or Link: line
> > > +		      $line =~ /$signature_tags/ ||
> > > +					# Check for signature_tags
> > >  		      $commit_log_possible_stack_dump)) {
> > >  			WARN("COMMIT_LOG_LONG_LINE",
> > >  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> > 
> > OK, but the test should be:
> > 
> > 		      $line =~ /^\s*$signature_tags/ ||
> > 
> > so the line has to start with a signature and
> > it won't match on signature tags in the middle
> > of other content on the same line.
> > 
> > 
> But the suggested won't work in case of merged signatures.
> Such as "Reported-and-tested-by: user@email.com"
> 

But Joe's remark is valid; we do not want to match on signature tags in 
the middle. These cases are probably mentioning signature tags as part of 
a sentence or some explanation.

Nachiket, think about a proper solution for this issue.

The evaluation data from running checkpatch.pl on previous commits will 
provide you some guidance on which heuristics might work and which not.

Lukas
