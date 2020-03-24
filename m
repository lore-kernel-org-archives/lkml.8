Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA717C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1A42080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3k0AzKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCXMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:11:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgCXMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:11:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so12131084wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vY16pX2Ju7qRLDa/0gTS9+JHXSJOBP/3FM7eL1JUvdQ=;
        b=K3k0AzKDhz5EKIwZ2P6aNlc5Hu1UUXukBgRzZ4Jx85Agw5WzqvfGHlaqOZIW8hO9a8
         vgYcFIzjW7WOdpC5/4eJa6/3mC3ar/ObJAjq2IF6CizmnlhZyG5X28g2gujoVraouSFt
         NgXVRAEeqkRbFht0E6Rnk/el6EtA5FE1feVgO4QrIWpdySLhGZ31MFql47VUo91DZ9qW
         SlqGTP1n7WYjFyg7KE1QyWTMP41FlhJdcbsQyXkux10TKD7bWtNF2WeBtAPWi599VZwb
         jJ4mrULu09MyLvhIGgjYcYcIf1MR38PXvao8ixB+TAZ3ogUv6pU09w/jotxI9J0tgIfo
         0SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vY16pX2Ju7qRLDa/0gTS9+JHXSJOBP/3FM7eL1JUvdQ=;
        b=QD194jS6PdHo+DehDfvddUonal9GQr1aYfaUI2LXC5wqOgcfWYgocR9diQgDkEfBmK
         u6g/1MkglFlzoRuEK8x6arHgBVjoefwspckaQm37KQSG2hNxBRotiTNy084x048AeVCH
         PSXJqHVs7BqTRZXKkB4o5nx5XBFksSTsXWXItSmcn54eB3S3ab7b73H5NKwD7dlsVjBN
         T9WyoLgf7eSUvgpewDbdAjicLcBe2L9rLnGYCPKRY0c4rIgQP/tVDQiuNflGClV+EDGh
         Wh4rrikaa415pTLl5MdTig06Gt/7RVuhgCX9mc6TV4VLMsSd9MfeT2RLRwDjTfQMxzjU
         aLmg==
X-Gm-Message-State: ANhLgQ2cjktcLXzg5SuNPALe7WVlKSsrRMQeVP324DUDhyWAjVYx5OJY
        47KzxSy5t7G7nXEtGBm/Voy/f2vvT2Y=
X-Google-Smtp-Source: ADFU+vu9jSV5rbs0u0XjtbxR3Mq7PrvFUwe3qxZKNZOPciVWlOn9gSmVy2USq2CCjfc9PILqsX40DA==
X-Received: by 2002:adf:a348:: with SMTP id d8mr36671670wrb.83.1585051890111;
        Tue, 24 Mar 2020 05:11:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o133sm4076013wme.35.2020.03.24.05.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 05:11:29 -0700 (PDT)
Subject: Re: [PATCH 0/5] nvmem: patches (set 2) for 5.7
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323190634.GA651127@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <40767351-3715-3605-edf2-0fee877f3703@linaro.org>
Date:   Tue, 24 Mar 2020 12:11:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200323190634.GA651127@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2020 19:06, Greg KH wrote:
> On Mon, Mar 23, 2020 at 03:00:02PM +0000, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Here are some nvmem patches for 5.7 which includes
>> - sprd nvmem provider fixes
>> - mxs-ocotp driver cleanup
>> - add proper checks for read/write callbacks and support root-write only
>>
>> If its not too late, Can you please queue them up for 5.7.
> 
> I've applied the first 4 patches, and provided review comments on the
> last.
> 
Thanks Greg for dropping the last patch and adding stable tag, I did 
find a 2 new issues with the last patch. Will discuss with Nicholas and 
provide a proper patch once rc1 is out or in next cycle!

thanks,
srini

> thanks,
> 
> greg k-h
> 
