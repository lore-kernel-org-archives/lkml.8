Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055EC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A4D2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588795672;
	bh=Nt0p1XAwElWlsnP8rsfXs4pncGj9jVnJPsHbNp+5TNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ntNiMPLqMM6PPaVIn8Csyg+7NkPDVWEP1zAh0ue28X2ryCZvMF2oIgEh5mQyM30HR
	 3EbzY6itnYjbeVG98zbFNaAZj3UH+tg1SHiXCrK5ZAqCclc5q+gSUOsC73EtWqW4vA
	 qqnM6QtJe9mxluk/okR7uAx9ChsQ6pdn0DlJEwFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgEFUHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:07:52 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:40603 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgEFUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:07:51 -0400
Received: by mail-oo1-f66.google.com with SMTP id r1so777144oog.7;
        Wed, 06 May 2020 13:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m//K22Duhst7MLLBowkL8H7YWW4DvGlsi4f3I8y8i0A=;
        b=Rox7UHtQLgIC6KW0D1bpRBWlRqw2gZjAiazOpnHfhm28YdA8gd5LVpew3h0YyBZUCO
         IwhKdXjoxbLs1KNIc7BQ9p8fE81cubjkcDxRRaLiw8BoNAZrfVtCzNy0WZs7mma9ibVA
         Tf0jjEGUqZU1SRpPy85bLmJZrOxoxR5eWKYypvC/zK6AXzalJkhN/aQu3DkEh23nPIoN
         R7h4rzOdfhXxAO1sGo5vaGdGLcWKx1QgWmM5OxNXOhBNBsaBRNcSJjVb50mwzTgmki0p
         Iu55sY84AveJOZxZvZWQ8Fjy58a8dFpJhEK02NkADNXUVCyuebbAJnYCx83UwhehobUh
         N5Cw==
X-Gm-Message-State: AGi0PuaiMihtNNmZA7pRQec6DXduxfo6YC9GAZ0koLSM0yuiAp2dx1wY
        9lewMCAl8rpcO6ISkhNSae1duP0=
X-Google-Smtp-Source: APiQypJG0GZkVXMMvIH0qOJ1vVRwc8oBzdFTSXt7YgCtCveVNkr6Z5mZ06vR2w6MBzufhOQoVl9k6g==
X-Received: by 2002:a4a:1445:: with SMTP id 66mr8623663ood.87.1588795670622;
        Wed, 06 May 2020 13:07:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm747801otr.79.2020.05.06.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:07:50 -0700 (PDT)
Received: (nullmailer pid 1918 invoked by uid 1000);
        Wed, 06 May 2020 20:07:49 -0000
Date:   Wed, 6 May 2020 15:07:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: power: meson-ee-pwrc: add support
 for the  Meson GX SoCs
Message-ID: <20200506200749.GA1868@bogus>
References: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
 <20200420202612.369370-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420202612.369370-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 22:26:10 +0200, Martin Blumenstingl wrote:
> The power domains on the GX SoCs are very similar to G12A. The only
> known differences so far are:
> - The GX SoCs do not have the HHI_VPU_MEM_PD_REG2 register (for the
>   VPU power-domain)
> - The GX SoCs have an additional reset line called "dvin"
> 
> Add a new compatible string and adjust the reset line expectations for
> these SoCs.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 28 +++++++++++++++++++
>  include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
