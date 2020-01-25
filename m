Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABEC35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621352077C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="aLDSmnkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAYItK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:49:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41872 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 03:49:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so5248564ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGAjdva52XclcmBAYiWTp7Sd6GB5NNj9om2nEpGZk4U=;
        b=aLDSmnknhi9UiBMok0kuHJCnAZeY4uhtKYH/X+BORsVDr5YF+JcIFAAry3K+SLxJW9
         slQTT3g2gR43PUn5n6+7pN2bDRtM4PQ8g7bQUbMK1erMENPyIZi36xwsGPEoMdIu25Cw
         YxyoARbdk24rAXOrf8OY6A8FsQ9grxqvMTe2e3q5R55FmenLHXj8UnblpkoOSPC/3ZzI
         JYSERj5m8SieDB3gs2qxHpS9IQdqqTZ3dL7us3qn8p9PIiBmmpJ7uwPVaigJPvkT3CJY
         5z9ApOEs8SBEVmxdjcdmko0TPJ7nrt9VnQVHmyfVMinGmi5Hvbnfsjq8Z8wuayQGQUCR
         slrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGAjdva52XclcmBAYiWTp7Sd6GB5NNj9om2nEpGZk4U=;
        b=Jp612DcAxAAlvL5P8Vk1fwjknOgTtLeHvpA8BB8R4Q9MG8R0PZkMc9uK/9hY7JKcRS
         +M2lbWD9E0aOnv6yMyvACTPDwATkwB+iSugcJB4k4uR1jdfkVeLDKTn+saBiYwRpSXa3
         jogJPW/KUlsxWuVNUty1HzInSlAYElacCVr29w5xSsUmUBQ49iLjGL41vTOTYyNPsLdY
         uxZAN7KBPsjEgPagByfAzuuWsJP0qc3/IAySxPgJiJRlNCroYPhisKVC/DsmI+LVtMMv
         +a8xnrObbINY8Dv7XXGiB/Td1W394sTip9DuNvZoFfIZnw2iRg8MawBBthRDhxNNP50y
         kYZg==
X-Gm-Message-State: APjAAAXVo9pB8jI2rNa32M1ri5MmR5n8xjrZp85xpe4juU/8E2nRodgR
        /SX2ysuOdfK/04mZVU3iant0RQ==
X-Google-Smtp-Source: APXvYqxB5+w6lkhCPG17xoLx9bc1dwUJrL5ZeRIdjTz9PZTEzoSIgRCEd7LlLdpXT5XwmkCrh4735A==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr4772403lji.50.1579942147515;
        Sat, 25 Jan 2020 00:49:07 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4d4:a77b:25e8:958f:2b17:6e20? ([2a00:1fa0:4d4:a77b:25e8:958f:2b17:6e20])
        by smtp.gmail.com with ESMTPSA id w71sm5005098lff.0.2020.01.25.00.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 00:49:06 -0800 (PST)
Subject: Re: [PATCH] net: cxgb3_main: Add CAP_NET_ADMIN check to
 CHELSIO_GET_MEM
To:     Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        security@kernel.org, ivansprundel@ioactive.com, vishal@chelsio.com
References: <20200124094144.15831-1-mpe@ellerman.id.au>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7a7d18d3-8c8d-af05-9aa0-fa54fa0dc0b7@cogentembedded.com>
Date:   Sat, 25 Jan 2020 11:48:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124094144.15831-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24.01.2020 12:41, Michael Ellerman wrote:

> The cxgb3 driver for "Chelsio T3-based gigabit and 10Gb Ethernet
> adapters" implements a custom ioctl as SIOCCHIOCTL/SIOCDEVPRIVATE in
> cxgb_extension_ioctl().
> 
> One of the subcommands of the ioctl is CHELSIO_GET_MEM, which appears
> to read memory directly out of the adapter and return it to userspace.
> It's not entirely clear what the contents of the adapter memory
> contains, but the assumption is that it shouldn't be accessible to all

    s/contains/is/? Else it sounds tautological. :-)

> users.
> 
> So add a CAP_NET_ADMIN check to the CHELSIO_GET_MEM case. Put it after
> the is_offload() check, which matches two of the other subcommands in
> the same function which also check for is_offload() and CAP_NET_ADMIN.
> 
> Found by Ilja by code inspection, not tested as I don't have the
> required hardware.
> 
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[...]

MBR, Sergei
