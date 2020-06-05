Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB62C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AFC206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeVsaMBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFEVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:12:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6BFC08C5C2;
        Fri,  5 Jun 2020 14:12:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so11065981wrw.9;
        Fri, 05 Jun 2020 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z57OiC3abxqcwvsTdrXlAuG1Pt+MVExsqKpBN7y2tGg=;
        b=QeVsaMBREePnhYZZok+uHuWDSZGOGhmn0FF7HULJQSNq/qfHdwayo9BW6J+CERVEdp
         22qDNQ+Jl10f3Tq/t8bL1U1+YGAme52zs4//Xp0H+zjTWKQ4sDq9wFb0j+RnZkZnjgxi
         vM5dVQnEJW6nTABnmb5KUbTh/K2USb42/14i9KZQ/RU+SZXHgTgnqzCTVxZ6MLUsG+Ea
         RBhIPj32rmX27bIdrTYo3O2bngl72OaDRb2U+BJBX2S+5EWrGhklWpH4AUb9Eegu+AvI
         8kT2IaZs2/Wjx5oud0IhrTkAtrxzYOwKYrryi4eOT8UJVDwP4Yz4mCtYfUKE753KvKlo
         b0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z57OiC3abxqcwvsTdrXlAuG1Pt+MVExsqKpBN7y2tGg=;
        b=rEuMurArh7zEtPobqyaezfY/E87EB+sog5F1nrbopNGoLcG/5/kwbR78feQgHjdEgy
         mJ35JJRRJhfXsC4j9cIIyQO0/EI12YVHFAkhAxOduahNTlKXMGw4ckB0v7PtLNWjzKs8
         RcYdpvAfwla5MKN041Nb4knKV0NkIhH5v4AtDnlC+ouuX0bdEgbvhU+OVVNFY6HUnhK0
         CtgITY+s/OGM816IwP6i8ZhLEhRzNa+QxybWAees7czh8fUZeG5RpEcuTnzpLFwhgN5s
         rbxJRt81qYvQfezHHClRqGD8rwCGW5VIxCkqaW83HvfJCbsfFHjA5PZckdvaRfQdic45
         Huzw==
X-Gm-Message-State: AOAM531VMKdnVrVMUw3iRdxovOFiHyx1tC4AizDVnt0Ta0sjd9Mv7xaN
        p2pkzuWlzymR86IIPl4eGv2buYA+
X-Google-Smtp-Source: ABdhPJybQF1DNlFXHUS02W4gM9Rh6/hUWIWrgpCRmr88n1ycqMPsteKGHAqInCADev72CWBk7mdZIA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr11504873wru.68.1591391554189;
        Fri, 05 Jun 2020 14:12:34 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x8sm13493342wrs.43.2020.06.05.14.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:12:33 -0700 (PDT)
Subject: Re: [PATCH net] net: dp83869: Reset return variable if PHY strap is
 read
To:     Dan Murphy <dmurphy@ti.com>, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200605205103.29663-1-dmurphy@ti.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c137e0f0-b236-47cc-eb4e-954daf193f76@gmail.com>
Date:   Fri, 5 Jun 2020 14:12:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605205103.29663-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2020 1:51 PM, Dan Murphy wrote:
> When the PHY's strap register is read to determine if lane swapping is
> needed the phy_read_mmd returns the value back into the ret variable.
> 
> If the call to read the strap fails the failed value is returned.  If
> the call to read the strap is successful then ret is possibly set to a
> non-zero positive number. Without reseting the ret value to 0 this will
> cause the parse DT function to return a failure.
> 
> Fixes: c4566aec6e808 ("net: phy: dp83869: Update port-mirroring to read straps")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
