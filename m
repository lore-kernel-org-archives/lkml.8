Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FE7C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E7821775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="BByQsgDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEHUaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgEHUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:30:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:30:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so2464521lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JkP0Yzz/l+xH+mX7IIfd2GFmeVL9ppgDSeJKkOGuaZs=;
        b=BByQsgDmBbVUVcJNFmy8AmkPi3iJoG361CWAoRezKGuEHrPpx915LADgZRUCQzDD8Y
         d1AUZrnvOydRU+LwM9UaAfWiwcpSpY7rOrfFk7/bfx9bcP8yDDeIZiDkHgVB8PvFGiwJ
         7BCLWlmbpZA/M97YC8l9EDbTQHmqii/CklPv4bsq3dqaaX1VKU9bncR/sLSag76bouXk
         0nhT07+IbyLij+n5haTbrVOdMIjxs1sgTQ4LkI2KrtaoUjOEi9ptNp6zVCdiprVa5dT1
         QximxT140ZlthkT+XVm0ax9oJwY0zBi9J6zC4x9A9mCMLyp8RL3Aug0lPMACnVX4n9Gw
         VmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JkP0Yzz/l+xH+mX7IIfd2GFmeVL9ppgDSeJKkOGuaZs=;
        b=jul5zoqJ5OdubPcMEgQF9x+5QxYQRkRSyG54ULC0D1aK+r4eLtuoqnFytDzchH8zQe
         OFOk73WEy4gLtf/Xiwnz3Tx1egqL6+Jnrl33BTSESuVg9QJ7J4nSNNJVvB+Um0Xxe9c4
         jYoc7exfnhCKlX3lCYjeA4aHkJgGl3SsTxLobbNU1+FlvBzE8FV0a5QLGl5p9L+2L7Ls
         uykXM42HdUOrtsRsR6c59FXEubeEpqEfYmAQ31bubkTdWkMrgpTQVPElJydk/NIPs6gc
         YQAtFF8p9t9rLTEwba6xpT5ETgevEP5l8xh4ENuxXVRfqUPX7JoagMnhtNJmim/nqOTc
         KlUQ==
X-Gm-Message-State: AOAM533MzpEBa+gT5t379XlwRktU8cSD8GMYGjXM7V0cfZZ4yz7ZfOzj
        +FT9hT2EAjq19tB5vEFUAJZTmQ==
X-Google-Smtp-Source: ABdhPJzPxpwJ4WTVl1KiI/hKOSLnHISGQjGrkhOYgyvu08zZAwTgwrRToxXHlwfcyz2NyiLE08DiuQ==
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr3014087lfp.16.1588969806431;
        Fri, 08 May 2020 13:30:06 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:222:bcfb:3767:1ed2:9bbb:4cab])
        by smtp.gmail.com with ESMTPSA id z5sm1826286lji.30.2020.05.08.13.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 13:30:05 -0700 (PDT)
Subject: Re: [PATCH] USB: host: ehci: Add error handling in
 ehci_mxc_drv_probe()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
 <20200508114858.GA4085349@kroah.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c6c1f7e2-e8c6-d120-23de-fa1b566661d4@cogentembedded.com>
Date:   Fri, 8 May 2020 23:30:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200508114858.GA4085349@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2020 02:48 PM, Greg KH wrote:

>> The function ehci_mxc_drv_probe() does not perform sufficient error
>> checking after executing platform_get_irq(), thus fix it.
>>
>> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>  drivers/usb/host/ehci-mxc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>> index a1eb5ee77..a0b42ba59 100644
>> --- a/drivers/usb/host/ehci-mxc.c
>> +++ b/drivers/usb/host/ehci-mxc.c
>> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
> 
> <= ?

   I thought I've fixed the ambivalent zero bug some years ago... 
   Please don't do this...

MBR, Sergei
