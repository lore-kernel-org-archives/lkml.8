Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E9C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkHBtYzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCRE1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 00:27:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44638 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRE1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 00:27:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so12935017pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 21:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5hQqpSvt4tC1ihG/h6rOXKsZco8EGDS57uVaABs5Le8=;
        b=jkHBtYzvhoglTRpv8FIvWUG1DiqqLYXPKxhZV2s2u/ECys5cNUub5EMaQiEN0fSxyZ
         6ZWxl+i2i9+jvb26DEbLyueO+Oz7femIGgayHCiqm+TL7MuREo9NyKVHuvfjjrIBW1yV
         zd2mi+gdahuqchxUqDeAqiiIFzfudI3QqtKTSep2DThD4cu5aii4SOt6ycbS8KvhRqSj
         aAL+KkEkNqUXB2a/hxVpBZaw0tmDPAD3yuc0VDjV1gqzBHcljWEHYSNfVduv8/FUkzsj
         9uY0PxmdVqk3GsnUdthJfLSDwzCpf6QLGIG1HXkA1v1loK5ety8WUcvzosjvPuW5lG8N
         Jm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5hQqpSvt4tC1ihG/h6rOXKsZco8EGDS57uVaABs5Le8=;
        b=RpoJBoH1MLq07HigaSN/IiYrT/jj4Mc0FfLEd3m1oR1SwjjCRFYTSEd4KKsJYVfB6I
         bcELSQE5EiOdpuTWekr5A8Jda9aNn+D9ekN3671APaEXt9d1XDptJy/Rsq7Jsn/R7K0g
         W5Olr41BlVRbg+Y0+ePco1gd3mQ9YrC+z3lRS54EIF6RTrgdeaSYo6TT4YgMHnQMrw8B
         A7Uvz9P9ujf/HqujiFidUKxUESc4AZu/xtBZV1uYQP2TWSDWar8FkIK6i+GQdPq9P1tp
         rpisCQrJIFfYmSqd48zHhoJbf2Ttd3md5Pq14TNb1h49yve1ITCe2wIA8MGwZ45k5uCf
         VG9A==
X-Gm-Message-State: ANhLgQ25l1B79IMq+0tLkWhxNDBxcUEHg6r528ClG5aRxheZPYhL51NU
        36EoOZ85ZiofMnrGlCoCk1TqPGjp
X-Google-Smtp-Source: ADFU+vuEqeBjNJTai5hfGuGalMaXMFOYwL2YIKQ432GnBQqykUaK8C7+PoU2vhjSjm3AY9Npbkd6Ww==
X-Received: by 2002:a63:7e49:: with SMTP id o9mr2776478pgn.80.1584505620617;
        Tue, 17 Mar 2020 21:27:00 -0700 (PDT)
Received: from [10.80.50.61] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id h4sm4400087pfo.87.2020.03.17.21.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 21:27:00 -0700 (PDT)
Subject: Re: [PATCH] mm: Fix a comment typo
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <0783042a-244c-0c2e-091d-e7002718d73f@gmail.com>
 <1584503945.15565.23.camel@HansenPartnership.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <ac5e1482-a943-d7c0-b80d-d9f671031be8@gmail.com>
Date:   Wed, 18 Mar 2020 12:26:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584503945.15565.23.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply, it should be my misunderstanding, thanks again~

James Bottomley wrote on 2020/3/18 11:59:
> On Wed, 2020-03-18 at 11:42 +0800, brookxu wrote:
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>
>> ---
>>  mm/page-writeback.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 2caf780..2acf754 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -1271,7 +1271,7 @@ static void wb_update_dirty_ratelimit(struct
>> dirty_throttle_control *dtc,
>>       */
>>  
>>      /*
>> -     * dirty_ratelimit will follow balanced_dirty_ratelimit iff
>> +     * dirty_ratelimit will follow balanced_dirty_ratelimit if
> Are you sure it's a mistake? iff means if and only if which would be
> reasonable unless the condition is only implies.
>  
> James
>
