Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A05C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A472A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKn1y7Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgG3F6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3F6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:58:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 22:58:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so11930173ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 22:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IAoTwvssfsWUMQsY9ak3cq0wR9KCIhNThNsjepDyRwQ=;
        b=dKn1y7HxLHmjpQTyJW7X+RsRlljgI8xQco6QX2Sff2ZbMzjvDCioNAC/Tka7RXXg+d
         QtUr+TroAF2McWFShmZtuzJb0Z6t+/w760qhbt7wPXZCo7e6W5BSrF5j+RdHwkvk4wS+
         L6A5z4VulNYVFb6SqSDDtKV41c0hcWnZwuHpQ23Tt0eYtfU98F70Y6WqBdWDJifP9RH8
         QrBFfCnXzdpiyyEwjg5/pgVZ/i4H+kJjHqS5bj/UroaAf4xzhawcTRuFOIdnXUNIpEyj
         RumplsqM723RrxBTIfGjfECg+SF9KJC7z45C1trHufbSSUFlpk+mz9ORjIor7w1N6OJ2
         zByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IAoTwvssfsWUMQsY9ak3cq0wR9KCIhNThNsjepDyRwQ=;
        b=ka6LjUHUZCY3dehhFmTNiN45pUhXDXma4WsjfmRLebSMeyinTwzW0V1yUAc5XxmLOo
         94eUMezxhalZFHj2vPUOlwLyU6/wyI9ExyPZ5yZ3ShFbxcLXDtRyvRXDqJP7q4I0CnVd
         0B4ywJDxoZXHPtP4z497rCSkllKEeVldHGx/+5XB5w4glQDPyKLA1THXJJibeB1S+V0T
         HnKtTu3XhQs0Y0RCTIWouxj6PtC1Tsf/+Cnl5q2fwzD1bSV61ut2vaUz8A8klpRdNx2P
         cP2XB8e/e5tE3kYvk86DLvU3PhZHPZCgW/9NfWnyvjblixOTvbt54yesUAmGrcXa5q0Q
         UXFg==
X-Gm-Message-State: AOAM532QWLK7MTZ7uGiSdTnCj9Ay4ecQw4ekjvM1pASrtPkf+Kk3U954
        XXDp79sCl12G/qGz6vaweUp1ORxE
X-Google-Smtp-Source: ABdhPJzUOY3x2BdBSICrBBmMp6brcvGJXLO17FFIn71N4JX99Cih8wJw/y7ACWjKWlADe/8JRI3Chg==
X-Received: by 2002:a17:906:3790:: with SMTP id n16mr1055673ejc.256.1596088721345;
        Wed, 29 Jul 2020 22:58:41 -0700 (PDT)
Received: from felia ([2001:16b8:2d08:ee00:c941:ef07:9c8a:8408])
        by smtp.gmail.com with ESMTPSA id a18sm4823135ejt.69.2020.07.29.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 22:58:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 30 Jul 2020 07:58:28 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Mrinal Pandey <mrinalmni@gmail.com>, joe@perches.com
cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
In-Reply-To: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
Message-ID: <alpine.DEB.2.21.2007300746330.13710@felia>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Jul 2020, Mrinal Pandey wrote:

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
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
> ---
> Changes since v1:
> Add Reviewed-by and Tested-by tag
>

Hi Joe,

did you see this quick fix to checkpatch.pl? Can you comment on the 
commit and can we get a quick ack on that fix, please?

General question on patches for ./scripts/checkpatch.pl:

How do they travel to Linus?

Do you pick those patches and provide them to Andrew Morton?
Or do you just ack them and we need to send them to Andrew Morton to get 
them into mainline?

(get_maintainers tells us to just send those patches to you and Andy.)


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
