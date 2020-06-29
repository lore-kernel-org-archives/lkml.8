Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E738020768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465659;
	bh=jjts91bP/Hq1hxKr3KjlA2i4E5kDyOSrF2dPRE5fNeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+zQ99UoJKs0rUL4cPfixnpZSr/pRA4aFvc0EZ4d3DWdaOug6NHLsxgkTh4cWK7Fj
	 9/rYnaGhoKE8PLAvQQljHBIwQM61rlC6Tu8Tvt13wktBdNNA+fqP8BQRVrHaYEq0TD
	 o76t2F/mt/uqklvtBkZxW3ljgZRrc0UrJQRU/Lrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbgF2VU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34204 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgF2VUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:20:54 -0400
Received: by mail-io1-f66.google.com with SMTP id m81so18796676ioa.1;
        Mon, 29 Jun 2020 14:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nq/kHSVRzFcNw0IODBT+I/N6PwAl6jWjGRwKgSayGsA=;
        b=hI9HINidBlKaaL72TmXdT3xCjrS+KJvQk5dQKLStxqcuG1yjk8YdsF+M7GMDzbjTdt
         WfOpmNUC8hUl3WBfIJpGJtl9hD4aw2W9WLUr+XUBeiwH97a+bTE5ROIDJ+Xhc7e2WKqw
         RK68rVnW5M4smksFaHu5T+iqKOQiAMfp7p3EZLCqts9e31zi/7pdgsfboYMBXHT6Zwrd
         aOPB7F4v8CC8ExLfiPKinNVqHXjFkUSrkKgDHQoywnMW+IRkFXrCndkanpArpdBheEqn
         eumsIewXgb/9qIZUehwpF+VBSRNvnMAXtNUq/8HHTTqUTlyIPoqANz7GTLJI3SgVGXyY
         dvWw==
X-Gm-Message-State: AOAM5323oKh3fvdEfYetGW1cQwv+4ALF2NhzOaT71SwwQFwA1boue6/D
        RxRAGG1+YFXVHh99gTFV3A==
X-Google-Smtp-Source: ABdhPJxv3PtS4RQsIakaQUoGXl8ifahEYDMJ9qJDJ3djTv2/Tdahsuj9+yPrhP0Qb0KDBrIQS4g2nA==
X-Received: by 2002:a02:3908:: with SMTP id l8mr20234196jaa.121.1593465653694;
        Mon, 29 Jun 2020 14:20:53 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id q4sm556352ils.11.2020.06.29.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:20:53 -0700 (PDT)
Received: (nullmailer pid 2925373 invoked by uid 1000);
        Mon, 29 Jun 2020 21:20:51 -0000
Date:   Mon, 29 Jun 2020 15:20:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: bus: uniphier-system-bus: fix warning in
 example
Message-ID: <20200629212051.GA2925150@bogus>
References: <20200623113242.779241-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623113242.779241-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:32:42 +0900, Masahiro Yamada wrote:
> Since commit e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to
> json-schema"), the schema for "ns16550a" is checked.
> 
> 'make dt_binding_check' emits the following warning:
> 
>   uart@5,00200000: $nodename:0: 'uart@5,00200000' does not match '^serial(@[0-9a-f,]+)*$'
> 
> Rename the node to follow the pattern defined in
> Documentation/devicetree/bindings/serial/serial.yaml
> 
> While I was here, I removed leading zeros from unit names.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>  - change unit names too
> 
>  .../bindings/bus/socionext,uniphier-system-bus.yaml           | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
