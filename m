Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6442078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592237388;
	bh=y2mDqtL28u7c4GVeiXXe7rwaVgAELY4epCSa6Dtiaco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GjsCkL/3BAGpPEJYqhpadqWHKaFEGKReZiWpwPFG09WxDojS97eWNi6bR4iD2nMMe
	 Myh2pMn9+uCwWoHN+0ngiBbJsK5mRbOGVq5q+A+URfRDzaZeoE17haC5NrCFZxJ7LJ
	 /v1dQBVzV1Bqa7r8hCJ8IIika9FlUD2f1j6rxQeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgFOQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:09:47 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44506 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgFOQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:09:46 -0400
Received: by mail-il1-f196.google.com with SMTP id i1so15772635ils.11;
        Mon, 15 Jun 2020 09:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nnum2C4PhSpPEfhThcj8nUToxxJitXHNbBnp8YsxMRk=;
        b=nHNF3at8lOny0OmnYg2NfU28goLlyMRmH6wSp4UN3MNXxEzc09/9Ixr8xi4VFEPwej
         E2IeG4tneHQ4NnVA/1eFqtvdFTcqRJ1GSTNU+t/vemqKL6UYiB05PJu/VN1syvwZXahp
         1fvrQPlC39HM+bDWXFya6fsXhPbIfhmDxfEyXdP6xeo+cbSBEC/m38w8x4ijjW8CUJot
         S1kQjISKtpzy2Xk5C0iXcr0iV7paQLjxR2eAICnIFFHZRQ9j2hKLKvgIajQIHCXk7Nue
         WumDedU4zL0UHgvhs8AfGh7qMH+CHgpYcWZSRuEJI5Rbx0pY0/eExwwVswWI86JskuKM
         Fw5Q==
X-Gm-Message-State: AOAM532AnbhweoAk/nPGV7tX7nAFhyDh/82PP+XgG29ABqHgFMKuvdE+
        Q4DpwqCGiPyqUC4F+6T4wg==
X-Google-Smtp-Source: ABdhPJw+XZZMbcw5q6e9ZPoHyfPayYNgKmpC2lmw3amkyFocbJjFVs0xj6wgLmEd9xyiUTfpovFVMg==
X-Received: by 2002:a92:c6c5:: with SMTP id v5mr25902857ilm.1.1592237385404;
        Mon, 15 Jun 2020 09:09:45 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 13sm8260749ilg.24.2020.06.15.09.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:09:44 -0700 (PDT)
Received: (nullmailer pid 1861367 invoked by uid 1000);
        Mon, 15 Jun 2020 16:09:43 -0000
Date:   Mon, 15 Jun 2020 10:09:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-rza1-irqc: Convert to
 json-schema
Message-ID: <20200615160943.GA1861039@bogus>
References: <20200528132853.1751-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528132853.1751-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:28:53 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas RZ/A1 Interrupt Controller Device Tree binding
> documentation to json-schema.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Validation depends on "[PATCH dt-schema] Fix interrupt controllers with
> interrupt-map".
> http://lore.kernel.org/r/20200528132323.30288-1-geert+renesas@glider.be
> ---
>  .../renesas,rza1-irqc.txt                     | 43 ----------
>  .../renesas,rza1-irqc.yaml                    | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml
> 

Applied, thanks!
