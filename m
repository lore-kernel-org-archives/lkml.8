Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A68C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843820658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tilrUvK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCXMSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:18:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38083 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:18:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so18296585ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SPUCMMR/pnomJcGWLTMgKFX0vHSGUAZoz9GUYMTj4o=;
        b=tilrUvK9V7AIYx6emcjcWpLXFQEyHa+05bdQDIoIywZX2y3SMoEqBFiAybQqeaoQmH
         qCW38SL4fJ5VBAOb8iFlk///0sNWC25UhpYQQWKRgBijygrHu0xvBAtqsphh+EUTl/O2
         G/N7sSiUT0spzki5rmzIRfzFDkF3rhztgtSZFIbBY7oBrWXTwy66j+A3LVnCQDsi7qDk
         /Mt7MYFlctk0gdfk6O3vSL+Tj6CY4O0eXlyiZi2ju9Ktl4TK6O0hsWQBgPzPB8PW2grU
         HFeLO7sow8tEfwRFWJ+cSErDCMq4U85TpHZyFV3YvgQJyUfiAMty/XMOrODGeLxAgSoU
         xXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SPUCMMR/pnomJcGWLTMgKFX0vHSGUAZoz9GUYMTj4o=;
        b=KWEh1UGKz2dR4WeS/GufxAn35kxb3bGUpxy7AXnvwtecOTZrWiM8ZGbU1keiqBEgzv
         2tR0iPMopzVV7LdksphCIGtgdgFSiKSacTuBoz84/fVVuJ1s06YINm2wv1vvf2uB48R8
         8dI8Y/QBkV0xKAUM7kW2a/XWw6og9dOEjPoUqF57TjyrTWmWc2wFTQRqpTTO9CciyhL3
         pO/csgJgqwwEaP8+m+9RSG58RwNZJnKfTMCtWAiGC7XTyTUK5Ih1K1oUI0cQ6DB19cJC
         VUEhXFr5Yh0f8U71C13eLW1Gb2a13nkXhJOZT7wF6NpJfFnaBFWiJmx1Z6e0GJnf+m2K
         +pWA==
X-Gm-Message-State: ANhLgQ1S/nEgtiHNcJMzuEucRMk8G/sdzmGYU1RQgnHsAoZwL15ePgle
        mBsGitJ536X+vpRbwCm2z7Z7kw==
X-Google-Smtp-Source: ADFU+vv7lKNVww4QN95L6mxFqLdHghRsIBPHCaknhAn/jJAnLJ98SKxvbprs0oZ3hACQ1WILAjzmhw==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr17842543ljk.220.1585052278511;
        Tue, 24 Mar 2020 05:17:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f28sm2195911lfh.10.2020.03.24.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 05:17:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A56051012C3; Tue, 24 Mar 2020 15:17:58 +0300 (+03)
Date:   Tue, 24 Mar 2020 15:17:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, sean.j.christopherson@intel.com,
        thellstrom@vmware.com, guro@fb.com, shakeelb@google.com,
        chris@chrisdown.name, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324121758.paxxthsi2f4hngfa@box>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585045916-27339-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:31:56PM +0800, Hui Zhu wrote:
> /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> control if the application can use THP in system level.

No. We have prctl(PR_SET_THP_DISABLE) too.

-- 
 Kirill A. Shutemov
