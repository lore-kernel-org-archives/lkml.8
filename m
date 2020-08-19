Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E872067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NyjiFBib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHSM5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgHSMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:55:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F6CC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:55:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so1134680pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrbpQDX15p//tPT7UvuN4uevRSDzI+hoTHUn4a3y+a0=;
        b=NyjiFBib4jG9+dEWoEnnDri1nWuFNmYsX63rP2x/bSpFDl3/E6+Fsey3gIejp1KEl/
         Zt6SapvAvbK+PGznoa9rvJsaQyrV7llkBKEAbb7QOVpy11/haGw0E1rjga4lLhOK0T3B
         n1yVM6QnrxYRbd0N+Jt6pZLHvycn/ysJVrHlVIhFSTUQqZQWGogi3CuaV/C7tao2jHcV
         ZG1V3RDNOQT2b/4Q2xqki4U7M2HHirSA5SONgufGeBgmeI+AAPNi4CjVp1a4T0bn7EHe
         8iEeDt/VxVc3GT62278Iw8Dr8R69qJZplrKNnbrbs1wqzr/zDu3RcURLPkusNnYLrbQE
         7qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrbpQDX15p//tPT7UvuN4uevRSDzI+hoTHUn4a3y+a0=;
        b=qb9hMxuIt7Rt1TD2fbJ3irCJKRA86xmUkOF9XML336PmCHJCsdY/z3xz0vibPK7m+c
         naopJlJvXI/a+I4nLpHnjrOcpeuipbxv59htaqVZTcMHoNqp7iUER9gAEPJrDQR3oLLY
         QWvNpY6KWPcr8sE7MNJrlH8cLJATOfdXuVnccFG6lYqgYQTyTfR3Wl8+llk1VLKJI3bg
         KcXUjTlz3B07atU9JrLS357zdFsbK3f7aLbIeGPp2zyG9sGqafBIkA5QC1MCuL5aivdp
         Kl3m7epMbFCijUK6VQgyiRZ0hzvB6krOWNehAZfNdDxG0ePQpzVujE/Nx96uWPX6U+Tb
         R5uA==
X-Gm-Message-State: AOAM532Do1hCzebpma6SF7KUuDK55jLKKLecBK/q/TPpNzgwJFs+bjbH
        NMyihoejiHBBk//aCrdUHkTHIIkAw7N1aC5u
X-Google-Smtp-Source: ABdhPJwt+h/eu259u72qGri6DEmcqEOTbSywiag9NYdAcHMjkxwqLjx5ajBORusqvqeZVyqqzP290Q==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr4061190pjb.228.1597841722879;
        Wed, 19 Aug 2020 05:55:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w3sm28975674pff.56.2020.08.19.05.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:55:22 -0700 (PDT)
Subject: Re: [PATCH v3] block: Make request_queue.rpm_status an enum
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200819123403.19136-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54e9ec37-00f1-b3a9-ab80-f4be77382aae@kernel.dk>
Date:   Wed, 19 Aug 2020 06:55:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819123403.19136-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 5:34 AM, Geert Uytterhoeven wrote:
> request_queue.rpm_status is assigned values of the rpm_status enum only,
> so reflect that in its type.
> 
> Note that including <linux/pm.h> is (currently) a no-op, as it is
> already included through <linux/genhd.h> and <linux/device.h>, but it is
> better to play it safe.

Applied, thanks.

-- 
Jens Axboe

