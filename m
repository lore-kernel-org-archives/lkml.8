Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C548C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698FB20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeQRnNQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgFJCX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:23:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB23C05BD1E;
        Tue,  9 Jun 2020 19:23:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so346558plb.8;
        Tue, 09 Jun 2020 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jHeSUddA32B2eduTi1qXwNDxzJjrZCcCzMHGeBTM2yE=;
        b=SeQRnNQyzPCAgpGMdg26dUVg3jqXElJ0x/PJKZFtIuoe3Wml3m/UsPZXWsrJY973Nu
         DcqEFQx466/ZpftjEA3tZbqbaIyNts//EJffrR6DGdcZXiQQlZLS6/yC+fMYRWnt199v
         0hzZLFwVKmu758RgCJtWV+gmLmgyicPIq41rK/eKYhCigm4Nqu1iWn2xlMcQgy/g7DZO
         w3VtERV0waJbKBUrHrZulcpgT2kPNnwQs+TGgy6qwNYjfoR2O6pxPFG7RYIeRuIaZM2q
         TbE0zcdz2maHLo3yZdeHe1UrmaI0Tu4nDcuBKnoQZp+VNVX/udfrCcEq0ciSPps9rkpu
         dndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHeSUddA32B2eduTi1qXwNDxzJjrZCcCzMHGeBTM2yE=;
        b=gDLSJ3oWxbS3CzDjK/8AWoSteAp+QhwMWXixLBR9BHHSX+03bwOuokGV1Qby1DdEBb
         dMJPmH973cKxmBZS+zS68QuT9/LRiTpRKFo/CjmD22E5Ln67ZoqYo2MqbT/+vmV17uIh
         oFmrHxBjRQLYw1eIu8W/3MCzbfA8JeSkGdfuF4AA3XvLWBhMYiWWB2D0vkhVmKuB7c3X
         c2Puvf/XyFXpuOkt8LQVz0eDO+uWkIPePxAb6YAlkHPOWLiLkDc8uGpMBccS/CA+ULzN
         gABtsTEo/IimogJCIKusgrvUmR/sNaYkA8nwXxggM0EnEwxFbmd6jFDP9Q/AZ8s0i2z/
         RmMg==
X-Gm-Message-State: AOAM532Dvabx8ab3zbt8AExcndiW9t/VhZ6wEj70VFTZaGxQNOB2k5e5
        aC+ZpTQoiXcKyUkqRW2nxY1Y4Hmq
X-Google-Smtp-Source: ABdhPJysfragYbTihcd5EuVMIl48ya3K9aszbRpyiRPGqPCxakW0/aAAbk/O2vflOG78j0LnTsu+Vw==
X-Received: by 2002:a17:902:a505:: with SMTP id s5mr1129099plq.20.1591755804533;
        Tue, 09 Jun 2020 19:23:24 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j12sm11145939pfd.21.2020.06.09.19.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 19:23:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: clock: bcm63xx: add 6318 gated clock
 bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200609113049.4035426-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <add637f5-2ab8-5aa0-a36f-dc221624fbfc@gmail.com>
Date:   Tue, 9 Jun 2020 19:23:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609113049.4035426-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2020 4:30 AM, Álvaro Fernández Rojas wrote:
> Add BCM6318 to the binding documentation for the gated clock controllers found
> on BCM63xx SoCs.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
