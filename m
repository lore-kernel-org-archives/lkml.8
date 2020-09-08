Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00EEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8F92078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599597881;
	bh=WITvV8xVuKVPulU439R+wmkEf+SCGd/2QyMIg8BA710=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bu4KpYL5RHlJXpD3rNG5tEV/vvGxg4CQxo/c6Hg3q6j0Qo8XzkkDkAQfX3SNhKNcq
	 8Eh6rceWCKB+yFmqakZ+ogR4byYvmMpXdr9PQddk8ZsTAFFcXoLuHfV++XESLHp1eU
	 p4azjq5EPXUWuIScADR7yHS4MqbHsUNaIbUPy8qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIHUok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:44:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38349 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHUoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:44:39 -0400
Received: by mail-io1-f67.google.com with SMTP id h4so828819ioe.5;
        Tue, 08 Sep 2020 13:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajf53tOcW4h9HqH0tzLtcpYfSl5aT0+OKeWkDGG+Cw0=;
        b=Cal/2nd98OmGs50KzJYOPV0phCITAlLdG9KblTX9OX1NTwmA4N6PPkrNSkYsBAKg6d
         CL71vhiKKzxpzzS5s1oibV8Fx9RtBiQclZhmEpTPV0GppJ5/EYkhM12gkmxZQjaGuB3C
         t3ACgy4iq8zeQLPGgFD4wjqmqLWZNtsopHMQg9BbKQ9UqK40thoutgE+785oikqwj7F4
         klUBEUCFadoXXNWESi/AXC6humv87gtSWLPtiguvJz/zJU8Y721F3aYJHxhr/JgMMiWo
         /cgNGS11tjDKbhXVAHk9nvBdN+m48guiXmcrUhUYSrkuqr0RTFdWKHtZ84GN8t24Z5Lq
         FcEg==
X-Gm-Message-State: AOAM531C5Gnxe0pzVLmGfVPad1F/U/0hXeym5d7TnoxEHx3GzFMCrF+A
        kGhwnuFt7YwQuIhBzYMY3g==
X-Google-Smtp-Source: ABdhPJxkEjT7yo67ONl2IkJXtFX410muPLz902ugA8W007oN+uLmHRDGr+aG7PgsTEkbL/otvBfoiQ==
X-Received: by 2002:a6b:da19:: with SMTP id x25mr652494iob.12.1599597877923;
        Tue, 08 Sep 2020 13:44:37 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a11sm177608ilh.20.2020.09.08.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:44:37 -0700 (PDT)
Received: (nullmailer pid 886305 invoked by uid 1000);
        Tue, 08 Sep 2020 20:44:35 -0000
Date:   Tue, 8 Sep 2020 14:44:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, broonie@kernel.org, arnd@arndb.de
Subject: Re: [PATCH 4/7] dt-bindings: fsi: fsi2spi: Document new restricted
 property
Message-ID: <20200908204435.GA875620@bogus>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820170228.42053-5-eajames@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:02:25PM -0500, Eddie James wrote:
> Add documentation for the "fsi2spi,restricted" property which indicates
> a controller shouldn't sequence loops and therefore has a smaller
> transfer size.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
> index b26d4b4be743..0d2fb071fd00 100644
> --- a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
> +++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
> @@ -24,6 +24,16 @@ properties:
>      items:
>        - description: FSI slave address
>  
> +patternProperties:
> +  "^spi(@.*|-[0-9a-f])*$":

Doesn't FSI define the unit-address format already? No need to do it 
again here. Plus the form 'spi-[0-9a-f]' isn't valid. Just "^spi@" 
should be enough.

> +    type: object
> +
> +    properties:
> +      fsi2spi,restricted:

[<vendor>],<property-name>

fsi2spi is not a vendor.

> +        description: indicates the controller should not use looping in the
> +          sequencer and therefore has a smaller maximum transfer size
> +        type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.26.2
> 
