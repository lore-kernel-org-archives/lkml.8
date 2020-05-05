Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56207C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFA206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7fddasA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgEEOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729142AbgEEOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:51:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69943C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:51:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s18so1109988pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M2EXFFKRgen9dOdoaNmpWiHUyjNR6THbe0hOWRO7mK8=;
        b=D7fddasAWnayCiXP2vHn30lJiXBOJv2aUiHOdfJde4gO8WX1JRBXjaUsSh2f8mxYla
         4Vcx3Lj7+2jFSZozWlZUqJ4F/wBJeDLYJdvLg7VanqP07JlBBqtkBCqZZBIGaBx+ozlG
         1CWshZSJFrUHiODphYd2AfN9t9lUsX3GgK4i4aGC1nbA1xu/8yhuTNkbYYH95w8mrY6G
         wPAc0l7d1YO0y2OmI1XmbtlFcZaMGMBON7c84uuWbYjK6CgU8A3QCP2bD3UK4x38AqKg
         OkLqZ+ZQlbycqkgaaImtw/veRODLqWCXNa3yJJ4Mq21juD5AOLy9wI9SpzCSNPT0yRF1
         TIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M2EXFFKRgen9dOdoaNmpWiHUyjNR6THbe0hOWRO7mK8=;
        b=rrLxEvCYliyDUi/I4n0corDa4xGmaPp7fEvybjgqjRAzttxoL7y0OSm4dbLy3yk7rQ
         verfk/WzP06kRWDtcloDWjxcZ0Qd5caHOfBd11Yoog5yQS350Ox3mzIZLu/OUqTQt7nR
         wmwFOvHcFev2/YXEiTYAS/QQsPGXbc8YWwplYM30sLHvnKW2Rj/0ZnFDgarZFntGUG8C
         M9MIsOy5UCFl947E8s4GW5ShnAa+2A4tVEvRnf+45KcJGi/s+9V6tYDqASPLK8nap6nR
         3csnmqYC+6j4fPn32IDsdwUGrZemg3u9yH92kdWrq5MMYiidfr1LkAJv67LCW3JCbpAB
         cdtQ==
X-Gm-Message-State: AGi0Pua5ETW//5vt38yWZFbfnBVqdbC9etOThh9JAO3p1tlpMeIMF0zp
        BnvAUfKAzOx/uvPFnWjYa+QndiEo05rlFw==
X-Google-Smtp-Source: APiQypLWT/eT6bBlOmzsdnLhfcWjUIOGYmmUvs4tqBFlqETjzRpH8Cy+o7M1d/EQm2xTC6ZHMmnHZw==
X-Received: by 2002:a63:da10:: with SMTP id c16mr3216084pgh.208.1588690276578;
        Tue, 05 May 2020 07:51:16 -0700 (PDT)
Received: from [192.168.1.7] ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id x185sm2293389pfx.155.2020.05.05.07.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 07:51:15 -0700 (PDT)
Subject: Re: [v2] fs: jfs: fix a possible data race in metapage_writepage()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     Dave Kleikamp <shaggy@kernel.org>, linux-kernel@vger.kernel.org
References: <20200505135313.28793-1-baijiaju1990@gmail.com>
 <d3e126df-e7f6-00bd-aa3c-ea39fcd1582e@web.de>
 <05f9211d-6f57-b613-b584-a6d84b163645@gmail.com>
 <074b3682-054a-d2ec-8142-1d87e1e97ed6@web.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <10f050ee-1b73-d015-ab57-fa0a3b59577b@gmail.com>
Date:   Tue, 5 May 2020 22:50:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <074b3682-054a-d2ec-8142-1d87e1e97ed6@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/5 22:32, Markus Elfring wrote:
>>>> This data race is found by our concurrency fuzzer.
>>> * How do you think about to replace the word “is” by “was”?
>> Okay.
> Can such a positive feedback influence the change descriptions
> for any of your other patches?

Okay, sure, thanks for the advice.
I will resend my patches for jfs.


Best wishes,
Jia-Ju Bai
