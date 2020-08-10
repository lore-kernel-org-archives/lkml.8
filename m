Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD78C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D220716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUYumKYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHJU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:56:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED87C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:56:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z14so11170290ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJ2Vqlv4BvhpTJPAIFfyDD26d6ySQAJxv6Dxf08So/Y=;
        b=jUYumKYnqRT0iQ2kDFfTOTL1IwILe6T8kU49yLhhNL7K1ZbsgZxBiBU7RY27Cdjnq3
         CsTUBh2hhfw54+eQkjXVU3r0w1SKzdY/Y6rM++6PeLGmgk1odTP40pY0MBxlcf0JK6/k
         Qif2FGPjmAgEuxvo/H3316omRBqQPEbtA5zXmqFcQS155QBaPQYEvJg6F8TsAVsBgz5S
         H88XBy+cluqajJAQgJkG/NjkMjXj7h2pe1hoHx4n6IzJn++BJ94IftIhUogZQ8csPGIS
         hahcmlxSUiNZSqTtiW0MEFyPv4RK6smv2B4HvNg8iq6ohGQ78zkwVpAaj47IuVrYbS5f
         N3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJ2Vqlv4BvhpTJPAIFfyDD26d6ySQAJxv6Dxf08So/Y=;
        b=fiTh/UGBA2yDKO/BGCoI07DSp84nF6PzxqsEE01vqWs3i2Mn1A9Cm5FkZri0sOlCcY
         //tHZV8MTSWQ38flFQByT+PaF0CYHHSAtB62/8eq4SIYLcEPaz5hfS335ZigLTA4m0BM
         LG637JL2ZWtpBJMlnzbxk2F8lekp2ikJiHfmANocYiXg08iBBvBCLsSEWk7bY74uT3qh
         BeWm6SoUzdqRuv8hZt/0D1+wKIo0O/K4uoBYxT57r1g0zIx2GYcyMZKxjHvoEal14mB8
         CB3b7QlSHbt/3xlEJXe+K1huFdt3MYUK7FMP+V5wz82p/NmGcrVSzOGzTuA6F/QeQBCy
         wRkg==
X-Gm-Message-State: AOAM5325ZgETZGC/wu4TJB5LMlxSPpKnaywi5u0DYaoXIYV8TdPMKGlK
        KAOcVhygVcSL5g2jyGtCwA+kjEi8
X-Google-Smtp-Source: ABdhPJyFq4eNoaMzO3/HI56oT1ypKSiPIaGlhdDOKijxaiesUv4y86FHXnIEuAqAWUFDIhrbHyQ+5g==
X-Received: by 2002:a2e:810c:: with SMTP id d12mr1363226ljg.34.1597092974837;
        Mon, 10 Aug 2020 13:56:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t18sm10591147ljc.126.2020.08.10.13.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:56:14 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
 <20200810201846.GA12091@qmqm.qmqm.pl>
 <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
Message-ID: <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
Date:   Mon, 10 Aug 2020 23:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 23:21, Dmitry Osipenko пишет:
> 10.08.2020 23:18, Michał Mirosław пишет:
>> On Mon, Aug 10, 2020 at 11:15:28PM +0300, Dmitry Osipenko wrote:
>>> 10.08.2020 23:09, Michał Mirosław пишет:
>>>> At first I also thought so, but there's more. Below is a lockdep
>>>> complaint with your patch applied. I did a similar patch and then two more
>>>> (following) and that is still not enough (sysfs/debugfs do allocations,
>>>> too).
>>> Then it should be good to move the locking for init_coupling() like I
>>> suggested and use GFP_NOWAIT for the two other cases. It all could be a
>>> single small patch. Could you please check whether GFP_NOWAIT helps?
>>
>> This would be equivalent to my patches. Problem with sysfs and debugfs
>> remains as they don't have the option of GFP_NOWAIT. This needs to be
>> moved outside of the locks.
> 
> Ah okay, you meant the debugfs core. I see now, thanks.
> 

This indeed needs a capital solution.

It's not obvious how to fix it.. we can probably remove taking the
list_mutex from lock_dependent(), but this still won't help the case of
memory reclaiming because reclaim may cause touching the already locked
regulator. IIUC, the case of memory reclaiming under regulator lock was
always dangerous and happened to work by chance before, correct?
