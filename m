Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DC020C56
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590686911;
	bh=xCGEDgZwvx0pRFF3BwlP1BNUPepPTvQG3TwTW6PfIq4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=h1ECIrPgTKWnr9z/lxZ/bdit23B9EitfIADPWkEtP5cvM1u+73x2YUQNlqxxtA2qq
	 3JpPK4lDwgL79Bk7ELtANzhVs/xW8BxAfAAw17RmdYA549Aar88JCl3XbLHxB+Uhs/
	 cIPjqXPzxw+/qm/hdQU8aaqzjFlSbstKb4fc59kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbgE1R2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405507AbgE1R22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:28:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F14C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:28:28 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r67so765918oih.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHyYz6nP7wTksJQUG/djnUS6+jOyIk+f5n0ywhaKoDw=;
        b=MuSRtJI8VTGc0UCEzAz3cuwZDM2mqqIlSnl5vwZVEY+qBeK7LBTNAmhIB77xiHMlmK
         aJx4mbm4O7iNGqKCDbgCzCpTOttRxL774RYYI69d2wkxl4WK5OQfovvWFrs0W6ntR8h5
         /HN6NraT5wLOdz1a5pqfhH63Ig7NIhYPJPpuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHyYz6nP7wTksJQUG/djnUS6+jOyIk+f5n0ywhaKoDw=;
        b=bc/r1PHlhyoKdB5vCQoAdVAwGgvVNtECpyalA+Nff0LOOjsok+nBUTzBzaqg8f12zX
         qprzmmliqIJOcdXQmHtUBdaM1j3OGW0a49NXDjOrJkOhWEulc2m3MJJUTSo7GAp0Kyx2
         tC/7rLqlqRdWsBTpbaxOurreKkBuNBDikC1L/pO5UYMz8Oq1CZZUnWohfobUrW6FZO59
         LT25735pjDBW2U+sCPASSK7V23/4kkOcCW/YPjRPuSDi9IjDM4WXUBeJK9G0gHEj/1Z2
         HEp1vwEKWmMWe5JqVSpmuB7U+6QAn6gE3usdabSMMWzp8cdUVpbJNT2TsENgfnKgurwD
         lDaw==
X-Gm-Message-State: AOAM533JfTmkuJsUURV7ShY3rJSPzEAdv12C/NcH6JHFbRBYjRttd7rG
        XL6R05J0ugCH5zvr0Bwct46Nfw==
X-Google-Smtp-Source: ABdhPJz8K2qEpKSG8d/E96Ivi+1oX/z6t2E69KX04odQ/hKLRgeQYkcpMySfRzy/nyC+2t/bI1VHWA==
X-Received: by 2002:aca:ad45:: with SMTP id w66mr2974934oie.59.1590686907819;
        Thu, 28 May 2020 10:28:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e190sm1995327oib.5.2020.05.28.10.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:28:26 -0700 (PDT)
Subject: Re: [fixup v2] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200527003420.34790-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
Date:   Thu, 28 May 2020 11:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527003420.34790-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 6:34 PM, Vitor Massaru Iha wrote:
> To make KUnit easier to use, and to avoid overwriting object and
> .config files, the default KUnit build directory is set to .kunit
> 
> Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> 
> Fixed this identation error exchanging spaces for tabs between lines
> 248 and 252:
> 
> tools/testing/kunit/kunit.py run --defconfig
> 
>    File "tools/testing/kunit/kunit.py", line 254
>      if not linux:
>                  ^
> TabError: inconsistent use of tabs and spaces in indentation
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Vitor,

This patch doesn't apply. Can you change to subject to be unique
Fix TabError and do the patch on top of linux-kselftest kunit

I think you did this, but I can't apply this on top:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit

thanks,
-- Shuah
