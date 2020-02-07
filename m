Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E41C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BC320720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jFDm3UdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBGUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:53:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:53:05 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so1032791iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gPAsDsH3JFu6Z/PO2T9two+jAgepbuUh+wb+Brcdscg=;
        b=jFDm3UdTaFobl8KlNZ+xx/OQpMdMEP0sLcKc6IIsBGRY/MIihU7Mgsj3q9XSgoaByQ
         IU6oR72HeXUVoJaDuENimaiQ7FTTNbejEkhdfZwIZyu9m6Mm1FnNkx21JF40GvLdA8up
         sMd1yFJAgN7UWzMOKXCKHJt7RseuAcC+5iy2+zH7w/fGdzGSQvfDPrPqxhbSdyKNiqkA
         c7pscdNnS8SSX8s+Lyulp5Tw0IOKY6P5OcwHaKiYrAKa9rXAqVnAnUgjr9A4rfkvj8iT
         9n5yYTngI3LNshykuhlFAnyFnIeNg1OfWy44ZA22zeWnM7dMl6mxqY3H2FpdW3eYfNve
         vOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPAsDsH3JFu6Z/PO2T9two+jAgepbuUh+wb+Brcdscg=;
        b=MCiU/spjKcXP/gy4eidfWJr15k5phCbItc94H6Z4DtrkoHvbc/kAwSOOzKpfMNMvNv
         wO4tABfgl08yoC46vfI9xA1Zvm2no+vRrUcDmHpOJLe3M1zRl8EpxnmDbxFZChJjotA9
         Z0qgpkbEyNUWky8R9arR6fwhFlKIP4Zs6nwqBHWQy6HI8e5RvlWIrRaF8tulVaNFzskc
         GTWHFaAJFGi43Di9BrlR2J77FpBL6pXtSXNHy24tXbtZPtL6a6lzqfgj0n0sZIwPbvwH
         JMCeI/z6fr2P8Gr2lafCHjOSVXzwVASKFwd2ud6XlglxV4zTgqGvru5db9iQoGXy1C4G
         BO4A==
X-Gm-Message-State: APjAAAWf4TFsNwK5Abb6ElXSYZk+41ANkex4ZGLuKXs6v/Q4de8Dk/lK
        Zac/HU3hHUf8IhTMSpwrUfMcw4a5xkQ=
X-Google-Smtp-Source: APXvYqz7ZNMHOg1C8hfC/YMMf42JDYx7SFETr40yRf70ihInQvE27y8HViPZNxfvJ/97hsDMMlTpeA==
X-Received: by 2002:a02:ca59:: with SMTP id i25mr323779jal.102.1581108784007;
        Fri, 07 Feb 2020 12:53:04 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l81sm1669041ild.87.2020.02.07.12.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 12:53:03 -0800 (PST)
Subject: Re: [PATCH] io_uring: add cleanup for openat()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d3916b5d2c04e7c0387b9dce0453f762317dd412.1581108147.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6729b8f1-f048-8cba-8a7a-45ef1d8c3256@kernel.dk>
Date:   Fri, 7 Feb 2020 13:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d3916b5d2c04e7c0387b9dce0453f762317dd412.1581108147.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 1:45 PM, Pavel Begunkov wrote:
> openat() have allocated ->open.filename, which need to be put.
> Add cleanup handlers for it.

Should this include statx too?

-- 
Jens Axboe

