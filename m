Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C817C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3509B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MNWayklz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgA2NjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:39:19 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:37416 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2NjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:39:19 -0500
Received: by mail-pj1-f42.google.com with SMTP id m13so2664353pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jRw4gHj3o+0fDg3wZL+MId/7a4nIQ2wDAMiYdbQUCIE=;
        b=MNWayklz5DOaPLQuHOF6vvFj3L/UpWZ8cJxmLJMaJ2B3hV7J4/9PyCQIcZCUniepHJ
         BC0JgUyyh2JTo+rYIfijyJo2csqrMSk1NgZBZKNj4JoFSTpCCSnmwXp9hTjd+enGGYYu
         dqkx50Nhvd9ugjHLtwOvHFXIyfMxuo4IIZXDTX3odQaI4VhjtqQ0KDXjmpOIgQI0s3hr
         xAA2Ua3U6sFfwiAYFP5TCXJaRWNEfK66QIqkG5sJ8mWFZaC+q0zLWJ9jTDKzIu6P2dQd
         3iqpEuVIMD13B9AWJ3jDbkj6Jl8DUhBR49cpjtsK2RCtSD+xdC3tcuaZn6yy6Rmb6xzQ
         ExQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRw4gHj3o+0fDg3wZL+MId/7a4nIQ2wDAMiYdbQUCIE=;
        b=Z+3MQL30YsagA9rIOVtsE8qPY4X3Er6rjj4GPD8ihbwrP89U8hpa7XMwf3tPcBIcTe
         87hOBdrk8gil0fgp16DPoyY6Ha+dw+4QxzdoOPpECeCJJebzEqPRj3jDRrahZjJlt3ki
         Jd0VsCsyrdkRTB8Jxg4QSvIMuVeGCP74jv+XG3YObQWenYH8jNNnAp2lrfbz7duQXyL0
         5I5+Se7GZzxuQ6/2vMUUnSSm4Im+F1afCiRZDA9DvbvmEQonzbpH+nKmn5Gi5MZ/2O8w
         73UIdaQ+HOJe1f+3L2TZY5Y85P0Nai3PDQQ089LI9M2CsuS8954md/Rm6B6MGKMzo4MZ
         bKTA==
X-Gm-Message-State: APjAAAU2+2Gd7h4aOsLcSKoSf9ZYMzg8Kbr5JS+xc2bHNFUtyG7O6Okk
        bbnjRqlBbHOzP/pY8lIQXdGriU5Ewv4=
X-Google-Smtp-Source: APXvYqyPhfTyC7VNpA0L1MnRS7VkitmsDY5CbseGZBhvbp+Wxs1WEbNLbRh9ExN3O88DCJIhHovfdQ==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr11397427pjt.104.1580305157936;
        Wed, 29 Jan 2020 05:39:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i68sm2972265pfe.173.2020.01.29.05.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:39:17 -0800 (PST)
Subject: Re: [PATCH] io-wq: use put instead of revert creds
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c79bab7a6bd174f32121c9508390264bff9950ca.1580292613.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <044f452e-76ab-c555-9dce-3c7a711d3c5e@kernel.dk>
Date:   Wed, 29 Jan 2020 06:39:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c79bab7a6bd174f32121c9508390264bff9950ca.1580292613.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/20 3:10 AM, Pavel Begunkov wrote:
> There is no need to publish creds twice in io_wq_switch_creds() (in
> revert_creds() and override_creds()). Just do override_creds() and
> put_creds() if needed.

Thanks, looks good. Applied.

-- 
Jens Axboe

