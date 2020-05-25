Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F92207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="XW0qdfic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbgEYPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391101AbgEYPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:53:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200CAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:53:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so168670wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sVa828/t+od9i6K0iwiT5/ErQ2zAZnhakYd2b2nYPJI=;
        b=XW0qdficRIZ4bWGRTkLECw9GWuN8I0mLbnKyDd1yVmlumgakhmdxHFS8P6Z6KHCJm/
         fbEJ/7NeD+3xrNc+dSE+dAxb+iup/hIm7VFsHdpO8xf+QyEAwRe7+JpLZfRM9vZyFJvO
         Es8sW8HRzROR89xwRNGRNGjfso2oiazQZKwkOWZZtIx234cC+zVDjXga+iH2E8UEfx/d
         SSmwQ+wB5cZqJ89t1YNsSfBErw+LSeC9U7k8yXCDqnEwtcbe8UZAaNAadycxqRr3zQh/
         sSnoG+1d4sK84a8vau4dwp7g8uR4Jui0aNqwC9jYxQPOFYDZ27vXJn2UGWoB/b6O1ByN
         swPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sVa828/t+od9i6K0iwiT5/ErQ2zAZnhakYd2b2nYPJI=;
        b=BxuKJhP+12os0J1DGtI8yhllehCnf2pBp87kX/Lp5dXQt8WlKnnWAIkBz3gNF7dW1L
         3fwAttzVH4inSVGj0A4RDanw/KSt2/P8QHhNWt8zA4BZ21NvAriUrz6865TwxAXLFF4B
         qw1sH/SICoNQIpiwFAU+nUMavrQhhkKqt41wg4Uj/96BYcRf/It03tE8x2ShuqpyAVgW
         lh+n/+YKYGXgQwmAlqNYmDKaBTyt3Yyz5YstqaJ2kKXeVxHVBrjdzuC2AgRoLnc8XKBx
         u3gPSL5oKSd/6G8cqgfD0AH9Y9/KAt/lJQXnessJedVDax+y56DU/X2ATiNCYFBTFAvc
         KoXA==
X-Gm-Message-State: AOAM532QMQjpk/wQvigU519Y2Mh30TQHJxfPIsoDbNc3g37Zx5pACuxs
        8r5S5Rre9jHq1brOLWTNYf14tw==
X-Google-Smtp-Source: ABdhPJx+cDjqy1SxHuN5QiXUeIyaA921alq/Bru+pnZuLjvbBBabk2j5F7gdzjYzOwbTU0gbqBDPCA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr27746065wmg.161.1590422021693;
        Mon, 25 May 2020 08:53:41 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:269:e210:80:e64c:847d:b568? ([2a01:e0a:269:e210:80:e64c:847d:b568])
        by smtp.gmail.com with ESMTPSA id r5sm14589510wrq.0.2020.05.25.08.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 08:53:40 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@linaro.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org>
 <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
 <CAD8XO3amGVeyn9qsWE-AyGM=e36ubwxC4tiwGMVHYBL6E46ZhQ@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <4be64892-e027-a58d-09f5-0450088292f6@forissier.org>
Date:   Mon, 25 May 2020 17:53:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAD8XO3amGVeyn9qsWE-AyGM=e36ubwxC4tiwGMVHYBL6E46ZhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/20 3:36 PM, Maxim Uvarov wrote:
> On Mon, 25 May 2020 at 15:10, Jerome Forissier <jerome@forissier.org> wrote:
>>
>>
>>
>> On 5/25/20 1:52 PM, Maxim Uvarov wrote:
>>> Optee device names for sysfs needed to be unique
>>
>> s/Optee/OP-TEE/
>> s/needed/need/
>>
>>> and it's better if they will mean something. UUID for name
>>> looks like good solution:
>>> /sys/bus/tee/devices/optee-clnt-<uuid>
>>
>> How about mentioning it is the UUID of the Trusted Application on the
>> TEE side?
>>
> 
> Jerome, do you think optee-ta-<uuid> is more suitable here?

Yes, a bit better I think. More "self explanatory"... kind of :)

Is it possible to have several devices bound to the same TA? I think
nothing forbids this although we may not have any use case for now...

-- 
Jerome
