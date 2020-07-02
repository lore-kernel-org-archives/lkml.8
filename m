Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEAEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E723F20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfP+3NH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGBT6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGBT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:58:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D536EC08C5C1;
        Thu,  2 Jul 2020 12:58:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so28716654wmj.0;
        Thu, 02 Jul 2020 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wC+zZCNyKVhch9fm+otFty88VRPg/0Jc+M1DZ5xEFf4=;
        b=gfP+3NH252b3V7MJrH3IOUF/KOnB4tPiudsZzWOw7IOLrLh9hGuWFf+AGDnXQAzEH8
         RvqJ9xBO29et9XUf9Wmz0/VDVg7y48eBcJ335U/XjAOLE4XqXamZaLqwwTWoKxtRJ+gl
         9q52aacbZwZcpK2XK7p8NcR6hjjLSj0B/Ytdll6gjwOC/62S9/p8ewg82vDXQKVAI0rW
         asRFbHU56HcVBZytz+Q15PFANd2iJ7dZBm1qAAUzaFDzHZCMoNCavOKv/t6yZm4mS/x0
         1JWbUvQro9c+vPq9AwhC0DT1NDy6zuHP+vS53FlSu3ZoqKD9MNnww852aMcm0VoIpujk
         CtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wC+zZCNyKVhch9fm+otFty88VRPg/0Jc+M1DZ5xEFf4=;
        b=hNrpXMZuArYW6vRNhoB9XcqfyJ0x3kHysJsfIVIYhM19W0lpsxGlv8ao5bFCU9O01J
         Tt+bN21h8/YqU7+oVkuXiK3U3IWnLbXOinAF0JQZ3gD3jKpDA1NnXJQKVQBX/ei2E0PU
         IcmHzUhv8usQd4gTG2DvIR1fcWKJIYgBLK9toczebWdrNxT/2v+lz/m6vIGqnhiuW7rN
         QWLeAgpvZTtoKqZO9otjOuSqtRqycfTvepWEgrRCNjZn7U19CpGEKr8zX8E5Z21TOqRc
         bSq/rWFrE/Em+HUMs4JBqNlgKRh5bhiFC65T1qesLze5GvYzunKSEsqFHsYyz2PbsP7b
         zVgg==
X-Gm-Message-State: AOAM5300WnQ54ZaApmDryyWamIZTO3YZVK+/3uRLeLLNCLhuCy1PLAe1
        99LWt/3v555eZXf3E3bc1a8=
X-Google-Smtp-Source: ABdhPJyS5o3QkxtoTq28hJhbwfOeQRJTZO9mu/ToqnB5o0vBUapCv4R7pRaM0IUtJw+vYOTlm/ojsg==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr13922306wml.25.1593719898535;
        Thu, 02 Jul 2020 12:58:18 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y77sm1178183wmd.36.2020.07.02.12.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:58:17 -0700 (PDT)
Subject: Re: [net-next,PATCH 1/4] net: mdio-ipq4019: change defines to upper
 case
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
References: <20200702103001.233961-1-robert.marko@sartura.hr>
 <20200702103001.233961-2-robert.marko@sartura.hr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <52169697-d7e8-6c28-01d4-eb02b92ae552@gmail.com>
Date:   Thu, 2 Jul 2020 12:58:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702103001.233961-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2020 3:29 AM, Robert Marko wrote:
> In the commit adding the IPQ4019 MDIO driver, defines for timeout and sleep partially used lower case.
> Lets change it to upper case in line with the rest of driver defines.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
