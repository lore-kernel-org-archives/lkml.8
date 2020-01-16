Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB55C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F93206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H47NxRoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgAPQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:30:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40192 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgAPQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:30:14 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so22484503iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0bxqq0C3ucXX8MRGglR7r12WdoPHtKKYN7fgSSxWGg=;
        b=H47NxRoDGlb9Xpk4hjnN3H5DX7/Y1nbHyooHSImAb/AuO91aQIFGkz5nukb3XJkFYv
         BCFJyRRwBEvzIYF9AfRc017mTLM9IhRny0GJr56Y/gybwsRwRQazXNKIwX42+sabdsLN
         X15X0BmyV6CSB6B1Y0jZ+xf0YMqxWgjogXUFVL8Y/KYiCwDz/+nV1XbCa9yYeU5MGCF8
         1T/UCC0X3pKY1oTWAPH2ZIvS3UdDEDvlcCzKmPNCOh3XoAgA/FTwnS5EKMetkIv9+Apq
         4JLhhIixxGEdCxKBIoAswpIjhjOkbeNcYmx9Vs77+dnLXnWv+kDj2QCiqbAPzVmQcn8D
         0Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0bxqq0C3ucXX8MRGglR7r12WdoPHtKKYN7fgSSxWGg=;
        b=PKbLATfgrHWKQGGWFNoxdeRFulV3v20KFkIKCMYmsUhI+u0zdoeToSNstE5Qspmc2w
         icMsHpYt4my2SIZjvxW44GmiQ0R9p+4xqwqH67QbgRTy1AGnIkPwbLn+rt9tg2857ZvH
         U2zy2GYmHTqMK/FHaXBFx0pONAnbE7sBicr7zBlAs3p+srHaq1M3lr7p/jJSyhqLzxJk
         KhOqt2iSNx5T9vQ4crcnKCts532sVP/aTBwcOJk1wYDeRofQVZaeU2vzBIPOrqvNBa7K
         thcPX+Ucm1f/l61VOzM+JeGJ/VvCzpsQ08zvqMdboDMlpz69XwLaeHWuInYRXFSL0jQO
         dCNA==
X-Gm-Message-State: APjAAAVaSvo1eYIhlTkTnOq19d6x+D9DhrRhgwNbmb+yAlxMQixWHK8s
        koVwUQNUiJpehwckd2DupY6Z4g==
X-Google-Smtp-Source: APXvYqzhcTFfeK/8XtYJhf0WKLmiMNNTbsufwyWfMiIHFkki4IrO43BdrOKgAlrWUXZCft53+JVmMg==
X-Received: by 2002:a05:6602:1d1:: with SMTP id w17mr26645700iot.239.1579192213396;
        Thu, 16 Jan 2020 08:30:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l22sm7113816ilh.37.2020.01.16.08.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:30:13 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
Date:   Thu, 16 Jan 2020 09:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116162630.6r3xc55kdyyq5tvz@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 9:26 AM, Stefano Garzarella wrote:
>> Since the use case is mostly single submitter, unless you're doing
>> something funky or unusual, you're not going to be needing POLLOUT ever.
> 
> The case that I had in mind was with kernel side polling enabled and
> a single submitter that can use epoll() to wait free slots in the SQ
> ring. (I don't have a test, maybe I can write one...)

Right, I think that's the only use case where it makes sense, because
you have someone else draining the sq side for you. A test case would
indeed be nice, liburing has a good arsenal of test cases and this would
be a good addition!

-- 
Jens Axboe

