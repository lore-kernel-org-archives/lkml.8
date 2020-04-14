Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31C42063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586870958;
	bh=LGj3Qt8/4b6jvML46/rwmm7jZX7wSxG7VD3wLCkuQrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OkiR719OkuJCTTw4O24sgubbUIWSvuqcU2icKYMy8bWsJRQBYFmCjTHzDdsPKxF2b
	 WfQtEXbD+1xdi0MwZdZsn4eNcpx4qxkc0DdfbTbguzqf9gg5FWHIMaCqnaQA2/7R+2
	 nG+D9dYNMw2+SemNAVstcM7lsFCQTnxvXzZtiIXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgDNN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:29:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36899 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbgDNN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:26:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so5190555oto.4;
        Tue, 14 Apr 2020 06:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uBhOSKycNvwYl7l6E83n7sL5ut/2EC0wcW7rRu2+vgQ=;
        b=gAPCHNezv8kVntkHCkOFyoFDJD6U8cApb+wdwbHJtPqUGDRvYU/eb2ppq0xY84As5+
         lvTDWxHsd2cF5RumBIR1qxwky7PvC7HGCtD4T1a2a61/CIXvuRcE1n60nLE1ogRGIicp
         8J98wq0H+X6V2yAR9vh1D+EfIMmEbaibPjGhuCo44eahbV6O08wzBGPysHBLMds0zAia
         kLMz3s+mdXwo1nzMsx2XS6RllIlTg8rNgJG27xPeP51iHMpU2RN3Q4HOb7oRODXgXcbj
         bZai4XLrM4eIzCpBp8KwH/EMcI4IQPn4HbFfq/LiixS+8aMg1j9XC/MaoCdrtER1eu9P
         wgaQ==
X-Gm-Message-State: AGi0PuZhBfOaZJ2BshJjRkPQfM3RLfPuh9DsMTzg1C0lYFe3iPzP2R6e
        hvhsp67+ED9HpN55WFvcqg==
X-Google-Smtp-Source: APiQypKulh49diU5WYrDhPSyt9XOk4wDWnAaaQ7DGWExGEYwcWK2zN/uZk6o5BO0wBK0tmXEJhy44A==
X-Received: by 2002:a9d:32a4:: with SMTP id u33mr19357758otb.23.1586870804064;
        Tue, 14 Apr 2020 06:26:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t23sm5711880ooq.20.2020.04.14.06.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:26:43 -0700 (PDT)
Received: (nullmailer pid 15088 invoked by uid 1000);
        Tue, 14 Apr 2020 13:26:42 -0000
Date:   Tue, 14 Apr 2020 08:26:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        anarsoul@gmail.com, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
Message-ID: <20200414132642.GA13898@bogus>
References: <20200412020644.355142-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412020644.355142-1-alistair@alistair23.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 19:06:42 -0700, Alistair Francis wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/net/realtek,rtl8723bs-bt.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.example.dts:17.1-7 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.example.dt.yaml] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1269392

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
