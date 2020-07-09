Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9571C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F2F20672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594335709;
	bh=hN6QIvbQztwLKcD9XrA0l4jVZB2qrI5lz+q7bVAULz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UOqX5c3Qjf0ZdNSaX4cfN5N6wZbpCgP6xjpFfePGvBEs26h9amqZrubObus1eC+ok
	 RlUpWPd/EFF+q3U2foAyTdFvcApCsk9r54ovzpe94Iojj6vJi9DZWfXwbWy7fL05U1
	 KHg1nd5DU9KuMVBQwhXoQxtjuZS7Jf/MTkUy5DOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGIXBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:01:48 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34266 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGIXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:01:47 -0400
Received: by mail-il1-f196.google.com with SMTP id t4so3506242iln.1;
        Thu, 09 Jul 2020 16:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9LyLZwIT1Tmr8hoOHUcIhBbsWHFqoFhPBb0XwVuwXiQ=;
        b=VI6B9P4jBgmrxLumZnTKzhe0SNvMzHeDplja2GUShO82aI45InIRX17hoa8czdzHuq
         jk7VRSxWRCMgESxUrICg9XsyzUPiUN7lJWwv5zV7USRd6S4BH7h7tfLQ1P7VDyXlD7CP
         085GQ8ecy/UPffOVK4GMQItJlYECHKmHEoyQ1FeAvUAEyalh1YKm6WNONbAyH5kvt7QW
         iMrvoi72hFjIbWokIimu1Yqq3x9vRgirHqG538XsQIaFA7HTlT56khbaLLVyYAxWOR7k
         4sQ4jV9n1Qp6aed/bY4TpVVNUPT6VlKycpZe3hYEFwIDp8ISD7ESNP1/lORyzcvFIyuy
         TKhg==
X-Gm-Message-State: AOAM532vJwodWAB9zateqBu7xa/FXKph8vdnD3G7ROnTYEv26LmRCaLc
        9b27xu0ZxqnnnD+sOUR9Pw==
X-Google-Smtp-Source: ABdhPJyFvJ/g6/scOhXaZDnhFMuXx37vLAx8Q2m8TIpc14eIJDuv0hQ7JlMf0TmAmHFL2IdEMnlwKQ==
X-Received: by 2002:a92:cb03:: with SMTP id s3mr49942616ilo.1.1594335707291;
        Thu, 09 Jul 2020 16:01:47 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m6sm2701349ilb.39.2020.07.09.16.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:01:46 -0700 (PDT)
Received: (nullmailer pid 1054096 invoked by uid 1000);
        Thu, 09 Jul 2020 23:01:45 -0000
Date:   Thu, 9 Jul 2020 17:01:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, zajec5@gmail.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, hauke@hauke-m.de, jonas.gorski@gmail.com
Subject: Re: [PATCH v4 5/9] mips: bmips: add BCM6318 power domain definitions
Message-ID: <20200709230145.GA1054020@bogus>
References: <20200610171630.465579-1-noltari@gmail.com>
 <20200613082140.2009461-1-noltari@gmail.com>
 <20200613082140.2009461-6-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613082140.2009461-6-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jun 2020 10:21:36 +0200, Álvaro Fernández Rojas wrote:
> BCM6318 SoCs have a power domain controller to enable/disable certain
> components in order to save power.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v4: no changes.
>  v3: no changes (patch reordered).
>  v2: Add BCM6318 dt-bindings header file.
> 
>  include/dt-bindings/soc/bcm6318-pm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/soc/bcm6318-pm.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
