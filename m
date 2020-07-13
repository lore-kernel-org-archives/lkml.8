Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9826C2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDkJTNFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGMTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:32:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E97C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:32:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so17987399wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9fJr/1cec8FKyUaFttMTbozwrrZF55RXbttTD7EpCRQ=;
        b=kDkJTNFBxC4a2FNUKP03AQhCY12UZJlGgVcyDgDvLPw8KZPiPnlAfWN7XnW+evqBXI
         0jiSnbQtqjhMY4zVLFafqqDI4t6p1szHPYxk3IA1QUnDwLvaHcuHIJypWiGJzUUVbYRy
         B7LTETsj8s8AESW3B999pXCd8ht7B/8CNzaGu6nNyC2BfMbgAiZ67xeZLKggxdQtyfkO
         YAWMRgpob37apwUNAHDyZqLsTnpAstOLYn4aWMZK/QGZgrK4EwBQPXlyDfbs+sHRnnwc
         t0i/XX4X2UO0Su/WXPkyqr+YL7pCQJf8g1ma/do2TPmD6BNT0BODB8iq8M023UYC4z6g
         sITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9fJr/1cec8FKyUaFttMTbozwrrZF55RXbttTD7EpCRQ=;
        b=j3Q3uzWvTAvht1UR0WrJA5FkTi8Yh1O5CLlpWSGGY/zoCNjxuxUqZ1GPiwF+U0+FMe
         jhJwktHkBUILcdEsC+bxk6c2THrLMnxnPzUtYvBaFUv4ichS4aI4d9s74zApUSxwCRy/
         uVIGSM6RAeSwpMvPLKZAq6lR1L/hqBcjrBvHAj3BDHxK4Yae1XuJZmpKYs+7mE/bc3e4
         MMRMPCa0pQFs39Ugxy35e/GRB65M7Fmsw/nFmE8tSAHD+v95yvmYtH4trlqi7y82VBGP
         a4DFAUtZM4qE3CACRmQPxPrDDVnrmbOIZQqasPkafj9FS6AZuK3z+s5JuXWUvhTSyO1y
         x/eA==
X-Gm-Message-State: AOAM531CJHuF39QGKtFyoUo9AYpHOVhzdlYRPz+RaZuzisaxrymxSc+J
        c4uWOnAqa4xIgxFhqOmbuYE=
X-Google-Smtp-Source: ABdhPJwYk6eRXZfmTcXvLwYULHiYq9q8wsOF8XnoAel9o+0AD+tYwJG7c097M+EIqfcOdAwgE3+rqg==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr1118798wrw.2.1594668730392;
        Mon, 13 Jul 2020 12:32:10 -0700 (PDT)
Received: from felia ([2001:16b8:2dae:2400:a50d:fbbf:27a0:1459])
        by smtp.gmail.com with ESMTPSA id t4sm836736wmf.4.2020.07.13.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:32:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 13 Jul 2020 21:31:58 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Mrinal Pandey <mrinalmni@gmail.com>
cc:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] checkpatch: Fix the usage of capture group ( ... )
In-Reply-To: <20200713043230.d7rhv6znvswt2h4u@mrinalpandey>
Message-ID: <alpine.DEB.2.21.2007132130360.11844@felia>
References: <20200713043230.d7rhv6znvswt2h4u@mrinalpandey>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jul 2020, Mrinal Pandey wrote:

> The usage of "capture group (...)" in the immediate condition after `&&`
> results in `$1` being uninitialized. This issues a warning "Use of
> uninitialized value $1 in regexp compilation at ./scripts/checkpatch.pl
> line 2638".
> 
> I noticed this bug while running checkpatch on the set of commits from
> v5.7 to v5.8-rc1 of the kernel on the commits with a diff content in
> their commit message.
> 
> This bug was introduced in the script by commit e518e9a59ec3
> ("checkpatch: emit an error when there's a diff in a changelog"). It has
> been in the script since then.
> 
> The author intended to store the match made by capture group in variable
> `$1`. This should have contained the name of the file as `[\w/]+` matched.
> However, this couldn't be accomplished due to usage of capture group and
> `$1` in the same regular expression.
> 
> Fix this by placing the capture group in the condition before `&&`.
> Thus, `$1` can be initialized to the text that capture group matches
> thereby setting it to the desired and required value.
> 
> Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
> ---

I have discussed the change on the mentees list before. So:

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I ran ./scripts/checkpatch.pl on:

    commit 6b3e0e2e0461 ("perf tools: Support CAP_PERFMON capability")
    commit 19ce2321739d ("perf flamegraph: Use /bin/bash for report and record scripts")

before and after applying this patch.
On those two patches, checkpatch.pl emits the warning before,
and does not emit after this change. So:

Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4c820607540b..e73e998d582a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2636,8 +2636,8 @@ sub process {
>  
>  # Check if the commit log has what seems like a diff which can confuse patch
>  		if ($in_commit_log && !$commit_log_has_diff &&
> -		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
> -		      $line =~ m@^\s+diff\b.*a/([\w/]+)\s+b/$1\b@) ||
> +		    (($line =~ m@^\s+diff\b.*a/([\w/]+)@ &&
> +		      $line =~ m@^\s+diff\b.*a/[\w/]+\s+b/$1\b@) ||
>  		     $line =~ m@^\s*(?:\-\-\-\s+a/|\+\+\+\s+b/)@ ||
>  		     $line =~ m/^\s*\@\@ \-\d+,\d+ \+\d+,\d+ \@\@/)) {
>  			ERROR("DIFF_IN_COMMIT_MSG",
> -- 
> 2.25.1
> 
> 
