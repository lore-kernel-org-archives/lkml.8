Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43672082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1ttHOWHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbgFXTqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391324AbgFXTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:46:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:46:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ft14so568371pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=etcC5SCWJE9q5GKdy+4hZU308fzw/ff8X68zPO6H23o=;
        b=1ttHOWHtWCaWFJVfcE2SivyYk2ulxNbtSjixxOQfHds2kZGP6Gc9XkIqkFyUu81A3l
         zVxwmONzVkY/1212l1Ohi1ILWSpgMjCfcSvQhbHxD4nZskRCMuc72cy4JeucvNJCgDX6
         CenroNIIg0Q5c6VjeWCsiLarTiCDSXL4er3ejHU6M2DFrrFTrfJHNzO6GTZgZFtESrtB
         hD6VDL+P7kH7+lBwdCnvXqSCgpXQ1kmTRiBCReupOsYSyrJW8NY//clp62BhHDyH9/t3
         hflvA9iK6GxL77waLEyDKc5iv8fXY4gEAKJOwOjHGT0bOfb8O1JXj/ls4Rp0xE4nv0rP
         Yz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=etcC5SCWJE9q5GKdy+4hZU308fzw/ff8X68zPO6H23o=;
        b=RzVIrZoNffykDBIRdX+Lbbr8G4Yqn2XYx+9gRImqh5dXivLtpchef9V23ukP3Nw5ni
         A7q6sBTPpbXfdeyNxz89+d7hYSJQYAzUXqmqFZyrbyYITvzYK+ZZJs2uEmXV69pgXNvX
         qxasdgjBHsbUf91Qxh8UU4zZ7uzk6K+ZEqB7SsoMPTAGCFUjwKf2+C/NV5ndlhjxFAiF
         2C4z+RPGfzXDF+wxIikj0XNKSIren0sVM/Ex2G23feten5E7qS2mSuZ1r0LQO3HBHcBw
         bEqPFDupYZd3XMqo6KP3V8eMWrmmqFO2Bk/+UOsojmf9L/M8biT2ZYJZlfWGKrqYlmGv
         q81w==
X-Gm-Message-State: AOAM531X+NqmvkQtTqMBSnjTI46KBkagOgsZsjIar6Lq8JCqxkndl6Xi
        gt7YvZcvCCmylCOj0L2zIo5x6ghBx3M=
X-Google-Smtp-Source: ABdhPJyEiH6lN1BP8U0UF2zar+GhMc8QVt8uZMBCSOvg0OFQqtKiGklvgIkVtpT4o5C259KRtBu70w==
X-Received: by 2002:a17:90a:de1:: with SMTP id 88mr31019016pjv.124.1593027974219;
        Wed, 24 Jun 2020 12:46:14 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 27sm6036508pjg.19.2020.06.24.12.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 12:46:13 -0700 (PDT)
Subject: Re: [PATCH 0/3] iopoll fixes
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1593016907.git.asml.silence@gmail.com>
 <32dc23ae-bc73-b4e2-f9aa-cab59280cae4@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d253bcb-8953-d975-1a39-78310ff2e723@kernel.dk>
Date:   Wed, 24 Jun 2020 13:46:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <32dc23ae-bc73-b4e2-f9aa-cab59280cae4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 11:03 AM, Pavel Begunkov wrote:
> On 24/06/2020 19:50, Pavel Begunkov wrote:
>> Did more comprehensive iopoll testing and found some more problems.
>>
>> [1] is from the previous series. Actually, v2 for this one, addressing
>> the double-reissue bug found by Jens. It maybe not as efficient, but
>> simple and easy to backport.
>>
>> [2,3] current->mm NULL deref
> 
> And yet there are issues left... I'll resend

Can you also please have them separated in terms of what's for 5.8 and
what's for 5.9?

-- 
Jens Axboe

