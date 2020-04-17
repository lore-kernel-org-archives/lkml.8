Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D919207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNvwnFmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgDQRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbgDQRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:33:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4419C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:33:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o15so870371pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uiZHWPBN/CjTn5hUSx0nb3GnNPB5jmfJyKfRvMXal2c=;
        b=YNvwnFmYkjqkWoEvUY0+m8s0f/DOwb1an7aZSbuoMNGexc3FmOkCdwgv3XkqLgemt3
         pZpIoSmAVJqwq2tqcwBEkbUiczJyZ48QZYtHCeDgkkht6E1qHyPYJGvCJJ37t9tSwgNE
         vTqRLWolKu2lm46gev8eS6SL44VTev9Iyu52tzKP8UCycti368nJubGWt8xUdqWikqz7
         eVTC4LGDRINBIChKfcbrJUdY11q/K+TkJ2freB3L1gdIaoArAz65OiEin/u9zP8GJgcm
         8f607IHeXpxVcOOzGCWIgcO9QC0ZJiKpb9et/kanNYNEH0FHl5ozwF0PHgqR6eS8wls2
         nAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uiZHWPBN/CjTn5hUSx0nb3GnNPB5jmfJyKfRvMXal2c=;
        b=XI1t5hKOE/1xfEADT8sRzMss5KexFqCgJ05uvHGhkMwqyjtVcn1180itc0l7pHsyth
         zeE3AnK8t+YdZwmLUB+/D2RvCG+MV/9f4lRkiplUxIshiH8pak9wCWJHPttZ1KabZcYP
         36ZsKhX17almgirlLqkEiOJZKcatEOPRxmqm5Ze0daZxzTWtie9lLV+qCN8J4N2kC0AQ
         kqioIzRWJxXkX0U5w15178D0M0y/8pjX0MNRZUUyC/2crAvCZDkxR3//m5QHHi1fezi0
         ejgbVjrLBTU0rxsv002g1yBvn7mA51yYyuQlhLtWEGVP68AH5zyvhhRVDq6pFOCnKlvX
         WWng==
X-Gm-Message-State: AGi0PuZjKjVutMPb2w/qClF7l4OADHE3vcgVnsHlrvDFS7WTWiGb+m4Y
        2uQlZZMmT8rb24da+xi57NftEnYF
X-Google-Smtp-Source: APiQypKtO7qZnVIFYzkJmOqGprc5/EshtyIvVGak8GMq4bL539i2dQ95cAHJmJxhmDliCyOEF1gN/A==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr4322228pgc.168.1587144834731;
        Fri, 17 Apr 2020 10:33:54 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i187sm19920599pfc.112.2020.04.17.10.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 10:33:54 -0700 (PDT)
Subject: Re: [PATCH -next] mtd: rawnand: brcmnand: Remove unused including
 <linux/version.h>
To:     YueHaibing <yuehaibing@huawei.com>, computersforpeace@gmail.com,
        kdasu.kdev@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20200417101129.35556-1-yuehaibing@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <890fd0ce-eda3-4de7-e79e-5276e69a25e2@gmail.com>
Date:   Fri, 17 Apr 2020 10:33:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417101129.35556-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2020 3:11 AM, YueHaibing wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
