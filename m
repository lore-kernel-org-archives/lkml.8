Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EE6207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WCwxFtPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:06:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:06:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d7so3440603qtn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9+fSKP0z6kMIaGF+78kIniE7F4EO/EazsTHVPcfTDo=;
        b=WCwxFtPd93lX5/INoql/D9+P8RcSW7fw5beK5vPk6ptSAutO+LLRfER/Li076COnIy
         lu/zA9qDPWjbyug0UIyw4mMQeixprvXth5P/EtI5AkIfhsMuxSLisIe/QrdbfNbZFrWM
         8GSsyxRhzhcRuqGDcZlxIbzr/beMFanlycBBBGt7D1NGjio6GMtlUhnwVhBeqjvMWoDM
         lnvb8JDxrjn6F+dYN03sCqTb4ra7eT2mIUjpP5RnYV8U05GxhMKb/UqwVRbrHrVxVJLi
         uPYMGPRevLMjJ2vPCFkLtuyo16AhMjPrmay/yztRKeK+ApmdPkuRgqlw6m2WvQ7/twkc
         r/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9+fSKP0z6kMIaGF+78kIniE7F4EO/EazsTHVPcfTDo=;
        b=LjsW6f+JVoqOS8+XZis3JeB0IA+sk0RVQ2H/anpxUbYqE/ACqlOulg8OUeI1AtJ16J
         Gl3Ur77gS3GtUD/SyjkCWR94PJ5ToO4R4mEJAZjanqHhT0sQ81h4CER3qF4+qPct1FWb
         H1C1HuHgy3kBhqP1hKEioRDrjJLTw9SYG+uHkY0yI6JUGiAqB30X41X9bgDB5Upp2kqt
         nICO14v6znbyRZfPfTIII050xQ2Gd3LFx4P5EqCSVI8PygdCOqXxX3KeWV4Y3JtXd6N4
         qZD8++l+xnEElZUsGIKkNcf6er2Tdr0duZVvgCSKrzBBstHkvETToj3Uja4QaYiAw2U0
         3aaA==
X-Gm-Message-State: AOAM5311Y1+b9y2AUJOYF7qOCF4uWKsHoZZUEkdplycec4DMg8LT415F
        Nm94R8kWhukjuWtInXfcRK/5pA==
X-Google-Smtp-Source: ABdhPJwMrPX8DXKy1MU6YGO3yj6Jsv1W1IZKUQc7PDxHt2LFjJv8FHFUGPY2Oja2twOoWMAH5HGJrg==
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr7227139qte.283.1590001559595;
        Wed, 20 May 2020 12:05:59 -0700 (PDT)
Received: from Qians-MacBook-Air.local (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c63sm2695364qkf.131.2020.05.20.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:05:58 -0700 (PDT)
Date:   Wed, 20 May 2020 15:05:56 -0400
From:   Qian Cai <cai@lca.pw>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Subject: Re: zswap z3fold + memory offline = infinite loop
Message-ID: <20200520190556.GB4894@Qians-MacBook-Air.local>
References: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw>
 <CAM4kBBKkOGOjT5fddQ_vongNx_cXmv0tCQzD9ZtrGgkuPTKfTg@mail.gmail.com>
 <CAG=TAF65nmW2m9-5z5xvLmfRAD0LZAxgARJOEAqvzA3GdN-iJA@mail.gmail.com>
 <CAM4kBBJSEpB9kS+PKpd5HJT0Ox5rNWW2vsvHTVUw7Q59C-ktig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4kBBJSEpB9kS+PKpd5HJT0Ox5rNWW2vsvHTVUw7Q59C-ktig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:23:38AM +0200, Vitaly Wool wrote:
> On Tue, May 19, 2020 at 5:50 AM Qian Cai <cai@lca.pw> wrote:
> <snip>
> >
> > >
> > > Removing that check in ->isolate() is not a big deal, but ->migratepage() shall not allow actual migration anyway if there are mapped objects.
> >
> > Is that worse than an endless loop here?
> 
> Well, let's figure if there really has to be an endless loop. Would
> you mind retesting with
> https://marc.info/?l=linux-mm&m=158996286816704&w=2?

The patch does not help. Running the reproducer the second time would still
trigger the looping.
