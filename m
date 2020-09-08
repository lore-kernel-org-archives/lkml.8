Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D1BC2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C4C204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595690;
	bh=ygSqGvXe2eiw11gl73xv8ND+uiCYj5lsp6k+Fw3NqBY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=BDNcLFSVvb0wgpZcInqV9ozSF/Xc/YKZFO00jB+elWlQOZH/FjPCEtBD0UnedN7GU
	 IqIRBzvWyLzuETHeIzdQuj1XORjciJv3ZX1+D5bYueM+s3E/dQ7OV4W7SPY12duqQx
	 5NqBao3N8WWWiDttropSiYfYqQjAFsvKVV6M/x9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgIHUIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbgIHUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:08:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:08:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so717791ioe.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uaM8vUsFC56bK1f61nDas4I4sfPBn95e3OUH/QbJ7q0=;
        b=JU8Eo3SAZSpvZFivo74bcIxLxvbhmvpW9bsQuZKHtZ/P3PFj4ISG2HqIfo7MPTUWOG
         dn+1cLKJtqYCjk3DOnJelHE9KNVj8Sn2gkBEiqupXcGmPah1QjGCPfwFjoOXFNh6GYWn
         Us/xQ1r9EFANyxmzRNNGTQsWSjVWHjIyIBVzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uaM8vUsFC56bK1f61nDas4I4sfPBn95e3OUH/QbJ7q0=;
        b=VSg9ypQJBOWkL4K8esDjxAybUv8QogJHU3cGSjO2DsZh9Z5x/6Qi6iDU/SxN2oTNBu
         zfwJux/x/ODNcjVTG71kusMRzqUiYS6M+nlui2M/fhWaQgkmeB/7u7EqWMcTXxVsCXyi
         2ODywqC96lDUFvKMBGVhE+RYiKq/PEak4CfWbYSHZaUlkx8LI/aZzaUhzAp+Z5Jpxwk/
         OWoqD2rb3KfbN9qqJDHhGXBBsIasm6TpfVRR3+5MwWnllYZ+iJBtQ7bquT5uDQpvpRkv
         7Q7La7qME0iH1n4xuYNBYE0BgfuWsQlV/A8H+Kggr14KddEd0oi91fk7yIqMtoWiAQJz
         qiKw==
X-Gm-Message-State: AOAM530HCasKOAHCpTxRDG+phsF3j2QOhINKZVWV/wmJpnHbevGPPL9k
        cij2Jivmp1uc7tzTdLGi+M/xvTl1k2leag==
X-Google-Smtp-Source: ABdhPJxdJXco5oWWxCEmLUw9bkzoqXLBitkSsdbtacHo7fw6PgnUfniVyhJfviUHS65OCv7RhPMU7w==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr492794ioq.41.1599595679503;
        Tue, 08 Sep 2020 13:07:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w15sm88442ilq.46.2020.09.08.13.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 13:07:58 -0700 (PDT)
Subject: Re: [PATCH] selftests/seccomp: Add test for unknown SECCOMP_RET kill
 behavior
To:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202009081232.92206075F7@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <486baf92-5051-e099-628a-ccee4eada6f3@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 14:07:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009081232.92206075F7@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 1:35 PM, Kees Cook wrote:
> While we testing for the behavior of unknown seccomp filter return
> values, there was no test for how it acted in a thread group. Add
> a test in the thread group tests for this.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> (This is going via the seccomp tree.)

Cool.

> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++++++++---
>   1 file changed, 37 insertions(+), 6 deletions(-)

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
