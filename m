Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0DD20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uH/9ULXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbgEZV5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390780AbgEZV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:57:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F889C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:57:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so3397825ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBxgS/luVHAeXT0Vdy997lAaqi3EXhdBrjkjeD26BA4=;
        b=uH/9ULXdDZTF5dDETLzY5uKo11ZJgkabQ6hKp/LAKfnLibCI7YGSaFVDqlk6BjBBX+
         9v/qkm9HoW5ERyU8cnYq+T3gGpaz1ikJkfATPJtQVIDTBdqYBsGkFsEhmG9hClV037He
         2OPG2HsI9DmjoRrNINLyx9TtDvM2zdJ3BUxz8ylIBFJ8a2QQHl1rVRsRp2IBf6t2/aAh
         tUYWxlsYkP2jMfWEPi39E46cwDIwXzsI1HF33yB5P0MsobmMUeSgWATR8V72uTb8yoa1
         3Zbv2X4ugtZcY5E6x/RcDha64PX3dBPljeq+Pi8O/lpUACeSLFq0PTriONOiIjZHCjwl
         4z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBxgS/luVHAeXT0Vdy997lAaqi3EXhdBrjkjeD26BA4=;
        b=bNkPxfOk56brs99GiGdyXlodNLhTGI/MEsgAQHAzXVvHP32hU3+G6M0+5Lzgq6X+XN
         goLTJmaDMy/iwuxl+laBj4kwL5AnFfUzwMp5G4O00+DWPUZL4uk8VSIN18Jtj4XMp9ur
         m5Pq/3Xgs1VVOlKiL7U5hr1FcjzFMVbwAbaMBmogcyKn3BRqtgIns1sYzDyjTJX4UBLN
         875MMnj0XsBMT2BXUCY7PIua3mIzebtj48fRNW9ZdmFZBN0qZL47KFjoG3Vz3HzWDV+2
         i6wShq3V2GrPUS9o7vkBbQG9Xj8w8Kixxko42u01+7vsyud7aols5qn68/JaJXrjJ8fl
         GSDg==
X-Gm-Message-State: AOAM5312DwyhP5pNAb0QM617iGkllO3wX+1Yn5TpmDB8HjUJplyIXgf9
        1xnoeQNTjtqH/vqeQZi/BPg=
X-Google-Smtp-Source: ABdhPJy7dXpaYaf6FVtHj8sPeZC8u66KiKuj3nr3xoEslObuORIp5/0XVhRvUzp7VVZpCNQmifl4hA==
X-Received: by 2002:a17:906:b7cd:: with SMTP id fy13mr1249808ejb.133.1590530241865;
        Tue, 26 May 2020 14:57:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s8sm964443edj.64.2020.05.26.14.57.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 14:57:20 -0700 (PDT)
Date:   Tue, 26 May 2020 21:57:20 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: use the same mechanism for get_count_order[_long]
Message-ID: <20200526215720.42rs547h2vq6xgl5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200525215958.21653-1-richard.weiyang@gmail.com>
 <20200526070457.GI1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526070457.GI1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:04:57AM +0300, Andy Shevchenko wrote:
>On Mon, May 25, 2020 at 09:59:58PM +0000, Wei Yang wrote:
>> These two functions share the same logic.
>
>So, same comment. Please, add test first, make sure it works on current kernel,
>then after your patch applied, and send it as a series, thanks!
>
>P.S. W/o test code looks good, but based on my experience I'm very suspicious
>about "small" changes that may lead to big issues. Hope you understand my point.
>

Sure, I see your point.

>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  include/linux/bitops.h | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>> index 5b5609e81a84..80703ef27aee 100644
>> --- a/include/linux/bitops.h
>> +++ b/include/linux/bitops.h
>> @@ -188,12 +188,10 @@ static inline unsigned fls_long(unsigned long l)
>>  
>>  static inline int get_count_order(unsigned int count)
>>  {
>> -	int order;
>> +	if (count == 0)
>> +		return -1;
>>  
>> -	order = fls(count) - 1;
>> -	if (count & (count - 1))
>> -		order++;
>> -	return order;
>> +	return fls(--count);
>>  }
>>  
>>  /**
>> -- 
>> 2.23.0
>> 
>
>-- 
>With Best Regards,
>Andy Shevchenko
>

-- 
Wei Yang
Help you, Help me
