Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9CC4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE91A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582753606;
	bh=GUeAaFwF8pV8iiq7IjKyCqgn74IfWW9varP2zMWHIY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aqf9kTm7xplQ8fe6evY4oItv66jySJR1Pc1uJewgI646Gi9U78XG1+aNu4EFQcM41
	 aBmAPxCsYpNA5pLvqdkWdq4pZ7x+NVWH69w+Bi0TU1HFwKKEVj59lkvpbvrG+DaL90
	 wX55M96Ji0xoEs3myCx/g1UvCnjjAsEa739wgVgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBZVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:46:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35863 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:46:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so1144840oic.3;
        Wed, 26 Feb 2020 13:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykCghEU0HIKEVpuEfgJeanwDYTO0hdry6TeLSu7ZHuQ=;
        b=e1gl/6T4Yox6DYhqAbi/poC/qRl43e4oWBhdJFIU/LieKXOaXbAUVmuDSKCFpqNQBP
         zeKHOVx7sueLyb4rzmHHtoFfh8sIKSnhHSkTL5tJTOs+D/7K00Jo3PHMwSmwdVP9fVTe
         Iylw8zRA9fvSo7TIEiG2jBGJ47zYeovuj24jcsPjwB8Fwex0FSJtF+Q4yEIcRde5hd4C
         ahFc62YSQU4n1DE+TzmdxiCR1qN3CYjtF1/l6U54P6AsQ9bQbgIF8AGBWecgcqjnnHQq
         snVaWn/WKL895gieQcJMTqv+zBhT22Fb6eIQhfZzszJWRNa/yKT7UbAMmhX67KUvk27+
         QKBQ==
X-Gm-Message-State: APjAAAURN4h6dIZVC5L0ZKarcgYKsY1iZTOmO2zSJB7qBCVm+9ndsozl
        CeMFno5YmXCo+vv0YlXpzg==
X-Google-Smtp-Source: APXvYqy39JBi19ty5lIMh3UAvPXf0/NW0hQi7cc8OYICFBXx/4X3dPhgCreZvPbuoUlB0Q+z0pE3TQ==
X-Received: by 2002:aca:ec46:: with SMTP id k67mr844736oih.43.1582753604749;
        Wed, 26 Feb 2020 13:46:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm1202143oti.44.2020.02.26.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:46:44 -0800 (PST)
Received: (nullmailer pid 16588 invoked by uid 1000);
        Wed, 26 Feb 2020 21:46:43 -0000
Date:   Wed, 26 Feb 2020 15:46:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: Convert UniPhier board/SoC
 bindings to json-schema
Message-ID: <20200226214643.GA9729@bogus>
References: <20200222060435.971-1-yamada.masahiro@socionext.com>
 <20200226214146.GA9521@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226214146.GA9521@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:41:46PM -0600, Rob Herring wrote:
> On Sat, 22 Feb 2020 15:04:33 +0900, Masahiro Yamada wrote:
> > Convert the Socionext UniPhier board/SoC binding to DT schema format.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> > Changes in v2:
> >   - Remove 'examples' because examples are fold into /example-0 node
> >     and there is no way to meet
> >       $nodename:
> >          const: '/'
> > 
> >  .../bindings/arm/socionext/uniphier.txt       | 47 --------------
> >  .../bindings/arm/socionext/uniphier.yaml      | 61 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 62 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

As this is all DT bindings, I'll apply the series.

Rob
