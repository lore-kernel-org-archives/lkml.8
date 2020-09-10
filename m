Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00058C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EE821D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op9WewQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIJSm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIJSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:18:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C46C061757;
        Thu, 10 Sep 2020 11:18:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o16so419833pjr.2;
        Thu, 10 Sep 2020 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFd3P1rOkLJ0aMveQe0KPg1GqwxvSb9Woluh1JdvYp0=;
        b=Op9WewQIHeEQlS/RoU8M6xE18aOAsW92SSqLEXdoL6DIM5z/cvbSOLwC+TG9fVWhJr
         kOMVkkvasCDay8WDHAqgzDL2YlJ64YeMuqpraanDfiFh3i7/3kwAX6ckuxPy/KWYt4T4
         88q3U4GbhB0qu3CCh/tQi68jHL1OS3ODXVKm5yqODXCRmVVac5yQPNlaGwI70/v/EZ7t
         SBpkwH1th3kNVmk+9VNUru7KzXB43xlOP9zMdh9me0fB1PsFUuVQirvnEBMZxKlwY9jp
         +YpWAQiaJyPxSCrIeDU0ggjpErGNtb0PDJzN0cvLbPJBuLuaXXeYXERl9FICtmz8nWS/
         aO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFd3P1rOkLJ0aMveQe0KPg1GqwxvSb9Woluh1JdvYp0=;
        b=sTRSyHNEEyWAtCvPfr3Pl09+8SJusX/WaEI9jzxGbZjF13JrtJyS+He0kLvn69zK64
         7vY+9qNasDflhAn5nnuWBs647Pv3ORdW/nPcoKuYDnA461WFCPJ76ALyXKvh6Q0IOVp+
         FnAeCTbNMnF0W5Aw4x/e2XdEUKZfLO1qPQFR9eErv5KExf0ubUJ2Ipc4la73Ht9Izgfu
         J/aMWEtGe5SSQUR/BUOVrpaI8cigdULI3XBFyKZ2hl5lJZ4wo0+cgtxIC8yXLtsC6kj/
         byCpYfuL2QuUsYSEY+dKQlyEwAi1yHJL1u5d1tvj2ZCQm4O+kSUZlR2COedDj3HhjJWA
         d2IA==
X-Gm-Message-State: AOAM5303ejn7xihi02JuKlh3g8x+b8xF1kPEIe35L8p2DbcS8c3Slkdg
        EjmXaAySH9B8gUZ6dlBR1yg=
X-Google-Smtp-Source: ABdhPJzkphfIrGONRGhkOvnxjIuDhqgQ5GuoK+0TLsSJppTv+BMsz6ImMXl+KGDeRe7/jApLXDLN1Q==
X-Received: by 2002:a17:90a:bd91:: with SMTP id z17mr1101093pjr.139.1599761883254;
        Thu, 10 Sep 2020 11:18:03 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ca6sm2551066pjb.53.2020.09.10.11.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:18:01 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb
 SoCs
To:     Ray Jui <ray.jui@broadcom.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200910152539.45584-1-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <583cb756-409d-afa6-0d4d-47100eb33e74@gmail.com>
Date:   Thu, 10 Sep 2020 11:18:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2020 8:25 AM, Ray Jui wrote:
> Add compatible string for brcmstb 7445 SoCs.
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
