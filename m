Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6E4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596F2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhRdmf5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgCaOqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:46:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43049 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCaOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:46:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so17504104lfl.10;
        Tue, 31 Mar 2020 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlVZW7cO8LWLLMbmrWvRh9aCWzHoG5nB1Hr1qEthe0s=;
        b=HhRdmf5KxjjoQt4LBZizBPlInYd/wKd/Mqfgs9f9wom1naC/0YlP1RbOs2zIxxQIlv
         QytVN7Ld6lMwrvkz8Wd/OcFcXzhITx4AfVWggBUKcSw7CH6CdIniZ3t5Jqom4ewCATzx
         0mh9XDyf0856xKA9vBvyB25HlsouGZ9GYm1EDEFdPcZaUgSWuqI+sxcSsBzR6t3LM1VO
         3sfXwr0be3jcWIJsmHcNT4gmddKD1Q5FNGG1D+fJwFOQX1uVsi0Tunr4UldGr2VW7uv3
         UyKL20yBUaeiYIw6EihJLf7E0oW0zlvuqqsD04yvCxFzw7Q2rCkAaFAZ+u14hgcSCMGI
         NVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlVZW7cO8LWLLMbmrWvRh9aCWzHoG5nB1Hr1qEthe0s=;
        b=I/JheuWtZzLGZJ4pCaX3/NzPKjwi2JzT4rhxiyIoGgQXOsBIkDAk+Vg8kYlYW6j7l4
         cxaH2POCV4E1jEXFT6z1jUHJl40sKdJuUl22zkb/y0tuQxFHTmQ3WAqDz6yVIjFkdjMj
         BdbdsbpuCS0A3JkOjfxsaXzhJLmBFveMzlbhpraMJhTabKb1G9rhvBBBLoNydN1b9Tsl
         V8AQmQR/nqN/AWeOLYJirGtzCtFFzBhbNhPVMusRJHEMJ3whetzdt+RR5G4wPiEJk+Ps
         HHxB+TVkLPsHlWZEoopBi8S0hmouXC+hEfFo+AemOc/JiDHAy7tdIobPQfMxh9drI1Xg
         pgvA==
X-Gm-Message-State: AGi0PuYeklHoCXWrPYFUTvgF1DBTz0HUpc8yVw8xQEAXJ8rV6mRLnMCU
        PcpsJx0j0okXJK4NGZSTxppbOaAF
X-Google-Smtp-Source: APiQypIGzlpm648IdeFdNq9Uu4f1ezA8RE20gBjKBpdwM/RLhCPNo36ED3uMsK5EsRVU/jBbMIViug==
X-Received: by 2002:a19:84c7:: with SMTP id g190mr11818783lfd.204.1585665966336;
        Tue, 31 Mar 2020 07:46:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id s6sm6004636ljm.58.2020.03.31.07.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:46:05 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] soc/tegra: fuse: Add custom SoC attributes
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200331103341.19571-1-jonathanh@nvidia.com>
 <4f1fabbb-a0a3-6f7d-f62c-2bd545f2644a@gmail.com>
 <bd1b2056-dc72-323b-bda5-d99df3a139a6@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17fb371a-14f7-360a-48c3-7f079875a8a4@gmail.com>
Date:   Tue, 31 Mar 2020 17:46:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bd1b2056-dc72-323b-bda5-d99df3a139a6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.03.2020 16:56, Jon Hunter пишет:
...
>>> +static DEVICE_ATTR(minorrev, S_IRUGO, tegra_soc_minorrev_show,  NULL);
>>
>> Checkpatch should give a warning about that permission isn't in octal
>> format, please don't ignore it.
> 
> Indeed. Will fix. I thought I had ran this previously, obviously not.

Also, please use DEVICE_ATTR_RO().
