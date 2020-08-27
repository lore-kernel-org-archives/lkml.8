Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EB9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2175207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="RNiGEKW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0Nf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH0Nb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:31:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB68C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:31:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so4481265qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDczrlJd3qpi62PuNHOBqp+bVIuJaZ3CIq+6qbkhanw=;
        b=RNiGEKW35DYb/JfM8HflEt7mDoN5TTPevUjWrFEMiWnB7Nb4c3aWKy7OU/kyHLadcm
         xBs4dPO9yvjR28pNvlkIVvz1z48FwzX+Q7XHHN6Hc6GYQb3xJXyaCtC7yoF6eGgJlzB5
         q3NWsx/2aKVfGGvJjPYX2AMGRKQLIZVqtIxk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDczrlJd3qpi62PuNHOBqp+bVIuJaZ3CIq+6qbkhanw=;
        b=JHV6IWwl3yjn2GFN7KSpNfYMYBmv22nwoNkFTP06zl5UvM2s+ozlyLyTC+Vu3QdZyL
         HVnIifByRMhF0ZvZ7T8BvEi1NBsvHSdTNjLbf5Sh5Vlp/auoH39QA3IQi7Yxy0+k4Hvn
         a0y9WXX54zL+b4wNBIxOJrsx/hRRiw9a5LG37rmpp3Q6ZIUGLdizfubFzXFuLRtj+hPv
         segl+wOW9DsAuDtYlZGUe8Q8/juaBrXh2abqtBLfJHG2GBzda1i1p5oZSWgbPT98G9zn
         hcDgnkfBfkTZItdoruhFdM4vDYO5MVM3qEVRYim+HvOpJ3NOdKQMbqlM+6YN2sBzIulz
         OesA==
X-Gm-Message-State: AOAM5317mIeqJYIN6fRZDIMRxKsb72O5+bQRffJyHHtfNwTjwa8RXnoI
        hLQkMv/YtIUOrDSOQ8xP/XcQbg==
X-Google-Smtp-Source: ABdhPJz94NCDJe1Y3TCUAT1fErYJ7r4fw5orM7dXc6gbtDSEIf2lbXNnjENlynBt6QlAePZlj2K0AQ==
X-Received: by 2002:ac8:4f44:: with SMTP id i4mr6328121qtw.189.1598535088575;
        Thu, 27 Aug 2020 06:31:28 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id i7sm1774133qkb.131.2020.08.27.06.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:31:28 -0700 (PDT)
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sumit.semwal@linaro.org, john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name>
Date:   Thu, 27 Aug 2020 09:31:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200827123627.538189-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:36 AM, Greg Kroah-Hartman wrote:
> The ION android code has long been marked to be removed, now that we
> dma-buf support merged into the real part of the kernel.
> 
> It was thought that we could wait to remove the ion kernel at a later
> time, but as the out-of-tree Android fork of the ion code has diverged
> quite a bit, and any Android device using the ion interface uses that
> forked version and not this in-tree version, the in-tree copy of the
> code is abandonded and not used by anyone.
> 
> Combine this abandoned codebase with the need to make changes to it in
> order to keep the kernel building properly, which then causes merge
> issues when merging those changes into the out-of-tree Android code, and
> you end up with two different groups of people (the in-kernel-tree
> developers, and the Android kernel developers) who are both annoyed at
> the current situation.  Because of this problem, just drop the in-kernel
> copy of the ion code now, as it's not used, and is only causing problems
> for everyone involved.
> 
> Cc: "Arve Hjønnevåg" <arve@android.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Laura Abbott <laura@labbott.name>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: devel@driverdev.osuosl.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

We discussed this at the Android MC on Monday and the plan was to
remove it after the next LTS release.
