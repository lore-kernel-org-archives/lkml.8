Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E027207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594310483;
	bh=OSdg9DI4vnt5BAZLhmq8Ur/TNMSId+ZoEu4uCqbxot4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1y7VC6DczWfNwoiwY/Pq9ldgMD7nMlN9HREKdoUgh3IzAQKdpqTkMGjMLpCC3YNZn
	 3mGYP7SyZxRvLSZls6rrbKTyXVL06r2QHEn5FU21u3Hhu5fJEd53yU9Mpev7fMBndD
	 m3nafCd0No7W7IqLEWFmi4uldJRjeQLp2312soGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGIQBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:01:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E1C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 09:01:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so2047937otv.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HGsTAj0a+RJU0QpPTNKQCpJ0VMDb7tRPj2FxIP6m4t4=;
        b=Hut5TGrFUZogrXJQXiJE+1pBXG9vA76Jx7ZETGuglXnVW7ytEkhFxIDwsUz1tW+fdO
         sAmFlnROS04w5zHgxmyNFSE60rNlwJzCzyZuEv8zQp19h6BO2BTMZqjp0MflhaEzmI77
         aQPbvFT78Bl6N/NOg983Nu+i7kNkvSFuiEDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGsTAj0a+RJU0QpPTNKQCpJ0VMDb7tRPj2FxIP6m4t4=;
        b=Zju9iZpbOGecCWN/U/rcEPVsuhga0JJTzMJY5ItU/jVLsvSUoMu0n/X4ReNcnUNf3g
         JCeviU3KDqxXksnVmhalcav9bKt11N6ZXsn7j683EoMfsLgglPKgP/akTP2i3fuZANk9
         DUheRI4kKDKeCkXH6P90JeFyRnzsXQ1dZbr/6KovJH8TeXz4jGmFp4QlKs+zfnzQKjcu
         ln0+MNkvMAddMDiZ8eydEM9BQxK63z1r4sfI61h97wovPjOI8QYBmBJZWy+zb8N+gueB
         zSHJVFtiPKGpchuqAH/Iy8f473ky8Yepz4jLugV6g+aNDxL57cinR/DqXNtvyALD0B46
         fXSw==
X-Gm-Message-State: AOAM532aN+CTDyr2mYoLpfocbGB8TKav3PKDxOVNjC11JeVCxaHw79ax
        kQEnqB9xsMlLr0mKoyYEk++eSA==
X-Google-Smtp-Source: ABdhPJxSOkqrlj+FklRoHpl9zpHklPVNbBXZvIvMzH7Yy2NJWfyT4uBUMIfZY07N/M8ALuniqIU6Qw==
X-Received: by 2002:a05:6830:1f22:: with SMTP id e2mr17125025oth.62.1594310479762;
        Thu, 09 Jul 2020 09:01:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n6sm578331otq.33.2020.07.09.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 09:01:19 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Tibor Raschko <tibrasch@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
 <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
 <20200709124327.369781a0@coco.lan>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
Date:   Thu, 9 Jul 2020 10:01:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709124327.369781a0@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 4:43 AM, Mauro Carvalho Chehab wrote:
> Em Tue, 7 Jul 2020 01:58:21 +0200
> Tibor Raschko <tibrasch@gmail.com> escreveu:
> 
>>> Allowlist/denylist terms are intuitive and action based which have a
>>> globally uniform meaning.
>>
>> Nobody has a problem understanding "blacklist" and "whitelist". These
>> are universally understood words even outside of computing. Claiming
>> that we need clearer alternatives is smoke and mirrors.
> 
> Actually, as a non-native English speaker, the first time I saw
> "<color>list", I had to do some research in order to understand what it
> means :-)

Thanks for the perspective. This is why we need clear and uniform words.
Our community is global. English isn't English everywhere either.

> 
> That reminds me: what about "graylist"?
> 
> For coherency, if "blacklist/whitelist" won't be used anymore, an
> alternative to graylist should also be provided.
> 
> Right now, it seems that only ACPI uses it:
> 
> 	$ git grep -i graylist
> 	drivers/clocksource/acpi_pm.c:static void acpi_pm_check_graylist(struct pci_dev *dev)
> 	drivers/clocksource/acpi_pm.c:                  acpi_pm_check_graylist);
> 	drivers/clocksource/acpi_pm.c:                  acpi_pm_check_graylist);
> 

What is "graylist"? Does it mean in between allow/deny?

thanks,
-- Shuah
