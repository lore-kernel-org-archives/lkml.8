Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D0FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0072068F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="z2hrydle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGJVNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:13:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E9C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:13:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so5561402qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Py7sbUg6SrhS/tqtX2Sq8t6PBGylJUmZvrnUWwDIZKQ=;
        b=z2hrydleOwcHTXUTY3Zdw8+qKJdrCWfJB9WN6Em2f/LdnIx8oUqkbqEsO2E3Jn4n5c
         WGWDW79gtum6V0gRq8VNRWPBOaUoJivLznSnq94+8ARITJSAp7ghn3Vb2Ft1hRqn1a7N
         nAJjVeMEupzJ1xbWmmWyT7HWG08fr8APAxDFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Py7sbUg6SrhS/tqtX2Sq8t6PBGylJUmZvrnUWwDIZKQ=;
        b=AT47exbDo+E8aoXYjRbS6rnIn2Pw+NfXh3K6zOg4ywFBKeuqWCxNLwpI22fFlVqgoy
         URewVzE6gilimz2MSMQ0+xlcr+HQdFhmVBT7xFBi3IcIpSgvPjHEcUm6eZNGJXuUU8h3
         GRsEljto870BjXlvig0SZ0rt4eCL2m7ysrQ4Aawh2wpRofbZ557UOXOcCMyjgcMsGEWp
         J2dIoiC5cEdGVaW/r9VkrbsZvjj1rKX8wxRyFmQ+Ft7ghPspGH+jMiREmZzrAhmNJxhv
         wlMXlvfMygvwLNfRCHOj/Nzfk5bsmt3hC8KtIfmYxhNsJ/rO8B++vGt3zMyWVW6B38ah
         kF8A==
X-Gm-Message-State: AOAM530y70vDd+tvSj9vXVmfz+GCAssxeMjkpPqSIlF2MO0/zwLXlZ+e
        jRUe4hhxsu4dRF9vvamwGYqiKj8pSFTbRw==
X-Google-Smtp-Source: ABdhPJyyT+pNMBHbp+rM/XUuxP36fWE0gYZosn0juRTh7hjb86WB84iL4vCYnrV250o29G7X0RUy4A==
X-Received: by 2002:ac8:197b:: with SMTP id g56mr52023025qtk.105.1594415617748;
        Fri, 10 Jul 2020 14:13:37 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id b53sm9292264qtc.65.2020.07.10.14.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 14:13:37 -0700 (PDT)
Subject: Re: [PATCH v3] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>, corbet@lwn.net
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        SeongJae Park <sjpark@amazon.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mark Brown <broonie@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <97c24e99-9f49-f094-acfb-705c2da12a76@labbott.name>
Date:   Fri, 10 Jul 2020 17:13:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 2:14 PM, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Chris Mason <clm@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v2 [1]:
> - Pick up missed sign-offs and acks from Jon, Shuah, and Christian
>    (sorry about missing those earlier).
> 
> - Reformat the replacement list to make it easier to read.
> 
> - Add 'controller' as a suggested replacement (Kees and Mark)
> 
> - Fix up the paired term for 'performer' to be 'director' (Kees)
> 
> - Collect some new acks, reviewed-by's, and sign-offs for v2.
> 
> - Fix up Chris's email
> 
> [1]: http://lore.kernel.org/r/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> 
>   Documentation/process/coding-style.rst |   20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..1bee6f8affdb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,26 @@ If you are afraid to mix up your local variable names, you have another
>   problem, which is called the function-growth-hormone-imbalance syndrome.
>   See chapter 6 (Functions).
>   
> +For symbol names and documentation, avoid introducing new usage of
> +'master / slave' (or 'slave' independent of 'master') and 'blacklist /
> +whitelist'.
> +
> +Recommended replacements for 'master / slave' are:
> +    '{primary,main} / {secondary,replica,subordinate}'
> +    '{initiator,requester} / {target,responder}'
> +    '{controller,host} / {device,worker,proxy}'
> +    'leader / follower'
> +    'director / performer'
> +
> +Recommended replacements for 'blacklist/whitelist' are:
> +    'denylist / allowlist'
> +    'blocklist / passlist'
> +
> +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> +or when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications
> +translate specification usage of the terminology to the kernel coding
> +standard where possible.
>   
>   5) Typedefs
>   -----------
> 

Acked-by: Laura Abbott <laura@labbott.name>
