Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61602C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5CB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU22Lzy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDTNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726211AbgDTNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:34:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:33:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w24so8349228qts.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dgcftu/x9UJBDAlYur83CJBxDaYNRax3tay0BSAC1I=;
        b=IU22Lzy5xvOSkMk4nY9GJel6btu0P79YoTwDXl8tNArK7FeSG/MwZrkZzYxA6gpKWf
         mXdheuxaQtX9WA6meku8uL2M0H0ApYh7T7tIJyopNVjbqn08BCzXsc9o4vi1RRaGAHwT
         tRjVt8OCwDZoa95i/ZI67EotRl1N9uM7Zyod1e2P/6hCk89D1TdCchL6oddbjTFMRNNL
         z7moyUmJPn1Wy+lGrrpWfGcru3O1xHhbpA2pLROXt4oK4tNdiFru5olOE/5iv2qor+Pc
         rtsut25pBF7KlNchf1HS5BcbQfSY3Np1CD3WuYgA+GtN4NKi0dk0d4edOj7eaKr3WPMp
         jyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dgcftu/x9UJBDAlYur83CJBxDaYNRax3tay0BSAC1I=;
        b=M8BbKCv7jQFmrq5XAYgbR4wN5Rvm5ecsMvxm04my40ZlnWKyOncecwaiSDP3/1fxyD
         DvPuZ0Tjag31yH7M1CtFf84Q4H+0p158Ie8RZmRmBgYfpE5fdQQgREhxa3zacIlAXaty
         Ro2OvOMTWRK0xswLWJTn8JEXXejsIoDhASaC3YegGRKhIsxnfkcBdTEA726JXniS4t4V
         BL+V+cs6iquyIa6MQ4TCg5DQncE8T+eLXdlOFPqU2w/GFiGDvOw4Hzly76fVMBtuLsYH
         WARlATaczD5oWUqWD5NbknkMScB3tecYGQwT8UKtMVttYln4QC7qtGH8WjGhJE8AC70b
         8txQ==
X-Gm-Message-State: AGi0PuZnRttS3f9zd32KqZsaWlACenuDb4t4EWcWMPS/6iOOrpHPahEs
        0/GBoVCFlpWWFMvC9YcdbwA=
X-Google-Smtp-Source: APiQypKqZ2SRSSocsIkZ+FI5I4VEIWiZ70zveQ1+0fQpdyRUjm+hzSdLCMb6i91kypk0HmsutwDjNQ==
X-Received: by 2002:ac8:4699:: with SMTP id g25mr16352936qto.295.1587389638930;
        Mon, 20 Apr 2020 06:33:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p22sm518179qte.2.2020.04.20.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:33:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C594409A3; Mon, 20 Apr 2020 10:33:56 -0300 (-03)
Date:   Mon, 20 Apr 2020 10:33:56 -0300
To:     Jason Yan <yanaijie@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Remove unneeded conversion to bool
Message-ID: <20200420133356.GA24477@kernel.org>
References: <20200420123528.11655-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420123528.11655-1-yanaijie@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 20, 2020 at 08:35:28PM +0800, Jason Yan escreveu:
> The '>' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> tools/perf/ui/browsers/annotate.c:212:30-35: WARNING: conversion to bool
> not needed here

Thanks, applied.

- Arnaldo
