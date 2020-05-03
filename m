Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E92C47256
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97493206EB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588521313;
	bh=EpPCIOKt3AtZBuY4gE8SjXaHM9fIc3fZUMoqA9uNNRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BqnHsoFD+s6Pp66f0A5iTK0JODXKglm7nP7/dm97p+xiyVL3aq5kdYPE7ok+kqEhg
	 W4v2FTRVww8w41smjlkRUea1yqlWJ2k857+e3Ptrw1lDBMjIkPG6EbXbqvcCV8Grr9
	 zLBxzn8XhQ11G2HR6ZF9Rl1FKYnwD0ohjZ7I5iME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgECPzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:55:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37281 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:55:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id r25so4463841oij.4;
        Sun, 03 May 2020 08:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtiFnnVOt7u/0FyAShytRgfaLSPAVTpaCIgPOD2FazY=;
        b=bke798D6c14KRqdjMa4Tpk+7QFlbUHUb039lBQrtn2TroNPKeS/z+N6JBo/Jt/HwVK
         pC2kuAzF8EK5r3swulsbl8zBg8uMWU1JtIrXpGNopk/7yiE2vLFImJZmV16BLG+l7F8S
         QZycoTLrsQx/GUoW29FUx3VmD1LxYETbXvCMbEi8pKvTnf2PZvtzAfTcSNGektKQt78i
         K07iH4EDxsMDv/1DTUFejRW4seWbWDbVHLumgobYpq5u8E2iL8c1qHZy9DmUM5ipQsTu
         SR+5wb7ejrsBcoaA0+p8ayVRXOVyhhuTUygy/uVZgc46h+Xf+Ru6o4S1Eacb8KxI04t4
         JDqQ==
X-Gm-Message-State: AGi0Puby7/lHP/MFeKltpwM6tzHpnNe1Gk1VIkegpUjzM4ATrKI75CPo
        JBU2zzIAOf9Rn+rIXr7dySmX3Ws=
X-Google-Smtp-Source: APiQypIgEGOwKeD5ETtDgqEozeKWVNtXZT1WJEmXRXwGBcZqlAyhhYnFolZnWGpJCJZAxVWA1zP8Tw==
X-Received: by 2002:a54:409a:: with SMTP id i26mr5993529oii.50.1588521311359;
        Sun, 03 May 2020 08:55:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n38sm2474847ooi.21.2020.05.03.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 08:55:10 -0700 (PDT)
Received: (nullmailer pid 19629 invoked by uid 1000);
        Sun, 03 May 2020 15:55:10 -0000
Date:   Sun, 3 May 2020 10:55:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/8] dt-bindings: sata: Convert Calxeda SATA
 controller to json-schema
Message-ID: <20200503155510.GA19595@bogus>
References: <20200430211054.30466-1-andre.przywara@arm.com>
 <20200430211054.30466-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430211054.30466-3-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:10:48 +0100, Andre Przywara wrote:
> Convert the Calxeda Highbank SATA controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
>  .../bindings/ata/sata_highbank.yaml           | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml
> 

Applied, thanks.

Rob
