Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9053C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B226B206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589232179;
	bh=CNeGzBWdZD1DH71TfAh0IYvOu2W40xVYRv1KD8eZjK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1mC6EzjUVIJ1mV9GdikKGpBvHvNbdLdqdbXeCjEMSSKlYAGvD3YXg8bNDAlkJvVOs
	 z7gnhcNX+2/JvLlcas0YSLTOx2yadSGO8d+IrJW9Ng7E9A9SAme9YokD4ZmqRi1DnC
	 aW75JD2nRa/qelRiCuw9TyLpWFxFkdR8iKQKYFqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgEKVW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:22:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35430 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:22:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id o7so16439294oif.2;
        Mon, 11 May 2020 14:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Mkg8V+JoQWX2B1DM8yjs2lSLyhIKdykuN4gn3x5ifk=;
        b=tpKfCEYznj6Qq2RnxAGFUf8YYJWQ+NHDIhi7Pyhp5mY2Ul2O28DGISEJkZMU4vQmE3
         +o9xdtEhlr4p8IYYcWfbXG0au/N7xk0jropT5I7HbhholiYXEbq67NZHIW3K1XK+MBTz
         bb6t+nWAkoRL5+/zg9J5uGT2E8nunjbOhf4lo0yRflwXkh+weABg/aWN3PMHL15xbCG5
         Nt+/7P/UrXj0zIuKo9thtvZuL4GqmKsq4AYcS6IjXBz35YJX8SX/bEPHvmI9268GjC9T
         rliU6jkf4WiJI2RjYgrMRUDP+ZXKBIm+dfQjxGzpao9LLLniUW5wdaB9ZCfIwuyBnSEM
         1/wQ==
X-Gm-Message-State: AGi0PuaT7VZf6ys+7ZXhAhOL/70g0yLi9v4VUeoX+RiWQ+JZ3It6UvB5
        2hsdhPX9C9Dh8UrMGKwajg==
X-Google-Smtp-Source: APiQypKK2ag6IZ/ioSiXyqFVnRS0KNl0xbPPl20EbtjPgyv/rgbjHbchQHheBVTK8FGO/hArALam1A==
X-Received: by 2002:aca:ba05:: with SMTP id k5mr20580338oif.35.1589232177745;
        Mon, 11 May 2020 14:22:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x129sm4973259oia.50.2020.05.11.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:22:57 -0700 (PDT)
Received: (nullmailer pid 2674 invoked by uid 1000);
        Mon, 11 May 2020 21:22:56 -0000
Date:   Mon, 11 May 2020 16:22:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     broonie@kernel.org, daniel.schwierzeck@gmail.com,
        cheol.yong.kim@intel.com, linux-spi@vger.kernel.org,
        chuanhua.lei@linux.intel.com, devicetree@vger.kernel.org,
        qi-ming.wu@intel.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, hauke@hauke-m.de
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add support to Lightning Mountain
 SoC
Message-ID: <20200511212256.GA2510@bogus>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <1f447a5ab8fee5bc9116ba70b0344193c9c6cc06.1587702428.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f447a5ab8fee5bc9116ba70b0344193c9c6cc06.1587702428.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 18:42:32 +0800, Dilip Kota wrote:
> Add support to SPI controller on Intel Atom based Lightning Mountain
> SoC which reuses the Lantiq SPI controller IP.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/spi-lantiq-ssc.txt      | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
