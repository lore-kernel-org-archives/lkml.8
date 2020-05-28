Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E66C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5A02074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590699295;
	bh=fdwBsBBi2gph+b4Rn35p4McelgK2p8QTmaFJ+CG8FWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cksHxFK5RntIJtsR5huoIKwfZ66mn8S68KCZxS4xOZZZ/rLK9NjKasrNsZloodXmv
	 12WJRHfdoOmbrPQLY/wbKKsTurabKsUK144KKHb8Pj4ooTrx4dYIsi2nj8NRn/fBYh
	 OuXDKZpRkHuarwxJyZHEin/0/u9zoLNAG8VXe64Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407404AbgE1Uyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:54:55 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36928 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407319AbgE1Uyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:54:51 -0400
Received: by mail-il1-f196.google.com with SMTP id r2so344613ila.4;
        Thu, 28 May 2020 13:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F7XQzSdkLERxE1acZynKbz0LO6ZEk9eeYt7e0P7o/i4=;
        b=fsoxEmoNBRR+/Nxyj85Tkuz1t6sQD4fPaAuDNZX9mISBcWqYABek2dB1anCsd2zOtW
         k1I2ZgXDoEpulE6hOBMpbE3Zzoq4W6Q7e3ra0cuBXn9JUtumHWDR/2p1H2KAFzxZP7E/
         17b1/IH4tMzedK2S56RXFT7p4Go2i6i5Ex9oIBswu7dD4UlScFIQnwYL9e+LEE1cHxnI
         Y+9zhtOvUmyFVf6lOKkg2jvb+3wsHnslNXatfLk4h/DmFDhglOsK7Dckw6pdgYLBz8+S
         DhfTagaTqMUEcKRIFSRK56tlHhP9k7JMYt5XV9u7+6bRqNCh9Nqler9dVX/tSYkPVW38
         9naQ==
X-Gm-Message-State: AOAM533Rm7ogtYFxUj6YhQL/Tp+aW3jOKrNQzmSYRg0kIgHkD728lIl9
        6zKwwsqDaE7ERKVgMbUc7Q==
X-Google-Smtp-Source: ABdhPJwJ0d29vn4rlFs/ok0iRsHB+WCre4sY9IDtIjo+Gy98OKVrQLZryjqhEtVfFrk6ImB9DOVB2Q==
X-Received: by 2002:a92:c809:: with SMTP id v9mr4494438iln.209.1590699290028;
        Thu, 28 May 2020 13:54:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y19sm2957545iod.41.2020.05.28.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:54:49 -0700 (PDT)
Received: (nullmailer pid 658956 invoked by uid 1000);
        Thu, 28 May 2020 20:54:47 -0000
Date:   Thu, 28 May 2020 14:54:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        festevam@gmail.com, Frank.Li@nxp.com, mturquette@baylibre.com,
        shawnguo@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to
 json-schema
Message-ID: <20200528205447.GA656972@bogus>
References: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 22:52:34 +0800, Anson Huang wrote:
> Convert the i.MX7D clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Update maintainer's e-mail address.
> ---
>  .../devicetree/bindings/clock/imx7d-clock.txt      | 13 -----
>  .../devicetree/bindings/clock/imx7d-clock.yaml     | 64 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.yaml
> 

Applied, thanks!
