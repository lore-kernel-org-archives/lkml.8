Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C34C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF40206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgYC/Nzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416022AbgDOQ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415915AbgDOQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:28:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16755C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:28:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so4342660ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVnJHMzMX4zea+T2RwyrRODXUlwOsF2FdlsCZVHk+oo=;
        b=kgYC/NzubYiLAa6kaXJ4bjDzEtBuG4wQ+FjtTCgn9wj25YfXSiFb/4XypzMVgiuvnB
         v6FwIp8E0EtRxWKEWEjFCgdimullb21rQl/7OFdqhwvDwYA1RwWXtH1tJa1W0k38dqxp
         VYFKX8SXqzlIlCJouxs7cvVdrx80p6dQdVvAOMlN52FrkxxSAY9wJ8v2BvWgVuhXGCvh
         +dNtiAA8Olr/D02x3XYacqD3kAiOB7sCEWRHq0VUiqLf37SLmaixRE/g3Z6L4yo5P42r
         DBUnhBLHOJ5zyVGo3L9RKpNtwUcGlBAoPNbxL9HIYb+GA9q32gKFgP1CkorAJnEe8oPp
         WMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVnJHMzMX4zea+T2RwyrRODXUlwOsF2FdlsCZVHk+oo=;
        b=pN+u+Qd1J/J/72Ab/Q0spwcZbHxgpUqX9crj2JxXZXBDDFrhJ+WMNjfOumzzSwp8JN
         v7edoodKmCfCTYoCpUrnkIEClgmw19jRm2/D71PswWFFh5gut1H1Ar1NA+6+1o6sO5Kj
         EcEusSSqU7ZkipLtxqazLKH03QJEhsE/cjTrmXEWC9rn20hJCJTrnIkHLWh6RYIPiyGC
         3qTHNvZwXAEAhkEzmnoE/iVFNsx04auOtvADRBOr/hp31pn6tlAXKe2Bx296qaZfU5OG
         JcRbb5MpCPBDCNd71bM9WHO2qruiEil5T7LEnUA/N7PVEAOQXjrJsv8PX0DX7kWiqdAl
         0bHw==
X-Gm-Message-State: AGi0PualGhQPB/Qr+PHIpn4GM8fkbhh4ad5PkkWEgiKvRqwtzafUHXC4
        gsFUxuCIU52+ZcopUUptN1XoSlky
X-Google-Smtp-Source: APiQypKl/fUg0WTlkFu5qkcnzx/jvwxvDUVKWbkC0unYzPiM/9O/T7aeBG8UEwFm1a4e3kN0cGfOJA==
X-Received: by 2002:a05:651c:102f:: with SMTP id w15mr3601309ljm.5.1586968090308;
        Wed, 15 Apr 2020 09:28:10 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id s10sm12089253ljp.87.2020.04.15.09.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 09:28:09 -0700 (PDT)
Subject: Re: [PATCH] regulator: use consumer->supply_name in
 debugfs/regulator_summary
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <731a4b299c6ae0ee9d8995157600a3477f21a36c.1585959068.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <606b7ddd-0c9b-2ba1-f873-8507377fdc4e@gmail.com>
Date:   Wed, 15 Apr 2020 19:28:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <731a4b299c6ae0ee9d8995157600a3477f21a36c.1585959068.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2020 03:11, Michał Mirosław пишет:
> Make it easier to identify regulator consumers when consumer device
> uses more than one supply.
> 
> Before:
> 
>   regulator                      ena use open bypass voltage current min     max
>  -----------------------------------------------------------------------------------
>   regulator-dummy                  1   0    2      0     0mV     0mA 0mV     0mV
>      1-0010                                                          0mV     0mV
>      1-0010                                                          0mV     0mV
> 
> After:
> 
>   regulator                      ena use open bypass voltage current min     max
>  -----------------------------------------------------------------------------------
>   regulator-dummy                  1   0    2      0     0mV     0mA 0mV     0mV
>      1-0010-vccio                                                    0mV     0mV
>      1-0010-vcc33                                                    0mV     0mV
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index c340505150b6..ad143004c32b 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5496,6 +5496,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
>  		seq_printf(s, "%*s%-*s ",
>  			   (level + 1) * 3 + 1, "",
>  			   30 - (level + 1) * 3,
> +			   consumer->supply_name ? consumer->supply_name :
>  			   consumer->dev ? dev_name(consumer->dev) : "deviceless");
>  
>  		switch (rdev->desc->type) {
> 

Hello Michał,

This is a very nice improvement, I like it!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
