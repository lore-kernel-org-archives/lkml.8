Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5AFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB890221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U16qJ5NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKLhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIKLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:36:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C66C061795
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:36:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so11143584wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROqzDYH2GWYM03ZSU07Jdgz37KQwQ40XxoRk8JD+TfA=;
        b=U16qJ5NMAwDC6g/alubwUiD2DCT0aJtaJaowLTNkDEK02oXkyuE17uyB71I8XjKcUn
         Oj1V+twOY/oc+NXpqGTg+KEvB+Hhj4rCDQ7+RKHidMWQ8jU1Jrtd2m6v6DPAO/2GMy8D
         nHL4jQTVt4Chj3q8/u3mVfb17Mo34LmngzIeSzFU1FCTE/sBInI237nHWgS5WTaxzTsF
         oQpVfGt82Ket8KLic/wKsOhzOd7TfsPWDLT1QlWZv9fqjErjYu91LiOVxBBeyFCk/ZY1
         gzrUpRrLZuyge0BsxkP0GNLGPTGvxpABLc4ezQrfMLDd6iSG/r7D65+ZRuDv6gLX/Kvd
         4s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROqzDYH2GWYM03ZSU07Jdgz37KQwQ40XxoRk8JD+TfA=;
        b=PlUwxP0r4uFJznfedDjPrJ4qy9sYfwxvoZUXlcNVd4SKEDQ2sy+B0HQs2/ZHO8XnfP
         McKnHlEdAsiifBye6OpT0wIcqLRlWVsRfLyHSs/GkzCFTS3S0V53sjOsKth3WEcj6g2c
         rn9ROxNF5qWZyeaPzVpODW7dbiTGIyMIRancLuxptXvvuonseaVKVvRHHUjsMgmBKzZg
         gfXMF/e6qyZHXWytGp1I4zKzcnI5E7hqlR7RHnywsJkcxkHBS/1iORn3QnGrdFd2XEhB
         lk7m8YWDGwIExUMdxDBLy7y7P68hRJLSNdcJ/UxWt4k0W+4xE7V3dt6TS2rCwUZPpEny
         ve+Q==
X-Gm-Message-State: AOAM531irAirFx7JxKmXIf2hJ5mLl1BmyljMEHZmUlgQovL1mc87Niib
        eavGnAJzsjc9dYczTVMkjSY=
X-Google-Smtp-Source: ABdhPJyOGi2dx1dxviGDvQdJEqt/EeYPVvT2aETHZSh69NTkv1l/vSh40bPwIrPOobBK5Bzc6uZWXg==
X-Received: by 2002:adf:e843:: with SMTP id d3mr1610921wrn.290.1599824167385;
        Fri, 11 Sep 2020 04:36:07 -0700 (PDT)
Received: from ubuntu-laptop ([2a01:598:b906:6939:8868:1825:7dd4:faeb])
        by smtp.googlemail.com with ESMTPSA id m185sm3899728wmf.5.2020.09.11.04.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 04:36:06 -0700 (PDT)
Message-ID: <a6c74afbead6741f6851ced377c7eccbb4a81196.camel@gmail.com>
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages in
 case of ra->ra_pages == 0
From:   Bean Huo <huobean@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        Richard Weinberger <richard@nod.at>
Date:   Fri, 11 Sep 2020 13:36:00 +0200
In-Reply-To: <20200911094709.GB14158@infradead.org>
References: <20200904144807.31810-1-huobean@gmail.com>
         <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
         <ef82be594709a8f954f4933968bd96888e589df3.camel@gmail.com>
         <20200911094709.GB14158@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 10:47 +0100, Christoph Hellwig wrote:
> > > Doesn't this defeat the purpose of having ->ra_pages==0?
> > 
> > 
> > Hi Andrew
> > Sorry, I am still not quite understanding your above three
> > questions. 
> > 
> > Based on my shallow understanding, ra_pages is associated with
> > read_ahead_kb. Seems ra_pages controls the maximum read-ahead
> > window
> > size, but it doesn't work when the requested size exceeds
> > ra_pages. 
> > 
> > If I set the read_ahead_kb to 0, also, as Christoph mentioned, MTD
> > forcibly sets ra_pages to 0.  I think the intention is that only
> > wants
> > to disable read-ahead, however, doesn't want
> > generic_file_buffered_read() to split the request and read data
> > with
> > 4KB chunk size separately.
> 
> They way I understood Richard this is intentional.

Hi Christoph
Thanks. understood now, MTD expects this result. Even so, I think this
patch doesn't impact MTD because the flash-based FS only achieved the
readpage. Inside __do_page_cache_readahead will use mapping->a_ops-
>readpage to read data.

Thanks,
Bean

