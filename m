Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DEBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2660420771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KV9sDYfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbgGAQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbgGAQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:53:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C6C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:53:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so9214465pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BaZwJStCKTwWav0ryjMZZK4OAhmZE1ocGk8G4wNBCcg=;
        b=KV9sDYfQt8i6bcWQYVOXUpa52LDHOx4jbjmJjzxRfMBvjz7w86fXpeqlk7POGl7Sov
         UpIwQ49CaZUr0I1DmuRlvOsMrXYuKox0gDb+MGbx/x6e6C7b0/E8naxTgXHrn065HltO
         ECztFHj58l7091xWrKwqO0+/eYp0NZvR6iQ1Q0DkkWUZbkfGLoSaxzRENwFTqwgFE4tu
         7inJK1Bf2fOSFgfFKvtufKOg5VseRtqHMsMBgqA9lsyM0zX5ofSW/v+TBi42BSCqEOUL
         pczORKL9PhlhhN2W32YC5dODi6u5a18YlsHAmuOdryeL1rgN7VXfK6npKFue9E0J7eYr
         Pbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BaZwJStCKTwWav0ryjMZZK4OAhmZE1ocGk8G4wNBCcg=;
        b=GUuV9ldc3t8ojiqesxek+4Sd2958+o8wghGjvPkSD9GQqbuwdUJeQB+PflcVeS1hBo
         WBKUE3ObuIpOi09vi7MaA5fP50vrEjQBIT6m5RsGmnffzc5Jt50nSPdXuc3C0JOZ2y5j
         ILFsKTNvrK/F6evvi8WUyEASONlobFX1CiLaLkBHECx6n9IrQiKAr/sn5HzpWmUZkJng
         F196ERIzZCv1jdSGiHW97lAF84EYydzB+u2sePjldhXprX1yQkk9Z9cIVsenY7t0nSez
         11+9aD1Y4gT9pOYyqyGJHA3Rtp+HPS1szKkV12DY7vpU2G6QXwtXFph/REtLlyhnF6Jd
         3l/w==
X-Gm-Message-State: AOAM531xn18aYNDG7T0L2J7XK5JQyRQ6+o81xotZg9+M1QxilKTFK3nZ
        ETdRclBDHdnQIBjgD06q/M2wVw==
X-Google-Smtp-Source: ABdhPJxVgsahckfB+Z5tVK0G18UWeGL0p2gtnmnPJ6s4JxBARSk1QzOGw1lpdWQ6rXkSJaPFgoYMvQ==
X-Received: by 2002:a05:6a00:15c3:: with SMTP id o3mr23997329pfu.304.1593622409934;
        Wed, 01 Jul 2020 09:53:29 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a48e:6306:8f4:9d74? ([2605:e000:100e:8c61:a48e:6306:8f4:9d74])
        by smtp.gmail.com with ESMTPSA id k7sm6478422pgh.46.2020.07.01.09.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:53:29 -0700 (PDT)
Subject: Re: [PATCH] sbitmap: Consider cleared bits in sbitmap_bitmap_show()
To:     John Garry <john.garry@huawei.com>
Cc:     bvanassche@acm.org, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.com
References: <1593590785-191512-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <122e0d4d-d9b2-a81e-b8ce-fa8636eabe1b@kernel.dk>
Date:   Wed, 1 Jul 2020 10:53:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593590785-191512-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 2:06 AM, John Garry wrote:
> sbitmap works by maintaining separate bitmaps of set and cleared bits.
> The set bits are cleared in a batch, to save the burden of continuously
> locking the "word" map to unset.
> 
> sbitmap_bitmap_show() only shows the set bits (in "word"), which is not
> too much use, so mask out the cleared bits.

Applied, thanks.

-- 
Jens Axboe

