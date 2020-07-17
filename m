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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456FC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01FC20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4VoSL7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGQQz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:55:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E9C0619D2;
        Fri, 17 Jul 2020 09:55:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so6944582pgm.11;
        Fri, 17 Jul 2020 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jMJRgEAicok38Zti38wBCnCPnlRiUGFxE5GhAE7i6g=;
        b=E4VoSL7W+m1UEkW55SeLBkOML4xAaKv2MLwlYQnZq/9xVGBKsculihtBH3BhK9/DhF
         NH/prjNmVA8SW0rrztNOVUnVp5vpStE64CK1Y9Uek/VyvRZjzGt+T8DFXTqf1VFBb9KQ
         JwJJ9eelIivCGV8WWQx5NblrFxvy1QpM/QYt+2zKMUEHY+EDJCJV1fYomVap35Kh/Czx
         lAEWe9tu2g5mNxt3Mn2Px3z/OVNoJyvoct0m8LU8nz6uGf1E+VVHxzRcBhJMKdFNYMma
         9bctY5fqVkH1TQjQ+OMkFadm7ODwM8SEki3NDozDdUM+EvBZijraK2xWIIoL8L0RLoAQ
         oqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jMJRgEAicok38Zti38wBCnCPnlRiUGFxE5GhAE7i6g=;
        b=PfrSEZNBLoaGMunx5AUN+gcOkzmFEPYMWdk6dhYbApPMyeoqN97iTqN/Pa5i5Zkin6
         JamRoh7MLZofyQLXTilBywSwj+wu331jMkXbR+yI7yXAJ4VE5I1OBC70ubGRkni/VHwS
         3gjZ0fpZEz70TXI5PCYJ/ZFTVMLu+UaE3sBNz1iGM5SS9rNdtMPp67Xkof3YT+bw5Szq
         zNDfez7R3lgNRCcttZQ8wS7GIzY+cuUbFjs14sCpf/pmalIX6zHGdnsOGvnkgAdKRwA4
         p6mHLdABwZhf0AYdNwvpvrQuoVLXBnhznj+heC2o1Y8cyyQSSaN//sqUz2uSfTay54ed
         g7eg==
X-Gm-Message-State: AOAM530GcLF41oGoPB9JLwhuW1YUUImCE1VHYcvj11jnqJ5If02A/f4Q
        AfKIjXrajUl0onsGGjfQ6hr34/2o
X-Google-Smtp-Source: ABdhPJyUHegj5L57He3Np6SFeK7a7Ydp90LiiTBXfsyXXFfV3J07qYYfaUalkWzI2LE+ZnlMoIZMgQ==
X-Received: by 2002:a63:5220:: with SMTP id g32mr9182058pgb.78.1595004956104;
        Fri, 17 Jul 2020 09:55:56 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q10sm9044646pfk.86.2020.07.17.09.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 09:55:55 -0700 (PDT)
Subject: Re: [PATCH 2/7] usb: bdc: Add compatible string for new style USB DT
 nodes
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
 <20200717152307.36705-3-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <47192ccb-d52f-f00c-a2a2-9397ac1fa17c@gmail.com>
Date:   Fri, 17 Jul 2020 09:55:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717152307.36705-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 8:23 AM, Al Cooper wrote:
> Add compatible string for some newer boards that only have this
> as there match sting.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

This looks good to me, however you should also include it in the binding
document.
-- 
Florian
