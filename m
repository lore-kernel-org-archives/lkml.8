Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F28C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F282053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="lPkCbxeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgENKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:37:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC82C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:37:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so2378975qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oQGuvng4zGGv5wxqMi1jZPorRLuXoaTainTjhtEgYIQ=;
        b=lPkCbxeMo7dsvFXTJg0O7IFp8a4XUMtflfpaw4jJsj34jpWrE7nR4OtRrG/OHB1V8j
         clSkW03wJM/LcoIo9aLEGmLWH5MymBRcWQng8UEd1YI0Qc0DLfhVql6UETwJUUq0M4UZ
         I68gS+DIMYU1xqH1eGpRsXq9Sda4RI4fmrq3d1y7myiVHD6sNyUenFBS7XucShvteUqh
         FWQuIcCzrqANHmgxDtH8lnnj/BWq2BPEqKQ5qiTVoP0wchnJCkH8GCZUysQ4E4jqX0UQ
         PDaqJnZeKrdM92YNItffMp9M5t4VvaA7UFTrODdfaQ2xaH8t9lOpsi/+tnsv7QnXlsCc
         ySBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQGuvng4zGGv5wxqMi1jZPorRLuXoaTainTjhtEgYIQ=;
        b=jzqCAXZLzZRT/n6NLqLbuq9zP9LYV12xe2xftGexT3o9jUxrS0XiGdWpAy4D8A56o8
         uKsAd8A2ltazfsVJojmxK1HwBTtLV4CeeLRui1zrvZivGmHOpeNH9Gb3mTlAWcWABK0K
         /gIkXYwzTqTLrNf0u9DP83fmt2UpcXwOLcMhaPEwlWDREKFyNVlLHzZgkpquK2hxI02f
         2OUt5KrxJiQj2PMhSuMZ7UL/DkA51LCOm1oh6Ze24klLfd7JOAZXzy8sXtvwfWMOMOud
         CSTTN/EtmRAo7XxY4+L1BV/dRhDpkhykuzv4gVjAHxpGPU/pPVvEurwhQ4llV1fy1GN3
         YXbw==
X-Gm-Message-State: AOAM533zcRsYlAq6ZDI9hDEWTg+fz9dI4YZaXvC13mgFforLp5ek72RE
        9csxg1xzaST1AaTXpnIQanbRCA==
X-Google-Smtp-Source: ABdhPJyDqNvFIRfBk7tlS98FRZ3FzokDDKiYSA1d0AeNz9UYvOdmQl1YlcVymLO7LJYmuo1SKTaFtQ==
X-Received: by 2002:ac8:6055:: with SMTP id k21mr2150455qtm.294.1589452659861;
        Thu, 14 May 2020 03:37:39 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h3sm2346327qkf.15.2020.05.14.03.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:37:39 -0700 (PDT)
Date:   Thu, 14 May 2020 06:37:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200514103720.GA544269@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <20200512212936.GA450429@cmpxchg.org>
 <20200513192410.157747af4dee2da5aa0a50b1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513192410.157747af4dee2da5aa0a50b1@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:24:10PM -0700, Andrew Morton wrote:
> On Tue, 12 May 2020 17:29:36 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > +		inode_pages_clear(mapping->inode);
> > +	else if (populated == 1)
> > +		inode_pages_set(mapping->inode);
> 
> mapping->host...

I'll fix that.

> I have to assume this version wasn't runtime tested, so I'll drop it.

It was, but I don't have DAX-suitable hardware so that config option
isn't enabled anywhere. I'll try to test this with a brd.

Sorry about that.
