Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A031CC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8085920786
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A21YlOTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH1DBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgH1DBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:01:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FFBC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:01:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so4784530pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IiuhGhzNgL/DLui8gzTK8ao7Oz/TOVe+cUKUpQqg/f0=;
        b=A21YlOTJEsZNmnka2SfNcYfgw1+lPMwJqhBVCkpEPv7LqDIBnDQ1HyazAFYe3K5uz2
         P9BSVvy4PZtAGr2MZ3SLhzIdEgEEDcCVNXLIHl0XN5Suu0YyGuHwSJfASthuIGbDq3IQ
         vb5ym4nNJOEbsawe5V/XdyIOduT+k+Bd5H2LWHDaJWDfIhRafUXcWvZYFFuV3PUwNYps
         k20xTAnBGa9QEmhjnP0csDgUrCHWALxg/bbUVlV1EJmuQQMn2axcjNTl7+5TB7+HJd9P
         /X1wZdjRci0LnAeuD+O5cXn22bEFiQ2dk5WQ8V1bV2NqM4SlAQ33C+QNdmaOGpA7Eikx
         YclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IiuhGhzNgL/DLui8gzTK8ao7Oz/TOVe+cUKUpQqg/f0=;
        b=AGb9Eaw6x1vVibh3T9AnruCR2OKn4ruQUXl8YsJPUe6KSyf8qSOghlbV+M+gh6341M
         Snbk70dvVm1tHCgdaXr4b70h0He6JZVy2lVw3LTFBtmqXrk4FKS69Z+U/vpYWgaYFSMl
         IRdtRPoqL+QT+kA8jPkUT3skstdYt27VB0eWH+EIVxyYg5nWzpaNtxdaTqmBO8Cp0SE1
         Sp+uHUVSxWQstRA/pr7e9vqyBlP07yWtgPkO37/jG+MUTTkkcvJ9/FR3yfekc8ehhg57
         rdWHC1GeRrR1EWVegs3cEOCNqKeb+bW2Doo6bCyzK/irVpDbVZAo2KlNSjuxHH7TWogY
         DRRA==
X-Gm-Message-State: AOAM532yKRuHqBGOlIVasWHjUw3SA/fAFO7k/7uGhj55cPDc1XGo8dBS
        PwHOmMEnc/Pi7Da6AX2EGdczlg==
X-Google-Smtp-Source: ABdhPJwOvqqC+wLSGyfhpDIPXvlFwqQ3jCC/e/zr3AGe57QwIOArUNETxLAixcYF7uYEXMzihbQNmw==
X-Received: by 2002:a05:6a00:15cb:: with SMTP id o11mr19227116pfu.263.1598583675314;
        Thu, 27 Aug 2020 20:01:15 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t10sm3575280pgp.15.2020.08.27.20.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 20:01:14 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] io_uring: add restrictions to support untrusted
 applications and guests
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20200827145831.95189-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a86fc8a-56f6-351e-aaee-d80c4798d152@kernel.dk>
Date:   Thu, 27 Aug 2020 21:01:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827145831.95189-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:58 AM, Stefano Garzarella wrote:
> v6:
>  - moved restriction checks in a function [Jens]
>  - changed ret value handling in io_register_restrictions() [Jens]
> 
> v5: https://lore.kernel.org/io-uring/20200827134044.82821-1-sgarzare@redhat.com/
> v4: https://lore.kernel.org/io-uring/20200813153254.93731-1-sgarzare@redhat.com/
> v3: https://lore.kernel.org/io-uring/20200728160101.48554-1-sgarzare@redhat.com/
> RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> 
> Following the proposal that I send about restrictions [1], I wrote this series
> to add restrictions in io_uring.
> 
> I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> available in this repository:
> https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> 
> Just to recap the proposal, the idea is to add some restrictions to the
> operations (sqe opcode and flags, register opcode) to safely allow untrusted
> applications or guests to use io_uring queues.
> 
> The first patch changes io_uring_register(2) opcodes into an enumeration to
> keep track of the last opcode available.
> 
> The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> handle restrictions.
> 
> The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> allowing the user to register restrictions, buffers, files, before to start
> processing SQEs.

Applied, thanks.

-- 
Jens Axboe

