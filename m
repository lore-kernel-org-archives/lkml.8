Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D6C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D1A20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Y1/bjlAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgBCRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:46:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35745 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgBCRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:46:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so10959968qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ld2hKo1VVtLh85GuM95xkpkrEOr4cXfnnR866Aylne8=;
        b=Y1/bjlAvmbsCw+bx5ccjZlMG2O3glyHFV3S5dKW6bP6V+qr3NIns7f/4mkKEHGTzzs
         fHs5IkFUIwjEGnQe+EaR/cGJ+B3/+ChcGDy9/59MzIlCPtqMU9gup1upmpHCwo26gOXJ
         oihBsBlNVxLXkyAEZnT4CPJxWU+GwxwmXqbEEoGQtLuF8I38LadB2rxbLKJ+ybLtztrG
         +s0FYr4E1HJIBvHVry5aG0xS7yL9QFbN9Y+OU9OvLTeyPFNP9YWAQQcxfbV3tAvzYxap
         CKenXp5FVlXI4+t6JZp5XbFXZECooC8QXqOPVjCaEVxeX0TMIekFqmrTKKUh0SdaTNGk
         33BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ld2hKo1VVtLh85GuM95xkpkrEOr4cXfnnR866Aylne8=;
        b=V9BxuFIaOiahiUUoR+iJUmdugRlntqwVDsJN8yo99cIBdSe1U//an+Uqza4GAytfrZ
         XLMvjavihReuabaH6j1RQojAehW0Ylg0OIHiIsQvKhjMy2q2renzUwWcE1iN8d1U+nhd
         mbFR/WqJSaYqFb32WzZnOXltrwsmn08ngh6vQRmmw4/3Lbei2bXFD87Hgz+6pnQuRd6O
         QkOfUA414KbDESQC7xtEMhkYcwfm+2akaMH8XguGzjSaLRIuIpZkmzXvSXF5wn2L2f69
         6ap9uFcz2h8Dbxll2WOpOoxwEtzKFieJ+1cTBLeuSj++p//nxWYvpy7D5pSF2nSQbwBO
         2QLg==
X-Gm-Message-State: APjAAAVMAGnjJdgDaj6S+MmrQwU3B6B8dY+FtLQNWm3ORajvbQXsVI0O
        TgnTJquRyyz8vASUhVv1cPuzmQ==
X-Google-Smtp-Source: APXvYqwvNGweATvkO9MJzNlp4PdYrkODEVxpkMQrA/qH7ow7vCb2Tm2LNB3fdnf8GcrUyiDHeMTXWw==
X-Received: by 2002:ac8:4257:: with SMTP id r23mr24372603qtm.126.1580751989839;
        Mon, 03 Feb 2020 09:46:29 -0800 (PST)
Received: from localhost ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id g53sm10430559qtk.76.2020.02.03.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:46:29 -0800 (PST)
Date:   Mon, 3 Feb 2020 12:44:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 11/28] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200203174418.GE1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-12-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-12-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:36AM -0800, Roman Gushchin wrote:
> This commit implements SLUB version of the obj_to_index() function,
> which will be required to calculate the offset of obj_cgroup in the
> obj_cgroups vector to store/obtain the objcg ownership data.
> 
> To make it faster, let's repeat the SLAB's trick introduced by
> commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> divide in obj_to_index()") and avoid an expensive division.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Christoph Lameter <cl@linux.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
