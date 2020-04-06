Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1462EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C512072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="1MwGnWt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDFVON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:14:13 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46483 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:14:12 -0400
Received: by mail-lf1-f45.google.com with SMTP id q5so616107lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Xd1xzbAohX/FqkqTk1cM6F9kOwM40uvkJrnhkR7+Fo=;
        b=1MwGnWt2vQYBfJnOaGiMooJfZu8yPk9Lnh8IpQq4l4Fbk8acKx7Q0J83j4fbMJhmTX
         Bz+eZjKKF+Ub1qTlSs94FqivztSEebggGwKqOO2o5c+66jj41PmWZIOIuYytFsaBqmG8
         vbyS8SUkw8WPy8l9fXvKJ/eTAO6MGiT8QjtZbd1sQ9eBCMAg61zLKtD8blKSPCHXxeBc
         XiVn5iAZEWta1iZrNBRvwoGTxeux9ycBqcHT22tBvWp4wUHFIRiKeN3mDGTuN9nsKMVN
         8v0178c+aA+YlM+cBBDnBIF5MieLOOec2d4ecPVr44unPekjdEqBzjzuGLrRYzF7VbXT
         XeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Xd1xzbAohX/FqkqTk1cM6F9kOwM40uvkJrnhkR7+Fo=;
        b=YWbOTIHI8eDoBw2wtUlqBxTQbISGMZbVe+7wH9jD/8c2FWCuMMjWffUTuiappehYuf
         0XgCpThfkvY48cV1FYJ76H1X3iacjzKrgzufv9dtZGtslO/YD4UWgYUBIwDqjvHrOjUv
         VyfIU55qYjkd1vyaE5mynnL68P/D4aGXp8YFuVJziS48fIEmixWPLU0qVGzz2UiyoFEY
         ALbaOBi68mGva5IdfxPX7/QeUwS1jrtGGhVplC6fQaW6czMLCrwteYf55b+dOx1F20wp
         DlfnlXX/fTCXbNm64gP0qGEvp8hAgpqphwWC3wLCXywPnyMkZ70WgKivFegP69JQ/sKv
         NFCw==
X-Gm-Message-State: AGi0PuZY9HtVaMn9LiBTZePk0ylzGrPXVTyVbbJlKFN8INNFqzTRSed7
        Yp1FNGpYfk1KsIK6F1Ez4V36WQ==
X-Google-Smtp-Source: APiQypLi+4wO9Y/cU95F3kWj2BAO3JcE28FDvZp9goT7P7q6xIUprCvzvB04YOF9s/5Y3E2PeokoTA==
X-Received: by 2002:a19:40d0:: with SMTP id n199mr14028200lfa.161.1586207649535;
        Mon, 06 Apr 2020 14:14:09 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:462e:583f:4b1:b175:1ecb:fb31])
        by smtp.gmail.com with ESMTPSA id h16sm10509386ljl.73.2020.04.06.14.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 14:14:08 -0700 (PDT)
Subject: Re: question about drivers/net/ethernet/renesas/ravb_main.c
To:     Julia Lawall <julia.lawall@inria.fr>, horms+renesas@verge.net.au,
        tho.vu.wh@rvc.renesas.com, uli+renesas@fpond.eu
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
References: <alpine.DEB.2.21.2004031559240.2694@hadrien>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4c39386e-4259-ba45-1f7f-1e6307a7753a@cogentembedded.com>
Date:   Tue, 7 Apr 2020 00:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004031559240.2694@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/03/2020 05:04 PM, Julia Lawall wrote:

> In the function ravb_hwtstamp_get in ravb_main.c, the following code looks
> suspicious:
> 
>         if (priv->tstamp_rx_ctrl & RAVB_RXTSTAMP_TYPE_V2_L2_EVENT)
>                 config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
>         else if (priv->tstamp_rx_ctrl & RAVB_RXTSTAMP_TYPE_ALL)
>                 config.rx_filter = HWTSTAMP_FILTER_ALL;
>         else
>                 config.rx_filter = HWTSTAMP_FILTER_NONE;
> 
> According to drivers/net/ethernet/renesas/ravb.h,
> RAVB_RXTSTAMP_TYPE_V2_L2_EVENT is 0x00000002 and RAVB_RXTSTAMP_TYPE_ALL is
> 0x00000006.  Therefore, if the test on RAVB_RXTSTAMP_TYPE_ALL should be
> true, it will never be reached.  How should the code be changed?

   After looking at the code, I think that setting RAVB_RXTSTAMP_TYPE_ALL to
0x00000004 should be enough. BTW, the RAVB_{R,T}XTSTAMP_VALID don't seem be
used anywhere...

> thanks,
> julia

MBR, Sergei
