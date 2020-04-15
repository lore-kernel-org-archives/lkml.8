Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A113DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386120768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586934162;
	bh=O3EE8adfJ7Xiulrk10cKHPtPh9AVfab/yVbPmRMdQwI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FyFM96vL+unDU+ufoMEGdKULOpQua2tLEier/cGGKKkBQYNyTMpG9GPPGHHZfww1S
	 n1ZKJHWC0heaL2Ee/IPgiRg3tS/+hdmzV0kVf7bJ+rGiyn5KKY3EcoQP4DiGgMTV6w
	 Jtocb2N5XFE7N3/KBJ4XaqOLFrtRp2+0W9ChZSHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbgDOHCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:02:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35745 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404013AbgDOHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:02:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id r26so17594628wmh.0;
        Wed, 15 Apr 2020 00:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YAjVwOW5+MAEVGUZITzA9KP2ft9GY7dJC9IkrG7J3Iw=;
        b=iZ3YliEPxi5ut2pMzERRZSOJI3M/K/V/egj45+oVUOFg4yZO0nhOi/O2MT1P+1izGa
         U4+vS6UE0jbQFKsU9YMr272UwRN4bMrwhd3jdHnry0kL7nFNKW2RwjfiXFOGEc7w/vhY
         r8RsyFewOmGQDXoUlOGsHqCl3nVIhb0ufWI1svBh7IQQ93Pujj3FOKTyVGhyGmEzMXYe
         OVenb5xHf0g8bwLDAR9iiuy0ZRuKPDKsYjZZ5ai/KPNiUdm0ui4yiMCjiHRudjPeFlCm
         9c71TBTDMq9QsQuccZOJa5Il8TRnGH0+/MvuaZHtn8mv8tkHs5lKc5ixUfTQnMAGmOl2
         XKFg==
X-Gm-Message-State: AGi0Pubw/H9OvbixtJUhLc59UfCFIiXpFPvvUakBKFi587q7yNSR501l
        kNArw7tYypGEk11OpXsxnXc=
X-Google-Smtp-Source: APiQypI5HqG7twtnkieJtfmzbu1uiIIPqFIE3j63CH5pDM0tP9ghY6y06m4sbK1+ERNGQzO0AIfQdQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr3551702wmi.152.1586934150877;
        Wed, 15 Apr 2020 00:02:30 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g6sm2960436wrw.34.2020.04.15.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:02:30 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:02:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: implicit AOP_FLAG_NOFS for grab_cache_page_write_begin
Message-ID: <20200415070228.GW4629@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just received a bug report about memcg OOM [1]. The underlying
issue is memcg specific but the stack trace made me look at the write(2)
patch and I have noticed that iomap_write_begin enforces AOP_FLAG_NOFS
which means that all the page cache that has to be allocated is
GFP_NOFS. What is the reason for this? Do all filesystems really need
the reclaim protection? I was hoping that those filesystems which really
need NOFS context would be using the scope API
(memalloc_nofs_{save,restore}.

Could you clarify please?

[1] http://lkml.kernel.org/r/20200414212558.58eaab4de2ecf864eaa87e5d@linux-foundation.org
-- 
Michal Hocko
SUSE Labs
