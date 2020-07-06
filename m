Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D70E206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH9wxfTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGFViC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGFViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:38:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA5C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 14:38:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so1390039ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCl4wVbcsht/zku6xJc527nvr4RdOXbi85FVXi9skdc=;
        b=fH9wxfTIjzfHa7HWFeWHMQu1lzSnZYl8rShWBP2JKkn6nkvQHjOzXWweDiPnxNMhIE
         /xYJas5omYRe8ca5w5EYN/S1XFDkHBEJItsxGmOfeq3DpHGItXYjBenscHl7YyViDuhN
         dt0eNrwOR3Zu1UKABYQg+bacEU5JpuvHwrPRZHOMF603I5CMrd946SEMWSQRxTRXZKQ9
         FSRSr8TsNz02XrHV9i+qYGvN5T0HrXA6MTh/OjutBYEnnvW3GYMzz9DmslA177sYAIeP
         pdvh6j3bmbf5OX+NyzBjk7LMkEz0pZq6Htvtnh+FlXjkUjTc3j9iORixGwpdr70nYtGH
         VIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UCl4wVbcsht/zku6xJc527nvr4RdOXbi85FVXi9skdc=;
        b=b8psHFf4asWd6AYD92vht0jt4Nw8BB8sEiYuR3v/g5JZHJVsM6OYNx3vG6LoeE5ESq
         qUYZwcj3PaLeZNFxrxFhQvfgmLWTzTnk4GoOb8agoNw41EnMl55no2lqvF2mNjrC14Ms
         wtjPQX4mPNvjW6fU/VAQ+Tj6s+nJVFqLLkct2+n//YtKnCqBIfQLQ/WM3Okvgs+7RwbD
         Gn3bKezeitfe/Y79u2wbMFi6oi6BBHIdm7gYB+OoA8voxSBoj0l3EHCb72QcuwCiSG9x
         Hv90I5yQ5Duod/Di1blgwiItsjIly/pL3WFtz00WhcUF+t9u7eZUFyt6KcI4HSN2C7lv
         Nxxw==
X-Gm-Message-State: AOAM531N2OT/h9aEcjFduL1g+pIlWnjonxvEA+AC+nHEhp1v/yLbzZeg
        GmdJF52sXAr8vNqt3//s73c2vn3+0WE=
X-Google-Smtp-Source: ABdhPJztqKDhuqTVGlApFi5Xx6MfjgXvqw25OM89vTRosSguHPyZObBACY3SUYbBBtCrbl8FjHQq8A==
X-Received: by 2002:a17:902:c404:: with SMTP id k4mr39348377plk.99.1594071481735;
        Mon, 06 Jul 2020 14:38:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm17711776pfq.205.2020.07.06.14.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 14:38:01 -0700 (PDT)
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to
 Linux error codes
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
References: <20200704142607.171400-1-linux@roeck-us.net>
 <20200706185230.GA792857@google.com> <20200706194120.GB180826@roeck-us.net>
 <CACeCKadx5vmqT9dnTTr49T3s-ZG1h3YnKZRvFVB4vrUhnD2faw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a6567dcc-8360-6537-3147-9da6ea1bcc64@roeck-us.net>
Date:   Mon, 6 Jul 2020 14:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACeCKadx5vmqT9dnTTr49T3s-ZG1h3YnKZRvFVB4vrUhnD2faw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 1:07 PM, Prashant Malani wrote:
> On Mon, Jul 6, 2020 at 12:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Jul 06, 2020 at 11:52:30AM -0700, Prashant Malani wrote:
>>> Hi Guenter,
>>>
>>> On Sat, Jul 04, 2020 at 07:26:07AM -0700, Guenter Roeck wrote:
>>>> The EC reports a variety of error codes. Most of those, with the exception
>>>> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>>>> error code gets lost. Convert all EC errors to Linux error codes to report
>>>> a more meaningful error to the caller to aid debugging.
>>>>
>>>> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>>>> Cc: Prashant Malani <pmalani@chromium.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
>>>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>>>> index 3e745e0fe092..10aa9e483d35 100644
>>>> --- a/drivers/platform/chrome/cros_ec_proto.c
>>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>>>> @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>>>>  }
>>>>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>>>>
>>>> +static const int cros_ec_error_map[] = {
>>>> +   [EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
>>>> +   [EC_RES_ERROR] = -EIO,
>>>> +   [EC_RES_INVALID_PARAM] = -EINVAL,
>>>> +   [EC_RES_ACCESS_DENIED] = -EACCES,
>>>> +   [EC_RES_INVALID_RESPONSE] = -EPROTO,
>>>> +   [EC_RES_INVALID_VERSION] = -ENOTSUPP,
>>>> +   [EC_RES_INVALID_CHECKSUM] = -EBADMSG,
>>>> +   [EC_RES_IN_PROGRESS] = -EINPROGRESS,
>>>> +   [EC_RES_UNAVAILABLE] = -ENODATA,
>>>> +   [EC_RES_TIMEOUT] = -ETIMEDOUT,
>>>> +   [EC_RES_OVERFLOW] = -EOVERFLOW,
>>>> +   [EC_RES_INVALID_HEADER] = -EBADR,
>>>> +   [EC_RES_REQUEST_TRUNCATED] = -EBADR,
>>>> +   [EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
>>>> +   [EC_RES_BUS_ERROR] = -EFAULT,
>>>> +   [EC_RES_BUSY] = -EBUSY,
>>>> +   [EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
>>>> +   [EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
>>>> +   [EC_RES_INVALID_DATA_CRC] = -EBADMSG,
>>>> +   [EC_RES_DUP_UNAVAILABLE] = -ENODATA,
>>>> +};
>>>> +
>>>>  /**
>>>>   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>>>>   * @ec_dev: EC device.
>>>> @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
>>>>   *
>>>>   * Return:
>>>>   * >=0 - The number of bytes transferred
>>>> - * -ENOTSUPP - Operation not supported
>>>> - * -EPROTO - Protocol error
>>>> + * <0 - Linux error code
>>>>   */
>>>>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>>>                         struct cros_ec_command *msg)
>>>> @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>>>     ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>>     if (ret < 0) {
>>>>             dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
>>>> -   } else if (msg->result == EC_RES_INVALID_VERSION) {
>>>> -           dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
>>>> -                   msg->result);
>>>> -           return -ENOTSUPP;
>>>>     } else if (msg->result != EC_RES_SUCCESS) {
>>>> -           dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
>>>> -           return -EPROTO;
>>>> +           if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
>>>
>>> Do we expect a case where cros_ec_error_map[msg->result] == 0?
>>>
>>
>> It seemed to be prudent to assume that this code is not going to be
>> updated whenever a new EC error code is added. Doing nothing would
>> risk returning 0, and addding WARN_ON or dev_warn seemed excessive.
>> Having said that, I don't really have a strong opinion one way
>> or another, and I'll be happy to change the code to whatever people
>> think is appropriate.
> 
> Thanks for providing the rationale. I think if a new EC error code is
> added (and this array isn't updated),
> msg->result < ARRAY_SIZE(cros_ec_error_map) would return false, and
> the code block would return -EPROTO.
> 

Some scenarios:

Developer 1 adds EC_RES_SOME_ERROR, and does not update the array.
Developer 2 adds EC_RES_SOME_OTHER_ERROR and updates the array, but
does not realize that EC_RES_SOME_ERROR is missing as well, and does
not add it.
Developer 3 adds two (or more) error codes, and does not update the
array. Someone else later finds a -EPROTO return code and adds the
necessary translation to the array. That translation happens to be
for the last error code. The developer doing that does not realize
that other error codes are missing as well, or does not realize
the impact, and does not add translations for the other missing
error codes.

Overall there are too many situations where this can go wrong for me
to trust that it never will.

> I'll defer to the maintainer's opinion(s), but I think we can remove
> the condition after '&&'.
> 

I thought about it, but I find that I don't feel comfortable with
doing that. If that is what is asked for, would you mind providing
a separate patch which doesn't have my name on it ?

Thanks,
Guenter
