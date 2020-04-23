Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039BC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6C220728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587679657;
	bh=4vjmcAoEw04l2V8m6FsN1oyvQD+Z6v+Kw6HAImQoYE0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UtsIYszErS8NRZP1cJfKWyDJkVDs/HP2XGlHPPng8a+KFWXFjA54X/kSrxPI00D1d
	 ODOh7p2vM7lV6KWAVIio9G60he1qiyRIP+EJdcChWzu0fSvJTBaazGL79K+71Ncw+J
	 EjRMkoXKChAmnfO9gtOiORJWZ3KPyAaGWJMicER4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgDWWHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDWWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:07:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5AC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:07:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u11so8305011iow.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NAMx4wud/Mi7YohlwtY2GeSPAKTse+6Zaacz6L0GB4k=;
        b=Lo+wxziG4e9zqEKOLc1QBrh8YdwMKE9QbsdG7j/we8WguL6xCqPu3+WLl0j2Sj191J
         pj7F5wcaFn2UX+t2KRFHgPnKC0lwLQT/dO6ZnEDG+kBZ4lI7YvzZRYyTF2Pri1mLJGLm
         do7qYwzCv/UxZKqvve0/yumPGAbraqJwsctWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NAMx4wud/Mi7YohlwtY2GeSPAKTse+6Zaacz6L0GB4k=;
        b=OSutpIUwChe2xj3aaamI/qr9KUbiwyGxfC5KFlFx3F3O03CVNU73vr5X2NbaeMe+oC
         gZ9ebbo7cJYiamS+9+6URghU0wBXXVw0PDAVj69Mq4PZymw61gdqJF760ZFS6DP2oUJn
         2ianAcu4ygCQ2w9BC1p3OkzdWhErgeAjYDmAaeCUEvV7XWqDuPs/g4eSgTiAsHbS7eby
         2g7u2hBp/mfqJexI0qhzAr/YVME3RqPDypNrupATTYCHqZeHgjKx9Mx+y0YQ9yX8Ewmm
         EsOgbqWaG1fR6qPxvgWvncAv7i09nYKGSeuo4l9t/y8CQmTXckmQJNFGYqDAmO5Vy8Bg
         e2Uw==
X-Gm-Message-State: AGi0PuZxrlSh9exg/CryOxwxVFvw7mdc5j77HMtT3m4hhQibkhnRM0lC
        e/B8vjMNEFjUYpLUNYvL7rZ+qiKpHrA=
X-Google-Smtp-Source: APiQypIf1AGfqowv5bNcmPIYb8uM6nxk+6mxvj/psnlguiKv+yM9vdBjwInxyKgJm5rujF1qs4t61A==
X-Received: by 2002:a05:6638:f0f:: with SMTP id h15mr5542081jas.142.1587679654921;
        Thu, 23 Apr 2020 15:07:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e27sm1328363ild.78.2020.04.23.15.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 15:07:33 -0700 (PDT)
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200416114256.226329-1-elver@google.com>
 <CAFd5g46tezcWT7z6DFWBW=7604=_hNopuvkazE80sLOmJvcQbg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dd192a69-8b51-7ea9-4327-a48fc96eb68f@linuxfoundation.org>
Date:   Thu, 23 Apr 2020 16:07:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46tezcWT7z6DFWBW=7604=_hNopuvkazE80sLOmJvcQbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 1:35 PM, Brendan Higgins wrote:
> On Thu, Apr 16, 2020 at 4:43 AM Marco Elver <elver@google.com> wrote:
>>
>> Add missing newline, as otherwise flushing of the final summary message
>> to the console log can be delayed.
>>
>> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
>> Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks!
> 

Applied. Now in

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest kunit
branch.

thanks,
-- Shuah
