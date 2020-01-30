Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2875A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM7GjmqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgA3QJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:09:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37824 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3QJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:09:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id d3so3631472otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c85UXDffSb2PXv2XpV6UzKNMBIzxhdNtxwM+oiL4ZfE=;
        b=EM7GjmqYIBO2WAnrvccmL3zonHAn+mRqth2qs6/SwOaauF5pna+ED/XapC1LRHMnRO
         QwwPWQbR+MZN5cas22iyUJowvCXZgVBOfVffSDO7v6Er/pLrZ6F7RFFEUJ8q54bxcBTu
         UWl0Sf3pEf6ylzzoMRw/vic+iXLSmxw0hpzN+uaw+B7b6zfatIE7GKrrAsf+S1AWc7XZ
         Gkk7bsBtQIgXRWdWxYuEAQEXvYMDlcNwBvBDkurnNzoadv4JoU1r51YCOLwiCutwifOs
         iI/8KZ8vrOnrmyGsM6DyN0MScG7siymJysokG5qKl9uSO7riuU19hy7Hk9trrySjGfJ1
         sP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c85UXDffSb2PXv2XpV6UzKNMBIzxhdNtxwM+oiL4ZfE=;
        b=uNGaKdkBdKibF+oYE5/d5AnhT4CyEBqQ1nmibU5E7BiT5reO49Cc6+NXTmCp/TmlIz
         czp6AziNIt8cBF1gEVKNRqBuGhnnbf4Y8FeAnyLMed53Mgnah/WgkrMRnphJ4lMi/dVS
         oCcZpOS+WWSGI18Pqr45Z4rDJdXK/iY/MmOvHzaJN1zQvCgaUWxkEhaukNILEkxrdX2o
         6pWcd3qzUtiDbSe8CUC6v2rWx75J3gKZ3QUlrBCorzrR2JUg+aMv9JiXkE63jbdxvsth
         UtpY9ZC+NPiklSRHRme5ycCLxVni9VBLN2MEGZWzh0eqW3AgAfpp5HkkzErtnSpJWNFI
         hPwQ==
X-Gm-Message-State: APjAAAXp/x571OR7CTBWhTZaiqMqJzLgKv/I3LO5vKwRWQ7N3yEDvmg7
        ioL24/fT8kb3QxWJe0Y4gw==
X-Google-Smtp-Source: APXvYqwa9xjKXt29xk4s3SxDL1xFfz94p2+LDPjwwMGl0PNRiE7Fyb8nzl+Z4QUOT8sgvoLMeuA5iw==
X-Received: by 2002:a9d:7590:: with SMTP id s16mr3832406otk.89.1580400573885;
        Thu, 30 Jan 2020 08:09:33 -0800 (PST)
Received: from [10.236.30.189] ([165.204.77.1])
        by smtp.gmail.com with ESMTPSA id m15sm1969943otr.65.2020.01.30.08.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:09:33 -0800 (PST)
Subject: Re: [PATCH] powerpc/drmem: cache LMBs in xarray to accelerate lookup
To:     Scott Cheloha <cheloha@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200128221113.17158-1-cheloha@linux.ibm.com>
 <87pnf3i188.fsf@linux.ibm.com>
 <20200129181013.lz6q5lpntnhwclqi@rascal.austin.ibm.com>
From:   "Fontenot, Nathan" <ndfont@gmail.com>
Message-ID: <4dfb2f93-7af8-8c5f-854c-22afead18a8c@gmail.com>
Date:   Thu, 30 Jan 2020 10:09:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129181013.lz6q5lpntnhwclqi@rascal.austin.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2020 12:10 PM, Scott Cheloha wrote:
> On Tue, Jan 28, 2020 at 05:56:55PM -0600, Nathan Lynch wrote:
>> Scott Cheloha <cheloha@linux.ibm.com> writes:
>>> LMB lookup is currently an O(n) linear search.  This scales poorly when
>>> there are many LMBs.
>>>
>>> If we cache each LMB by both its base address and its DRC index
>>> in an xarray we can cut lookups to O(log n), greatly accelerating
>>> drmem initialization and memory hotplug.
>>>
>>> This patch introduces two xarrays of of LMBs and fills them during
>>> drmem initialization.  The patch also adds two interfaces for LMB
>>> lookup.
>>
>> Good but can you replace the array of LMBs altogether
>> (drmem_info->lmbs)? xarray allows iteration over the members if needed.
> 
> I don't think we can without potentially changing the current behavior.
> 
> The current behavior in dlpar_memory_{add,remove}_by_ic() is to advance
> linearly through the array from the LMB with the matching DRC index.
> 
> Iteration through the xarray via xa_for_each_start() will return LMBs
> indexed with monotonically increasing DRC indices.> 
> Are they equivalent?  Or can we have an LMB with a smaller DRC index
> appear at a greater offset in the array?
> 
> If the following condition is possible:
> 
> 	drmem_info->lmbs[i].drc_index > drmem_info->lmbs[j].drc_index
> 
> where i < j, then we have a possible behavior change because
> xa_for_each_start() may not return a contiguous array slice.  It might
> "leap backwards" in the array.  Or it might skip over a chunk of LMBs.
> 

The LMB array should have each LMB in monotonically increasing DRC Index
value. Note that this is set up based on the DT property but I don't recall
ever seeing the DT specify LMBs out of order or not being contiguous.

I am not very familiar with xarrays but it appears this should be possible.

-Nathan
