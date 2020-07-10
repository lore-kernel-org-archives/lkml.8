Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7756C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B338F207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdeyBHoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGJOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:04:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEB7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:04:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so6579085ljp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FohwNfXrZ64dI/A6dzP4B8r132U3m58v5WNQmAc787c=;
        b=FdeyBHoPZ/YazdNbuptBYqPxCsSqUwT3eKPkBfbE2ygIjlnl7YKFCbnvAxJ/+HQWn8
         MJNJ3lz8nHH1iOkADufts1pqX5u+DmzlF96mXCPwmr3x1qC0WclhB2qmRHZJjXddhDHX
         FqMANUwWLDw8iFQ1qXODdXI+xnmxp6Eb0sNojyP0tToYPCjJAuYF1yyp6FYKVWVLpDFO
         dpQwssxsdswmxdqWVv2G3c3382AFAwoN5jcM4bUzEphLfgYzgszyGQ0oPZP2btBdnCje
         8jKg8pDxpixH206ZyW/v1AHMN8bY69CZwJYpiFBjELqqReUDUIKAiRHS7KCrymk3LipT
         fnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FohwNfXrZ64dI/A6dzP4B8r132U3m58v5WNQmAc787c=;
        b=BgqXFkNG3f3CgaDOrze9wO1/kJCf2FjLSbtY3TLvTNl7MtvJSDHjsvDUhdAqX2++pD
         BfSQBGgvYKjAAr1L64s9SScnryqHS2M4Wrfd6i+ivUyQozxafuWaUaQcfTB/ccfalNb9
         J7opRumlA7E00RoAUpk4qErIKbnpCyXzj86WcIfmF6c2uedw4b4s412utbjoEZapR9PH
         SQ4snAUc9QhNwrC1qpyoVUlOXjjiQmv454g3AH4cl5dXJefYmivE0bIUTab2ExECfshD
         MWitiifqFXfBL3+j7v6y+GSqnIRqm9A7yFBsxXRoTqcZixt/T2ZLmnGwRByGHdNvloHw
         I2kg==
X-Gm-Message-State: AOAM531VyMsH/wBInqPJozh/3a870SxTCLZWxlz5gVmJjLbEEJkABQYK
        1OkM9Ps7g2aARaUS6EyhV+U=
X-Google-Smtp-Source: ABdhPJx9Xj8F3jJ+3vIeNuvenAc1On3KXSkIWPuNL3idV6WigPnS/KTN7FKGqctRoNTjzb/hMSlPhw==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr26798970lji.269.1594389882122;
        Fri, 10 Jul 2020 07:04:42 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j25sm2194769lfh.95.2020.07.10.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:04:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 16:04:39 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3] vmalloc: Add the right hint when vmalloc failed
Message-ID: <20200710140439.GA14846@pc636>
References: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
 <20200710124323.GJ12769@casper.infradead.org>
 <20200710134956.GA14549@pc636>
 <20200710135301.GM12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710135301.GM12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:53:01PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 10, 2020 at 03:49:56PM +0200, Uladzislau Rezki wrote:
> > > On Fri, Jul 10, 2020 at 08:17:52PM +0800, Tian Tao wrote:
> > > > In fact "vmalloc=<size>" cmdline option is not available on many
> > > > platforms.When the user encounters this error, add the correct
> > > > hint to prevent misleading.
> > > 
> > > i don't think this is an improvement.
> > >
> > Matthew, maybe it should not be considered as improvements?
> 
> Every patch should be an improvement along some dimension.  This doesn't
> feel like an improvement in any way.
> 
> > It is rather an extra information that indicates that your
> > ARCH may not support "vmalloc" early parameter.
> 
> If anything needs to be improved, it's the documentation, not this
> error message.
>
As i mentioned before, i do not have a strong opinion about this
patch. From the other hand improving that message looks normal
to me. Especially in a context that it took a time to understand
that ARM64 does not support it, so we have had a precedent. I am
talking about author of this patch.

--
Vlad Rezki
