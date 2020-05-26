Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5358720721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u/ZRPnBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEZSDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgEZSDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:03:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00895C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:03:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t8so116897pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+3D93OdvzuNAS+/2pVk3LjUucF4nmiUUGgFK0NpFcMw=;
        b=u/ZRPnBTRQI4xng9kUTbPBygrFkOgmR+gilKAQglT/PMcwMAIpPff2+accAg07GIPs
         kONvnDsrwwCzXkYnYUHhkfqkGO26bQkCPaKt3/DPVWuVzasMnH7Uo9cNaU0BqcmLXj9z
         jnBtvfYnWEx29e6l/rmHGJ7PCyNK/OYUclekxMrbUAh5Ilh8PMuEneblUHlmjWSEyMxX
         C/9VTL/RZ9QLE7IOBg62OGhsxaT9cY9EvMBZY7crhviPo+aW9jXO8Quyl+l/wuRQwwLQ
         HyJAX0HhbVCfEwzbUubIGUO31TL5dxqCFtUGvDLllffArudoCfOIFhiTS6JsIEnFwhDt
         N7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3D93OdvzuNAS+/2pVk3LjUucF4nmiUUGgFK0NpFcMw=;
        b=eM9ty2aMXAIiBgBRRlhQYaeQIAZ0SqqgnMt+9WmnuVhHBSH6+lbiSdCawZpyEByU9Y
         T8y6aNzwKSNZj7ldIZs8pkDxVTimqPrpON97u2pZyuzuv3yPUggx3bJPBpNgepRF0YQx
         otFuGg//MjaeOkjUE8woirTJRA5ZPHUKp3+H4VDrkZTBZ+KMkr92te5lgIKNrcniD/Si
         01uQo9HmcnspywHt11yzuQ8x+YA8u0npofRzl33fY33a151mzFC4XQJ9bywi0l45E6o1
         ecO3qh7NTVFu7X3AcKU66xYmxrd3s5oCgXiX3iLuL9gstdPUjPtvUnkB5Q4peKodOs4Y
         yY0A==
X-Gm-Message-State: AOAM530YBs8EMyvmueGBy5h8616n38S07qtmj3kZlX3scSwkUDro6iFv
        okVA3erJ+gHYmhF6dOiN8eAZB/IGqZaAuw==
X-Google-Smtp-Source: ABdhPJzQMLqb4bFrLyBbxKGDwPw9C8NipoMqeJ7xNPTsBkJi5NjPuG27JQYf1w7A/zdPoLEj/xRjMQ==
X-Received: by 2002:a17:90a:5d06:: with SMTP id s6mr513034pji.88.1590516193211;
        Tue, 26 May 2020 11:03:13 -0700 (PDT)
Received: from ?IPv6:2600:380:495a:792b:6476:7a3a:9257:12c7? ([2600:380:495a:792b:6476:7a3a:9257:12c7])
        by smtp.gmail.com with ESMTPSA id i197sm182611pfe.30.2020.05.26.11.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 11:03:12 -0700 (PDT)
Subject: Re: [PATCH 6/6] io_uring: let io_req_aux_free() handle fixed files
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1590513806.git.asml.silence@gmail.com>
 <3e06564a15ca706f5f71ed25e8e3f5ea1520117e.1590513806.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c1727c0-43c2-b4dc-8093-55030ae49057@kernel.dk>
Date:   Tue, 26 May 2020 12:03:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3e06564a15ca706f5f71ed25e8e3f5ea1520117e.1590513806.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:34 AM, Pavel Begunkov wrote:
> Remove duplicated code putting fixed files in io_free_req_many(),
> __io_req_aux_free() does the same thing, let it handle them.

This one is already changed in mainline:


> commit 9d9e88a24c1f20ebfc2f28b1762ce78c0b9e1cb3 (tag: io_uring-5.7-2020-05-15)
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed May 13 12:53:19 2020 -0600

    io_uring: polled fixed file must go through free iteration


-- 
Jens Axboe

