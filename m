Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E14C2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E2B208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVLXegnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgIKDIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:08:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADBFC061573;
        Thu, 10 Sep 2020 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=17u5u0kQTmkzHsPKJ6AjQQe8GBeqYiMCxBwZYRKeDOI=; b=iVLXegnzzfWNH+6H112xclIt6h
        NPfBh4uUMJWO/gGCER2QObfuMmZOXr32hlqG3XOJb1v88bvgWY1Et94rL6vn3T8u7vt6MXA1dTJDK
        Z/C+e8OXr14sUXjrXgrMDu16wGk4oQSNKhEKgSyFhL26Fq68mY/F7xPY9Kv3I6Pdes+l04tNrYM/4
        OJt+MBb+jEL5Yt7oBwwMjnH+3hbW/bd8iyRyqGe3gdtX6ZOKeq3O3Bc1Qt8VMsrQy3hTqFb+ZmBSu
        CQd85dcW4rx74pcUtS1CYXAs82xIyrN7Of6c0+iw7xjqlx6ofkm60oZuAjZkU9jv5jNE1l0wX3zwY
        S6RSYpxw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGZQW-0002RK-NY; Fri, 11 Sep 2020 03:08:41 +0000
Subject: Re: [PATCH V2] scripts : config : Added example use when run without
 argument,extend help
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org
Cc:     jeremie.francois@gmail.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20200911015421.22193-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <508f3917-8b3f-fe38-f6bf-43f5026fc4e2@infradead.org>
Date:   Thu, 10 Sep 2020 20:08:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911015421.22193-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 6:54 PM, Bhaskar Chowdhury wrote:
> This patch extends the help section by adding an explicit example of use.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

Difference between versions goes here.

>  scripts/config | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/config b/scripts/config
> index eee5b7f3a092..d905dccabb94 100755
> --- a/scripts/config
> +++ b/scripts/config
> @@ -45,6 +45,23 @@ make time.
>  By default, $myname will upper-case the given symbol. Use --keep-case to keep
>  the case of all following symbols unchanged.
>  
> +The concrete example, say, you want to change any particular config,like

                                                                config, like

> +GCOV for profiling, you can simply use this command

                                               command.

> +
> +To enable:
> +
> +#scripts/config --enable GCOV_KERNEL  && grep GCOV .config
> +
> + and the output will be like this:
> +
> +  CONFIG_GCOV_KERNEL=y
> +
> +To disable:
> +
> +#scripts/config --disable GCOV_KERNEL  && grep GCOV .config
> +
> +# CONFIG_GCOV_KERNEL is not set
> +
>  $myname uses 'CONFIG_' as the default symbol prefix. Set the environment
>  variable CONFIG_ to the prefix to use. Eg.: CONFIG_="FOO_" $myname ...
>  EOL
> 

I don't know why we need this extra help text.

-- 
~Randy

