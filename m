Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81726C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A9420787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="io57zylj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEXQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgEXQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:44:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BBAC08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 09:44:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id p30so7656159pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P07jNVug+guoc45rIbpWbEU3M5+cKVFLecgNbhSQG+k=;
        b=io57zyljez92lXPJk3vdqKPgqSMKidnBUnshqQzXWVfdMLSnMN4ncxj5FXVt38mRUS
         78sjGtVI8BVkd93ywJu272PQWMrNhkc8rN7wc3MIk8PalcnlNWx/NIhIr1rYeX6Uyshu
         apemMmrd8sIH7VeQx/SADuIFUiM1geZA5kKCRecz+3YDYXd5BGUHU21MSTPzEdRt93eD
         OYIW4Db9mt2vmF3VD6ZAcusf6gLJtfx95KbvzrUz1s2Kv2XmIcsS6UrloIitadfK9E0I
         6aXGZ8qYz6bRhZOE3r9+Wm4DqXPmhbQbYrasNG8EQtXNknrybL1VJhZyEy353QCTiDFw
         JSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P07jNVug+guoc45rIbpWbEU3M5+cKVFLecgNbhSQG+k=;
        b=FCSXhy0nccYb7CHpzervR0yU275yK0X3Wm+EizS7On2ZjjUO08maq9fWVOwctCwye9
         9V2vsxag+X6UM+ZF0lIeEPoIJ6U9QAp5BjoKj6p71Cra9nSRkuGi+hGRzGNJcJEhNEv9
         vCm7WGpn7Ych9PH1hht6h/2JN2FeEDixx+HN91/l73vOScjng03mAjvtYXVIZ2jJOO6s
         vXDBIxezRGLgFzWqiZKMS69bhC62gTbOFWBq9qCqBtZ0sez4AI+PNoh6rznaK3a7QCdD
         vJ44Bi/3I+IKIiPmXxcvO1S+L9OgVmlCJHSh6+j5Iot2rHT/VGym+RgtxxwFMPFR0WcO
         stbA==
X-Gm-Message-State: AOAM533p0syjq5Ae/yw6WSt9Ik097uWGCgcX6s9xPYh/NJYt4k1v4JCc
        c4oC73/O4xwc4u11X5au+FCkQy9chwPH7g==
X-Google-Smtp-Source: ABdhPJx0YpgjyeRPkAeGqtyKmO+YkPOhyf7xDYJjjrxeEpAVaraZ68Yj2I56dIVK9WlV+GF4gdFOQg==
X-Received: by 2002:a65:4c8a:: with SMTP id m10mr5165221pgt.138.1590338659249;
        Sun, 24 May 2020 09:44:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:8568:4ec4:ebd3:32d1? ([2605:e000:100e:8c61:8568:4ec4:ebd3:32d1])
        by smtp.gmail.com with ESMTPSA id j186sm10832729pfb.220.2020.05.24.09.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 09:44:18 -0700 (PDT)
Subject: Re: [PATCH][next] loop: remove redundant assignment to variable error
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200524161043.20292-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9042a7ea-2d2b-9cb9-226b-266c35036701@kernel.dk>
Date:   Sun, 24 May 2020 10:44:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200524161043.20292-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/20 10:10 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable error is being assigned a value that is never
> read so the assignment is redundant and can be removed.

Plus, by definition, we already know that error is zero at the
time of assignment.

-- 
Jens Axboe

