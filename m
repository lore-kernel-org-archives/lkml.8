Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F89C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A0020674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b6Z1NPOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBCXBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:01:46 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40246 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBCXBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:01:46 -0500
Received: by mail-wm1-f42.google.com with SMTP id t14so1252681wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L/WmTifwmb89BwczOAGZOKM4jEn1McfbNHT4zsZzsqk=;
        b=b6Z1NPOc90KxyfZxvIPq9oTI2wC8S/JW90xYYYcMS71Mdy3OzAhwbnSfnAlk/z86oD
         zc2r5R4V8AKTzLjMO83EaNF8qhL/8OZRbFFI3JThsyZawtdQLRkSDtr5MnoGYZ7sEn9o
         0zKVeJA5fPdEab2H+yCceY9mLj821RrP/1eYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L/WmTifwmb89BwczOAGZOKM4jEn1McfbNHT4zsZzsqk=;
        b=XhQQytEmxrIn1JX6KfOAHTv+pJYCZ4uSwvS/+eAyMd0oyB3885iukGzdeBVghlNDqy
         XvofdmFOUQYVSOpJPJeDZvBTU9+SRyJPfF2p5EZ4UR2WEbfxpb73OxXo9hXhd9jAuN9q
         +GRfB7b0mtmbWQqFb80IA+GvokilZEtvLbT4ATLgj8aVsKMblWbFyIlL8pnXSwD/th17
         idLCrsJaeqQLKCvwcXWsMYKeFHjWzXQr9Dul7GuF6CDvm2jgPf0nSjm4r748bAexpu6+
         lbQWtogfBCwBPJ6kLNDc9uPQrU3sox/OUJMHs6R8FWySlBa+JQUWx3faiA5IU8pXSJAr
         FFaA==
X-Gm-Message-State: APjAAAWe7pPInYEHlY2GsSCkJpaWkF7RjlDqAbsWP4dUiC/He2iDQbmJ
        BCA1oD7wi77pLHWMhZcVrNNHeQ==
X-Google-Smtp-Source: APXvYqxKfIyAwPGFZH6hhinfmnaMBYKvz9zPEaOcLLhtZP7NlDgbeDOcVLjNgEIJc2REVbq+ryMVzg==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr1371643wmb.80.1580770902705;
        Mon, 03 Feb 2020 15:01:42 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c15sm26990390wrt.1.2020.02.03.15.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 15:01:41 -0800 (PST)
To:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Subject: RFC: Use of devlink/health report for non-Ethernet devices
Message-ID: <f8e67e40-71d4-f03c-6bc0-6496663af895@broadcom.com>
Date:   Mon, 3 Feb 2020 15:01:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri/Eran/David,

I've been investigating the health report feature of devlink, and have a 
couple related questions as follows:

1. Based on my investigation, it seems that devlink health report 
mechanism provides the hook for a device driver to report errors, dump 
debug information, trigger object dump, initiate self-recovery, and etc. 
The current users of health report are all Ethernet based drivers. 
However, it does not seem the health report framework prohibits the use 
from any non-Ethernet based device drivers. Is my understanding correct?

2. Following my first question, in this case, do you think it makes any 
sense to use devlink health report as a generic error reporting and 
recovery mechanism, for other devices, e.g., NVMe and Virt I/O?

3. In the Ethernet device driver based use case, if one has a "smart 
NIC" type of platform, i.e., running Linux on the embedded processor of 
the NIC, it seems to make a lot of sense to also use devlink health 
report to deal with other non-Ethernet specific errors, originated from 
the embedded Linux (or any other OSes). The front-end driver that 
registers various health reporters will still be an Ethernet based 
device driver, running on the host server system. Does this make sense 
to you?

Thanks in advance for your feedback!

Thanks,

Ray


