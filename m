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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29C9C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB7124956
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIRz/0a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEHWvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:51:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D4C061A0C;
        Fri,  8 May 2020 15:51:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m24so2233028wml.2;
        Fri, 08 May 2020 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pY+FRX/F1JgAkLBUd+POYrhs0Y5rE0YkIgkFtY0rBYU=;
        b=HIRz/0a/DHuW6f2lCSZjoDNuHkDRMe4b186+ArCD3nLCQd/0a3MRNR0xpJPVEB3R8m
         OZrsm1/b8qNHO8yRT3vAgs6mgzwSbuGW9Yas0/dki5RxI9oVSRgbMRgfs+t9ub4PWoMa
         MDUEJlc0Nf6ZQrD9++ozDxEnzooUfmvvKXQsnezTX1Z4cNf6t5z0U7qZNIlp3ngrO0xw
         k/ORK0FBCD9PN4E4L700eA431cbt18IGdyY6fWEBGf+C382XCZH7NmVx9PYroK2D0Zmf
         W13hAHQDiwcHhwiC3xRB8NV9Cbowz16pFjthRCpWU/UwQjPgBTTQpKWOMoqa6+qdelqq
         7Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pY+FRX/F1JgAkLBUd+POYrhs0Y5rE0YkIgkFtY0rBYU=;
        b=ILws2ky5w8lG/iI9J2Kuer5XeLpBetONFEG67d2niY+J/IeGgIofpAUlqGbFdn73nC
         itNlL+mgt1twT2GbIvjTYvBJT4+QlgVQ5+bHCk3T+PiT+BmAZ8IVoAGpQFu9adT4TD2L
         UrwEvFNz528el1TKK3Z4ZJPzerTo6d42YRVsLnYMBsQzXLsPwIfDCBoh3tAn0ZS1uexN
         R3R80ELuW00U3yklQ7CpS1ER2J7jPEkCjsPe/CWV+F5vrvVhFwWePkS5eAnOJJ+vWmBh
         GJmYNYEIjBmyQ/dSjRVko6ngh9K3p8GVv8ORco5X2OKmgV7jyOKl3AJl7qKlALTaWybc
         MQLw==
X-Gm-Message-State: AGi0PuaUAngj06Z01BIxfG4d0/CG7Y4lWm3fK4ppmsjDPN32Kp3RVy4U
        ZOshYeQMC0Egm40Z2upc4D0=
X-Google-Smtp-Source: APiQypL+OTBqvq+rGKOPMzBnZCO30yPJy1UiGy7ywSmsfyHu64CxDhJ1EI/aXJDIA0t7VKrSwc8l0g==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr19137003wmk.142.1588978280029;
        Fri, 08 May 2020 15:51:20 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v8sm5240995wrs.45.2020.05.08.15.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 15:51:19 -0700 (PDT)
Subject: Re: [PATCH v8 2/5] dt-bindings: Add Broadcom STB USB support
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
 <20200508211929.39020-3-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <662eb752-2ebc-d8f4-3a9f-65adac00dede@gmail.com>
Date:   Fri, 8 May 2020 15:51:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508211929.39020-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2020 2:19 PM, Al Cooper wrote:
> Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> 
> NOTE: The OHCI driver is not included because it uses the generic
>       platform driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
