Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D468520767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887827;
	bh=EbmMqfwZdQ48vvGP4gUEgE4gk1uvCdbJHR7To1L+RzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zxVTkWkaEc5WO+1rR1YkwEwxc1kh2rZSsKBBjXM2Q3Ms7vlbvpbC8CJ+whnMHwRBs
	 mExg9LqaEIq78pBvkNG9sYV6MeOqwKU49nFrLlhXJu52aS+xknzLiiblzy1EX8tJfl
	 vAVB07/R5wsfWwhAyIuA8p0GrbYEHFLBMLkoSxBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503443AbgDNSKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:10:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36266 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503440AbgDNSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:10:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id s202so8027437oih.3;
        Tue, 14 Apr 2020 11:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gk9v81jHbK3iR48L6X7HK2W2hW2idFCYLNnsfsLJ5DI=;
        b=RhIBHdLmpH5b82iqnJh1wB1tjsulhqO2PWtMksh7mLPeS1gZY0+VPtnGAsywDxa39a
         SFBmk6t5wejd2uRwzx7HHxrs3/sdcCbE/3h8jf5G+UiAjNRx/lsegHtifoXEoUysKnfU
         I9TtiUGHhkUwrijNgQW+rALnItJ38XZy9NwWQOrCSchvUvN4Q1gWJoE83d8XNulnnI3E
         GVpIbuVOUfRolu2MpfKCqRIgRuMJkrap0VsG4gj95kfQ5J7KDDRKGe0a3wsfJQnKf7ZF
         +Kx6Mjos42lv1t90unKHkPH4A3ZdUR0e50BWIpbaKKBktiYMyRBmcnFD89kJpgzIDcQb
         9lDg==
X-Gm-Message-State: AGi0PubA6Bft/6+0S82ARV2fUtN1tc4QkwcU2O4GpCgAiIgeH1fgsYcH
        OotH/3f9V2OC/rUxPH+Rxg==
X-Google-Smtp-Source: APiQypJDRGMEJXG8wmRe/NiPBnSGRAZWCVmHL7lGBysJHnkMXrQCbeU+veI2YWGa/oKKLMFumNHrzA==
X-Received: by 2002:a54:4e0e:: with SMTP id a14mr16768498oiy.88.1586887804608;
        Tue, 14 Apr 2020 11:10:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f45sm5697664otf.30.2020.04.14.11.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:10:04 -0700 (PDT)
Received: (nullmailer pid 4320 invoked by uid 1000);
        Tue, 14 Apr 2020 18:10:03 -0000
Date:   Tue, 14 Apr 2020 13:10:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Caleb Robey <c-robey@ti.com>, Jason Kridner <jdk@ti.com>
Subject: Re: [PATCH v4] dt-bindings: Add vendor prefix for BeagleBoard.org
Message-ID: <20200414181003.GA4231@bogus>
References: <20200403191931.GA31296@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403191931.GA31296@x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 21:19:31 +0200, Drew Fustini wrote:
> Add vendor prefix for BeagleBoard.org Foundation
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> Changes in v4:
>   - rebase on robh/for-next branch
> 
> Changes in v3:
>   - add SoB from drew@beagleboard.org
>   - email patch from drew@beagleboard.org
> 
> Changes in v2:
>   - Use 'beagle' rather than 'beagleboard.org' to be shorter and avoid
>     needing to quote within a yaml regular expression.
>   - Assign 'from' to author e-mail address.
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
