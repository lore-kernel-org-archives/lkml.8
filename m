Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA5C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585602328;
	bh=rdBN0mXNfj+Lz4ouGnYrYZbdJTKlhiV4h48TGhnFwO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jnIyIiq3QI0aSZiQYg2wzXDg9b7OZPavy39hdy9ZIL0IAKuYOTlYMnr3Ogju/5EB
	 kfgiBol8+DCE/KwsN1f3SQikWHgdgSgTjYVqct7T7XDrttiXvHWgHmcoV8HS500MX5
	 OLkbwrBlF3TEMMWrRoe1VZ2kh87jd23yfGwjtYaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgC3VF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:05:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33367 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:05:26 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so19420567iof.0;
        Mon, 30 Mar 2020 14:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tXDSX2PzFc8lPZTxH+CtlfEjScfEVePQ1OA7jnYYW0=;
        b=tz/q7X5sLJ4aRE9kx+H5YtWeFUvxv5uSS3eWma+QqHiHAi7BMNspEHDdZRAGjPOLKk
         gWSKjeqWul7MJnnoWYjoyc/5zEPUovmDqiQyqup8fav3sPP3PDNA5oARY14gokKIsgc1
         sRbD8T074iqJj+XdjLtk8swMK2e510s7gaIK5pb+VtGnVf/pvnDLbS3vkb6N9VFAx8kD
         6gQZiO95j4xwvFqJE1qhbysKjLk460QPMJFIavuWL4RF0n3KrFfni22JlCgr1+k3a3Br
         3nqIC/bAQtHktwbfiiAOTixUZlOzOQRkyQDFhrT18DG4jxOSS0otpmEeTqMJmKT4sgy0
         swsQ==
X-Gm-Message-State: ANhLgQ2d+sn1xdYIdvbQzXe0x5aReicRgCbP6RPuMd3yDyfVAVxqKLT1
        vwoS7kbhVFPiwvFOzIrKEQ==
X-Google-Smtp-Source: ADFU+vsLX1L/PYCfqYAzFfBxs3g5Uc1emhP0yS3eiAGhtCUDnoasD+pUie7FL2kBzWtLetFrY7W+IQ==
X-Received: by 2002:a6b:d609:: with SMTP id w9mr12335400ioa.41.1585602326068;
        Mon, 30 Mar 2020 14:05:26 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l65sm4314953ioa.1.2020.03.30.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:05:25 -0700 (PDT)
Received: (nullmailer pid 7500 invoked by uid 1000);
        Mon, 30 Mar 2020 21:05:23 -0000
Date:   Mon, 30 Mar 2020 15:05:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dan Murphy <dmurphy@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/12] docs: dt: fix references to m_can.txt file
Message-ID: <20200330210523.GA7429@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <db67f9bc93f062179942f1e095a46b572a442b76.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db67f9bc93f062179942f1e095a46b572a442b76.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 14:10:43 +0100, Mauro Carvalho Chehab wrote:
> This file was converted to json and renamed. Update its
> references accordingly.
> 
> Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>  MAINTAINERS                                            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
