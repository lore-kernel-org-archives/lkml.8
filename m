Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D48C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EF52075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Gt2BfRBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIGM26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbgIGMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:22:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32507C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 05:22:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a15so15978952ljk.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OeimeRwYw15Dm5RC3eo69tmFfj1HBBCH+Ah5VSbh/Ao=;
        b=Gt2BfRBeLNDr0PblRAOYsE4HNTz4wKvTVDu7qg36r+FUseQBeVGogfyt7JJY3STT4j
         Fzy2fYx8DDhHvCXTmvsX7sj4xfCcgI+PcjmlG7+o/24nsuKPssEmxA5bWZw54Tp7mMA4
         8TIyDN8lzrlk7WAwLmenIFX0LPFQPe39Ymg3eEAcnZlmRSVQ3Ks1S8ZTGKDiZgkptQLn
         LwpMRMVFFfFD5T1kqMWPqtQf2gPCzYEQcMCkFzdZVao9BqqmBpz0JMA6CXHYgX+4lIT6
         NhgiUqjW9sCi5VH7Zw+xyKCHSs3ptiCTXv0qrdaz52vPmEubrEkjzqaDfxugUYBHfWbs
         s6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OeimeRwYw15Dm5RC3eo69tmFfj1HBBCH+Ah5VSbh/Ao=;
        b=GFoM3pG9IF+f8pJq/ND2woJmztN1Zuv5geek6cLTHOMNiT74WkQ+XQUy476KiWoDm1
         3tfTw5i7x13N++7Z2wuSC0syRZeDTFM77kPKzdoKvJBA6NX2bBhXozvZ/yS75clX32H1
         H8FGHDYxuYzt8Ke8Ta6knobZJJFJLsDsy5xrjqHW/CmnzMxB2dE8W3fyoOmYVU/LEYfd
         aV48MHMIPVw7g4JLwP/VfoFTsxTbnnMqHDYKzVB3cfCMIJPSk+wbKCRBmLZviNnALwEh
         Y5PANFxihwKtRWqFfAlrdIQQF8cr0CW4xF/R/T4+URShx4V7CqAYtNx4GpC+SrkZGG9a
         shNA==
X-Gm-Message-State: AOAM533MAqzk7GkgvoJhwpp3b4DGdDQPY1lt0azXdnfY5ao46kKBUIbC
        QuxjMg1U7pTxruEH5mfBA3JfwP7RnvyZjA==
X-Google-Smtp-Source: ABdhPJzW0Pifwd6OEvOK71T48MQ3RPn7hLBhLx6SaBRHMIDZiRcdsyi7AiYq1feoD31R1T10xCd43A==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr10330338ljc.438.1599481344757;
        Mon, 07 Sep 2020 05:22:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p4sm7235316lfr.68.2020.09.07.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 05:22:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 109A51034AA; Mon,  7 Sep 2020 15:22:28 +0300 (+03)
Date:   Mon, 7 Sep 2020 15:22:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
Message-ID: <20200907122228.4zlyfysdul3s62me@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-2-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:13PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> When depositing page table pages for 1GB THPs, we need 512 PTE pages +
> 1 PMD page. Instead of counting and depositing 513 pages, we can use the
> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.
> This, however, prevents us depositing PMD pages with ->lru, which is
> currently used by depositing PTE pages for 2MB THPs. So add a new
> pagechain container for PMD pages.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Just deposit it to a linked list in the mm_struct as we do for PMD if
split ptl disabled.

-- 
 Kirill A. Shutemov
