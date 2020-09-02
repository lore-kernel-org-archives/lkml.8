Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4925C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717B92087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599037849;
	bh=IOmbCqxmZYDkBSNg8v2Xoyif0LGwCY8FU6j8LXdijOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuB1P1sQch2pnv/jzYQ65QlFTi3wF8nKlxfBlolE8g/OyLxb/RZvKxCPFlH91+x8L
	 C1bKx4pmp6ImMgxDnDkMdYYuZGBWYN7EN03Dd5zwWKHWwrKkVhBdChIUmpU4usf6dz
	 CBezxQpQT/nFhiR5HR1bqT2KJE5mbKqalBY21q74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIBJKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:10:48 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34540 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIBJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:10:45 -0400
Received: by mail-ej1-f65.google.com with SMTP id d26so5627308ejr.1;
        Wed, 02 Sep 2020 02:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E4fh5/MeVusZ4b0N/tjFHVUKNTWkPzDCAhh11fSrU6A=;
        b=oQNAPd0+odkIrjosh5I44L9RwirngUdsQc4vn8gHUk18EUOgwD55LLJZs1hYX/JW6P
         zWZlUV1De5RH016R5xQ5WEQZzlcXLmxt4DJ9vQhWXgPFSITizc79pfQlHJFUG/2S2YvM
         xhPG+oJtn0Wmn35qzwBcMpdarAvlOoK2Ozo+VCukX3T3DGyyPpYcJxfO57fgLBZRYjUy
         AUjClMK9sCBJhFUbVEheYLOEY+Fpb6jgAEjvKV6oxwIsVrsq8VCzS0zZgax6ggAMKLYO
         ILi4dK28sh5UFw3S+u0OeCjCWE7je0naYQEAsZkGwji5GgrQwEVA8sagrUf3qQwTjdrK
         ExNQ==
X-Gm-Message-State: AOAM5336dsfzjMmhSLpx2a+L5pqmoKWI1hTVo/V45Td+PAs7jWdxouG8
        CGMh3K/RPRzK2KpYp0HBRJE=
X-Google-Smtp-Source: ABdhPJwSWg4FBr7OY7AxzYwDMv1nLEAHRO8crmn+qZHgmfPLuyez3KEx8mKobZPHm50gu/Snkusk3A==
X-Received: by 2002:a17:906:2b87:: with SMTP id m7mr5278949ejg.210.1599037841796;
        Wed, 02 Sep 2020 02:10:41 -0700 (PDT)
Received: from pi3 ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id n20sm1704793ejs.14.2020.09.02.02.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:10:41 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:10:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200902091038.GB13726@pi3>
References: <20200830112633.6732-1-krzk@kernel.org>
 <20200901110349.GC6262@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901110349.GC6262@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:03:49PM +0100, Mark Brown wrote:
> On Sun, Aug 30, 2020 at 01:26:32PM +0200, Krzysztof Kozlowski wrote:
> > The "sound-dai" property has cells therefore phandle-array should be
> > used, even if it is just one phandle.  This fixes dtbs_check warnings
> > like:
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

The usual prefix for bindings is "dt-bindings: ..." so I wonder what
type of prefix you expect:
1. ASoC: dt-bindings: ...
2. dt-bindings: ASoC: ...

Which one of these?

Best regards,
Krzysztof

