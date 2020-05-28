Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E460C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40185207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590633847;
	bh=9dgBup4XYqUy5QRkh7OvtNISD9cQqOy76D6lOLLAZrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cN0dRPZrxVqs91YgMKKwU1svbxEsIR8JWGw9QrL3N30qLrpwoY9zDWjxr4FwDkC+g
	 I7DkVyiadMQE2sd4yGPIOCN/Ht78T6ObSbvBRDDJVjKNvA5DAllhL303vDTSYn9MX/
	 pQBdM+2RMCtjKzZEFqb/Uf4qyj+NXPYrkLYImY88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgE1CoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:44:06 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44634 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:44:06 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so26120991ilk.11;
        Wed, 27 May 2020 19:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9S08ihFeIRidZey2wpS/I0khWsWfeV4XOhtDvr0D60s=;
        b=rVLJ2BDgnsxKFEi7bPfXaKmJ8+ZGNMXslsB3jjV0/OnTFWx9sauc4RzWeu59S5gwCI
         dVHoy1Y71rP9oim7cV5+djwCAjdoaUDHgx01V7A1UGuS4ngH0pDm5s5RxRIl2RwOykCe
         xfuKGbQPXd+FB9AfIu75l7vab7BU97ntNXXDO4+TEHs9+qbXzb28wOi9llq49V9jpl57
         dIOUdKiHO9m+zIbuNEU3cK9ff9R5jcuBJUPhH7Ed7ZSFPiwh9LBnCkMOkvIQzup82hED
         EHpeZLuhxQVl83wbtdlkbkIQUe+pNNiar7klxREOR4SYMaD12xeTRRh2HMliftmDl0Ri
         YeVg==
X-Gm-Message-State: AOAM531JzK19FOTVy62a6CZGm6ij1D/fQn4DYIncSP8Xxgy/Q38uOoAH
        uR5DVOCQrl2EAkQT+h5Kow==
X-Google-Smtp-Source: ABdhPJxlR+HNBwpJelsLXL6xPGuvjkY36V6RbtBEdpOzZ9/E9af8LFD7Q3J43Wp2818emBNbgF8l0Q==
X-Received: by 2002:a05:6e02:503:: with SMTP id d3mr1108450ils.208.1590633845579;
        Wed, 27 May 2020 19:44:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j17sm2430785ilq.79.2020.05.27.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:44:04 -0700 (PDT)
Received: (nullmailer pid 3264044 invoked by uid 1000);
        Thu, 28 May 2020 02:44:03 -0000
Date:   Wed, 27 May 2020 20:44:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     a.zummo@towertech.it, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        linux-rtc@vger.kernel.org, tremyfr@gmail.com,
        p.bruenn@beckhoff.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Convert MXC RTC to json-schema
Message-ID: <20200528024403.GA3263935@bogus>
References: <1589436805-22923-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589436805-22923-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 14:13:24 +0800, Anson Huang wrote:
> Convert the MXC RTC binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-mxc.txt  | 26 ----------
>  Documentation/devicetree/bindings/rtc/rtc-mxc.yaml | 59 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.yaml
> 

Applied, thanks!
