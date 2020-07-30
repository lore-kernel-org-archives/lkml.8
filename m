Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF823C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CEC20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgG3PVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:21:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54683 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:21:36 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1k1ANC-000559-Ev
        for linux-kernel@vger.kernel.org; Thu, 30 Jul 2020 15:21:34 +0000
Received: by mail-wr1-f70.google.com with SMTP id s23so7892735wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXXK4liP7bQ7CozkD5bhh1H2HHcUedxbi6NOcFjoOVg=;
        b=WkSXaqSnw0wpRMi5bTtB8De1dsa2yxdJWtYFOwQ3VBOZfMEpsfkRN0BiF8N4ttwJfC
         KlgcFdjX4VF0vuZcrOwS/a2Nz1PGYNha9tx/MVyTYYpRlvbzEsTS8h/yaKmo8mApR6P8
         gOBSPCsevbTvEObU37fZzIVzVNgNoY3MlCEg+DX4eYUIRevrBjbS8iTRjCuQqVvDQZmk
         vIFyzrB3Z6FOKN+YtP/KSWuD+O6prNxA0EWVGZ5N4te/JZkOo4qKN+cvdpPkVb6QFgvc
         Y9htORYtM0C1kEc2yv2QmLIy9gtb1kHN2oaLQCmsmANX40zKgL3cKhJ2d3VWj/HiElJE
         xmlA==
X-Gm-Message-State: AOAM5329F1lDtTI3a9Je5XFwYfPqLwGjMwLCYrx8O4nH0+N8N+45hGDz
        ey+di1Ij38Ik0sKxWndMYfV2oIlDu6cY5AOSPU0K5cY8O+C0viwKHLdDEq0H7O7EZTA7CJcHcl3
        DtBaKnN3bLZcSo2lEOW+DAlQLw4B1lv3s97j51qnXdA==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr15054253wmc.117.1596122494116;
        Thu, 30 Jul 2020 08:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl0tZIa21k95533z0miEXwOe9CtPUgrZoCZm/Q3HY2eIv1wmounyxrFjQPcaRzS0iAqfXFUg==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr15054231wmc.117.1596122493810;
        Thu, 30 Jul 2020 08:21:33 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id u66sm9251623wmu.37.2020.07.30.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 08:21:33 -0700 (PDT)
Date:   Thu, 30 Jul 2020 17:21:32 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Justin Forbes <jmforbes@linuxtx.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: crypto: aegis128: error: incompatible types when initializing
 type 'unsigned char' using type 'uint8x16_t'
Message-ID: <20200730152132.GK1185941@xps-13>
References: <20200727130517.GA1222569@xps-13>
 <CAFxkdAphiZJWnrDUNToVwYJ1Nr9H+E9cSLwA6w3OwSpO4K+pow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFxkdAphiZJWnrDUNToVwYJ1Nr9H+E9cSLwA6w3OwSpO4K+pow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:11:52AM -0500, Justin Forbes wrote:
> On Mon, Jul 27, 2020 at 8:05 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > I'm experiencing this build error on arm64 after updating to gcc 10:
> >
> > crypto/aegis128-neon-inner.c: In function 'crypto_aegis128_init_neon':
> > crypto/aegis128-neon-inner.c:151:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
> >   151 |   k ^ vld1q_u8(const0),
> >       |   ^
> > crypto/aegis128-neon-inner.c:152:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
> >   152 |   k ^ vld1q_u8(const1),
> >       |   ^
> >
> > Anybody knows if there's a fix for this already? Otherwise I'll take a look at it.
> 
> 
> I hit it and have been working with Jakub on the issue.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96377
> 
> Justin

Thanks, Justin! I'll keep an eye at this bug report.

-Andrea
