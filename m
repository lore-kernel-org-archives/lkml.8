Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F7C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D1E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuCqbnvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgEEOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729915AbgEEOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:21:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA80C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:21:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so876516pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eAUuDffef+SKab6BV2gqJGaP2t29oArGlcFYJfwH38U=;
        b=tuCqbnvR1GkWNemBW671Bn9V6e9Y1SHREsa4AEipbKin/vpc+1ek5T5KgnHQnwmVBs
         1AvEz6DMQa03Zbbbi6nMpmUs1dcd6jWZUtKwr+WaYPBnMhHO5U8itz1WBcZxWbb8SbVB
         nloUXBdOWHcSeiqIXiPk5hST46aIhSh98bI3EHLpki1W+x1dvvFeMWc5ggcPKFwld2SY
         WaAr/fseUTNKgh8CWhAlGqSk1XQl2FQOoqOVym7rstXcEqiAIolGEcouCZVEA8cWxy9t
         5IGVglH9r0elFsQQRStQkosB0y1WSJN/T2McNQQpDLWoPvHr2Sg1HFAXKb1Qu5A76/Lg
         RGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eAUuDffef+SKab6BV2gqJGaP2t29oArGlcFYJfwH38U=;
        b=SJokVnxTBKuVR5uQfM3pttKmN2CdEJXF5sZHqp5VQT5lvv3TWjYHteQMioLdp+rfUc
         8FKDFjFrTclWFSh7EJwImNl04NjnSqpW1IZhrcDnBZvUjKClUpWpBzbGrVZ4RdQK0ksp
         p8hDjol7taA9bnX+791scQBvUkU9IkabsMJ3o6WirUhvgY3d9mjF0nPmyDWt8kDWsvKd
         9y0bx2w/wGyX6NdWUrlPqrjj3ispdJoRyseCpng6K9yzRDKWNN3nsWUM8l029gsIL3hB
         BQFjdU85IOasvZc3ZyVU0Gv57YJvEl3SoO61uxHmoncE9QsVQxGjMUQZNyWWQFP38KCF
         vu+w==
X-Gm-Message-State: AGi0PubuLZHiqEZbkaWWum81+tS/vNkFS289tQRjrVTCwV+7E6yS6VeS
        4cBMwDPFoy2NS1L6M9xGv86SFkJlIi3mXQ==
X-Google-Smtp-Source: APiQypLtMbBtDxHog4ustBbrIiIeMpG8jnVA0urpR7RWuus7RBw9XgTQgxEw7+Q4LWVAMFuB9Q0WmQ==
X-Received: by 2002:a17:90a:d711:: with SMTP id y17mr3375951pju.11.1588688502228;
        Tue, 05 May 2020 07:21:42 -0700 (PDT)
Received: from [192.168.1.7] ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id l16sm1687705pgh.35.2020.05.05.07.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 07:21:41 -0700 (PDT)
Subject: Re: [PATCH v2] fs: jfs: fix a possible data race in
 metapage_writepage()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     Dave Kleikamp <shaggy@kernel.org>, linux-kernel@vger.kernel.org
References: <20200505135313.28793-1-baijiaju1990@gmail.com>
 <d3e126df-e7f6-00bd-aa3c-ea39fcd1582e@web.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <05f9211d-6f57-b613-b584-a6d84b163645@gmail.com>
Date:   Tue, 5 May 2020 22:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d3e126df-e7f6-00bd-aa3c-ea39fcd1582e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/5 22:15, Markus Elfring wrote:
>> This data race is found by our concurrency fuzzer.
> * How do you think about to replace the word “is” by “was”?

Okay.

> * Is this analysis tool publicly available?

Not yet, because we are still developing this tool...

>
> …
>> ---
>>   fs/jfs/jfs_metapage.c | 11 +++++++++--
> I suggest to omit the triple dashes before this information.

Okay, thanks.


Best wishes,
Jia-Ju Bai
