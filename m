Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3408C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C152065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mxga3zG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbgEMS5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390512AbgEMS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:57:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA905C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:57:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j13so1385888pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=olYgNFifDF5Ql8cvhPsDTbAfAKaoIaJE4DaDog+mNS4=;
        b=Mxga3zG+/llCfFVNMb4pfupbzjfgaM9EEesFiwESfHj8FFQxGRavYEICkCcOqf1FNC
         WEltsqblrtZzlLWK+i4JwtOaroJ1sJY3Et7c7VKZ2VMKq2LBYLjkFaGsc+g3KmoJbwpe
         9gJXssiGnu0P62bGFSfvvpRogr+D+sPmJasFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=olYgNFifDF5Ql8cvhPsDTbAfAKaoIaJE4DaDog+mNS4=;
        b=M5/FdD4JQ0oEWp17d/O/gwomtRJ2Q3Tiwvf3rzZ83la8strwDXwnzbw8plLq/Hc3G3
         PgdOAPHz2YgCwuA3qYQlcuxNKanJ6Sb3ZvDGIZCwyD2vHE0DJMn+YE/e88tkLFpl7fJl
         S7nze9eE2HXLZLZhVb82CkyMYgn7Kw4iHRA5MOzWI5H5f0cSwRewOs2uTLdhwbozTuGc
         Ol0ei2Wb+SN7+B7Si1g92uYnvt9xpmroqcS93/NFowrx32Eo08O9vxVq3qJ6dPp7xkbz
         XtbCE/Rm2xRfUioTdNAVGu3Zl3L78eRcWGWZZWlSgHrqKJXP9afeq0IaPpqNcjR8vufs
         FL9A==
X-Gm-Message-State: AOAM5314h6+WtR+hRHTxQCnP4hSzEVFU4VbwxhdH6stcAU0j03QIvBkm
        AhviKNEl8oU+5JFmb1vZN1NZ/g==
X-Google-Smtp-Source: ABdhPJyNy9Rl7h8JlfCsAM2l3oYqsGcSQPFVLty424N5CPNqdloYyrOidsbzuToZPmVBZWv6P8ZZzw==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr518815plb.325.1589396234214;
        Wed, 13 May 2020 11:57:14 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm360743pgm.73.2020.05.13.11.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:57:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Scott Branden <scott.branden@broadcom.com>
To:     Mimi Zohar <zohar@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
Message-ID: <104a1eea-6b55-d857-04b9-d13aed9a36fd@broadcom.com>
Date:   Wed, 13 May 2020 11:57:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-05-13 11:53 a.m., Scott Branden wrote:
> Hi Mimi,
>
> On 2020-05-13 11:39 a.m., Mimi Zohar wrote:
>> [Cc'ing linux-security-module, linux-integrity]
>>
>> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>>> Add kernel_pread_file* support to kernel to allow for partial read
>>> of files with an offset into the file.  Existing kernel_read_file
>>> functions call new kernel_pread_file functions with offset=0 and
>>> flags=KERNEL_PREAD_FLAG_WHOLE.
>>>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>> <snip>
>>
>>> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void 
>>> **buf, loff_t *size,
> The checkpatch shows this as kernel_read_file when it is actually the 
> new function kernel_pread_file.
typo: "checkpatch" should be "patch diff"
> Please see the call to kernel_pread_file from kernel_read_file in the 
> complete patch rather this snippet.
>>>             if (bytes == 0)
>>>               break;
>>> +
>>> +        buf_pos += bytes;
>>>       }
>>>   -    if (pos != i_size) {
>>> +    if (pos != read_end) {
>>>           ret = -EIO;
>>>           goto out_free;
>>>       }
>>>   -    ret = security_kernel_post_read_file(file, *buf, i_size, id);
>>> +    ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>>>       if (!ret)
>>>           *size = pos;
>> Prior to the patch set that introduced this security hook, firmware
>> would be read twice, once for measuring/appraising the firmware and
>> again reading the file contents into memory.  Partial reads will break
>> both IMA's measuring the file and appraising the file signatures.
> The partial file read support is needed for request_firmware_into_buf 
> from drivers.  The EXPORT_SYMBOL_GPL is being removed so that
> there can be no abuse of the partial file read support.  Such file 
> integrity checks are not needed for this use case.  The partial file 
> (firmware image) is actually downloaded in portions and verified on 
> the device it is loaded to.
>
> Regards,
>  Scott

