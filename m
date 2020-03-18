Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E16C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EA22076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584519790;
	bh=jDvHCpypzcLcBBKtNJAnHnUIbtmoHA4If+zu0bErYGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iD0JPc8mAz0u5xBLvJ8pQloMHUm3xHPxVa2FJrtl3hB5SMd4MU0kXQnJ06vJRf0jW
	 DajgvHmQUR9IXtN3+8MMwc7l28BAuaA/J0CpU+jZva487qpITuQ5tIiqhnHw7sKVS6
	 +bPFLstVYhieikAV5X2VMuPGsuq9YvQ9+IyJV0FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCRIXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:23:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50829 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:23:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id z13so2164054wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u1Vg0mBLvEo3DD8HGaqtItvQ6lzE59walEAWqglake0=;
        b=iwgJSpDTnLWgPGlIafKKXkISo2ettNMoVsYX1VmWBKmuthXkzNBRDrJt27iICh8DyX
         8Zb5nyPqUYZSEs5Cnl4wzsevuoWXldMYvcKQZLFeiU/X6qRzpHIY2y/2RivVCfpokiti
         ecKl61GPlgnLR7lWUt3QtjDQWvblnYhFV8sHPNRTRoGtZnqzGsvkI0Rv+VN5sbOzSZdp
         5nPawOENPGWDfoKDi4ddFoPxloKfkSEvY7LahmnVUOzuh9Q6F7ZHq1tlxISHVyiDarjt
         X2xwikwJ4ANY7XQenNxC+NpL6RAiXhvXuCwPphZ4cAFBLzeSZAd4IDce/HXlVQZDtIPM
         m4CQ==
X-Gm-Message-State: ANhLgQ3FNt+wEKmdWU7VTTJfqIHBNZtmJdZx+zT2mCd5FFkRKh+PKpaG
        sZB81tR9xud5mnifS+ZN8VPE2t54
X-Google-Smtp-Source: ADFU+vv9coRwTHLE3umhggTpYzUH3ioL4391no4/tGzs7VITeqhq16r6w1jTqgWDnBBfQ6gbdU5Wng==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr3787266wmi.119.1584519352976;
        Wed, 18 Mar 2020 01:15:52 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id k3sm508962wmf.16.2020.03.18.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 01:15:51 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:15:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, shakeelb@google.com,
        vbabka@suse.cz, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200318081551.GC21362@dhcp22.suse.cz>
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200317190411.GD22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317190411.GD22433@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 12:04:11, Matthew Wilcox wrote:
[...]
> In fact, since it's only called by those three files, perhaps it should
> be in mm/internal.h?  I don't see it becoming a terribly popular function
> to call outside of the core mm code.

Agreed. I do not see any strong reasons why anything outside of the core
MM should care about evictability. So if moving it to internal.h is
reasonable without too much churn then I would that way.

-- 
Michal Hocko
SUSE Labs
