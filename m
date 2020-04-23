Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EEC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402D02076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chSOWq4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgDWOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbgDWOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:14:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446AC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:14:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so2402460plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gr4q+GtQ73VeA1ex9WDdOXnvVsAGwwpT9Br82wEFbbM=;
        b=chSOWq4WT8sLvJ6tgwVOsVV5xwk0uqU1QNxzyAno/WKveBs/2IXVsFUCOT54GDobkv
         uPcs1fPtUIZUVsC6VD8qweivTuwJ/1hAj/RawRP5iJNQVG142svwWGv6aLVblg04PQQg
         DH/k4yOQrq3alOMg9cqUM9x3UI82NDP4tWpYZgG0gL5C79inVyY8+AJMTRRBBUaOwZ+b
         PZWTFjzPSdf8CZBov1dA/M8NALAUc2B7KSUAdsJs6bRzc75liNI157k5AanFHPLP0MJy
         2KGWGXRQtHHGqLi0YA8KehFLMOfixaDWKcEjzB6BIJ2E6hyxgWri3GwAUGkQtV+81miE
         bq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gr4q+GtQ73VeA1ex9WDdOXnvVsAGwwpT9Br82wEFbbM=;
        b=CDqBRnQwLE8+JxVmn8+97Ma9btA9cADsiYGj1AEmsBqrKJjhQLy0iMmbUjjOP9abLU
         SpPixJER6Qa3Hj1qEgDpm8txxMuKElH8HgGknkuEXdiaKuRvgA6CaO3b+kLzkslP1qPr
         bRNO7JvuUt5AKCvp2lEfgHCqRmK4LzZSwr3Z1gM5ljH52ArL8tnJPISw8SHjqQ+PFlJ8
         ElC+fkEW8TThoRd1ZbY67xyoP5lmP37duqLvg+xpykNifDTn5pnklEma+Ro+GH75axyV
         GSGYBCkjUl5QN5119a3oj2kgzlcGHjf/tq0LkthZ4RkD3D5F0zF4Ke9Tb5vZiszWYuOI
         bxIA==
X-Gm-Message-State: AGi0PubdRaC2HM5ZvuvHimasWED7EuqupJI15gsvBU97eNT55Z2m3z7D
        FHwfME657+ur4V5918zfT+Q=
X-Google-Smtp-Source: APiQypJ9D5YwGJP6XZ0Hx/3cE3rM1cNh5FmISzcRlldumlGuRKgCjPow9KPEvSp4D9K3K9JS3R/h6Q==
X-Received: by 2002:a17:902:aa97:: with SMTP id d23mr3921865plr.244.1587651260522;
        Thu, 23 Apr 2020 07:14:20 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id s145sm2237772pgs.57.2020.04.23.07.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 07:14:20 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:14:16 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Message-ID: <20200423141416.GA1562@nuc8i5>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
 <20200422135215.GA25950@nuc8i5>
 <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
 <20200422152142.GA26943@nuc8i5>
 <20200423101420.ityynrorrehjvxrs@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423101420.ityynrorrehjvxrs@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:14:20PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > I am a newbie, andy gave me some directions to submit the patch, eg: check
> > ioremap leak. At this time, I found that the bochs driver may have similar
> > problems, so I submitted this patch, then, Andy said the best is to switch
> > this driver to use pcim _ * () functions and drop tons of legacy code.
> > I think we might be able to fix this issue first, after that, drop tons
> > of legacy code by pcim_*() functions. Can you give me some suggestions?
> > thank you very much!
> 
> drm has drmm_* functions for that.  Daniel Vetter <daniel@ffwll.ch> has
> a patch series pending switching lots of drivers over and IIRC it fixes
> this bug too.
>
Gerd, Thanks for your info and abandon this commit. 

BR,
Dejin

> cheers,
>   Gerd
> 
