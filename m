Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0E6205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5YpserX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgEMWHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729775AbgEMWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:07:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B81C061A0C;
        Wed, 13 May 2020 15:07:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so15994473wmf.1;
        Wed, 13 May 2020 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uIfGmlsWsv2Wb6K5SaLI3qMgfMija21e9CZ9F/PBTQw=;
        b=U5YpserXKPS77Z1Gq3jFSa+91D02KZWmq8lLBynLq0SRsKcQQmtFvqZ0Sk2wM6WacF
         lrN/jEfxHlWS2HXm9ymEQoS9yQxJC57j2oBDqtSe9nBi7k/4b6qnX9++3e5Bwr4adgR6
         U+Goz3ocmjizxvWxzW5w0bbwxhERgxO1RL2MgCobaWcR6q5VWnQJ0xviCWTpe9cX8Xct
         R3a49QAEZE7hPBTb22ye1lgyL7aC2JLlGM/Xkn5EHox5ebeR1oFwURSATzqmBqDX6muY
         71IDsQdGtZueJLIPQBHz5lT9oZH5isJujwjXyC6LbAa6b8CTypgyta7WMwT9a4K/iaIK
         +D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIfGmlsWsv2Wb6K5SaLI3qMgfMija21e9CZ9F/PBTQw=;
        b=eFlLtCD1FBtqA0Oja7+V7XQBHYAEE9RXKcesiaWHxZAjxFHLKJhyU6vTLHKsD9qbTw
         PY9TePC4W4a0mGa5XcqC75wKuYt1/fqeqP7SYOR8PHMo1k1V42R8BA+kctFACufz+CYR
         anXPNPBmPh1GQLhk4zOjTILPCN12GKZa++tqHhv9El4U4phwx7sJuFiJoErN3qTSWWO+
         EB+QYn57GiU8PPFadApoQ6Z/ljt8uFG2hK4GpT5n/hS4IyLp1bKDhRhcLz/pJNJ0Gl9a
         xMfn7R36fj10fux+wz4Tqimho52uBs4V3cFm28dBCtpLS4iZUufkS1XCzsBkiSvlOkTz
         NhRw==
X-Gm-Message-State: AGi0Pub90yMqc/811UZRJoa0TWduh9J3nKhO6amaOOr6jA3DZBlGh70O
        tyHTfWNC6VE54pXlU2YZij8dtV7D
X-Google-Smtp-Source: APiQypJXnx6BlmHK7jVCOtk1nzV6kOPAUnhYYZV5BNr+gQ9tnc6/WaM1Ed4GNF3RKRIwNlktTRjTtg==
X-Received: by 2002:a05:600c:290d:: with SMTP id i13mr29667029wmd.81.1589407633188;
        Wed, 13 May 2020 15:07:13 -0700 (PDT)
Received: from [10.230.191.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o2sm29972862wmc.21.2020.05.13.15.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 15:07:12 -0700 (PDT)
Subject: Re: [PATCH net-next 1/4] net: ethernet: validate pause autoneg
 setting
To:     Andrew Lunn <andrew@lunn.ch>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1589243050-18217-1-git-send-email-opendmb@gmail.com>
 <1589243050-18217-2-git-send-email-opendmb@gmail.com>
 <20200512004714.GD409897@lunn.ch>
 <ae63b295-b6e3-6c34-c69d-9e3e33bf7119@gmail.com>
 <20200512185503.GD1551@shell.armlinux.org.uk>
 <0cf740ed-bd13-89d5-0f36-1e5305210e97@gmail.com>
 <20200513053405.GE1551@shell.armlinux.org.uk>
 <20200513092050.GB1605@shell.armlinux.org.uk>
 <20200513134925.GE499265@lunn.ch>
From:   Doug Berger <opendmb@gmail.com>
Message-ID: <08316b1f-a88f-1eb5-5ab2-06c23900cae7@gmail.com>
Date:   Wed, 13 May 2020 15:09:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513134925.GE499265@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2020 6:49 AM, Andrew Lunn wrote:
>> So, I think consistency of implementation is more important than fixing
>> this; the current behaviour has been established for many years now.
> 
> Hi Russell, Doug
> 
> With netlink ethtool we have the possibility of adding a new API to
> control this. And we can leave the IOCTL API alone, and the current
> ethtool commands. We can add a new command to ethtool which uses the new API.
> 
> Question is, do we want to do this? Would we be introducing yet more
> confusion, rather than making the situation better?
> 
> 	Andrew
> 
I think it is likely to introduce more confusion.
-Doug
