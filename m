Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58052072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbiad5YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHYAno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgHYAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:43:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EAC061574;
        Mon, 24 Aug 2020 17:43:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so330764pjb.1;
        Mon, 24 Aug 2020 17:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6KF3YyF8XW7CU02DB+9SDZOobpa8DnWIkfKxSLrha0=;
        b=hbiad5YBHrZmPttPpjGDQ8Nhfv2fKXHVMI4ebQsp4hGaxu5txlSFQSvQcPywedpv6I
         kkoTDf+pnZx5s7CFagLvXkrz0cFi5ddI6neBd8BjgFrANrWgB9KDDyXX49HS/iNNcaPz
         z59U83Q1yuvju0wi/tkoBCrWst8IH0SmUilAgdwhWPIudMgDEjto34hFa3o6AjMunR0g
         zPxCQsxlFvyEk3eXkVw6kMSRueinojdkFmwzA8vXzBhZqCndYS8y+B5qKHZpC8Wn7hEG
         JO23zqscadTllO2TCDsxwX6Le9BPdZvHX0IHwf0FoayBa05NB8j0MEmRdekExT04HQ+9
         VHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6KF3YyF8XW7CU02DB+9SDZOobpa8DnWIkfKxSLrha0=;
        b=fp3NRsfVuekh8FBBtrkgLFisnl26ZKpVSMfwZfUUSpYQH5MoW9uNRau63cQgjRw2tl
         kVVsUlad4x/jhaSFT94bl0YZOigou86pA7Hlx6X2O1mAXFjNIXxghep/4l/m9qUr8w/D
         9AfMXs1pfta0eyvTSbGTF+MGi1eXQGqoITcDLk6tsatX7hoS9eC+tviqphMEOGxgNWPd
         9AjEVbVbqjCz4IWaFR11Fa5c1mENRs2A2Xc6xWC+SRZkimAnubpiGs9LlbLs47MsjY8S
         7SB1UoAd6yqueYKZOKLF8nLj08w74yDV33Fyhh4Qk3R49rO6lMOXLOA/DOWzNqouxjRm
         hElQ==
X-Gm-Message-State: AOAM530/c3t7liHNU+y+39fomLOJ26tN18HQW0sBgIx/Z3vcbfM/bDTy
        Y9oG1yBuxYRBI89zpM3v1vY=
X-Google-Smtp-Source: ABdhPJwayAyLWT/ej7w91nbRscZjR98nq8drWRqMz6g/m45+2aSM4QyOY34I3OqlX7DmMuaIFAfZlA==
X-Received: by 2002:a17:90a:e287:: with SMTP id d7mr1389875pjz.21.1598316219971;
        Mon, 24 Aug 2020 17:43:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id d23sm655766pjz.44.2020.08.24.17.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 17:43:39 -0700 (PDT)
Subject: Re: [PATCH net-next 0/6] MAINTAINERS: Remove self from PHY LIBRARY
To:     David Miller <davem@davemloft.net>, f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk
References: <20200822201126.8253-1-f.fainelli@gmail.com>
 <20200824.161937.197785505315942083.davem@davemloft.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bd8da53d-ebf8-2e2e-124d-f12e614d820a@gmail.com>
Date:   Mon, 24 Aug 2020 17:43:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200824.161937.197785505315942083.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2020 4:19 PM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Sat, 22 Aug 2020 13:11:20 -0700
> 
>> Hi David, Heiner, Andrew, Russell,
>>
>> This patch series aims at allowing myself to keep track of the Ethernet
>> PHY and MDIO bus drivers that I authored or contributed to without
>> being listed as a maintainer in the PHY library anymore.
>>
>> Thank you for the fish, I will still be around.
> 
> I applied this to 'net' because I think it's important to MAINTAINERS
> information to be as uptodate as possible.

Humm sure, however some of the paths defined in patches 4 and 5 assume 
that Andrew's series that moves PHY/MDIO/PCS to separate directories. I 
suppose this may be okay for a little while until you merge his patch 
series?
-- 
Florian
