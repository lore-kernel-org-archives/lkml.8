Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC48C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53D32074A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XNy4Wqw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgE3Nul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:50:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1277C08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 06:50:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so587028plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RXgrwt9PbbSX3t/ukylqmDcsnfwgGXpqGngrByB2Wxs=;
        b=XNy4Wqw1hnA+o/lKZ7o8W+5cd0PzsWvQzvNKSj3dpld7fyif/tu6FrPeovOnHH5uLn
         20Coo7jd5wT2fP+GZawqHJMRIOXZcSFzPpB1abmWTxwvQ5FPO/HGazssPeqMCY7Tn68O
         6tGzacVWhx/zzYtdhaAh2vRC57t7VynCSqG+d7Liu5ENSwhPcWD9c1xdVy8JFc5c0jjb
         XwIGrEg2jAI2GvwZYtnSVRSgrnwUgfI9Z6r6oYItb3ymKtSkpdTes7Lyj3INWKsn27jL
         wx29fvGrTnsGpGsGAYgVAEHytFerKSBSDC7g59aIXRp2Ah7ONnE09OLK1r4nqLdKkUUt
         cyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXgrwt9PbbSX3t/ukylqmDcsnfwgGXpqGngrByB2Wxs=;
        b=ZRat60A/wLxjU3DJM4lB8xM3ZRkyc/mhZJA2wDr5uCR1ToSIrQsDikt6dywGzX7Z02
         x2rhgmsUuGhqFqeMZ7Aqu7eWuHnXuPBaJEUiAU5LZ4TNGuPdwumpAQRQtfT9I5Nv4neH
         KfPWlbkoU9LI9Qe4oHU0IN4+beKPwtosD8hkQ0mD/Zbxqbjq2qQ+s0TyjlG88h3sczqz
         NK9YV1Zs6njSZ8wRVdOjaJOF5tW+Uszg7+sKHsWYM7sC7UL65F82u8SMOuaaDzfdxB1D
         7bCSLouxIE5w4sqTKGsgDQ/LC/0NSw4hrf+0Y/XCCwyNhGZRKGZI7NXdsUiLcwaR87GF
         lP7g==
X-Gm-Message-State: AOAM530VNzxE/g+Xo9zfmk8EEkulIeadkvI7XC+E7YhsQ0uy/uSMsHxf
        d6+rOVgZ64Emv9HrcQZMlqUoil9CNF4Vgw==
X-Google-Smtp-Source: ABdhPJwkZm5zTsn0XdJ46Ne0zVIWPxOBE/ToR+NK/aeIgt3NP9C3vuKcwkQzDbsc8p4oSKGZ3cAlUg==
X-Received: by 2002:a17:90b:ec4:: with SMTP id gz4mr14883884pjb.36.1590846639987;
        Sat, 30 May 2020 06:50:39 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a14sm9585928pfc.133.2020.05.30.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 06:50:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] CQ-seq only based timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1590839530.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d1a637d7-e16e-ce08-fad6-9423bb52d1e7@kernel.dk>
Date:   Sat, 30 May 2020 07:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1590839530.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/20 5:54 AM, Pavel Begunkov wrote:
> The old series that makes timeouts to trigger exactly after N
> non-timeout CQEs, but not (#inflight + req->off).
> 
> v2: variables renaming
> v3: fix ordering with REQ_F_TIMEOUT_NOSEQ reqs
>     squash 2 commits (core + ingnoring timeouts completions)
>     extract a prep patch (makes diffs easier to follow)
> 
> Pavel Begunkov (2):
>   io_uring: move timeouts flushing to a helper
>   io_uring: off timeouts based only on completions
> 
>  fs/io_uring.c | 97 ++++++++++++++-------------------------------------
>  1 file changed, 27 insertions(+), 70 deletions(-)

Applied, thanks.

-- 
Jens Axboe

