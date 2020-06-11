Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5192C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A91C207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpswGGbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgFKHUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbgFKHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591860035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaDPKfElQw2EbPSMf7NzdGzIk/N8eShdAJgRkziqYxo=;
        b=YpswGGbDCZlUQHBvWbHl8gk5e1XATiMpJdyNjBBXhf/9PVkfHSby/6le1uXesok7z5FYBU
        pK1sabCkB4Ui8iRtsGk6PvtSQxXW6qsEbmAAToymlWheiWARyhjNVlbdww7651GoeohCf3
        2apUoCOgHs+KLi5h5TgX1f/KYJJ/W/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-iF4ZVVJQNsqtNy8KbyvNCQ-1; Thu, 11 Jun 2020 03:20:33 -0400
X-MC-Unique: iF4ZVVJQNsqtNy8KbyvNCQ-1
Received: by mail-wr1-f72.google.com with SMTP id d6so2210580wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yaDPKfElQw2EbPSMf7NzdGzIk/N8eShdAJgRkziqYxo=;
        b=YyLH1GtJvxHK4QZjHY+YIRN9eod/rnTc4B8NKEVEnmeLPy+yLX6LQCJEnZhx4OMWuf
         EXugipnFRkQ/AekwD29l2/9d77fbIGfOyX1gu/XnRtodUrxRo7Df+Pwo9ozprIRs9c6t
         GkxpwrYEJJzu9pgRE3dsZRLFEv7BzOzAd8LvRCSLRCytiOl3JulptfI6xYdOFyEI/LKT
         8LmkmEEfcquxAPEu/S4sRWfFf1viwrt59/PhsdT5AkSLPiLxVCbJivnYkln5Eg8s2FjF
         9sf+tilIOKnw3Ctasri+x/DgfnGi69vNwFvyHd5Q9+uXBT30qxWk0hOcGrL64kxlrhqk
         5lzQ==
X-Gm-Message-State: AOAM531Snz3g5l5a/MF5Rb4XlLBcM3wyEUT4wagvE5WrndzOf7lF7IlN
        CqBjL7dhhxu+uFeg33DC3wbCAASingPcs+F97QyCLx9GIS3r6SrNVv67BVMPH0b4pAzyJPeWvX+
        DfgP20RFHxP1BdQMyWWJR65g1
X-Received: by 2002:adf:e590:: with SMTP id l16mr7634840wrm.383.1591860032648;
        Thu, 11 Jun 2020 00:20:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA66WKSAmtJ+sZXGhpsVf0Sl7/pNYHpzwg5MJQ7WIUxQqgrnwhnOxyK8LA1PstwxI4KhuiNQ==
X-Received: by 2002:adf:e590:: with SMTP id l16mr7634831wrm.383.1591860032457;
        Thu, 11 Jun 2020 00:20:32 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id k14sm3333212wrq.97.2020.06.11.00.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 00:20:32 -0700 (PDT)
Subject: Re: [RFC PATCH 7/7] objtool: Make unwind_hints available for all
 architectures
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
References: <20200608152754.2483-1-jthierry@redhat.com>
 <20200608152754.2483-8-jthierry@redhat.com>
 <alpine.LSU.2.21.2006101516310.26666@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c4518f15-545a-3cb5-214b-29ddc068189b@redhat.com>
Date:   Thu, 11 Jun 2020 08:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2006101516310.26666@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miroslav,

On 6/10/20 2:20 PM, Miroslav Benes wrote:
> Hi Julien,
> 
> On Mon, 8 Jun 2020, Julien Thierry wrote:
> 
>> Unwind hints are useful to give some information about the call frame
>> or stack states in non-standard code.
>>
>> Despite unwind hints being used in arch-independent code, the
>> unwind_hint structure type itself is define in x86 kernel headers.
>>
>> This is because what an unwind hint will describe is very architecture
>> specific, both regarding the state and the affected registers.
>>
>> To get to share this concept, expose the unwind_hint structure across
>> architecutres. However, the hint types remain defined by the
>> architecture code. Objtool then needs it's arch specific code to
>> "decode" the unwind hint into a cfi_state.
> 
> I think it would be nice to split the patch. Something like.
> 
> 1. current include/linux/frame.h mixes assembly and non-assembly
> definitions, so introduce ASSEMBLY ifdef first seems like a good idea to
> me.
> 
> 2. move the relevant definitions to frame.h and add the file to
> sync-check
> 
> 3. the rest of the patch
> 
> Would it make sense?
> 

Yes, I think your approach will make it simpler to review. I wasn't sure 
how to split it but I like your suggestion, thank you for it.

I'll probably post the split patch separately if the rest of the series 
gets picked.

Cheers,

-- 
Julien Thierry

