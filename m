Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA25C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDAE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWJ9KsnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMH54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:57:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727021AbgAMH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578902274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRCNtJBa3pAnVzkWFvQcFj8dlg5Kh5b/Y+kQmy5E3UE=;
        b=XWJ9KsnAKXJUNX/QQPMcFN8TKS/KquapDLJgj3nZo+cFE8DcqJu+F8VH0zV4pfnyJTrsqW
        8Hh+wlro0cn8cgI0PDIVJt/bCO5sbkB5KID4iKkJXKIrLZO6uq5W2b/ebph8ZozgAXa5bT
        XCRbCBZM/JvXEUx2ZkMIS6oFZ70aqM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-d1obQ6SYNrKntRExGLasdQ-1; Mon, 13 Jan 2020 02:57:52 -0500
X-MC-Unique: d1obQ6SYNrKntRExGLasdQ-1
Received: by mail-wm1-f71.google.com with SMTP id c4so2224884wmb.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 23:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRCNtJBa3pAnVzkWFvQcFj8dlg5Kh5b/Y+kQmy5E3UE=;
        b=iJfUTgNzOP/ZFQtYvQidj+mzOlRaLTLdESQ5CKc2Z975ySemUYtXpBMDKkBKrw4x/k
         ju3/HertezLKmBNFJWpWa93GokIUhfWYVD2b4PKiqyt9Lb3+xcBDGJvKJbW3+tI/WdQ/
         8kOKiffJziYogxqGfBKmW5vyyiOMHNuIYzNx2PlI4tycjgZlXMuasINaRea1hAwWmPKn
         qXxqx9cN987CrYwnesikFfRTkBNvfbyH6WOG6IB//h9mHe4oKkHoONz6S5WuLiGmhurp
         8ZJLmie7DZpIgFT0v0vznlfuTPMiQVd72Xvre4OBVoDJhlrCbu6PNFq8h+pYeZX7Yxzl
         zxqg==
X-Gm-Message-State: APjAAAXOp/uRxGET/a/K1o1BqzNOKqXlnWyv6owiuFwt8JfOenx5AQF/
        GZyDN0eRNb4WJpW9uerUuasJOCIk9HDde6XVlIvKJL+u+oOipH3JdjRSpcOriZM7DGFHl2TmBxZ
        YpwjLUAib9CbqdToZdz9oC/pV
X-Received: by 2002:adf:b193:: with SMTP id q19mr16871566wra.78.1578902271130;
        Sun, 12 Jan 2020 23:57:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqIhiJZej9sb5HxMulHntphAZP0eMI9QslhV7jkOwDAMQtJgRyF42O5Ld6R4wBUaye/bVyQA==
X-Received: by 2002:adf:b193:: with SMTP id q19mr16871542wra.78.1578902270852;
        Sun, 12 Jan 2020 23:57:50 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id g18sm13034427wmh.48.2020.01.12.23.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 23:57:50 -0800 (PST)
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com>
Date:   Mon, 13 Jan 2020 07:57:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 1/12/20 8:42 AM, Nathan Chancellor wrote:
> 
> Hi Julien,
> 
> The 0day bot reported a couple of issues with clang with this series;
> the full report is available here (clang reports are only sent to our
> mailing lists for manual triage for the time being):
> 
> https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ
> 

Thanks, I'll have a look at those.

> The first obvious issue is that this series appears to depend on a GCC
> plugin? I'll be quite honest, objtool and everything it does is rather
> over my head but I see this warning during configuration (allyesconfig):
> 
> WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
>    Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
>      Selected by [y]:
>        - ARM64 [=y] && STACK_VALIDATION [=y]
> 
> Followed by the actual error:
> 
> error: unable to load plugin
> './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
> './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
> open shared object file: No such file or directory'
> 
> If this plugin is absolutely necessary and can't be implemented in
> another way so that clang can be used, seems like STACK_VALIDATION
> should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.
> 

So currently the plugin is necessary for proper validation. One option 
can be to just let objtool output false positives on files containing 
jump tables when the plugin cannot be used. But overall I guess it makes 
more sense to disable stack validation for non-gcc builds, for now.

Once people are happy with the state of things of arm64 objtool with gcc 
it might be worth looking at a clang plugin (although I don't know if 
the kernel has any support to build those at the moment).

In the mean time, I'll do as you suggest and rely on CC_IS_GCC.

> The second issue I see is the -Wenum-conversion warnings; they are
> pretty trivial to fix (see commit e7e83dd3ff1d ("objtool: Fix Clang
> enum conversion warning") upstream and the below diff).
> 

Oh yes, these are valid warnings. I'll fix those.

> Would you mind addressing these in a v6 if you happen to do one?
> 

Yes, I'll most likely do one as I don't expect this to be a final version.

Thanks for reporting those. I'll fix them in the next iteration.

Cheers,

-- 
Julien Thierry

