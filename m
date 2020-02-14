Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053DBC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9A7206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TGx6y5fU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgBNVp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:45:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:45:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so5579859pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X3k++zPE+sJUaSkRsR90u7Z+waK86MTRLdYHtDYo8Qc=;
        b=TGx6y5fUThAzKiGPPrR1HboWlMJPoX8PWImpJR2kFuB1x16oearTlMiGq9UDt+pzef
         cpJ62eFdDnZww/gDwXGJx8uAQ7rHWPRcmgBGdVwwLWLCkbI6cW6rgD8Rid8XMTKfsKu8
         sjAwaKbDNN7PitVT+CfYr7pBMcCIBhvEJLL5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X3k++zPE+sJUaSkRsR90u7Z+waK86MTRLdYHtDYo8Qc=;
        b=cd/PQJpzkzoPAMjcDbdKEHi0h7wrbbu0X3IB1ShWPP9YOiJoR+G7CkRVzOenKNdLfh
         eXY2e5c5ODXVLl84FW0jLp2IYIHLluVlWBgmRntsjfn+y+EEK6/nEXJ6eaazxAvxaSd2
         SWhICVG4APNDwBmO0KHJ9p1dI0cZqCyY6TReoAfbT6OZeJDjhrjgt/ydK94wB59YHT5t
         18rWdUC/+Sd04Lr8iiLE8pwhQj+lamaH8NLP4Ykr9qaFDAf7UnOQfqwY6PXW3ZEtcMBk
         DUQlWGo3JCx7+IslpO56W0nkPl/EgoLZ0QF84t8Bl+Iz6DAvO5o2CaVYMq+ZWLZWBpVZ
         ARTA==
X-Gm-Message-State: APjAAAW0zvWoTFNtvJZ2uhMV6foKesJ5SlcYeS7ojNm6z4w/mxgBitSr
        7I4megTeW6rcwsT9UkWfLxG9+Q==
X-Google-Smtp-Source: APXvYqyzZJJFq1c38QhMNLslqHWYMOZuNFRjjazVVBYOiWk75QGD9U6hjRqAr9JRahny+PHXEzOwww==
X-Received: by 2002:a62:16d0:: with SMTP id 199mr5436500pfw.96.1581716723255;
        Fri, 14 Feb 2020 13:45:23 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m128sm8165821pfm.183.2020.02.14.13.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 13:45:22 -0800 (PST)
Subject: Re: [PATCH] net: phy: restore mdio regs in the iproc mdio driver
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20200214194858.8528-1-scott.branden@broadcom.com>
 <20200214203310.GQ31084@lunn.ch>
 <2b0ef4fc-c3a1-9aeb-2e86-31e9de7a19eb@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5ce01f06-c116-06f1-d60b-549024cc8864@broadcom.com>
Date:   Fri, 14 Feb 2020 13:45:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2b0ef4fc-c3a1-9aeb-2e86-31e9de7a19eb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-14 12:37 p.m., Florian Fainelli wrote:
> On 2/14/20 12:33 PM, Andrew Lunn wrote:
>> On Fri, Feb 14, 2020 at 11:48:58AM -0800, Scott Branden wrote:
>>> From: Arun Parameswaran <arun.parameswaran@broadcom.com>
>>>
>>> The mii management register in iproc mdio block
>>> does not have a reention register so it is lost on suspend.
>> reention?
> Retention presumably.
Yes, typo.  Will fix commit message.

