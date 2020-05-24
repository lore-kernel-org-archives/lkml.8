Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD82C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D03C20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e+VnPB6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgEXTYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgEXTYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:24:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B397C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:24:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so7922406pfw.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dgc3lxr2w8bqe7nZRW8lKjFTzqIALZXVaHjKz6zro3w=;
        b=e+VnPB6Ko1789GSjUbC5PBmmKMbZDoprtwNwSYo6Modwe+qUJSLxKRvETyHOsx+iaF
         F2i5yehyv8rgJtaiUIFt0U92bf4Y5FVCL12fqCATHKChX6SYTalfaewnHHp3WxkHY83Q
         7rxj7BdB829+EV8HmJlzz3qXZuE1Kk1rwt9gsxkugR7A/ykv3wiBBXdnq49s4dF9AYiX
         zId1SRMwlerW6+8br+rRS0jlsnjPXnzaG3yvz3afr3UK1+yKvGRZ138GUItgFUZtfaB7
         d0oCLOSKrQttJKYA4jTReghoh6HdrAQrRrEzkzf+s4FT7Fz1DWHL6drtw54iBaSWbMfq
         ICTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgc3lxr2w8bqe7nZRW8lKjFTzqIALZXVaHjKz6zro3w=;
        b=K78Lse2H6GXpbbaVQtuCx1WLCfKHGwYYRMuKe38gm/gT4bqpt6n0DKjL9W9PkTTQQo
         2N6FwcnIZsUe4Z3v7JEEYsdRfc/o+MdHYOdldQeLhypRANt2dyIdOD9tSfHMtAJUcAAK
         JTkVLPR5RJBJQu5BwrsjE9J27/hbOwDwunfPFiMXE6CsWKbUSyvL1kWjzx0MLeZzCM6u
         IPZKdAXEjh0PinF44otQwA6NduX/Z6yGKKDC7HppzgL/0PyefyOEKHfWgGiSonNGDCB4
         QJQclmOJ7Qj8B16L2VIksf/YiLToaW1AMlgTh6SFDw7b4U8LAL/QqCr5/K74/RJQ8nkO
         NX1g==
X-Gm-Message-State: AOAM530dGLnbQjJbsLN5mLifmEB3sGbWIW9lC5HoLj0T2iDWj+ge+vfA
        XcLv4pGGq/X3Rmb/WRsmfPZkQg==
X-Google-Smtp-Source: ABdhPJzxor4BiLVaXHSh4qj7gDp1AJs+eMT8WKofeCCw54L99wJmJlkXn8O1bc5hT4IwWo1ovoT1sw==
X-Received: by 2002:a63:da50:: with SMTP id l16mr22609989pgj.198.1590348284045;
        Sun, 24 May 2020 12:24:44 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:343d:8ab7:4cee:d96f? ([2605:e000:100e:8c61:343d:8ab7:4cee:d96f])
        by smtp.gmail.com with ESMTPSA id g18sm10134116pgn.47.2020.05.24.12.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 12:24:43 -0700 (PDT)
Subject: Re: [PATCHSET v2 0/12] Add support for async buffered reads
To:     Chris Panayis <chris@movency.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200523185755.8494-1-axboe@kernel.dk>
 <2b42c0c3-5d3c-e381-4193-83cb3f971399@kernel.dk>
 <43ee202c-ffd1-2276-3c8d-7d5201b60684@movency.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba854ebb-b4d3-1982-9602-61888ba77a5f@kernel.dk>
Date:   Sun, 24 May 2020 13:24:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <43ee202c-ffd1-2276-3c8d-7d5201b60684@movency.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/20 3:46 AM, Chris Panayis wrote:
> Yes! Jens & Team! Yes!
> 
> My code has never looked so beautiful, been so efficient and run so well 
> since switching to io_uring/async awesome-ness.. Really, really is a 
> game-changer in terms of software design, control, performance, 
> expressiveness... so many levels. Really, really great work! Thank you!

Thanks! Glad you like it.

-- 
Jens Axboe

