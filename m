Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C79C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C0321744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAbyYbDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCERDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:03:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50632 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCERDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:03:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so7195782wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MunyNn69liLlQ+cQpSYYuODZL15Sib99CGKMTN6jGUU=;
        b=YAbyYbDl7nbtpn+aS5+Cf5gxdFylZOS8Gt+/5g+TOoOPuwWv/Y4JUiD0qZFLFYGdvK
         L4a6dXGfBdiZNNV6QX8XiCiEWTFeb/la3tlqm07UdTiWkQDc/mt69DZgMLSz0mglk3OJ
         TQ1gmDb+EVMRsYxxYyuuM+kwQfI1mSxdnbS6RpqLFPTriA2YXgjGR3Lu/JqbIjy5rLeN
         737Ai4vFSJdusoRlEhyxK8lPNJ3vUaro4ljDAOO9THUnatuwgVCe/cuDukMwLxAlEPmj
         zBDKB3UF7/fG55VuNNBH0UkpxxY379fS8muD07mPXfiJfmv3JobOuWtAwEnbZOupnOI9
         pt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MunyNn69liLlQ+cQpSYYuODZL15Sib99CGKMTN6jGUU=;
        b=jCAQ1xFoZzdaIyyXLS50dojoGhgjeX8ti9eFhNLe2TTzZkwMT3jtPz+JrAkCJNAvYa
         x+jdSCHmMxs67pewR6pIyW/rECJaHttXDm+2DJEyQgU+mR/XDZXhc6T8mHaYiKLDC0Iq
         q9LXNvR7BFXdJJ/Fg57Y3O3dHPYCcnoCyqHQ6y1VJzqiZjT4OiawbeGKmxWMak7OMZXb
         VOBfYuDl7qp0pCt/dGCJdg2lbyO9TiZCk2u21M4kTbQcWk7PjLQNoRgssSYugdNL7Gyb
         zMieKgIyA/1daVOEhWvpWM08fg6v40CuGeFfkeYIV/9Elhs33g390bMQwA0YE6tw7kPr
         /Ntg==
X-Gm-Message-State: ANhLgQ1chilFLn/oBURdIo0zVkgJ44bwty75OcwSmD+ea1hezDva+K23
        RGsLWGdmXqCxaagThEMcQO1Kdw==
X-Google-Smtp-Source: ADFU+vsXR1awFCmok1vIpABPXDLD/t7aJc89sR1pA9amodN8hfTddeMspOhkYKRnZB0QLg3mJGsSTQ==
X-Received: by 2002:a1c:bd45:: with SMTP id n66mr10135162wmf.167.1583427798727;
        Thu, 05 Mar 2020 09:03:18 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i18sm41958443wrv.30.2020.03.05.09.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:03:17 -0800 (PST)
Subject: Re: [PATCH v2 2/3] nvmem: check for NULL reg_read and reg_write
 before dereferencing
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438A1EEBF56DF852F18F14580E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5030fbd1-baca-6e6e-de76-516991d3407c@linaro.org>
Date:   Thu, 5 Mar 2020 17:03:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438A1EEBF56DF852F18F14580E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/2020 15:43, Nicholas Johnson wrote:
> Return -EPERM if reg_read is NULL in bin_attr_nvmem_read() or if
> reg_write is NULL in bin_attr_nvmem_write().
> 
> This prevents NULL dereferences such as the one described in
> 03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem file is
> read")
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>   drivers/nvmem/nvmem-sysfs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Applied thanks,
--srini
