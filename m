Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12216C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1E124125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579710198;
	bh=LCZBvvOS0KLjWc9/STGzVEdt5nVKnCe0i6V++IqwJis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/VucRrE/eAXx/G+tnF/WoDSbO04/YWS/24qRgtaS1jp/rM1L9OUC0MJN4Y1KcdOx
	 KXxP0Rdz5ACPfhFDesy2kEObor1V+Jk6/Onc+8cSkmFwcIlA/kPxm6zSZclo9CWjVu
	 pNeMKs20KUQb7pS67Iqbj6xFUcovGQCBPeCIYifM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAVQXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:23:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46532 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAVQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:23:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so6559842oij.13;
        Wed, 22 Jan 2020 08:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kl6DkjB86yGpM9juSr7kQ2SQ7zaftAaJ+ye7aw840JU=;
        b=J9LjScM2ZL5NLgNxUMJZxpKOT/SjwjdEj1dHpXqUlXcqEBFYmf04CkyndIXu/8QICi
         1zTFc+4Jji5Bgv9o77gYlQDOqVQW/iV4WCmhjz77zr67c718erhHOFG0GOEtNodxLKuI
         ktbFST2gQrG0tehFowoHS8V0rilaIdA4IL8tNblLR0eYM6JAF49Cxm0jJz3RQ59jnAO4
         H5GRK/hXo9fcoITJcv5u3/ICtWTza9n55I34f5/DhfUaUJSqeae4UNk9ALMWwV4MLJ0L
         30P0CG1Pqfg3kxvbsFph7ko+XWwqxN01WhYv9Hq3JH1c3lyUOtjGMQN5RGBQF90luU1C
         /LSw==
X-Gm-Message-State: APjAAAWPXSWQLzqaTkERv/Oj6VWIo3J5v8f8JCUALE5TNCdDLZLVL6SF
        61aVqLh/XnNhH6+gM2sNYQ==
X-Google-Smtp-Source: APXvYqx+wMlJuRZhN1C81TQvWCFvFCstyCoUvH2JF2ogKYXviYxz5AWDV3kOmMi0oeIt8a8lXFN9ZA==
X-Received: by 2002:aca:c415:: with SMTP id u21mr7373960oif.49.1579710196135;
        Wed, 22 Jan 2020 08:23:16 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm13112789oic.40.2020.01.22.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:23:15 -0800 (PST)
Received: (nullmailer pid 8106 invoked by uid 1000);
        Wed, 22 Jan 2020 16:23:14 -0000
Date:   Wed, 22 Jan 2020 10:23:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: spi: spi-rockchip: add
 description for rk3328
Message-ID: <20200122162314.GA8044@bogus>
References: <20200118230848.15326-1-jbx6244@gmail.com>
 <20200118230848.15326-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118230848.15326-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 00:08:48 +0100, Johan Jonker wrote:
> The description below is already in use for rk3328.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3328-spi", "rockchip,rk3066-spi"
> for spi nodes on a rk3328 platform to spi-rockchip.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
