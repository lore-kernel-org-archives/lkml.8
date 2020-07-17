Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9DC4345C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8C7207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Y+Gxyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgGQQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgGQQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:57:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA61C0619D2;
        Fri, 17 Jul 2020 09:57:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so5695294pls.9;
        Fri, 17 Jul 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l8xDxA8kojCoOA0aKOLVl5EuXMDT6t6AAoB6hlYLn4c=;
        b=W/Y+GxyhjM2mw5UaQFS5Np6o9mOvfHYzIpCF9QAUOtKGHjlByhrh7hqHa1+rWARPcB
         wZvWtfOY970oJLrVq7++GMfYNCbglgc0uqwvkILMbIRV1ReEhj78KvcNZ5BSR5qi4NYm
         GWCr4heAT73gHXOi3Qb9NrtvZtc1dH658Z4M2rAr6AK5NLzIX6ECFeDykTU2Pl0bdamv
         ZGbDivldoTR6xTCEslnjwanx+n3qzVZQdLBAwHfthyvLw4mzL0pccpsRmTpy9URWn+QK
         HgcdfssxXfWaOzML+LF5qPd+l7b2ExOA57XbcQK0lMbF5qFdftE5o7eOjqi6vKRGkssI
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l8xDxA8kojCoOA0aKOLVl5EuXMDT6t6AAoB6hlYLn4c=;
        b=tM2zLpwmC12wr8joiq0n8lkv63b10U96vWoLHPrX4Xq3+rGaG54KswzrmqlTQA8qFt
         SWkdJFdDn1fXLO3shJGIj8LWoJ+zbeqhcBRN8SD/gBpxYRQcJuIO+FOtFWlk5uhzKcZc
         2aprQQUwFCqlZH+kC7YzhFTbbbrOKsrI+d2qQMw6UNylzt4MpkmLDrNLXXN+VZi8mrsS
         zhOyc5ABiKAH87mvI8EMxOhFbAbtFH3iM3NRsd4vIGjk9pJc3HUMCRypXrzf4/x6jqeW
         SnbH5bMJWDILPczcpSrkSliATQWWDw0xlhQQGWgxckY1XzkAX3KDv6eXkuNIb65HfY21
         g1QA==
X-Gm-Message-State: AOAM533KHsuQYLpxoxWd+48K7IA50343ZqVfTUfJLypQ2ZO+Bgts8sXH
        HueHwl3iL9E/F+FZhL3///E=
X-Google-Smtp-Source: ABdhPJwQYmCmnOsUWnCWRIRCLhh5wVUlWnLAiBc9fUebbFncgMYxQYGvGrqUpmhxhoGVv4Le2iYmzw==
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr8237614pli.183.1595005052114;
        Fri, 17 Jul 2020 09:57:32 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 17sm3334257pjl.30.2020.07.17.09.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 09:57:31 -0700 (PDT)
Subject: Re: [PATCH 7/7] usb: bdc: Use devm_clk_get_optional()
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
 <20200717152307.36705-8-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6b52771f-addb-88b0-fca3-e22c6756c38c@gmail.com>
Date:   Fri, 17 Jul 2020 09:57:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717152307.36705-8-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 8:23 AM, Al Cooper wrote:
> From: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> The BDC clock is optional and we may get an -EPROBE_DEFER error code
> which would not be propagated correctly, fix this by using
> devm_clk_get_optional().
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Since you are carrying this patch on my behalf your Signed-off-by should
also be present, if you don't mind, I would like my gmail.com address to
be used here for consistency with all submissions done throughout my
tenure at broadcom, thanks!
-- 
Florian
