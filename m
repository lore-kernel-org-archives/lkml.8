Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB8C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C276F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691392;
	bh=8n+Kh8XT0EZrnbYjJxYejv0op0bqH3mHIBCHS4nu/c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WaEGHa1pJr9x9QByc1t4te4efDe6jdLRTaEBoh6odGmS+qVTkWaqMOB8+oZ5Ig/dr
	 6qO0xFZIz2G86MK1gQJU+pmkyHfyVE6DvLdTPn+5tb+t77cn4F5lQqGcJjLlKko4mp
	 yr1Qp/9geUsA2Awvk3HXKaUKUzBaA0LW4tzagVjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgCaVtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:49:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36634 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgCaVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:49:51 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so20986757ilp.3;
        Tue, 31 Mar 2020 14:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGaSzuYBrzwb5Afzco535xjNeNm7VCR01D0e+KSHlBU=;
        b=gTneFJeCBSFloAJlZJlDtxRj3bW2AXRuMrV3hivTuEN9jFL7o6GuUnif9YkRGLcnCr
         MFg8p3WXk4SPgjTDrjS0fbF75kqSieyGZxiydG+qbAJjqrvCFdQXMSI/f5URBcin3WZh
         EzewSDfAU9ucpnjdvdELKuRocahNElwIFzWJSNSmrSQzXDwnWAjqySx29PSRk/rERJiD
         Wti2YWUpbZwma02otcv2FI1GeB4Ryll0zJNs6vDyirwfe4XVj/RQRi5ezxg+wCvCXdQl
         LsZAiLFvocwd8bsf86/icukiromC00VI6UKUNOH7qKstS0bfcs7J6M0P2agxgPCjeWEs
         5HSg==
X-Gm-Message-State: ANhLgQ0jmoIIjVVI/FZvGrELP4/31RZsP70ltRzXW+0XjB4lZrZ6w4ag
        Zm0GTpUg5w3wUnZp7eEhVMTNZoarkw==
X-Google-Smtp-Source: ADFU+vtLiLqlrFPVsFsHqZpYWIdxcsfYWlyNB3SkdVLs9VJv60/GvpmZRG/1ep91VBksmL/cQASE2g==
X-Received: by 2002:a92:d582:: with SMTP id a2mr16558293iln.37.1585691389269;
        Tue, 31 Mar 2020 14:49:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l25sm34133ild.61.2020.03.31.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:49:48 -0700 (PDT)
Received: (nullmailer pid 486 invoked by uid 1000);
        Tue, 31 Mar 2020 21:49:47 -0000
Date:   Tue, 31 Mar 2020 15:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, linux@roeck-us.net,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200331214947.GA446@bogus>
References: <20200325130605.2420-1-alexandru.tachici@analog.com>
 <20200325130605.2420-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325130605.2420-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 15:06:05 +0200, <alexandru.tachici@analog.com> wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
