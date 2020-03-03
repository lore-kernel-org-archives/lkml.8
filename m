Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE720838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583245771;
	bh=3MR04Xav1gqBn5qSWHpAX5yo6X7wTkmvPFUqCLIFQXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UpIpiWMj4tFxYB3sd3K4hyGe1+0zK+tEZ7DK3WCUEMAHDjdpG4gegkqgGtoFXB9fK
	 FOKlM1uCYQyr+zBLVl9XRh7Zp9ddMLT8sjVCfLXkJucz8+w4mLKblmOtAwNVv/gcrn
	 kf1RH428Qos1wnkW5jrN4hiZDYD6az3e9WFZOi0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgCCO3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:29:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37386 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCCO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:29:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id q65so329301oif.4;
        Tue, 03 Mar 2020 06:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sxXGPCpiiQ3NKqYM/EkgYrDujePt7SEpyxP3AujfUFA=;
        b=ApVw9gM5l3HwJepUg9gsuoG+vcnV1TaJV4nmphLevYKOewM8f4FOvWLeudKvSesLgy
         3RWsayssfVu/px4ZE0RnG6n9W5+wuLgyC8u+G5TvBbbuILqvY9gQcH5/JVFKhw2wb92n
         BzoR2VZmW1ab2Hj5fNg2bNxxSmqylqA2y9jRd4y3T3F7mh0o3wcDfH+UAk/i1bDHov6m
         FlhuyMpnSOXmWxZzaQapPDbuCi7MqBSa97ddqhbacY4FptO3qQAYF78R9LP8vewXTQkd
         PUJdaE/qUxmPlzK1kzh/I7liHKBeYfrs3cpISFoA4jxdsvMdzLDiYvY3uf+ts8YTVJJN
         +pIw==
X-Gm-Message-State: ANhLgQ1AnqhnRlHAEeNBKVKluL8hH6ptclf17SI0avByKSm8aNmW6acq
        vrdzY6t9fJCBrVE5JJoVWQ==
X-Google-Smtp-Source: ADFU+vujo7i6Ogir/XUOiCRLS7rCiYKP5e3/neig9vho1p99qwZ4dRON5loaHvGTrbWgOlyo6BgFTQ==
X-Received: by 2002:aca:44b:: with SMTP id 72mr2602805oie.67.1583245769918;
        Tue, 03 Mar 2020 06:29:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm7681332oie.18.2020.03.03.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:29:28 -0800 (PST)
Received: (nullmailer pid 22368 invoked by uid 1000);
        Tue, 03 Mar 2020 14:29:27 -0000
Date:   Tue, 3 Mar 2020 08:29:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io,
        Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH RFC v2 1/3] dt-bindings: Document shiji vendor-prefix
Message-ID: <20200303142927.GA22307@bogus>
References: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
 <1582727592-4510-2-git-send-email-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582727592-4510-2-git-send-email-nbelin@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 15:33:10 +0100, Nicolas Belin wrote:
> Shenzhen Shiji Lighting Co.,Ltd is a LED manufacturer.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
