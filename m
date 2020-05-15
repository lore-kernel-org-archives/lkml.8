Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A4B2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UnQQdzA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEOX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgEOX2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:28:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960ADC05BD0B
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 16:28:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so1742363pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 16:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E8j1zsP3t9Db9IDf/V9aE8nyZ2/Ryf+TXAxn3gqfEkQ=;
        b=UnQQdzA2k7WTu3soGTuHp6WGTD+qiK8qSJb8mk1Pn9H2eum+E9Ts+BBJn73fEbeHhn
         RCvwsXpvTKZDN9nf0ieSFsKQIBNAAhSy3JGMSLqfTBgCWzn69SZ6AjRrdwRptGXc6OxA
         GMwQn9MzvTX7QqrnZx+alQ0//TqjxC7Ikw4bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E8j1zsP3t9Db9IDf/V9aE8nyZ2/Ryf+TXAxn3gqfEkQ=;
        b=kzc3Tr2MfUt+5bNrU8pFYwAcFCmm5vtfgYmRDKCgfmp1llJv9+dRs1tAg10Nnbe+ts
         iMyhiYm9SWDZaK1VdT7iO98SU9XYARi+KrFyMqjH2P8c5sqeFIcmdR+1hqGAQRZvRd/p
         wVf9ArCGB/l6x/bHMdhnd5+2HT98CdpfDKjMkbw2T7nUymvOQYN7IC6tIY8HjRBzrOUe
         l/BIxNpl2A3c9QEZr+q3w7S3nYsohdVrQJfVwkNBz6LM4JpVkHI1oE82mdPR9MLChRv3
         VX45XfXiCYMfIt/MRLHyKq/g6C6fmtV+H51JWevIl7hG2k8EqfYPdyEtRBX+96/Wyyv/
         eadQ==
X-Gm-Message-State: AOAM532Bv16kwrqE3uGePEyEKfx+aLTj4Jf/ZN6RRgxuDrE5OQAUqeIj
        voXJOOS7ZPsd7Q4ABM5KGJUjmQ==
X-Google-Smtp-Source: ABdhPJzDjdFyP0pP2LVm3Q8vARDClgR1ApLEZE6gM2tCxeAVs7H8OmgkHRMJ22dzucxwh+mZ6qJIdA==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr6259587pfj.256.1589585292833;
        Fri, 15 May 2020 16:28:12 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b13sm2543954pgi.58.2020.05.15.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 16:28:11 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] firmware: add partial read support in
 request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>, Mimi Zohar <zohar@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <1589387039.5098.147.camel@kernel.org>
 <20200515204700.GC11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1e75c270-eae5-8f1d-ecc6-1fd2fb248f29@broadcom.com>
Date:   Fri, 15 May 2020 16:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515204700.GC11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2020-05-15 1:47 p.m., Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 12:23:59PM -0400, Mimi Zohar wrote:
>> Hi Scott,
>>
>> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>>> Please consider this version series ready for upstream acceptance.
>>>
>>> This patch series adds partial read support in request_firmware_into_buf.
>>> In order to accept the enhanced API it has been requested that kernel
>>> selftests and upstreamed driver utilize the API enhancement and so
>>> are included in this patch series.
>>>
>>> Also in this patch series is the addition of a new Broadcom VK driver
>>> utilizing the new request_firmware_into_buf enhanced API.
>> Up to now, the firmware blob was read into memory allowing IMA to
>> verify the file signature.  With this change, ima_post_read_file()
>> will not be able to verify the file signature.
>>
>> (I don't think any of the other LSMs are on this hook, but you might
>> want to Cc the LSM or integrity mailing list.)
> Scott, so it sounds we need a resolution for pread for IMA for file
> signature verification. It seems that can be addressed though. Feel
> free to submit the u32 flag changes which you picked up on though in
> the meantime.
Sure, I can submit a new patch to change the existing enum to
a u32.  For the new pread flags I am adding I could also leave as
a u32 or change from a u32 to an enum since there is currently only
one flag in use.  Then, in the future if another flag was added we would 
need
to change it back to a u32.

Please let me know what you prefer for the pread_flags.
>
>    Luis
Thanks,
  Scott
