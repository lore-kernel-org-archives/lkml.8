Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102BCC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D644D20747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589321025;
	bh=WF1ZOC7ddCOvDm9qPy5ZFh7ldSEKUGXz1ZFduTbexHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mc27qM8qmNkLZjEtJL6vxXiV+A9hxnVKVgkhux4Xo9v3IZ3M6j2B/CYXAkAec0Khd
	 n72u9CU/PZ85WQO6GhvYJPNZPj/W2DgQvLSSi6hP566wbWVK7R91lCK1PYOOffBHUw
	 1Zx/ACbhJ3hZTQfX8L/FtNGe8BpkGGFp/en6Lw+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgELWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:03:45 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36227 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbgELWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:03:44 -0400
Received: by mail-oo1-f66.google.com with SMTP id z6so2147085ooz.3;
        Tue, 12 May 2020 15:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsnWB/RZuG/6JISv3zODzhF3cX24dCFlPTbEBhn7oxU=;
        b=GbuakF+ugPaYSahW/kxfS8vYFTnOvfXMiplU9HM/EyrioEJh5ilPGlg8aqkJBYU0QY
         cZTnHcYT8aXoyxmqnX0LvSdFAKatXPaWyNcAVgOFvNaX1VJwaWqAlclSt7lRmr+bX+gi
         8A4Sgc8qQ2D9aoLwgnemI5WiOKzJB7tiUZGh4IeegP5V4wQAW/rgKHSvv3b/1RyQCcLe
         /Kix+iQVcUuS9DPXhEm7/ZIak0o9Z0v0tWAxReEHOwAknYjsj5/mwTeO7mXqU20KLCA9
         NjVp906erwAucnwdmv4pbapok3NpZdWWQ/W2EPh5WH7taqZy84GDs3CBk6srZ5SL74BD
         G8ag==
X-Gm-Message-State: AGi0PubLvtpqfjVmNMFaxVw6078GdbJgFRdF4QdWIAluQ7O/YIfiNSmJ
        wNCZIJJDCwEbbKcDuTpzPQ==
X-Google-Smtp-Source: APiQypLQGiX0rauKDDSSe0EY7yJ93FyTpXKE0zOptqWqXNeKHsfI9Bzl2DiMfh+5vOQd4k68p6Km5Q==
X-Received: by 2002:a4a:6441:: with SMTP id d1mr19963201oof.10.1589321023626;
        Tue, 12 May 2020 15:03:43 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j186sm5659962oia.31.2020.05.12.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:03:43 -0700 (PDT)
Received: (nullmailer pid 14161 invoked by uid 1000);
        Tue, 12 May 2020 22:03:42 -0000
Date:   Tue, 12 May 2020 17:03:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        vkoul@kernel.org, narmstrong@baylibre.com, kishon@ti.com,
        hexdump0815@googlemail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: phy: meson8b-usb2: Add compatible
 string for Meson8m2
Message-ID: <20200512220341.GA14126@bogus>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
 <20200502114752.1048500-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502114752.1048500-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 May 2020 13:47:48 +0200, Martin Blumenstingl wrote:
> The USB2 PHY on Meson8m2 is identical to the one on Meson8b but
> different to the one on Meson8. The only known difference is that Meson8
> does not set the ACA_ENABLE bit while Meson8b and Meson8m2 do.
> Add an explicit compatible string for Meson8m2 so those differences can
> be taken care of.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
