Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E4CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9FF2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cgZg2f4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgGURLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgGURLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:11:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4AC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:11:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q3so17040888ilt.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yWaQmsiCiZZZ3Uj8uamide4LdDUSTz+/SoKFonKhAb4=;
        b=cgZg2f4sd5KgzapbCbk47ql+PhAAt+zV2ric/v9iIjaESnZgeOgpZeGKtGwr7Guiqb
         7m/qpv9dJvOsT33Dm8kbaPrszNy/70thpJG4rBdFsKLft/Jd6dLWk34bU/WkZh0nk/ri
         chNuRg3DUWLT9xFsI7E71aiXfNNfuuYQqGrGsXweihhOrp+ZODIq6cevaSEBmiM0KTDB
         cji5uM5VWXCMUNLKEzcUlpghhGTQDBbq8mE1tVXpTiYOOjNdKBkdgSrEOufMx4gCrBOj
         0L7CSdIG+y0ec0mh5PV3bqTap3A1SOyjKieW48+lPV1Hkh9KX68w5QPASQxzdfId+iBK
         gmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWaQmsiCiZZZ3Uj8uamide4LdDUSTz+/SoKFonKhAb4=;
        b=b7DPyoRseomvyDuJp9dZs2BFPu1ND/UPl/abxCA3ZnWluoEaVHY9qQn2l6Hv7cUGbo
         59FigeWX6i0pGeHlDibW+7hewpr1xhNBR5sy8vVC5Yjw5wVtYxCI/963KNPWK265QDXw
         xlyBJ0R/EAiB0DVpP7F4FTNos07loU0Kpg/HEgF3DSSGjms6poFNXC41YwlTpDN9qG9R
         YvOA+FHGDGvPZrKjVqBg6kGfdV2dNVCfoGHHH6Z3FxINlqLDljvmZWJY50RmhVTDaXMX
         OoT8O6jE1RZdo9Tiq4hzz+J7ZUD50UDs7R7hb3BvS2QxRz+LUzoPonWDLgV9n7SAgUb8
         Af2w==
X-Gm-Message-State: AOAM530OvH26CM35OgdE2ujcXyZ9CMEMGZbci6uw7+OQWxzllDrgQrUi
        ZUGpzLFdrz5u2eG4T1rO3nZRj9cmhOF2Zw==
X-Google-Smtp-Source: ABdhPJz/BZFEORJm8VP+fSEBvPITI4MrX63+k47jktVuZG2VxxBRTWs5F6VJi5EgR+nyts+EBlISmA==
X-Received: by 2002:a92:8544:: with SMTP id f65mr29398838ilh.42.1595351479058;
        Tue, 21 Jul 2020 10:11:19 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l17sm10499667ilm.70.2020.07.21.10.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 10:11:18 -0700 (PDT)
Subject: Re: [PATCH RFC v2 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-3-sgarzare@redhat.com>
 <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
 <20200721104009.lg626hmls5y6ihdr@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15f7fcf5-c5bb-7752-fa9a-376c4c7fc147@kernel.dk>
Date:   Tue, 21 Jul 2020 11:11:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721104009.lg626hmls5y6ihdr@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/20 4:40 AM, Stefano Garzarella wrote:
> On Thu, Jul 16, 2020 at 03:26:51PM -0600, Jens Axboe wrote:
>> On 7/16/20 6:48 AM, Stefano Garzarella wrote:
>>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>>> index efc50bd0af34..0774d5382c65 100644
>>> --- a/include/uapi/linux/io_uring.h
>>> +++ b/include/uapi/linux/io_uring.h
>>> @@ -265,6 +265,7 @@ enum {
>>>  	IORING_REGISTER_PROBE,
>>>  	IORING_REGISTER_PERSONALITY,
>>>  	IORING_UNREGISTER_PERSONALITY,
>>> +	IORING_REGISTER_RESTRICTIONS,
>>>  
>>>  	/* this goes last */
>>>  	IORING_REGISTER_LAST
>>> @@ -293,4 +294,30 @@ struct io_uring_probe {
>>>  	struct io_uring_probe_op ops[0];
>>>  };
>>>  
>>> +struct io_uring_restriction {
>>> +	__u16 opcode;
>>> +	union {
>>> +		__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
>>> +		__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
>>> +	};
>>> +	__u8 resv;
>>> +	__u32 resv2[3];
>>> +};
>>> +
>>> +/*
>>> + * io_uring_restriction->opcode values
>>> + */
>>> +enum {
>>> +	/* Allow an io_uring_register(2) opcode */
>>> +	IORING_RESTRICTION_REGISTER_OP,
>>> +
>>> +	/* Allow an sqe opcode */
>>> +	IORING_RESTRICTION_SQE_OP,
>>> +
>>> +	/* Only allow fixed files */
>>> +	IORING_RESTRICTION_FIXED_FILES_ONLY,
>>> +
>>> +	IORING_RESTRICTION_LAST
>>> +};
>>> +
>>
>> Not sure I totally love this API. Maybe it'd be cleaner to have separate
>> ops for this, instead of muxing it like this. One for registering op
>> code restrictions, and one for disallowing other parts (like fixed
>> files, etc).
>>
>> I think that would look a lot cleaner than the above.
>>
> 
> Talking with Stefan, an alternative, maybe more near to your suggestion,
> would be to remove the 'struct io_uring_restriction' and add the
> following register ops:
> 
>     /* Allow an sqe opcode */
>     IORING_REGISTER_RESTRICTION_SQE_OP
> 
>     /* Allow an io_uring_register(2) opcode */
>     IORING_REGISTER_RESTRICTION_REG_OP
> 
>     /* Register IORING_RESTRICTION_*  */
>     IORING_REGISTER_RESTRICTION_OP
> 
> 
>     enum {
>         /* Only allow fixed files */
>         IORING_RESTRICTION_FIXED_FILES_ONLY,
> 
>         IORING_RESTRICTION_LAST
>     }
> 
> 
> We can also enable restriction only when the rings started, to avoid to
> register IORING_REGISTER_ENABLE_RINGS opcode. Once rings are started,
> the restrictions cannot be changed or disabled.

My concerns are largely:

1) An API that's straight forward to use
2) Something that'll work with future changes

The "allow these opcodes" is straightforward, and ditto for the register
opcodes. The fixed file I guess is the odd one out. So if we need to
disallow things in the future, we'll need to add a new restriction
sub-op. Should this perhaps be "these flags must be set", and that could
easily be augmented with "these flags must not be set"?

-- 
Jens Axboe

