Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EACCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8E20776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592425880;
	bh=B1YJNVezz+4ZMGoHs4RXcOFqtzQ+8swirTSFOqof3qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O2sXr/kzkTEtxafnCkqcdgFzOhOCvA50l4zCVt5HXgJYoG1BliKW9A1cBJgS0jOxi
	 4Piroiv+My8b4yp9Nux4/rgbkSCW9Du6W4FXF5hy1Mdq4lvV1nDATlQ08KcX1DkmH8
	 auPPjRrZVS8KZGOlRXipw0TcTEqcIqmRzQG4+pSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFQUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:31:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47009 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:31:18 -0400
Received: by mail-io1-f65.google.com with SMTP id t9so4449006ioj.13;
        Wed, 17 Jun 2020 13:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBXYSk1/ATYeub4n9kMvAH2hmCPII0+QncDRP+7+Htw=;
        b=bk65cOTNA43Ik1iHnbZlK7AuKOUFauOyqGDG+1JnsCzAFxz9vtZ6ZSbHVd+zS6I7Rm
         TjpIvAfq/r2CrfriJZpD70WohnQNRLmxx/MePr4z+mL8p9/tX1FKG4NTw/99noHo7+ep
         kj4I3fJcUFR1p1DH1OJWtY6zIbeezkjdpeLByWmbE5IYcEdJhQiwTM1oHK8SIMeszQNV
         k1uiW/b2C3MkD8odV32SYqVgXqjCe4m5x9Teg9F6M5RBpqwAPzmg5q/8tQ14eQi4ZJ7G
         T+ffCEeSX9RHoWkYDrFqh4iRPRrfskq4DVlFcxPH8anOJdQAL8GK//pSXOue0u5PDSJa
         uZJg==
X-Gm-Message-State: AOAM532UOxHdLKyYexu2N8UaK/ZdcnLNqn4MZDYF5eYY2td0naIT0gU4
        0zwCXG0ykFNwM6VESPlxvSx1WY048w==
X-Google-Smtp-Source: ABdhPJwJ3J48mh8YLrWWaH382tu/CTB8ZZ5/9hfRxSeLhpiWZor9+iKA/OgTvoX4RkqqBCty76mFxw==
X-Received: by 2002:a6b:1785:: with SMTP id 127mr1302084iox.136.1592425877505;
        Wed, 17 Jun 2020 13:31:17 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h23sm485548ioj.39.2020.06.17.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:31:16 -0700 (PDT)
Received: (nullmailer pid 2740358 invoked by uid 1000);
        Wed, 17 Jun 2020 20:31:15 -0000
Date:   Wed, 17 Jun 2020 14:31:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200617203115.GA2740308@bogus>
References: <20200607175812.95777-5-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607175812.95777-5-tomasz.duszynski@octakon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jun 2020 19:58:12 +0200, Tomasz Duszynski wrote:
> Add SCD30 sensor binding file.
> 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  .../iio/chemical/sensirion,scd30.yaml         | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
