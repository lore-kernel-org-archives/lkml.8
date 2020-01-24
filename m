Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9458E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579874952;
	bh=QFpulhqs7BhwPzn6uhHuG/g25Qlt5GhN8GB8XRQmIbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aW7nJZRlaocawkMU596B9ayM/jVy16Vm+Qqgmo9J8U75fpaBHpVaPd6aMEWiPLftI
	 ZPIsE21ZhJ7FzyjmzzFhPY3ri9zAjiPbwMPLegdMwkhCToQh1DAeQaqysTMYjagFtN
	 TS/W9iwuWJ6SGo2GcJF1/WxIilOQRKhxAJdaleSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgAXOJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbgAXOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:09:11 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906E92087E;
        Fri, 24 Jan 2020 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579874950;
        bh=QFpulhqs7BhwPzn6uhHuG/g25Qlt5GhN8GB8XRQmIbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x+9GRFEDe/CZ5Egno7tT03tafQdhrpnnkDgdVXXLr4AA0itgSS5o+siUXhSdqU5t0
         CD4NTq5Mi/LTDl00BpdEocKXMMX5Hgg+pIgt0zm9kE76O0w4h0omAJNwgqto1v3iJs
         /PK289bU1BuH8u3OEHTzDhep/38Sub4qdQRG9VX8=
Received: by mail-qt1-f178.google.com with SMTP id d9so1542189qte.12;
        Fri, 24 Jan 2020 06:09:10 -0800 (PST)
X-Gm-Message-State: APjAAAV4jCgCmINVmie57kE2BY4ce+LxhuI31EqO/VzvgynnO6UvmoOs
        UDsNwiWiH/Fr8g7os3dhZq4NymtWadTMEip0Kg==
X-Google-Smtp-Source: APXvYqw9emwqw3XGNWzol/n1tHMUux0BStqaxT8MOP10X+Z7I4obcUr5hYArd029o57NsAJ4M/xzBjV3YF57vgHToNM=
X-Received: by 2002:ac8:59:: with SMTP id i25mr2279317qtg.110.1579874949719;
 Fri, 24 Jan 2020 06:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20200124105753.15976-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20200124105753.15976-1-dafna.hirschfeld@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Jan 2020 08:08:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7E6B181hYn_6yNE53Mf+jiQ+o6pGDotwGX=m+GysW4A@mail.gmail.com>
Message-ID: <CAL_Jsq+7E6B181hYn_6yNE53Mf+jiQ+o6pGDotwGX=m+GysW4A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix compilation error of the example in marvell,mmp3-hsic-phy.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, soc@kernel.org
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 4:58 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> Running `make dt_binging_check`, gives the error:
>
> DTC     Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.example.dt.yaml
> Error: Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.example.dts:20.41-42 syntax error
> FATAL ERROR: Unable to parse input tree
>
> This is because the example uses the macro GPIO_ACTIVE_HIGH which
> is defined in gpio.h but the include of this header is missing.
> Add the include to fix the error.
>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Fixes: f6f149604eef ("dt-bindings: phy: Add binding for marvell,mmp3-hsic-phy")
Acked-by: Rob Herring <robh@kernel.org>

Arnd, Olof, The above commit is in your tree. Please apply this.

Rob
