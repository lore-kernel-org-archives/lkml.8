Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2838B21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGq/fHWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDRPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDRPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:55:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3605C061A0C;
        Sat, 18 Apr 2020 08:55:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o15so2166414pgi.1;
        Sat, 18 Apr 2020 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=os49Kt86JlY5pSJZvK5uq8qx4Lix7y20IpAizDOhSSc=;
        b=EGq/fHWaGaj+LDNS6MsnymRJjUB301/nGdnoysoRF+LqqUCRab9pSeGh6YppYacG5c
         y6L+b3Lk09qtW5rETj2uBMoTc6TOQJ4RSRHSzYGjnuphAblK8Y0krKWFhZnfumHSz16D
         FV32wQEIOrBjlNy2CIgNsG5f32frq/yONRIBu8Mwf6XmXuGlx64Pk7avugXyZO80Qf7M
         PcR5/n9dMPWIAUlIdiN6B6UZylljO6AfRXXwzPHMuBKT5lz2V7lhPWe7KxYr1rqo5La6
         39E9TUlgMu4W0Xcu5dd2grXg/DXXuJQX+pU3SwQgIv7dMjxQ1bKajdDCwNUDvC3zL0a/
         mIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=os49Kt86JlY5pSJZvK5uq8qx4Lix7y20IpAizDOhSSc=;
        b=LYNzymJ+t5S3dDiL1gOjbdQMJApoVk+KP16AON9C48iftE2yEsB3WjwVO7LRXXfeC0
         RJRzWlvMitjmIUlNiqlXoQzWqo4JqK5UuU4VSo5mG64ZXMalW/kWH9fJXxXl1WqLh1pK
         sNowPVB4aQDOMxfcri/WrWfHmmDZoUyznzJcNjWAbCe12Y7zjI0wKa4uWqugEQ8nk8S/
         TBAJTZG+TP70FKLYRfZYM+btbyDkT2laJ3FR7LEIHIYCrMu18l5e/oSa/Z2c3AgCVgrd
         3Nc22YUbRhf1hdQaApAweD3Ify3mGESa2bNkEXs5YDvFdPGaRXnNV/omPD3catdVduS9
         YCaQ==
X-Gm-Message-State: AGi0PubYB4orSckPYSx+MUqpEcwPE5cGWTpnn+al2OUgfM5JZq6DrQFv
        wzJzfjeyndvfO9WH/zf9LGY=
X-Google-Smtp-Source: APiQypKLqMXLNbCranlRJZSuXcCuy2WnCq3zPNou+S7rkJbtgxSIE97wWIKBiuX0UyXVPW5LK9EVNQ==
X-Received: by 2002:a63:c007:: with SMTP id h7mr8248283pgg.428.1587225304244;
        Sat, 18 Apr 2020 08:55:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id i9sm4622888pfk.199.2020.04.18.08.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:55:03 -0700 (PDT)
Subject: Re: [PATCH net-next 1/3] net: phy: broadcom: add helper to write/read
 RDB registers
To:     Andrew Lunn <andrew@lunn.ch>, Michael Walle <michael@walle.cc>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
References: <20200417192858.6997-1-michael@walle.cc>
 <20200418141348.GA804711@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <aa126ad1-ae29-3da6-bd50-2c0444cfd691@gmail.com>
Date:   Sat, 18 Apr 2020 08:55:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418141348.GA804711@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2020 7:13 AM, Andrew Lunn wrote:
> On Fri, Apr 17, 2020 at 09:28:56PM +0200, Michael Walle wrote:
>> RDB regsiters are used on newer Broadcom PHYs. Add helper to read, write
>> and modify these registers.
> 
> It would be nice to give a hint what RDB means?

It means Register Data Base, it is meant to be a linear register offset 
as opposed to the more convulated shadow 18, 1c or other expansion 
registers.
-- 
Florian
