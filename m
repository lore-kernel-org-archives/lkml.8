Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE29C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053F20838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="wdSfUa9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCZJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:23:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38053 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCZJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:23:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so6802815wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCq0cMZFL5YKjrRymewcPmfdY/+U3QFHvibyA/UA0EM=;
        b=wdSfUa9fXkTxk6SAooj0EMqhEemdVCAWUYagyKUugjT86tKyyvSLhv2/FiUiyov4hj
         89WD+pgTLUpbrkBkpZJ/0bKwhJcaYs3WznzozuSx0anb2PFHcy7AGNIu/VpLXY158ZoU
         yjgZpE+3CSeZ6vn8gXwkBjTvqO0VqsRYxIedSj0klcjx4P/6D7+CI56RoMQfXUQMZ8Ii
         LVIaMn5jvETT3zik+AVmi48zuFg97z2HGEBO+LQfoOnpdmThCA/SUbD3HPQN1SyvMQK+
         HFnS09leWdTNU0v6ORvnW5LYWsMKag0syHH0AC36RD/fIHHJmajqty41YHeBypHjExs2
         rD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCq0cMZFL5YKjrRymewcPmfdY/+U3QFHvibyA/UA0EM=;
        b=cFVimj7q2AFwOsY9wSTbOq8pUgAigUJIADn125AgaMmGICCuTNBiyy+2yJMuz5mSXr
         u1F0RJNIbQjoNAirN2GqJMUYUChNuFFVDfe9mIgJ/YwbMRmXjawvafte/0RPz0GFRmkT
         vqKHkodFmw01Z6PkcC3xWOtsouguFIXKkppuqB8ySkfalAYUQlkTMj38KvnkusTyqXFI
         WbHAmVOh/QYhnlw03Ge92NiIE9f2KVgERrxGrxDUg9lSZ0En2wfesVal+dHmBMExPvH+
         OliOQ+Kq7aGyueUrmk9vin1S5W0NUhX7IZEPnQVk875VosSv48V/hE1/ogthSSYWKeCO
         MmkQ==
X-Gm-Message-State: ANhLgQ0gCFXL3xtTLSRMkvoR1DiLPBIWAQlG+i4Y+VQeJpiAZm+fqMCn
        V5F1fYmXaCwaiGQgNseFNZ/xbaPWjmuySOo8
X-Google-Smtp-Source: ADFU+vt9docCioSkc9NiHMBLy3kC56uqVBuM4+xxcH9k4v/ldbSjC99vA5BdNc5GOByqORl9VCC0yw==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr8066426wrw.274.1585214614992;
        Thu, 26 Mar 2020 02:23:34 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:4468:e57e:609:75e5? ([2a01:e0a:3cb:7bb0:4468:e57e:609:75e5])
        by smtp.gmail.com with ESMTPSA id h18sm2552278wmm.34.2020.03.26.02.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 02:23:34 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCH v5 2/2] tee: add private login method for kernel
 clients
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
 <1585207429-10630-3-git-send-email-sumit.garg@linaro.org>
 <CAA-cTWZWPFtq-9MOrr6YDV4SGyo_JNaNsFJc=pjaWBrWHMid1A@mail.gmail.com>
 <CAFA6WYOvBNcGe+4ndq-YmM6haVoH4QiM7goYw5T40mR15muQKQ@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <b64c3ace-4558-deb5-7493-4837f48af188@forissier.org>
Date:   Thu, 26 Mar 2020 10:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFA6WYOvBNcGe+4ndq-YmM6haVoH4QiM7goYw5T40mR15muQKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/20 10:07 AM, Sumit Garg wrote:
> On Thu, 26 Mar 2020 at 14:05, Jérôme Forissier <jerome@forissier.org> wrote:
>>
>> On Thu, Mar 26, 2020 at 8:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> There are use-cases where user-space shouldn't be allowed to communicate
>>> directly with a TEE device which is dedicated to provide a specific
>>> service for a kernel client. So add a private login method for kernel
>>> clients
>>
>>
>> OK
>>
>>> and disallow user-space to open-session using GP implementation
>>> defined login method range: (0x80000000 - 0xFFFFFFFF).
>>
>>
>> I'm not sure this is correct, because it would prevent the client library or the TEE supplicant from using such values, although they are part of the TEE implementation; and further, nothing mandates that an implementation-defined method should not be used directly by client applications.
>>
> 
> Initial implementation of this patch only put restriction for single
> implementation-defined login method (TEE_IOCTL_LOGIN_REE_KERNEL) only.
> But after discussion with Jens here [1], I have changed that to
> restrict complete implementation-defined range. If we think to further
> partition this range considering API stability then I am open to that
> too.
> 
> [1] https://lore.kernel.org/patchwork/patch/1088062/

In the end he proposed to reserve half the range for user space and half
for kernel space.

(BTW sorry for my previous HTML reply)

-- 
Jerome
> 
> -Sumit
> 
>> --
>> Jerome
>>
>>>
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>  drivers/tee/tee_core.c   | 6 ++++++
>>>  include/uapi/linux/tee.h | 8 ++++++++
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>> index 37d22e3..533e7a8 100644
>>> --- a/drivers/tee/tee_core.c
>>> +++ b/drivers/tee/tee_core.c
>>> @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
>>>                         goto out;
>>>         }
>>>
>>> +       if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
>>> +               pr_debug("login method not allowed for user-space client\n");
>>> +               rc = -EPERM;
>>> +               goto out;
>>> +       }
>>> +
>>>         rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
>>>         if (rc)
>>>                 goto out;
>>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>>> index 6596f3a..19172a2 100644
>>> --- a/include/uapi/linux/tee.h
>>> +++ b/include/uapi/linux/tee.h
>>> @@ -173,6 +173,14 @@ struct tee_ioctl_buf_data {
>>>  #define TEE_IOCTL_LOGIN_APPLICATION            4
>>>  #define TEE_IOCTL_LOGIN_USER_APPLICATION       5
>>>  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION      6
>>> +/*
>>> + * Disallow user-space to use GP implementation specific login
>>> + * method range (0x80000000 - 0xFFFFFFFF). This range is rather
>>> + * being reserved for REE kernel clients or TEE implementation.
>>> + */
>>> +#define TEE_IOCTL_LOGIN_MASK                   0x80000000
>>> +/* Private login method for REE kernel clients */
>>> +#define TEE_IOCTL_LOGIN_REE_KERNEL             0x80000000
>>>
>>>  /**
>>>   * struct tee_ioctl_param - parameter
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> Tee-dev mailing list
>>> Tee-dev@lists.linaro.org
>>> https://lists.linaro.org/mailman/listinfo/tee-dev
