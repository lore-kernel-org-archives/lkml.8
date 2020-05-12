Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78872C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1EF206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589290416;
	bh=JMbnZNV5GWBEG81bTe/hzlYpxatVV1xl1pAlF1csQRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S8lrqTxA0oQwwY5qb+Krx/vjPffuBW8yYvus14xFp5UtceSwY9akqtNjpUgFJrSgy
	 EbeYnjrNHNeMXhEOP7KsP0yCm5Mu7lkGDJRtrju5gccj0x/+U1ZWXGSEpfkVIIDLvb
	 ldfZK9/qbAt80LRYYzOZP6tP37mYHsK5DxtLeIb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgELNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:33:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46550 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:33:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id c124so17978195oib.13;
        Tue, 12 May 2020 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFGIuD/Xpph/hs6mOp9w9FUA6ja/tEq9l8yoFeXouFw=;
        b=r9B6R8S6kgQwCodDMIwZ6wYjNrhVUktFMLj2tD26erdxGFuyf+fAQwV5zOEwQr3Xq0
         rfsqy55qAjB+8F05QsgBhNPzhW0aiouGfTQaUxiC1AuV21pSM82TezPGn1zQ8kJWT2eq
         wXFn1Sh7fttbgAUkHhIlHlGLmOjG/BpqE6DSSq1bi8QhO/0HQnwUPcLGv+QuN3LrC5Rn
         +z9LXzajhNszqqYfmjF/BLBKDhnZ5HEJYtCZgBh+SRlVzXg1xFKFDprMQ2H6Iq8cy5Xb
         PvnaepgfOEhxM1Iqrv/MaYIfPIaJ3jiyR1rcBtGLR5dyZRoDdIG3cP++Eqqr3EoeiXYT
         LkPA==
X-Gm-Message-State: AGi0PubytIQw4HV3IwbXeX+7ID0zTzHF64InYt7KVcCpshdqIaBbiAlk
        rI0sNYWHVBT7XAv/FdeUsQ==
X-Google-Smtp-Source: APiQypKbHwhW843vidRVikJDKSgfpX/YNavionaQgpuXcxU4nOF/+zAbaPV8eIuwpBpb9BxWfvo/gQ==
X-Received: by 2002:aca:50c6:: with SMTP id e189mr1692952oib.34.1589290413774;
        Tue, 12 May 2020 06:33:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g10sm3630958oou.31.2020.05.12.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:33:32 -0700 (PDT)
Received: (nullmailer pid 27973 invoked by uid 1000);
        Tue, 12 May 2020 13:33:30 -0000
Date:   Tue, 12 May 2020 08:33:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/5] pinctrl: lochnagar: Move binding over to dtschema
Message-ID: <20200512133330.GA23637@bogus>
References: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
 <20200504154757.17519-3-ckeepax@opensource.cirrus.com>
 <CACRpkdYSzdUgZgA6jtdP3K9bWTF=-whkQCr=bKkr_Z0VXywdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYSzdUgZgA6jtdP3K9bWTF=-whkQCr=bKkr_Z0VXywdkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:06:59PM +0200, Linus Walleij wrote:
> On Mon, May 4, 2020 at 5:48 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > Changes since v1:
> >  - Moved sub-node into MFD file leaving just the properties in here
> >  - Removed contains on the compatible
> >  - Added a required -pins suffix for pinmux/ctrl nodes
> >  - Added some extra blank lines for readability
> 
> Backed out v1 since I see there is some discussion on these still (sorry for
> missing this).
> 
> I'll hold this off until there is consensus.

The whole series needs to go in together.

Rob
