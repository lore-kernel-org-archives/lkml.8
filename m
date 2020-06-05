Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE82065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YJ/fPVEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFEMr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgFEMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:47:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A84C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 05:47:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id bh7so3592064plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=490Gf2ZQ0nyEq6XiXWuoZcDXG5zho6wXaKrFBnwAX6I=;
        b=YJ/fPVEzCQVzHx3XF0LCWnOyVHVlaVv1Smwe4knU5+aaK/UoyrzSI8du61rjd/NI8R
         HDGY7fgG3eGhYJHqKaW4fxetecYI4aHggN5x9KU/D9O6vzc3/Hftq8VRf1I99N+NsyPh
         3K/TDOOs6LyOyU+tmzz6Na2LXqFLAZMU4Ml4MZfwh0icjI2AcJWFoADQ3EYuSyy2xpzx
         fD7DIk3/QfshP7+zEdXhO/cq8dof8xYj297b/Ai2GKzuah56KswsBXWHZhM2rHK+M4KW
         r2JqjoLAz+mSfVPOChEJsROrZ5VHHY/sNt8GX/v2R6us9p2j+NPu9IG8LhClD8Z1k8fv
         woMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=490Gf2ZQ0nyEq6XiXWuoZcDXG5zho6wXaKrFBnwAX6I=;
        b=H2rNThUcC973h0VSKkRyQIwq47WjzRzdy1tXTaoeL5zj6XTMUQkv+x1WnWy9KvnAVd
         GRnyl5wg92unU7xP78QO8L26SM5LR+hP/pJ7CYqS5GLGCFNBlmku9Crt6OxnOZlmBMW7
         hka5VI3K1bk0LeoTPa3FV6mNsnaX/AiQO/PTIOxIOuXe9FYCd63EjvPW6g7X+SnOS7mi
         qv/t6x3GDvLVsknpU6kwRyN88Il843Dfi0dSEXh/6b0zjO+HmC/DvpIyN1//DR/Rh2wK
         CKazLJ/y8KpqrNxvCNf2oqD/y7DpxXU3UgxRdfMY1ASRjxJf6V/PC12Bho3eu/9TRVuC
         uy/A==
X-Gm-Message-State: AOAM533jSmpY0zGm0PLV2PcKWrOyP45NnnJ0VmC5Ra2seOWhQSuGDLpL
        1get70X0lfPZgM/57CW/xK8Dpw==
X-Google-Smtp-Source: ABdhPJx3HI2O3F0O32IYSaYmXdqgjmrOOvr0+Gh4YuE0uQ85tItBnRvrQf84NW2ac3Qb4GHq7SRfaQ==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr9954036plr.128.1591361244448;
        Fri, 05 Jun 2020 05:47:24 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x12sm7583806pfo.72.2020.06.05.05.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 05:47:23 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use kvfree() in io_sqe_buffer_register()
To:     Denis Efremov <efremov@linux.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200605093203.40087-1-efremov@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <855ab3dd-4a3b-2c66-ba82-e6a1fed2e3ee@kernel.dk>
Date:   Fri, 5 Jun 2020 06:47:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605093203.40087-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 3:32 AM, Denis Efremov wrote:
> Use kvfree() to free the pages and vmas, since they are allocated by
> kvmalloc_array() in a loop.

Applied, thanks.

-- 
Jens Axboe

