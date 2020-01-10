Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C17C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45B62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="S8msUfuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgAJXuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:50:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36651 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgAJXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:50:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so2757660lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Up/bORiVZCe+ht9daj4eKUM5Ea1UCapj6K9HW34R5ns=;
        b=S8msUfuLnxCHM8bT1qJiytka17qVyY8ZVrWgxMyflSfHUuBij6STEkbxfermPfL//+
         KtGfqQG87GiX2DcSRsaXoTWWzuXOCzOcviF1bjh+KZNEo2KJEl6UbQRpQlOEAN4aTdOO
         9uB6zwuq5WETS6YN8IQs41xzn3cXA68pp6ziVrH9amHmxk0w+18NMpJzyZSGRThntIb5
         nMzW7a7PoyU1hLUViTeMhRFkxjIuhpltULvEbquK97BB0Jb8/asISY0Zy9ZH2Ufpi7hW
         bAOfeTBm/G60sQxK4vTgBgyzWA1QInLlOptAdelRKnosGPeIDPVm7LALVXA7bBfJzxaf
         wjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Up/bORiVZCe+ht9daj4eKUM5Ea1UCapj6K9HW34R5ns=;
        b=fiKpiB0dqEpm+b9+8Xx0j+BNBOmwp720q3+xrD1k69mMOG2qGNHhKDto/gbc/Z/cuv
         nSzm75ozaj5Tj1iR+g5iDbEybacH4H9UpRPfZ9soKD+ufhR4+UoJoqAw8vy96PVGtsyc
         XKRSJUXmD64U8hlj6spUMnlvlgWmMAls0sR6ktoxR0PKSBCOAI7cNJcpzj9FdDVlzvYG
         Dx3IE241Pok1fVHmGYjn240cqkzSlFDgxdOw2xN1OVfb/6JaLbeisjd3XpBxHoJDtyxA
         8ct+ZtBIpS5tupjV6pQbSZDPDn/ELBGJNQ6NXCXUh54D1cqjJoADDGgJ6nBU0d/4MIJ/
         I8/Q==
X-Gm-Message-State: APjAAAWmrjNjBbzCgN+zArKpKcx841If7sZtDAv3/kNgNGMgFHfy1Edt
        mAFlPpjS5hrG3YtjJePbWxn8gA==
X-Google-Smtp-Source: APXvYqws4IPaym9XaoOdclFEODCMjxAzsLLkrqIrxCIiTw1AkyjTotz1ggJalhM7dmrxCBCmHHeYKQ==
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr3889435lfr.5.1578700248713;
        Fri, 10 Jan 2020 15:50:48 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b20sm1642796ljp.20.2020.01.10.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:50:48 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1E47A10144E; Sat, 11 Jan 2020 02:50:49 +0300 (+03)
Date:   Sat, 11 Jan 2020 02:50:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/2] mm/huge_memory.c: use head to check huge zero page
Message-ID: <20200110235049.kzvcm46t6e2mw4uf@box>
References: <20200110032610.26499-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110032610.26499-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:26:09AM +0800, Wei Yang wrote:
> The page could be a tail page, if this is the case, this BUG_ON will
> never be triggered.
> 
> Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
