Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8D3C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E609E20757
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nacZRdte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgH1PUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgH1PUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:20:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8AC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so1270415qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmAVQxaLJpSgHlGpdC6W2VwrKbmge9YTpG2rcbgWFRY=;
        b=nacZRdtevNeYT9CJ6nLA4NoNXEAyPImxNMxzlfmMca1i8stapDOrP+Kxip7McKhAV5
         9l08gUo+8TyO6SN7VJAQU4gEAh0vE61+p3F5SrGs1jt0HPdwN0EihHO615GS6tH3XX//
         A0nOV+WX2a0KXUWY77Rer07c9z3S74bV4v2Bb585J/p8y5I44riACgPdeFN811woipZp
         TD72hirXsZeWcK+F8I5M2JyC0qJQZ/JdoITLLoxkYgfLPw2wtf7zY5nMI9Zk4ewPdMIL
         E5GAHWmTEy4YROGgjL9tDeBgbPku0C+eQHKQQ1SjhXL1STugmflpgEmdEcM/svZScCzw
         LjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmAVQxaLJpSgHlGpdC6W2VwrKbmge9YTpG2rcbgWFRY=;
        b=uhEWsqFwhdJF/M3n0u0nORg9Pd7ptYOJT3bVu7D0FmXWVswHguhwAMR67BrxgSNe3i
         KpyOfGckeaNA+iiLBS3jn43hd3luqQnsZfoC1NL63Uo2Os8vJLb4KDTEYFK9Yab5mtl0
         2IllVqOQcN/UO3YFRZlplhLXYmfIDsLoq1typ4cmpi3yhuETmXX1Lmxg5ghVusWu2i0D
         Bt43oY51la4t7RYhBI/soyudcta4qllsqMmQ7AzGqP2vnXBC9akH3L6mPxeJHaj4EAS+
         GHiEHF8H0kxcoT8SwInbunKKcimDg90u2Y0BlroRm93NYTr2HZTy1ibdLlGcT3BM2A+/
         GJ0Q==
X-Gm-Message-State: AOAM532HuBHfGoK45FKvwumNDF2MPJxxfa7MWp+uZjbyc9uEUHl03ZVZ
        TKZAa1nlhm7Yh6YG0WpXyJajDA==
X-Google-Smtp-Source: ABdhPJzcd9CgTfJl/sRgwevfrnu6z/jWnfmDFGgqlGh6cAgk0HZk1toJqs+TYqzoKCtlM+546U/ncQ==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr1652758qkk.293.1598628008018;
        Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v136sm1031904qkb.31.2020.08.28.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:20:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBgAg-000vxD-HJ; Fri, 28 Aug 2020 12:20:06 -0300
Date:   Fri, 28 Aug 2020 12:20:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828152006.GY24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <20200828142137.GX24045@ziepe.ca>
 <20200828170103.6d954d95@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828170103.6d954d95@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:01:03PM +0200, Gerald Schaefer wrote:

> Just to make sure, you are referring to some future / planned
> changes to mm/pagewalk.c, and not some currently existing
> pagetable walkers already using the READ_ONCE logic w/o
> spinlocks? 

Yes no current code, just something I've been looking at slowly.

Jason
