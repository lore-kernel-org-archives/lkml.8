Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF8C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E22073E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594693313;
	bh=G0iEwjdw5aEJ62RiyfLc6luWUQJ1iS+i8d65qsjwg8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0R3t6WVgwHzQCrymx0prCSnLkEyxXYZpVJ+yLyb0+4tE6Q97KVwebxlf8JjwLqga6
	 GjaXeftxL3VlXJTl8+JzYSU/56dbwxKBsoykw901BGr7W/6bH8qv+gyCxWDFGOc7mr
	 nEtx5d+tjfe27N74n72sNfigJqkgrX3OWRpPWOXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGNCVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:21:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39688 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNCVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:21:51 -0400
Received: by mail-il1-f195.google.com with SMTP id k6so12988972ili.6;
        Mon, 13 Jul 2020 19:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3FbKAVk6JJr3uR3Bza87ijOzpykZ/ht1Tqwf65b3KI=;
        b=ZKQkEnsqCJvzt4tvofwn4Wx/VfNDnpQAu1H6PydxkBpaNR9EtrmmCoHBHErAQ4ryD2
         Y3MqOAeO0gVecfhwlcflkBWxrgfC6sHREJ4Oqn+aw+gsbmmdUptiCZnio6GMg3X3iWae
         SVRVEo66L9Th78f3dibaZHrKOZ9EWo2loyxrztdLmREJx7ETFH9BMD+kzcd0YsGr+R0y
         iNcuX9rjUbSgJqjI6Gj6jqlffx+XZG7CR+tGrwsVkBCHoWuckR1IEyuj/CdhNrxDDahq
         bojTqEOn69FQm7rcqCf9bb29v6QT1LE5TdnlFZ1FT8QszL5krDcmeOU9FTUzDoidoa/Y
         FuMA==
X-Gm-Message-State: AOAM532100pRDUTogFMhmLxuXFgIGuzQu5sZHLdAyhCmFTxUruatShrH
        D09lmt/uw6j1w4wZeaCKrA==
X-Google-Smtp-Source: ABdhPJzNWhuGWWKx+6Cf5B07q0XeaVK35FXAFTq+PO3QiZ3qQJW25KSE03/NCtBcUoJnPLSKpkgQsg==
X-Received: by 2002:a92:5ecf:: with SMTP id f76mr2561312ilg.281.1594693310705;
        Mon, 13 Jul 2020 19:21:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w5sm9143558ilm.46.2020.07.13.19.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:21:50 -0700 (PDT)
Received: (nullmailer pid 1150001 invoked by uid 1000);
        Tue, 14 Jul 2020 02:21:48 -0000
Date:   Mon, 13 Jul 2020 20:21:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Frank Rowand <frowand.list@gmail.com>,
        - <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier AIO audio system
 to json-schema
Message-ID: <20200714022148.GA1149971@bogus>
References: <20200623113915.791386-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623113915.791386-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:39:15 +0900, Masahiro Yamada wrote:
> Convert the UniPhier AIO audio system binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add schema for subnode 'port'
> 
>  .../sound/socionext,uniphier-aio.yaml         | 81 +++++++++++++++++++
>  .../bindings/sound/uniphier,aio.txt           | 45 -----------
>  2 files changed, 81 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
