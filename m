Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9639206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="WLzsoYHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHJDuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgHJDuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:50:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDEAC061786
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 20:50:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so4086071plk.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cmRFdnEKW2cmEvuqp59fJ6fyMLbaBOiFPwb8NljC60Y=;
        b=WLzsoYHuFkh2cVaLTuqqjBq7blLnA1X5UVbvITM/8GD1fRwyZc2bwEkuEzBPqXJo8g
         l9QT14DgVrnrq3ajQYOXad12UMvyWt/jyNbaCpk0LsTwFkyvM43wI7mitPgisWAIY5Lm
         7X28LeYPYfNtp4gkm3g3IlvcU4LxgNGSFbUgsRsvi2OQjSCWaWbgNNi7yJSbSnUEyFmm
         9xbFyC4GkcfTgireDa1q5cQijiDyKYEht64xD/MJ/YSrbW0nA2Xu5JlGLCMX9/4NX+5N
         5BMFJJDFOzsobSIrDm2Xrazo8iKFGL002M48vR2dT9cgzTMuFQUWXZDHqUod3VMD0lON
         9evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cmRFdnEKW2cmEvuqp59fJ6fyMLbaBOiFPwb8NljC60Y=;
        b=jla2zTVsByYimXAkzXDvCyNHR9YhelcaflWDVUv2RhOIxdBtqGk2+jTZbUl1nhcOby
         TXAe+R+nRd+FnPv7qDX0kMAvoZ7eqeAfE/f0iMOw0xNBROJOSG7lXcJVAUMIo86v+pUI
         yJ9P5tnyjVoXswjuyCHMa3boqnjEKFACBRvCSLUdVBQ+rJpWt3LL8gRCtA0aIHkjmrv1
         GaCn3vYIqPYwj1zhUx7urSXYI84sQmonu8GEjPDjqMDxNVDhHdCxqJnTRwDxAYsimhFX
         65EjlHMVI9PPez4XJ8g63cj0rPJ0200TqCy+NAehALGxR4x+d9qlRGUisu5Ud02Ik4AL
         yeQw==
X-Gm-Message-State: AOAM5301mNxphC1v29si0QTUi2fxxKkfSxwpv1e31a9efexfzov0vw5T
        y6eElRD5Ks1Y1lzO3dZ5PYQ+gn18HIo=
X-Google-Smtp-Source: ABdhPJx36HQ6Tq+0vKHU2mpEQFQQZluNmLKpNMd5rSTcuBP8K/TnjBkSSb7J9p5PJYikJ4MN3W+eKw==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr23952101pjb.151.1597031403585;
        Sun, 09 Aug 2020 20:50:03 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id bj18sm17391208pjb.5.2020.08.09.20.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 20:50:03 -0700 (PDT)
Subject: Re: [PATCH] ionic_lif: Use devm_kcalloc() in ionic_qcq_alloc()
To:     Joe Perches <joe@perches.com>, Xu Wang <vulab@iscas.ac.cn>,
        drivers@pensando.io, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200810023807.9260-1-vulab@iscas.ac.cn>
 <4265227298e8d0a943ca4468a4f32222317df197.camel@perches.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <2623670b-09f0-2ab4-d618-e478d98c186a@pensando.io>
Date:   Sun, 9 Aug 2020 20:50:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4265227298e8d0a943ca4468a4f32222317df197.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/20 8:20 PM, Joe Perches wrote:
> On Mon, 2020-08-10 at 02:38 +0000, Xu Wang wrote:
>> A multiplication for the size determination of a memory allocation
>> indicated that an array data structure should be processed.
>> Thus use the corresponding function "devm_kcalloc".
> []
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> []
>> @@ -412,7 +412,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>>   
>>   	new->flags = flags;
>>   
>> -	new->q.info = devm_kzalloc(dev, sizeof(*new->q.info) * num_descs,
>> +	new->q.info = devm_kcalloc(dev, num_descs, sizeof(*new->q.info),
>>   				   GFP_KERNEL);
>>   	if (!new->q.info) {
>>   		netdev_err(lif->netdev, "Cannot allocate queue info\n");
> You could also remove these unnecessary allocation error messages.
> There is an existing dump_stack() on allocation failure.
>
Yes, the dump_stack() tells you which function had the allocation 
failure, but since there are multiple allocation operations in this same 
function, I find these helpful in knowing quickly which one of the 
allocations failed, without having to track down the symbols and source 
for whatever distro's kernel this might have happened in.

sln

