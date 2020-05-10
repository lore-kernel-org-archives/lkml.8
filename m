Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B5AC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F4B20801
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfaR0nZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgEJTwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729195AbgEJTwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:52:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E208C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:52:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so8288843wrp.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ev0gVa/MeZtNVLRSEHKJLWUsQeV9Y9ZcxTr8PwODIP0=;
        b=QfaR0nZ5+bPcvhnSmQsi58zM9q7KBGLdwmlhOXGbhFXjcWmhabac21g3D2BnWXSK3f
         v/ZkMSWcmOIdLvbPyLi4IppBNGM46VDFy9RsPgb7BEyIL8Bzie2U371oiECLD28TzRBk
         YOZvUUt/7bVjlOYYCyc7L/YTI7643YqoWTWQ1muknuAg7tgJHsgoqKCt6ZTmt7bdKoPZ
         nbNM35zz/UDc7DX19FUkxwsEVrEkTa5HLoyClYIjxzZx56SjegEcMm7U4RrUJ7maI5xA
         i1d6HZdAEKKYA0t+AXKS7fQcyH8nAd8ysA1LfjAqNuNZGk2VDKkerfxQ6y6p2qNdccuB
         9r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ev0gVa/MeZtNVLRSEHKJLWUsQeV9Y9ZcxTr8PwODIP0=;
        b=pAcNp7iE3fMeloHnV3FWD5cu9baonICWpkRJhhOGNiUCayUyDhGWqYk0r2eqj8O3zu
         li+lrDdDe9QSWHS+EF83RYlha6NySHOuLWuoXFOZZOAZJrws7KwwUd/ILHXMYcZgYg7T
         VZLQXLJ5R7zTZd1X2Uc1OS55noJ8gMdPtK2B8pJ90KP+dlGCbuvILhz2Bnh7mWwoVkHQ
         SLrlSCQ3VNGrDl76mWgCJ5g4E0AQZj97fA/0IAhAUpHWaCgLjObuVWNDTXIGF8S3yesB
         qi7bfA9E/4WcoC9+uq+EogtrEF82/QAH0TxnC/I37y1zj5g9D0ak35KHt6qlGfR1cLAx
         e4Ig==
X-Gm-Message-State: AGi0PubDy2tiMES6CiwUmu85xC6zAZlAaSWjCHrWomTmHJNoCzul/tYq
        xCy/lZC591Mh3qagXvV8pVuFFhSG
X-Google-Smtp-Source: APiQypKSPzeLW70VVH8h+5+6V6ehsgDTv/l/qVwKIpRbQesWfdY8AcjsCcwOivqjUFFttqnOydl/+w==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr13682424wrs.128.1589140330910;
        Sun, 10 May 2020 12:52:10 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l5sm14492680wrr.72.2020.05.10.12.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 12:52:09 -0700 (PDT)
Subject: Re: [PATCH] ARM: mm: Remove virtual address print from B15 RAC driver
To:     linux-arm-kernel@lists.infradead.org
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
References: <20200506233708.422-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <74e3f5f8-468f-b535-526f-b17c3ac8b4f2@gmail.com>
Date:   Sun, 10 May 2020 12:52:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506233708.422-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2020 4:37 PM, Florian Fainelli wrote:
> We would be trying to print the kernel virtual address of the base
> register address which is not very useful and is not displayed by
> default because of pointer restriction. Print the Device Tree node name
> instead which is what was originally intended.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
