Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA92C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2760A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHFBPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:15:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHFBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:14:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so42413025wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 18:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMwzmeUWlIUMBkzoWUqLg8C7tOu2SeHgF4lmZs2oBQs=;
        b=gW/V39euzkyW+/A9tR7aiC0g/MBkQcRs7Qwv4zSgadwTRzodZIF3AUK2qDNfD16SOD
         igikE1SbtTYadSH0fVPOwJqP8W3ySEUQXbxIDN45mdPoqc4HwDTs1cNjlPyL13JZQnEK
         RpeA5im1x8H02nM/GwZRFABh+1kRvHPeUUdULmfXE31wo2jBqcpEP4vGqN9Zs4bG30VE
         D3qqLfTbo8D0RQYmd4S+akHo4XUZGdDznTV3Ek2ApIzHDAu+GpbNv4+f5/U7B8sQdnAy
         j1iPA6qxy5kQYVLh8DNQ+SJUt0c6WxBi6ojxJIJA1ErHPy1WCQ7SOPswBeDxZsCCtmBK
         J40Q==
X-Gm-Message-State: AOAM5316mdnOwkLa+/knQvpJIXdeg+DAoZEUaPjqrWRiGCHa7l/bGN/V
        R3yVQCiprDbtXBmjK9Im3ByqT2QA
X-Google-Smtp-Source: ABdhPJwdbef6jXmE+jN4Pl9BBz1qDXxUWRKEm8jm+fUg0/0xhV9D/uT919vQNvtPF63Psh/G8aDoWg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr4940678wrq.200.1596676497600;
        Wed, 05 Aug 2020 18:14:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2803:3684:5e52:5417? ([2601:647:4802:9070:2803:3684:5e52:5417])
        by smtp.gmail.com with ESMTPSA id 111sm4632767wrc.53.2020.08.05.18.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 18:14:57 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "hch@lst.de" <hch@lst.de>
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
 <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
 <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c31c1600-7b9c-f2cc-57fe-e8c16d857d2c@grimberg.me>
Date:   Wed, 5 Aug 2020 18:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>>> following oops :-
>>
>> Why LKML and not linux-nvme?
>>
> 
> My bad (+linux-nvme).

It doesn't have the patch. can you resend?
