Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8B920829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7OrS+Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgG3N30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:29:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbgG3N30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596115764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41pj8/5lJ3jNzDQBVtsxhhVYFRAGYi4+Q+1vYu6XaVQ=;
        b=I7OrS+KrIY0Fg+ABLKsjQAtXQKArcwpljOfQiRVofkc9HwSklwVu4Nj54VUeiDj69J+yKI
        HD4VcUcG602oKKhwmUNFRrmBJW8CMF6zSovSbnn90nYfkNGNMtEFQvwhzFXIE0j3JE3gKg
        gBh+9PUUY4XxoF/eX1et4YzDAfwZnfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-egXC3jLhMvOa-DqIjtHIcA-1; Thu, 30 Jul 2020 09:29:23 -0400
X-MC-Unique: egXC3jLhMvOa-DqIjtHIcA-1
Received: by mail-wr1-f71.google.com with SMTP id 5so7905818wrc.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41pj8/5lJ3jNzDQBVtsxhhVYFRAGYi4+Q+1vYu6XaVQ=;
        b=VSarTq1Se0Nx8JHe86/vx3yJ99p7uYD3eRQXwFX3zsxTE578In8/EE9IAXtAhZ2LPi
         x1sQv5Jj4cvAno8oPQt1zYxOI9xhQdKVU+TyrVH35CGj85hFwK6NRSx6m1O94ahx9li+
         YzkU1Op7kRs3UBxfeFFKPW7/fDvjgFbKGsgjDTBsmMfqZ4OOeicOfMGv6Zz8thXslGU8
         sZDKX7AQOHbRIO0m6o3GbIMmNHqVj2LR5ahYQ7IctsrE3QzoMp9FWuf+hNH/ejtMtKQk
         sZoJ2BHaKiTXDx6fsA3f2IJUYQF7NAR2T0fK1XcfEe5Mb7yjwBjdHbCvy1mqx603f0yQ
         NgFg==
X-Gm-Message-State: AOAM533jW9DwGAo9xgD26SW1i8aOH5TpvzV2XyeWAv5VxOUh+7vFW4Rn
        inwF48+ceBaPIklj28K8e1VggZko68Zpw58xUlixA8i3yB+npyZ4tqIK32/gIrFRbomMzQ2xb1N
        2EAs3FGwISSy7l7LpkzBD4eCF
X-Received: by 2002:adf:de8d:: with SMTP id w13mr2828853wrl.129.1596115761861;
        Thu, 30 Jul 2020 06:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx76Tx0wgVVQVbWjDNUL8ft4beYAtHvHbkyIuR77+A69lj2B6s4LMH1PTWW3YwPmjIwRx1stg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr2828841wrl.129.1596115761714;
        Thu, 30 Jul 2020 06:29:21 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j5sm9495639wmb.12.2020.07.30.06.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:29:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
 <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
 <20200730132237.GM2655@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3af41a3b-a4b9-8120-3ac0-c9ce13770628@redhat.com>
Date:   Thu, 30 Jul 2020 14:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730132237.GM2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 2:22 PM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 01:40:42PM +0100, Julien Thierry wrote:
>>
>>
>> On 7/30/20 10:57 AM, peterz@infradead.org wrote:
>>> On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
>>>> +		if (file->elf->changed)
>>>> +			return elf_write(file->elf);
>>>> +		else
>>>> +			return 0;
>>>>    	}
>>>
>>> I think we can do without that else :-)
>>>
>>
>> I did wonder and was not 100% confident about it, but the orc gen will
>> always change the file, correct?
> 
> Not if it already has orc, iirc.
> 
> But what I was trying to say is that:
> 
> 	if (file->elf->changed)
> 		return elf_write(file->elf)
> 
> 	return 0;
> 
> is identical code and, IMO, easier to read.
> 

Much easier yes, I'll change it.

Thanks,

-- 
Julien Thierry

