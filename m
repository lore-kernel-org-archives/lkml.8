Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FAAC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA822063A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586020854;
	bh=40WpbGwAN0WiwlLDs4CFF9djZrFIaaC4QkT8nVOC0BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HmzOMsNGGWJb1A2WSrDfl3VWtQT30h0zfjHyTW2phNglwtdURXSruJGd311B0V2dK
	 7Ar34lJv3pwpLVSFSBmZcpr5RIMHJ5TYPASfbba0w1xinybSPI1A/mLiM8p6KhYJAy
	 DfADOpvsVIT6bd819FdHuSec+aNjvSrejs00Lr/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDDRUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:20:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35202 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDDRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:20:53 -0400
Received: by mail-il1-f194.google.com with SMTP id 7so10607988ill.2;
        Sat, 04 Apr 2020 10:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKQqfFLrWC9wU446xOFUiOzeLBJC9J0I8BpHyK90qRg=;
        b=pfzRHBKoanUB8zpUphlbqkkLpQ5N5QkW05NuXnrNeP9ZY/zFBQQYJt9gAFI49bQtYt
         gC2rOTwOTItz1EGuMcSlBa5vROkaUtQVulmYUBz1Ypn0xmIvLzgMA6RIzFVqtRLKTeJy
         q3rCu4YP7IgG9Ek5STovIG57v4q9/H/BRrDt5D5lMZs94Q3c9eLUJodRMMKMblQtMEyE
         1rPxTiktZqtBf8JOjOy1BTWnwFadkE5KCn/qltijKaSeVLBreCPzLIyYIirOx8jJ7lon
         n363qSP6yrBnOasxVCVHTQAdp5zE5Aqfa5xKUeQhMiErgpkgM9pzyU9GiuWMLA7AE5VK
         EnTw==
X-Gm-Message-State: AGi0PuZYcAV09vymwImjwmFPIej0Y/q9CSQWu5ZBIolH95uQjNNkf9zI
        9AWrVzFSsrbzu+/LjU6gtQ==
X-Google-Smtp-Source: APiQypLdRpDCBU3mc/Sp7WlbLkhX/tB6DU85rWpfeXHQ8j7oUx65QtgEHgFQpAec5Smx8y+Ezl0+iQ==
X-Received: by 2002:a92:48cb:: with SMTP id j72mr14218395ilg.162.1586020852230;
        Sat, 04 Apr 2020 10:20:52 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y6sm4035926ilc.41.2020.04.04.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 10:20:51 -0700 (PDT)
Received: (nullmailer pid 27481 invoked by uid 1000);
        Sat, 04 Apr 2020 17:20:49 -0000
Date:   Sat, 4 Apr 2020 11:20:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl:
 add the Amlogic GXL and GXM Families USB Glue Bindings
Message-ID: <20200404172049.GA27426@bogus>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
 <20200326134507.4808-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326134507.4808-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 14:44:53 +0100, Neil Armstrong wrote:
> The Amlogic GXL and GXM is slightly different from the Amlogic G12A Glue.
> 
> The GXL SoCs only embeds 2 USB2 PHYs and no USB3 PHYs, and the GXM SoCs
> embeds 3 USB2 PHYs.
> 
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 73 ++++++++++++++++++-
>  1 file changed, 69 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
