Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939DCC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7862720872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0WHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:07:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39190 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0WHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:07:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id q8so1364372lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tYXpRXE4eeK4xPbPZvlJUIW6lMXzrkezSTbNoQcO9tM=;
        b=NYBJmk2w3CV7f4h5DtbT6sb0J+7Gpg1AjyJtf/am1ELs2iV3vWSSo4wmyamLjmWp73
         1f6ToZojq7VmvQdKWFhBipM8EZ2qT068aEFZS44E34jxNwqnkwypwSAaNIm2aAFjpoQw
         OQB8mrXdNO9K80detiMtauLi5euVE4rBh8OXlSxyDTi9ob4rcHSJhBM5ZrXI13L9g1wc
         DhgCW/rQfqMmIM8zmY67Tu1hR6Vvgf2ZPnvOFPCLjN8oregiZ9H4HRDpaR8k6vzBDX9k
         M7pDCBD6a1HJmFqJQvimDhhbV6eVWTTXJC0c5Vw269ysWz5vRoGF4e/L0rs2s1+LnfmW
         Kkgw==
X-Gm-Message-State: AOAM533DnLabl7YLcUQNay3w4zjT/V3EMOx1XbC5sB5NXGhzWZQl6pZK
        jA/HUpwkmNFODEDmJm3Nw+SAMypcVn8=
X-Google-Smtp-Source: ABdhPJzLhcG+J8GmjfwreDL8RmYsV7bO/fIk97lP52ruIlXIysJJo9gdcyTLVgb3xg/69SkMeQ86vg==
X-Received: by 2002:a05:6512:330c:: with SMTP id k12mr10730928lfe.151.1598566060214;
        Thu, 27 Aug 2020 15:07:40 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.147.111])
        by smtp.gmail.com with ESMTPSA id h18sm811851lfk.86.2020.08.27.15.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 15:07:39 -0700 (PDT)
Subject: Re: [PATCH v2] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20200827151923.40067-1-efremov@linux.com>
 <20200827212530.48013-1-efremov@linux.com>
 <0caaeb1e-6f71-b97f-f86c-22819c30e31f@embeddedor.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <552711fa-5b85-d418-2ed7-05fc027d6c10@linux.com>
Date:   Fri, 28 Aug 2020 01:07:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0caaeb1e-6f71-b97f-f86c-22819c30e31f@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 1:09 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 8/27/20 16:25, Denis Efremov wrote:
>> Use kvzalloc() in udf_sb_alloc_bitmap() instead of open-coding it.
>> Size computation wrapped in struct_size() macro to prevent potential
>> integer overflows.
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
> 
> Please, comment here what changed in v2, vn... e.g.:
> 
> Changes in v2:
>  - Use struct_size() helper.
>

Ah, thanks. I added this initially and accidentally regenerated the patch
file with format-patch.
 
> 
> Why not this:
> 
> bitmap = kvzalloc(struct_size(bitmap, s_block_bitmap, nr_groups),
> 		  GFP_KERNEL);
> 
> and you can also get rid of _size_ entirely.
> 

My bad, I missed that only nr_groups is used down the code.

Thanks, I will resend it as v3.

Denis
