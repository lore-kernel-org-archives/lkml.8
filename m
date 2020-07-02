Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA7320B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netrounds-com.20150623.gappssmtp.com header.i=@netrounds-com.20150623.gappssmtp.com header.b="Cis4kNAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGBGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBGOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:14:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22BAC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:14:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u25so15271624lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netrounds-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F/rMuyuvEyEfi/6FryOT8XNai0M0Cykvyrz5tU+jLoo=;
        b=Cis4kNAoB7Bzb9zXm4S1rMZfQDTsxKJCUW7enqkypgJkJiiaentFQ9x+VfJAUjA9F5
         pBpF6yLg7sKhk/mKJIPZdVnI+BAaykmLkjd7XirSvZsn5XnZYCCkOfBIgwWh8SMt7cJS
         TJ43WS5jMb7zmZH6OGsaZjHjgFqiYgN8DBZh8vM127eJ/kING+BWHao3CXyCN1AEGXHa
         JYLvJKHwkb4vVdIlq0HuwDG6pBgxuz5TwMP3vd3Y6xZAzCrraW0UCAt0W8DERReC3WJ9
         XQkB08hl789zTjELaaTwAiklcpOmeOU7cjV2tfdy2/oIIVi085TmagrF6I0jHtRjMzBA
         LwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F/rMuyuvEyEfi/6FryOT8XNai0M0Cykvyrz5tU+jLoo=;
        b=Thdn5qBttujB8b/olC7pfCmqcHXtOnFUaqMaVxXxdquPR4CyqozZKRPCCBms+4akdm
         n2fEPx8002H+MxOkQRQJN719QPMYLLtsdA7ZAYXQJVRP+JYuBd9Ua+NaR13uMDer74/n
         ajgjeyzunoP1CzC/vcZCXXUJFRvUZReD7o9qiYAOWtGXhuqt43tfprGRKNqcFmluXxj+
         vX6SHFdMwJaJwr6f5NDEMCwy6HD8C0tcedyfyGxFVkkIhe1fccaEwqm2uKz9C7Nb/S5V
         9JCSeWh3VEEu22IgVQVtjjQ7BLXDnJMrGwRVODSwPt/GpMeSedF9PVlwYMbpAckv24lN
         vltg==
X-Gm-Message-State: AOAM532pA8m4NpPX6xIxZH/zpfz6RQNRUoOXMdo8GmZigbRU0VmYRbSW
        Zl9oo4MnyWm0kcJyiRIy4A+qug==
X-Google-Smtp-Source: ABdhPJzqeXTumbtaMxqGyuknh6nk1NxCfny6HrJGFO+DKXdPGrlnzEn2wsPfFPuwQOirZ6ykNyG3FA==
X-Received: by 2002:ac2:5a50:: with SMTP id r16mr17945836lfn.170.1593670477459;
        Wed, 01 Jul 2020 23:14:37 -0700 (PDT)
Received: from [192.168.1.169] (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id m2sm2574458ljc.58.2020.07.01.23.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 23:14:37 -0700 (PDT)
Subject: Re: Packet gets stuck in NOLOCK pfifo_fast qdisc
To:     Cong Wang <xiyou.wangcong@gmail.com>, Josh Hunt <johunt@akamai.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Michael Zhivich <mzhivich@akamai.com>,
        David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <465a540e-5296-32e7-f6a6-79942dfe2618@netrounds.com>
 <20200623134259.8197-1-mzhivich@akamai.com>
 <1849b74f-163c-8cfa-baa5-f653159fefd4@akamai.com>
 <CAM_iQpX1+dHB0kJF8gRfuDeAb9TsA9mB9H_Og8n8Hr19+EMLJA@mail.gmail.com>
 <CAM_iQpWjQiG-zVs+e-V=8LvTFbRwgC4y4eoGERjezfAT0Fmm8g@mail.gmail.com>
From:   Jonas Bonn <jonas.bonn@netrounds.com>
Message-ID: <7fd86d97-6785-0b5f-1e95-92bc1da9df35@netrounds.com>
Date:   Thu, 2 Jul 2020 08:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpWjQiG-zVs+e-V=8LvTFbRwgC4y4eoGERjezfAT0Fmm8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cong,

On 01/07/2020 21:58, Cong Wang wrote:
> On Wed, Jul 1, 2020 at 9:05 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> On Tue, Jun 30, 2020 at 2:08 PM Josh Hunt <johunt@akamai.com> wrote:
>>> Do either of you know if there's been any development on a fix for this
>>> issue? If not we can propose something.
>>
>> If you have a reproducer, I can look into this.
> 
> Does the attached patch fix this bug completely?

It's easier to comment if you inline the patch, but after taking a quick 
look it seems too simplistic.

i)  Are you sure you haven't got the return values on qdisc_run reversed?
ii) There's a "bypass" path that skips the enqueue/dequeue operation if 
the queue is empty; that needs a similar treatment:  after releasing 
seqlock it needs to ensure that another packet hasn't been enqueued 
since it last checked.

/Jonas

> 
> Thanks.
> 
