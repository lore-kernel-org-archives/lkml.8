Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA5E2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="VCzX7wAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFBHXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:23:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A3C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:23:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so1986693wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZHo1QuB0kAfaTwTp4RSd4mHS3YIQOmK6CEUo3780m3M=;
        b=VCzX7wADfccH6WdRDKjo2XpH5R6yQWUPDumdpTdeokAH9JR5oym803nnUlxjwjh3tG
         EUFPsHWr0DG/eUOJZy/h3sEJU57Dpy7zK5QnhUTF1RA2fVscezKmtKunGzb8oqCWO/MS
         HOwBSYlwXrQhitaFL+ZU138oUQ7lYi/PdzReU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHo1QuB0kAfaTwTp4RSd4mHS3YIQOmK6CEUo3780m3M=;
        b=sTdF96vO9c1BxeVaS/5AH3hHsFdwRd09wqyEb9vaTZztFKL0RUCMvRqZjm7Id3L+Y+
         SQSVy/FlzCMCUXQSr1k4YS4sgzIHm/TWVIpy9fjsc5XPJKGuXCFIofVqTQaqb75YGP15
         8fK334DSropuTJnCELKbNfWRzZ2Ej7I9ee4UFEj1TUAmSE4I6GsWAmynbAaFHUZSoHVB
         OWDlx3LAslsx8H2acHjm2I3JGYljRQs5dtIjebL8gKXwxZZylJBNzliDOkM7+PUc3yfC
         yk8devBIOHCiedq/0sXtLDVBqyq70uRowoy8Xp65XvbpnXux81iPARR71XrloT5V5axv
         eH5g==
X-Gm-Message-State: AOAM533uvmjrXyNIdN0zDDd03tIQVV29v77vgqViClRqY3y7+aKpq4E0
        ZfxyPvotRs/MZj6IIOX5722x9dit6PI=
X-Google-Smtp-Source: ABdhPJxnayMLHt4aiPZE6YU+Emu7SV6i6jun3yYCseigX+vwnCJ1IfR+v0MLRVFDu1up3bCG2vlEfQ==
X-Received: by 2002:a1c:49:: with SMTP id 70mr2663299wma.184.1591082591775;
        Tue, 02 Jun 2020 00:23:11 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id v27sm2560033wrv.81.2020.06.02.00.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 00:23:11 -0700 (PDT)
Subject: Re: [PATCH] ipv4: nexthop: Fix deadcode issue by performing a proper
 NULL check
To:     David Miller <davem@davemloft.net>, patrickeigensatz@gmail.com
Cc:     dsahern@kernel.org, scan-admin@coverity.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
 <20200601.110654.1178868171436999333.davem@davemloft.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4e6ba1a8-be3b-fd22-e0b8-485d33bb51eb@cumulusnetworks.com>
Date:   Tue, 2 Jun 2020 10:23:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200601.110654.1178868171436999333.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2020 21:06, David Miller wrote:
> From: patrickeigensatz@gmail.com
> Date: Mon,  1 Jun 2020 13:12:01 +0200
> 
>> From: Patrick Eigensatz <patrickeigensatz@gmail.com>
>>
>> After allocating the spare nexthop group it should be tested for kzalloc()
>> returning NULL, instead the already used nexthop group (which cannot be
>> NULL at this point) had been tested so far.
>>
>> Additionally, if kzalloc() fails, return ERR_PTR(-ENOMEM) instead of NULL.
>>
>> Coverity-id: 1463885
>> Reported-by: Coverity <scan-admin@coverity.com>
>> Signed-off-by: Patrick Eigensatz <patrickeigensatz@gmail.com>
> 
> Applied, thank you.
> 

Hi Dave,
I see this patch in -net-next but it should've been in -net as I wrote in my
review[1]. This patch should go along with the recent nexthop set that fixes
a few bugs, since it could result in a null ptr deref if the spare group cannot
be allocated.
How would you like to proceed? Should it be submitted for -net as well?

Thanks,
 Nik

[1] https://lkml.org/lkml/2020/6/1/391
