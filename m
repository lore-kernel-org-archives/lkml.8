Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD870C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01B3218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vrehnZkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBFUmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:42:19 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45931 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:42:19 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so6358065iln.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hSKAPXuw/qdxw9inxEswmgHt8h2yXurDtN2Z4Xr63Z0=;
        b=vrehnZkfqdhinR2vRNC3Cj7Yx65Lc6yH5V7n3a268mzPSpu0KywkM/5TyaQu3C9Hrk
         Kk3c8M67vgErRSUXFhgzJ7YFH9GcPj2xQ7Hfjd5Gr0SsDpTw/AOOIEDSUBbpoMeJhfTZ
         YIX/zm6EoV6aVw/2C9ETCyq2HOsUmMfOBDg4ivf0VLUKojXXKX8U7J7fl7vY1yDrwh/5
         YjGFywENwJ82kNXN2utfVKGhFF2BXVxQDocn4szgvA9zSm3wdTMJb4GrE7KcyN8+7Ym0
         IiRY2AFpJqDJra4Kc7qqXJoGlssEFa3dbnxiVYeau70ZJufKogA5XV/L1F48fh8xJSeJ
         JN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSKAPXuw/qdxw9inxEswmgHt8h2yXurDtN2Z4Xr63Z0=;
        b=q6GbOymMBmqtvHfSPeApWfPKgJdad/gyTTT4t/g8uSgS9I/5a0dxK2kS7b+RQpRjXf
         VXA2HMUmu5T6JvGqvy7VpIW7p9oBKYfdmBpfqagOSEHLmLgvDndCEw82/y8AQoPqgIsv
         UWU9Eh+wHGNUEKYYZBMFyY/9ZZo2Qk6zOIf8dB4XUGq8jp8bOErSOneWl/Yg6B49xplV
         RXH2YllW6v3DOvz/C2dBUPtCvejks6ReDjj9O6/A3k/tcuwznCbxPShE3QKQxUKWaQtB
         qDlcjshzsIdjzjBIjJF1ERQwYy3bFLX0ts1oazgScsk8untqPN+Br9UAFr/sQSWIuTsj
         Dluw==
X-Gm-Message-State: APjAAAVm1Yq59xz7vmYDQae0UrSGEw+tHk7SWGDihz8iN2RwJ1spLorN
        M1zCkoZ0pGur+roadU91kXcgLQ==
X-Google-Smtp-Source: APXvYqwZB2x3Iz0V+ifgm6G+KSO+hCUJuDxsNlIVwShchirorpQ/wv92n2XKP5n1MJ+xMd/IYNcv9w==
X-Received: by 2002:a05:6e02:e06:: with SMTP id a6mr5715310ilk.88.1581021738435;
        Thu, 06 Feb 2020 12:42:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k129sm190195iof.82.2020.02.06.12.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:42:18 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix 1-bit bitfields to be unsigned
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
References: <3917704d-2149-881c-f9e5-2a7764dccd3f@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed4cfaad-d6b3-3add-a329-0b574b8fe380@kernel.dk>
Date:   Thu, 6 Feb 2020 13:42:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3917704d-2149-881c-f9e5-2a7764dccd3f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 9:57 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make bitfields of size 1 bit be unsigned (since there is no room
> for the sign bit).
> This clears up the sparse warnings:
> 
>   CHECK   ../fs/io_uring.c
> ../fs/io_uring.c:207:50: error: dubious one-bit signed bitfield
> ../fs/io_uring.c:208:55: error: dubious one-bit signed bitfield
> ../fs/io_uring.c:209:63: error: dubious one-bit signed bitfield
> ../fs/io_uring.c:210:54: error: dubious one-bit signed bitfield
> ../fs/io_uring.c:211:57: error: dubious one-bit signed bitfield
> 
> Found by sight and then verified with sparse.

Always thought those were pretty silly, it's not like this change is
suddenly going to make:

if (ctx->compat < 0)

be anymore valid (or invalid) than they already are. We also have
cases of:

bool foo:1;

does sparse warn about those?

-- 
Jens Axboe

