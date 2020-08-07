Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB6DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E32075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596831389;
	bh=zBooYBIWnGK5adBiPGAqhJfeVNFxpyvJpuKircY/IHg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=f/xZrQZg+/wonbb2q8e4DsJTgM/Xck8caXNrbD+dlDKifdWWMnsffJDNfT5u/RXE0
	 IW4I+F3u1yICofpAEVLRWFJOsNOMzLBPGUCf3OADLaYrSvWMfJLY6Qym8EZRRfjD+b
	 ObC522019mVRtztfnhsR1gr4XZUiOsNWt+Oc4zxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHGUQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHGUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:16:27 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280BFC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:16:27 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g18so679065ooa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iIZRPhzhxvlQPAhRZLYpwVWj9ulUHGVA0m8o8NVr9w0=;
        b=fO9nvYG1DHSSSUBg8D39QTcN6kddz8Pc3RyN9EXcxze4qboNGD3Q7ZsSwOY7C22ULO
         w1GlGdGahdCihTkGqeV/WQsWi6J+fPvH49Fd3ZzIfg2fPYZkwKP/M1lGKBzF9hpVAZcu
         Fp9YjXrUXfktUkjqRTTsTGSeCGBhhZHWMHytg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIZRPhzhxvlQPAhRZLYpwVWj9ulUHGVA0m8o8NVr9w0=;
        b=WoUb0flvhUSUsAiDWMToP81Epbt4alTAb91fyFTdfFM7Q+yHm3LchsaP7jTS2+X51N
         qW/0rb+lSAmQuvz071cTd2IAsdHr/vZHH8ipG5spzK4C/WwxQVXtR9sfMu89Kh7CvogR
         BynhlHb/MCmjGbeqzEQwj6m5mEtewGy2FXiLwwUmiJ3+6sh3Bo2adrLhTn7qhAvVOqGo
         Lw1dOs8Fwj5e/bsCsYv6rmj2+cyaWe807JJhFy05yS5yB9bC5n4gJ2BmiEjbWxYfXcsX
         zE4yp4jtVs2fjkfZuD6dMlhrH0JwedR4iM8ZN0qIuJG9P0OKPb/dRvqINWzYDnAR7TsA
         to1g==
X-Gm-Message-State: AOAM531sdwY3JUWAlB9n2SXcMdu5kLcojeuetXoHBoVTE9e6f++0/7Em
        10hY2r/NgAPeBVmdJXsF8d1jIA==
X-Google-Smtp-Source: ABdhPJwejuQGe9h7jhPsWtvn9CGO7dvBWRvMPyLjF83kiV6/cuYjbXhBPy3jfz9LBFNhccmJLw4dLw==
X-Received: by 2002:a4a:9298:: with SMTP id i24mr14320378ooh.5.1596831386067;
        Fri, 07 Aug 2020 13:16:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x70sm1982965oif.3.2020.08.07.13.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 13:16:25 -0700 (PDT)
Subject: Re: [GIT PULL] kallsyms_show_value-fix updates for v5.9-rc1
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202008071250.7DC8D5FF61@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d625f256-0f99-05df-1fd2-94d3bd302bcd@linuxfoundation.org>
Date:   Fri, 7 Aug 2020 14:16:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008071250.7DC8D5FF61@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 1:55 PM, Kees Cook wrote:
> Hi Linus,
> 
> Please pull this fix to my kallsyms_show_value() refactoring for
> v5.9-rc1. About a month after the original refactoring landed, 0day
> noticed that there was a path through the kernfs binattr read handlers
> that did not have PAGE_SIZEd buffers, and the module "sections" read
> handler made a bad assumption about this, resulting in it stomping on
> memory when reached through small-sized splice() calls. I've added a set
> of tests to find these kinds of regressions more quickly in the future
> as well.
> 

Awesome. Thanks Kees.

> 
> The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:
> 
>    Linux 5.8 (2020-08-02 14:21:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-fix-v5.9-rc1
> 
> for you to fetch changes up to 9af47666cb0f331bfcd76799ee368cdfcb00882c:
> 
>    selftests: splice: Check behavior of full and short splices (2020-08-07 10:50:11 -0700)
> 
> ----------------------------------------------------------------
> Fix sysfs module section output overflow
> 
> ----------------------------------------------------------------
> Kees Cook (2):
>        module: Correctly truncate sysfs sections output
>        selftests: splice: Check behavior of full and short splices
> 
>   kernel/module.c                                    | 22 +++++++--
>   tools/testing/selftests/splice/.gitignore          |  1 +
>   tools/testing/selftests/splice/Makefile            |  4 +-
>   tools/testing/selftests/splice/config              |  1 +
>   tools/testing/selftests/splice/settings            |  1 +
>   .../testing/selftests/splice/short_splice_read.sh  | 56 +++++++++++++++++++++
>   tools/testing/selftests/splice/splice_read.c       | 57 ++++++++++++++++++++++
>   7 files changed, 137 insertions(+), 5 deletions(-)
>   create mode 100644 tools/testing/selftests/splice/config
>   create mode 100644 tools/testing/selftests/splice/settings
>   create mode 100755 tools/testing/selftests/splice/short_splice_read.sh
>   create mode 100644 tools/testing/selftests/splice/splice_read.c
> 

For selftests part.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
