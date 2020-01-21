Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43155217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gUtEqbH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgAUJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:01:55 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44839 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:01:55 -0500
Received: by mail-lj1-f181.google.com with SMTP id q8so1861131ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afnx+B71cegV5q+X/wf5E0hqEyBS8gYxOHw2pHAP4kA=;
        b=gUtEqbH3wrzEHS6VY12SMMG7F1oEFdMbmxOnSmV4lxTFUJt2d5TlLqYNoOFecZufw3
         a477lxgVbqZX5rkopOK4Zc9Ce8D9w3bbijX36LD91VxAT/0/dMhB1THRgNYBGW/EqNma
         lCggK0dE6zrfQIfexStSjXp3gfgrJFHEzM+qXfoBqL5X8m25H9NeNOa0wk+O+nN0/DQO
         2OGq5nkoX+gGJIWoFhx+A6nmMLnmzVt4VcGSsSe2QV+OyUnSyeIISP09DKZYczpHLnFX
         Pmw/PVCQjRHpOakl2TWxyYhuXsY42mHETBVkoL+b/F7TIC5iBcaR0QNGIAIEc3zDEpAR
         jtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afnx+B71cegV5q+X/wf5E0hqEyBS8gYxOHw2pHAP4kA=;
        b=c4AzGYWFV+nEeFidzdqnqcOxIM4ZFFSwXKyVj5pWE+RroYaOTTijCmT8rd9OpL0HwI
         +tm3kXc3dxLD2yx/1sPrf5nzyPZugf6HQ/CQxJreI41hGo5RhSY6JcXvQNYuAY1j5ml+
         /uEmDsqtw3YJaPEvcUC6TpWubSzArMZuZjxTjZFZ4xd0uvm/UoixB+WH9K0a6z1NGxAF
         IZXy3V8P8U7an4KBjR5Z9bO9QVuxLRdJQ5eh8TqnTFsfmJx57VwuSRxCLMYdKjZIdXNa
         0thZb+ua+ymIOOpMn19fTP57c2GlDvh5xM/ZbUafEqrE3Tjj955gti4SRXnynmNQwkgq
         OQQQ==
X-Gm-Message-State: APjAAAWfw62mt51ApnfaVLGsJAjfwmn6zEvi7FJ3UqphnwSUeC0mdfk9
        eIzKxVNWCzuCtEImH9Ke6W5Zcxu5tJAzng==
X-Google-Smtp-Source: APXvYqyMnIQZDBbTNeeLyMo1ILlAA3ZNKrbHRjmpJy1YuY8TagG3jH62uv3BdLWZpWLfJOp8iVr43g==
X-Received: by 2002:a2e:916:: with SMTP id 22mr15885841ljj.60.1579597312835;
        Tue, 21 Jan 2020 01:01:52 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4257:4d38:8de3:4197:be8e:7729? ([2a00:1fa0:4257:4d38:8de3:4197:be8e:7729])
        by smtp.gmail.com with ESMTPSA id 195sm18030740ljj.55.2020.01.21.01.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 01:01:51 -0800 (PST)
Subject: Re: [PATCH -next] drivers: net: declance: fix comparing pointer to 0
To:     Chen Zhou <chenzhou10@huawei.com>, davem@davemloft.net,
        mhabets@solarflare.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200121013553.15252-1-chenzhou10@huawei.com>
 <40eb3815-f677-c2fd-3e67-4b39bb332f48@cogentembedded.com>
 <86f4d4a0-627d-84aa-c785-4dac426b7cc6@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c223c347-4c19-176f-4626-b096c12c0558@cogentembedded.com>
Date:   Tue, 21 Jan 2020 12:01:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <86f4d4a0-627d-84aa-c785-4dac426b7cc6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 11:54, Chen Zhou wrote:

>>> Fixes coccicheck warning:
>>>
>>> ./drivers/net/ethernet/amd/declance.c:611:14-15:
>>>      WARNING comparing pointer to 0
>>>
>>> Compare pointer-typed values to NULL rather than 0.
>>
>>     I don't see NULL in the patch -- you used ! instead.
> 
> Yeah, i used ! here.

    Make the patch description match the diff, please.

> Thanks,
> Chen Zhou

MBR, Sergei
