Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FFC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885AE20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589223421;
	bh=aME7cALOfczDam2d7yr89y3S5+hgQfoKtR6HBhsPlR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/ZNUVTlK3QCzAbBuXrfYeDfHIya+WvPWTtd51uotOFj4YMfgL1Zd+reHlJt8e/ZZ
	 vwAoA+4DWp4V6f//QlR4l5HwxApfZXK73gAvEDeRemqN4ouwUj+a0S/e1Dc13/TWAK
	 Vkk8dA+lZYWkB70x9uLklp7eb+5RJZbnV1UpS3GM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgEKS5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:57:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33694 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgEKS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:57:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id o24so16055604oic.0;
        Mon, 11 May 2020 11:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIn25vBi82IOwahM5pBiB38UosZt4F/Z2M2+HzBSDZ4=;
        b=qFmxwy1Xz6PtjcP1TZypsF1esd9FH1eJfOrFvp/k8iGJHYJClrAsQyoNvjafSJmwq/
         1EsLUT37O/bRxg5RL0WNtPeY8ccUrfX7v0w7732GgyUdUROmgPVnlQnKBg9+mAR0z+Mh
         Lr73t+6lEln5APyWNIUgujz2u9dqgd/1o/pSlU2vOAa80ap9oQDN0lNbWvM0JatJzLp2
         ElU2kyNA7E7CJTGG2ejzmQxQgqfQPswPjaLJqY2B5OoZ/sK4AL5oAGUm7DyThl6VkU3p
         7SSVG5RXHrFUKdSdZSkouq1nR0FxwRDFkE6Rr4O3NRca7mvTDb4TwhM05bee4ehmiLaz
         8CUA==
X-Gm-Message-State: AGi0PuZl9yOOnmNzsTjjTNvPleeeCO+Ax6zOo3hKlMTJTn5axF/ybySb
        FRT+PKcJTS2ZOqnatAS7nqKA3ik=
X-Google-Smtp-Source: APiQypKUJXiJDpd8lpqc1m/Rf0pICBB2aUHxHx/w7KltA8pYYnkSuq5OQKc/RZp2TaGVNnEtZWtLmA==
X-Received: by 2002:aca:6705:: with SMTP id z5mr20071285oix.122.1589223417936;
        Mon, 11 May 2020 11:56:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k8sm3034534oop.30.2020.05.11.11.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:56:57 -0700 (PDT)
Received: (nullmailer pid 2278 invoked by uid 1000);
        Mon, 11 May 2020 18:56:56 -0000
Date:   Mon, 11 May 2020 13:56:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        festevam@gmail.com, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, s.hauer@pengutronix.de
Subject: Re: [PATCH V2 1/3] dt-bindings: nvmem: Convert i.MX OCOTP to
 json-schema
Message-ID: <20200511185656.GA2102@bogus>
References: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 22:09:39 +0800, Anson Huang wrote:
> Convert the i.MX OCOTP binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- improve compatible;
> 	- drop clocks description.
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.txt        | 50 ------------
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml       | 95 ++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> 

Applied, thanks!
