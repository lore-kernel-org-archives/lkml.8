Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3D1208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693958;
	bh=UjvpnCH1TW642Ry0Dh7lLMyGwaXDEjRGBT6p0LlBVyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tCVlE/NZcDSWgYSzhH9aKo+ZYqOy5WFVwIivy/pflpnAjDeW1Tx0G+QyMSGbA3w7f
	 UuFLh3FWIyArJ7JbFK3PHrOidcmU6yFHrM2k3H/Wo3XFlsG8bn9ta2cQd5PejhjL9P
	 qw6Rqs5QpCkl/5jo9ragBHwIOZJRy7TzYCHH+qck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406544AbgE1TZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:25:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39292 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406229AbgE1TZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:25:48 -0400
Received: by mail-il1-f195.google.com with SMTP id c20so36907ilk.6;
        Thu, 28 May 2020 12:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4Ebh30dLah5nkQFHP/HqHWiN5d7yYnU+hWm8jxa2y0=;
        b=gEFxxyql6uKy8ZP5HAr2TDU6yQ8JUc7hKU621zZ1cVGXHYsW53TcYAhwbYigITdKWU
         sdXCAU8xBEXGKhvKs36lhtvwrBnvPLrE3y7rEZdoOHBmBOXMLLoz2rZXRHv7oJNm9mo5
         PAmkT7hMNMnjy5G9gmA6USbd4PzB2tpRS4Ll1nMJEwPfYeKErRyvRzvA5gbSKU8H0c8A
         zWZZtsbdhUrAmEcZSsi9efVV4b9brlEjySttfqcHAeYElNje3zFROaVRttxBZ4UG5kSX
         nONQUiQ1SodWr9s9JCNzphB1dI/sl58wjX54UD0c34mo5FlJtfUUEQMyTcQlhgaK1bPC
         EX+g==
X-Gm-Message-State: AOAM5332p04w3s3hoEoeMmzSsSeDSFGbTJHUrbamS0tDlNhg7aUVgLW1
        kqBguElxsgwtt1RR/gSQaA==
X-Google-Smtp-Source: ABdhPJz8bc1NW1uAdeop8kTE6ez5Rat1YgGQghwLnLUp8ofv7myFJ2um0Nw6ppAWwfwc+BvKgELr3Q==
X-Received: by 2002:a92:3a81:: with SMTP id i1mr4321823ilf.234.1590693948047;
        Thu, 28 May 2020 12:25:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f1sm3673347ilh.17.2020.05.28.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:25:47 -0700 (PDT)
Received: (nullmailer pid 538157 invoked by uid 1000);
        Thu, 28 May 2020 19:25:45 -0000
Date:   Thu, 28 May 2020 13:25:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: PCI: uniphier: Add iATU register
 description
Message-ID: <20200528192545.GA538082@bogus>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589536743-6684-4-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 18:59:01 +0900, Kunihiko Hayashi wrote:
> In the dt-bindings, "atu" reg-names is required to get the register space
> for iATU in Synopsis DWC version 4.80 or later.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/pci/uniphier-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
