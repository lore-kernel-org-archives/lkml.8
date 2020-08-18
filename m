Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54CC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688F6208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d3qdQ7UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHROt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgHROtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:49:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372AC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:49:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so10058734pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fCviTlz4XSnwg6yVOSQsWhVAGKd364Znuee6QkGLbdc=;
        b=d3qdQ7UZPKbZ7S+EnT9F/IN+BE6+5jbLchQTYDcmwIEOjBhWvPQznkybbt0H+G6ND1
         h9mEckYYN5ikynT1ACEykIl6aXlC4E931EuXEHxn+d0KBcy9G6LTrkvXqhpWdNsvl9+h
         56QZb0lSW0Eml8RJskwKAk8dvVP2RepBw/GMwudC33XqUcLJJQKjXKg+iQrk0q7zBZfJ
         rEl5ENyQej6T/ZKKd3Sz/roVc2N+L2wqKf8MzYfAwpZgrHIW32iZTUsHMWwD3Ijrbqq9
         efjH9gdjiE+jXE6V0NJ3mmPkS7GL/FzPbsYk8txCUN1Pxk+7xj+N7Ms3ARuf3p7wZuKr
         CbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fCviTlz4XSnwg6yVOSQsWhVAGKd364Znuee6QkGLbdc=;
        b=BAaQ1lHa8d3a6Rws6DdKlrzH8DMzb+orysz2SJC6F4U2RvKRns06SLBSz+Eye4DdPn
         +yT+qvTo1qMugsNZko/B0BRJUGzm204jxpoFt8cwoAELBk66O+h826DLt7VpgbkZP+2P
         Q+iB7xqPdxhNHzJMUtgGUbZMSBFt3rilcO81sKRoEg7mYgVpyEK9jlS+hndI3N0F4A6m
         ZMzDQtuZkaUTh7c2ewSqnrRdQaS4Ps2E25zAwDayfgaT7bDcQ/0x8JkOKelUrCftFuco
         mGbvM1cAj7iv2ho0R27lq9s0Di/0xign8nc12qNzSOptUI5WA/gSyiJaxseGWhFo4Ge1
         GCxA==
X-Gm-Message-State: AOAM532xhCrHFZMhmUIhEnq0nbwm1BQmv7pYtWli08QlbQLyDkL2furn
        NzWbZRRtjn+ZQCgdwvLolVKosTIz/cVRiDluwqw=
X-Google-Smtp-Source: ABdhPJx0FESruQtVAJ0RygWDB3g1tZOeUssXuc6Oj9ZrdkWXm/c4kZfcWzGKId1IecLreRwWduJRBw==
X-Received: by 2002:a63:4450:: with SMTP id t16mr13494555pgk.3.1597762162542;
        Tue, 18 Aug 2020 07:49:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id fh14sm171070pjb.38.2020.08.18.07.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:49:21 -0700 (PDT)
Subject: Re: [PATCH] block/rnbd: Ensure err is always initialized in
 process_rdma
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>
References: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
 <20200818064924.3984068-1-natechancellor@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6c0f92d-6c0c-cad4-24d3-e17f0f59a8c0@kernel.dk>
Date:   Tue, 18 Aug 2020 07:49:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818064924.3984068-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 11:49 PM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>         if (IS_ERR(bio)) {
>             ^~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
>         return err;
>                ^~~
> drivers/block/rnbd/rnbd-srv.c:150:2: note: remove the 'if' if its
> condition is always false
>         if (IS_ERR(bio)) {
>         ^~~~~~~~~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
> to silence this warning
>         int err;
>                ^
>                 = 0
> 1 warning generated.
> 
> err is indeed uninitialized when this statement is taken. Ensure that it
> is assigned the error value of bio before jumping to the error handling
> label.

Applied, thanks.

-- 
Jens Axboe

