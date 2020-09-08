Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD90C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013572087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fc5KlT/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbgIHRDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbgIHRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:02:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C9C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:02:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so55980iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6r8oY7P5aaaNjTS2Z3JuHAo/BodSW0G0Qz3+9SCpdcA=;
        b=Fc5KlT/QgmDUw9wewiSXZGEfR0knpYXatiwTcFvCBfuTglDqwe97Xqfk0+3x8rqwqz
         +7tuFM8H7/+AmHKFAaAgiLJ6SRjQRhYk33odBKaz/HYiH3Ner4l978qk7J5fVRCppZat
         NzbCVkM8xF0xtOByqvqkwhwdQxGZyDDDgP822eVuJM4gG0Hcg8eiv1RslZap/Bek1+wl
         Zo6pLSrd6Y9goqQPOoDIZfkmRDiwu8LSP2FkQezPzvHh4k3BUYgvl+MCayPCGDN/ggRH
         EbcMddlY2Qg8dVmq7IG0F2iCUIwDUoScipcAw4Y7Ul6q0kcLqRY/IS7Ixd4PLxrKKOK1
         TsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6r8oY7P5aaaNjTS2Z3JuHAo/BodSW0G0Qz3+9SCpdcA=;
        b=e9Uvpk2W9vkCLz3AlQXCXnbtVZLGKOrlN5P+dXlg126jUfO5244YkgV5/1wAntYXVG
         ksITGZ5q1UxL6wXpdezhuW2RNoFOoiteX2nEO8w1qaEdIQ+9skkXxg9lOS6u7GlIOYCi
         HEYE0b9761WvuvlVHGPznVUJ10pJSWkfwUgNZ3IdHVSizY0IhF0nluMp9LAImPm9/UYG
         LsOlph5bYjvn974JX0m5naO8DX6hIMdMUGfGbil6MbOjDl5yAGTckstWS2FiATEGt2kX
         IQ0fexbelbm1kN/SWvgJRl0ttUp8pnwKK0CcB+nK9bKiXyV1DFHa/2LjpDtJ1FcQdAO9
         phkA==
X-Gm-Message-State: AOAM532fPaKQhvhg6u0gETxkJoh538R9iBif7oAIRQ0h031/y6HVhvJR
        U2dHZ0GX/drGgstQ0x2OK8VTiNARFDk6PmVd
X-Google-Smtp-Source: ABdhPJwKYohUKj3l/8T5Uy0NjpVMb531t2l/rRzat+mZoQM4CjOho16dsxnLDc/YijlCusjH4qO8bQ==
X-Received: by 2002:a02:9986:: with SMTP id a6mr23301374jal.28.1599584569815;
        Tue, 08 Sep 2020 10:02:49 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i14sm10669430ilb.28.2020.09.08.10.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:02:49 -0700 (PDT)
Subject: Re: [PATCH for-next] io_uring: return EBADFD when ring isn't in the
 right state
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200908165242.124957-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e119be3-d9a3-06ea-1c76-4201816dde46@kernel.dk>
Date:   Tue, 8 Sep 2020 11:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908165242.124957-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 10:52 AM, Stefano Garzarella wrote:
> This patch uniforms the returned error (EBADFD) when the ring state
> (enabled/disabled) is not the expected one.
> 
> The changes affect io_uring_enter() and io_uring_register() syscalls.

I added a Fixes line:

Fixes: 7ec3d1dd9378 ("io_uring: allow disabling rings during the creation")

and applied it, thanks!

> https://github.com/stefano-garzarella/liburing (branch: fix-disabled-ring-error)

I'll check and pull that one too.

-- 
Jens Axboe

