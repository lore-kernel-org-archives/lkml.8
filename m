Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9973CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7120760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+veirxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGAUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGAUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:03:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:03:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so11445514pfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LLlCSg3wFZxdInZpyFkkqv9fx47XurIkaRWTEZh/Vfg=;
        b=N+veirxC6q9Jg43Xh5oVdvEX/Bl6N4PRWBWLZNBWmbtVsNuVbMdRgbl8JDbxTbhQtF
         omFASxNcNrY2gU300IHgJa8SKI/SUWTuXzoucgKv6yrk8Bb3q/NxvCqLdhxTZEFW0M5Q
         nUhFF9n6zVRjbsIakT1pFEFaFsHKrMC/7GHQ6LYmklPEvBqh4+15WXxilAzifDaZaMPY
         5V6K1Wd4tyUd7LRRmtjDcqAJSpNbeNnDjNcqaCuLpv6VAEq47yQVRhlFLRmCv0oY40my
         fqbqMTyYzRyhsyNQxSJvGle0dKCIZ+oUymQtHngEbhiR3oDLJKy4oq5OMdE/4gCoFLt1
         lx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LLlCSg3wFZxdInZpyFkkqv9fx47XurIkaRWTEZh/Vfg=;
        b=scH7FGYRKkqBnK20MLBqfMnaEiJHrwVc8O2H+nfCVE56wVIhr0pmvL/SDoN6lkEZDa
         obqeaDna2FxDBFTTQwgp3A7FPSHQzO2o1kdfToPDkbX2SciLy+Y+ynl807lcoKuDIAuB
         Oyaoof3tAtok3bP3iTmyuXbUuV6U8a7ccBAxS/P5vRy7sNlpYgU0kpGQZs88xbhgtlDM
         LcYP4IWxT7lCX+i0L3fgFiYlhUu/5cWXOT+URjPlVL6KS4k+ssyT+ODxJkfreRTaIDC7
         bj71OEXd2Ttrr8URtYaLoJKJHtz9RUM8X3nmtOjRH+d+v5kv20UAkpTDsnBxf/y9X8Hd
         sW+g==
X-Gm-Message-State: AOAM531iWp+xhAI3RHnosNSnsxz/UOlTGF/iT4BqJECJ6EZmhMLeIGS3
        DWiJ44AJYNW89i/M0FPQxsRw/Q==
X-Google-Smtp-Source: ABdhPJxBAW8RzOdi9h7XE9ImdkUrGaumHlNPBkSMbKrMSH9JkKtgCbkfa6zCr63HCxxd+DiZIPurFg==
X-Received: by 2002:a63:515a:: with SMTP id r26mr22767294pgl.204.1593633818169;
        Wed, 01 Jul 2020 13:03:38 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 8sm6058629pja.0.2020.07.01.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:03:37 -0700 (PDT)
Date:   Wed, 1 Jul 2020 13:03:36 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 2/3] mm/vmscan: move RECLAIM* bits to uapi header
In-Reply-To: <20200701152624.D6FBDDA8@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.23.453.2007011303250.1908531@chino.kir.corp.google.com>
References: <20200701152621.D520E62B@viggo.jf.intel.com> <20200701152624.D6FBDDA8@viggo.jf.intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Dave Hansen wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> It is currently not obvious that the RECLAIM_* bits are part of the
> uapi since they are defined in vmscan.c.  Move them to a uapi header
> to make it obvious.
> 
> This should have no functional impact.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Daniel Wagner <dwagner@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
