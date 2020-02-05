Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6998020702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yUPqJ3jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBEQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:05:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39392 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgBEQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:05:11 -0500
Received: by mail-il1-f196.google.com with SMTP id f70so2297503ill.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ro/JXxhb6fw5qhCk5bQIEJar86Lbd1JTMDnrvXuIV4U=;
        b=yUPqJ3jzwFieQL/5BZRPu4H0WRWwlT5nKvTswUken+f+XokvK/Y2BDmFYVcwoM55fH
         E6IXP0IjFXq/HiXab6CQt9UgY4XcUaBrfw+NrIVZu9+hMcHAP/um/RXzdbI1Vcaw5rlG
         swFws0EZyn4OyMjkmnDrDszvSgkehnMyE2CR2KMrGtUNzBJjj05MfrbNxa2AFB4r90mT
         gcwu3CukLDOSE6cWiv8HO9Y4/n4QWbsbMIJPBdlguDqnts1acIYV2mTyWPjh9PsC2odi
         yJINYbfarCl9O2HZbmxMvWozwpfupGIr1O4B9IEGhYhEga9ln0pQd02Gz11l+ZFF28Lt
         dqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ro/JXxhb6fw5qhCk5bQIEJar86Lbd1JTMDnrvXuIV4U=;
        b=brrZsS8gCn4MWrWj5/cvt6WHFlLBLfVdSi++YC4SoZaXG9VXkWjShEgms0oIk88MXQ
         PE6Mv36eBhdfS1+BtQscSEIIWiM5Hy9XS5aLtl6sbybeYHA/cz0wTFdeRkhco98iTjWb
         zmwrib3QYMjPAEpLkiG1aHTgbA48AhrQD695fr7SpA+eSXTbzcUES9g+xtcRzYYrfzZg
         X3IJu51+i3lkyCHARTSx0bZSId289HEgnugIHdNWydi1iFpL/uHOgkYpJfHiwzardxmE
         UHXqoyN9RSh8J2jnc8WsZ3TrAMXG4qitDICjFc53tmPrjP2j9icizOXIrdfU5EJ/avTQ
         qvpg==
X-Gm-Message-State: APjAAAXPT+zXCyAkvYt4yGHjo2LycKMKLDxM8wvHkEie/g4UsB+AYMj9
        AMkoVj6wmKJ+0R5lhGLXvCRMN9peHnI=
X-Google-Smtp-Source: APXvYqylwHIZDtu9aIEeijvNn8AMoRetp0DgOjDxJslUe4m10dMnz5SGv2BsR+ZugAOm1RQscfIiTQ==
X-Received: by 2002:a92:7a05:: with SMTP id v5mr32067440ilc.122.1580918709973;
        Wed, 05 Feb 2020 08:05:09 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t15sm10386974ili.50.2020.02.05.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 08:05:09 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix mm use with IORING_OP_{READ,WRITE}
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <951bb84c8337aaac7654261a21b03506b2b8a001.1580914723.git.asml.silence@gmail.com>
 <df11c48e-f456-3b64-88d1-6012b1ac2bc8@kernel.dk>
 <d9a15d32-a20b-a20f-9ea4-3ac355c15bb2@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6cc1e97-f306-e3f0-3f7b-9463fdbbc5a5@kernel.dk>
Date:   Wed, 5 Feb 2020 09:05:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d9a15d32-a20b-a20f-9ea4-3ac355c15bb2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 9:02 AM, Pavel Begunkov wrote:
> On 05/02/2020 18:54, Jens Axboe wrote:
>> On 2/5/20 8:46 AM, Pavel Begunkov wrote:
>>> IORING_OP_{READ,WRITE} need mm to access user buffers, hence
>>> req->has_user check should go for them as well. Move the corresponding
>>> imports past the check.
>>
>> I'd need to double check, but I think the has_user check should just go.
>> The import checks for access anyway, so we'll -EFAULT there if we
>> somehow messed up and didn't acquire the right mm.
>>
> It'd be even better. I have plans to remove it, but I was thinking from a
> different angle.

Let me just confirm it in practice, but it should be fine. Then we can just
kill it.

-- 
Jens Axboe

