Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D8C38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9298821973
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gy59aPv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgDQOH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730850AbgDQOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:07:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646ABC061A41
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:07:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id c12so910032qvj.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LqhOO57sChESg9+cIngyrXtjaLelgEgf+v+L/tbLWk=;
        b=gy59aPv8zMj56Mv03vyLFGLBjHJ7J1u+UArIzN0R+rT72xnw/cutPk5HRKX2d/1xSE
         hKj5WfRwjwgNBiBwpu21u9UkwU1NN7FZGkJLCpxItWEKZUwsINzhO6JPR6PivXLj7MQo
         DzlEdqiF/kNV0iIENDraE2hef4Q3wXijNqzULS2WDLUwm63Q6O7Y1oO0EPjvaSWN7MD0
         AunwqeklzSrYcvc3UTO2x5yR3FPVWYFM74ybRxl3Xmx6E1s4oWCv/m8igVBmhfwOLa12
         kXgIX2z40DDQpn1mBfE7DJmt9RJZ1SuirkW4fEIj9HgNfMqTedHLx/oI8bh09LtR45/s
         R9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LqhOO57sChESg9+cIngyrXtjaLelgEgf+v+L/tbLWk=;
        b=qxQ4Lpcj0akNnoC5ZABlckGIxC0d2Kqwjj9VTzptPSHlY31oM4NlQT3lhgFuiqdqzi
         43v+H+21ycECXuJgJ6f+JGbHkl4XCVNWQ/r30ttFkGZPLrU5SUZdPcdo1/lL22em8Uhl
         tyLDpaJkviglM8fvj0mEsnXlAdRaHpGzoFjLKOl++o5InEzjgkTgeU6qF3GcJJjEYBfQ
         qoqLosxpqX507cAVNApPVlOaedhZ7+J19It0fclODmH/fCdQ5LlaV36HxhU7AR4O+ur1
         UyCISJi8f9PslNEXmQlkBQS46MPR7kDosThnkNfcBIl8aL32DeV7UkfSLG2NLPckr8sW
         WkPQ==
X-Gm-Message-State: AGi0PuaeRqtQXdNbVeQpQVYK5+3DVzN/r9xB8RVuFnI4+2pz9XAiEFe+
        ChluzYkNaw4DfGzt05aJ85dQnw==
X-Google-Smtp-Source: APiQypKaGok3DQChb57xxsDjD/Iyacg7EOqm08DjV1CqcQ8BJaa7llQ5QiLWdRU37gbKKcQtu2odUg==
X-Received: by 2002:a0c:b790:: with SMTP id l16mr2844426qve.244.1587132472350;
        Fri, 17 Apr 2020 07:07:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n190sm16749764qkb.93.2020.04.17.07.07.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 07:07:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPReo-0000hP-VC; Fri, 17 Apr 2020 11:07:50 -0300
Date:   Fri, 17 Apr 2020 11:07:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, leon@kernel.org,
        kieran.bingham+renesas@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, jernej.skrabec@siol.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC PATCH 1/2] Kconfig: Introduce "uses" keyword
Message-ID: <20200417140750.GF26002@ziepe.ca>
References: <20200417011146.83973-1-saeedm@mellanox.com>
 <87v9ly3a0w.fsf@intel.com>
 <20200417122827.GD5100@ziepe.ca>
 <87h7xi2oup.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7xi2oup.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:01:18PM +0300, Jani Nikula wrote:
> On Fri, 17 Apr 2020, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Fri, Apr 17, 2020 at 09:23:59AM +0300, Jani Nikula wrote:
> >
> >> Which means that would have to split up to two. Not ideal, but
> >> doable.
> >
> > Why is this not ideal?
> >
> > I think the one per line is easier to maintain (eg for merge
> > conflicts) and easier to read than a giant && expression.
> >
> > I would not complicate things further by extending the boolean
> > language..
> 
> Fair enough. I only found one instance where the patch at hand does not
> cut it:
> 
> drivers/hwmon/Kconfig:  depends on !OF || IIO=n || IIO

Ideally this constraint would be expressed as:

   optionally depends on OF && IIO

And if the expression is n then IIO is not prevented from being y.

Ie the code is just doing:

#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_IIO)

Jason
