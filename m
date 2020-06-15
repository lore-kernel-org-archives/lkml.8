Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8992C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9421F207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP7HtQBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgFOSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:05:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D6C061A0E;
        Mon, 15 Jun 2020 11:05:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so188732pjf.1;
        Mon, 15 Jun 2020 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jhsd8aTl+CMui37A0Yluu4YuHY/r0BYk4cBD83Toifg=;
        b=HP7HtQBgtpCTVUxRrPKP9+cQFpP1w8c5GIfmD22gJAwYZtuu/s8lJpymZEhRpEcjMi
         MxnkoWKZoU46N4yQjdekxWTHxuzsy+95wo18CAa6A0d8yE6pA1yRkagm2p3KQNl8KMjl
         J93aSOUjmvNS9htvOBr8iuI72aAGjqSz97fOZtL1N1NqjL5iZoLmjf9bG8+9bZx3pz6o
         6sTYebPcqVrIobZMlJ7pyY7pCd93n1WoBPv7HUjpAVJ0VEKZBFjf3rIn1OoqunNnJYeA
         TKds5NDzYBYNQLzsnlZCLUNinADLQzCLKNeodnkvxJtNhy63V+l4GpZsI2r3/5xFbUCn
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jhsd8aTl+CMui37A0Yluu4YuHY/r0BYk4cBD83Toifg=;
        b=AYHN+bNCAirFFaLxC11uVYd7CDjuutISjR7R2J6GRkoLjVmH1wA1cAyOL/esFp3GID
         4gg9f59DqwfTVeZWc59YUMnBrtQwhKzewMNzOlxT8tKTtLJXwA9OaPwr+D8pgE1TFHEi
         np1BFECXvQfKMg2pJENgMZHR06Xx6KEBnw8xTFiTmnd8UOqenLG1hBfTjDV2Uxp6haPF
         19fFcLRWlfDWA8MxFyhnzi3kwsqwWI6ncPDa/qHcsjwQJI3hH53aXhtJCcr4vWpFm1pQ
         Ml1IdhCNzNxo6KsCJroGocaHAcsQVOTnPKmm9R42f/jhzgA0rE6jFz1OBAiRm1N2EgBU
         FBiA==
X-Gm-Message-State: AOAM532aawUOCo8eV1DWhhina77XSp0zsldQcIqMe/KQOLdN+xOltvzQ
        DCir4Qu+9hk7P7sgqAaWQlvokFj0
X-Google-Smtp-Source: ABdhPJwawRl8MamUhH+oKsenRXYuR4LdoD3dAQhMnHayPTZrpgrJnkGjikp1luyyr0S35HTcZuhxSw==
X-Received: by 2002:a17:90b:234c:: with SMTP id ms12mr542035pjb.164.1592244314047;
        Mon, 15 Jun 2020 11:05:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5sm14659240pfg.191.2020.06.15.11.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 11:05:13 -0700 (PDT)
Subject: Re: [RFC v2] hwmon: add Corsair Commander Pro driver
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <4064217.uIqdvtiHzK@marius>
 <1bdfa5cb-ad9c-ab4c-351f-5b86d38c3eb8@roeck-us.net>
 <2951227.8AuJ4AEgc1@marius>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f078c0de-f66a-235a-b575-414a6b756786@roeck-us.net>
Date:   Mon, 15 Jun 2020 11:05:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2951227.8AuJ4AEgc1@marius>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 7:54 AM, Marius Zachmann wrote:
[ ... ]
>>> +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
>>> +	ccp->buffer[0] = CTL_SET_FAN_FPWM;
>>> +	ccp->buffer[1] = channel;
>>> +	ccp->buffer[2] = val;
>>
>> As it turns out (unless I am missing something), all commands have
>> one, two, or three parameters. Also, the full buffer is always
>> written. With that, it would be easier to add command, channel,
>> and value as parameters to send_usb_cmd() and handle both
>> memset() and assignments there.
>>
> 
> There is at least one command for setting a fan curve (0x25),
> which I intend to implement at a later point. It needs 27 bytes.
> There seem to be more long commands related to the RGB output.
> Also there is CTL_GET_FAN_CNCT which needs read 6 bytes of the
> response.
> 
In that case it might make sense to add a helper function to handle
_most_ of the commands. CTL_GET_FAN_CNCT can still be handled
with that helper function since the response is 6 bytes, not the
command itself.

>>> +	ret = send_usb_cmd(ccp);
>>> +
>>
>> This makes me wonder if reading a response is always necessary.
>> If not, it might make sense to add a flag to the function indicating
>> that no response is needed, and skip the read part there. If it is
>> needed, it might make sense to add a comment into the send function,
>> explaining that a read command must be executed even if no data is
>> returned.
>>
> 
> Actually yes. After a bit of further testing it seems, there is an
> error code in the first byte of the response, when sending invalid
> commands. I will check for it, return -EIO and log it, since I
> do not know, what all the error codes are.

Makes sense.

Thanks,
Guenter
