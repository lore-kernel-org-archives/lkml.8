Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C95C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CC421974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/TzgS8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgEHWxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgEHWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:53:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308EC061A0C;
        Fri,  8 May 2020 15:53:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so2802935wmc.2;
        Fri, 08 May 2020 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMrlGS3Usu2vxGof1+PJ+l2BUflCsuWc3mZfos5tvb8=;
        b=o/TzgS8fx2y71BYwe1ZVMxzbshUJ0qg7RVghfPrQX920582rMFq7Kq1X2CAfogr+kk
         5BlCTYWr/XkIndEtU60t/GK5Zkz8kh+5q9Y2oghH3/xu9XlNsxNxuDtspnRH51XZVWy4
         J+zSmOSqXtN6X9+HVe+ejw8ymeocngnKhNpsAO225fpehfxgrCgF0rz8yXxgGFsRlNIg
         1ETCLVmhKepLIhYIhDnaIqVzr9eAZhijyeOzORYeqHh+PvEswpkRSMRikSDK92Ky1K8i
         opps1/VrkBmXPGT6VHNg2o6PwZuoHH3rT6npdw4sLKdqRNBlkxkuTWFXQWyoddDCzdS9
         z1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMrlGS3Usu2vxGof1+PJ+l2BUflCsuWc3mZfos5tvb8=;
        b=p4cK9DksdzX40MDdrqbfwL0Jzl10zRiyqWGFAYPJkoY7awIt4KmN6TiPegfPpfqM9+
         nzZM/HP/CkxYkh/ASqlh+3sLleLhO98NCjrobAJReO7KGuYvz3/7x69dXNT2zL21UKm9
         Mn97yBYga7FzlgSnnaLWFkGv11RJrl6ZssS7fNcdy3CBa6KCJkw4m/hzzYhJOCYuz9uB
         dzYFdTbL3cgNESrGHvA82l6ITwgpCYYtbyQMD0fe3K6qD9fs/qqOuXErQhYjAx8Pyy4l
         J0xHKXbH4X2Sk/IYOCyvg+Sd53GzulUYgK7J5c/MenBttwTB5Dir7CS3jU05kYXhaIRY
         3H+w==
X-Gm-Message-State: AGi0Pubfd72xrRMDfusFXhdMyQ4knbnCbQ3+xqTCvt46s429n/byttt/
        AHjEs9ET30yGq6oUpdFevuE=
X-Google-Smtp-Source: APiQypKudYAyXmUpgl2IgAZ0fi2GDMBEyzSbjTybQpyZpDiyC+Ad6xlbbmCtcKKA7LoyCl/fAkOYGQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr18057283wmi.178.1588978393519;
        Fri, 08 May 2020 15:53:13 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l12sm1346562wrh.20.2020.05.08.15.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 15:53:12 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
 <20200508211929.39020-6-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5bd76807-ac02-5627-a3ad-f02aff3cb579@gmail.com>
Date:   Fri, 8 May 2020 15:53:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508211929.39020-6-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2020 2:19 PM, Al Cooper wrote:
> Add the build system changes needed to get the Broadcom STB XHCI,
> EHCI and OHCI functionality working. The OHCI support does not
> require anything unique to Broadcom so the standard ohci-platform
> driver is being used. Also update MAINTAINERS.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
