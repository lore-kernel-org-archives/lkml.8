Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE533C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6E2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="eHClCP1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:46:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37272 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:46:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a141so1849137wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d9hiWNQ6J5n3j61Fv/V6tZE2JLkQSqjWYDVkkP/+6yE=;
        b=eHClCP1d12t4vlxl6n7r39rqsL2C7OiH/LXFAM/DgTnYYvZJm3QDPnuKZyuXrv15/V
         0TW0q676MD43QFcX8P/UcUVTRGV3T2Dtc0k8eM8NGh/bvFz779Bc0F3UfQAg51D8Jd/v
         B7QPKgFmd3ebbKD0/xYQGeR/udzkH+4t+LCRBlP9neskFizDKLBfssG9HJdF9ktIGDfo
         7ZSGzm+GfTPaFH97ubJ67Xi+EUBSqOsgEtSm8upPNm6C5h5Oa8EDidDycVKzMouwn0fF
         mYD1G9KXWU8g5yG/xmlhn+lZ8A6mrcVhSlqCcCdC/aA1X5dHF7wG8mBOFoNi6KzafVrC
         K1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d9hiWNQ6J5n3j61Fv/V6tZE2JLkQSqjWYDVkkP/+6yE=;
        b=MVErcm7llA0BS6sDT4TojzBJdSWd7e1KQfXmkXcad9nwZUG89RLPYnmKvUgQd8I1sQ
         vJIwNEXH+2m6JgLp3FloUXPRSzKW1zsP7vQGXZ1XJseaL00+6GxVWD3TYlb1oYCs6dgK
         yU3OBGTr5h00cmOQ/S7oC/XO+6//8lZj0qUo15tI468CNC1Ny9SMODWT/J46qeddzM6V
         AKpQOtyCU34xq8MIRERPZlyxk5hLjixH45reCvZEzMtbFdV0KxPo4VgpgFgMK0vkc1xE
         wxYvlUJJvczfNVdBpNKHb1lpLUeMUzzq+IhwGAPnsSjAaTybCcLF+KhoSym1G726Z6TI
         MT7A==
X-Gm-Message-State: ANhLgQ2qtdhx3+KRXxlc+hC+hOv3bA8WJYN8AVoWgXdTEUpcphiUj1Ev
        lAYmmFpyqjffr/n4gwDe0hQ5bx5Yfv4=
X-Google-Smtp-Source: ADFU+vtyuUNlJMUe6+PBiy69yoy09fo5sBeHo942glDD+YgiDtuy/FwybcSRvw5ZFgPFJU/dlDmHzg==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr3509384wma.86.1583491571878;
        Fri, 06 Mar 2020 02:46:11 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:3ca7:8f7d:279:5ab9? ([2a00:1098:3142:14:3ca7:8f7d:279:5ab9])
        by smtp.gmail.com with ESMTPSA id i14sm972437wmb.25.2020.03.06.02.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 02:46:11 -0800 (PST)
Subject: Re: [PATCH 00/10] Raspberry Pi vmmc regulator support
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <b33aadf7-d481-10db-c290-6e53b696b2d4@raspberrypi.com>
Date:   Fri, 6 Mar 2020 10:46:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306103857.23962-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 06/03/2020 10:38, Nicolas Saenz Julienne wrote:
> The series snowballed into adding a new quirk, as I reliased
> sdhci-iproc's behaviour is not that uncommon.
> 
> Based on Phil Elwell's work in the downstream Raspberry Pi kernel.

There are a few typos in the commit messages ("reliased" -> "realised",
"trough" -> "through"), but otherwise:

Reviewed-by: Phil Elwell <phil@raspberrypi.com>

Phil
