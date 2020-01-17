Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C04C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6D721582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579242498;
	bh=0RgEcPl4y6EU+Wh8MtTpHBo4siOzz7nrcdr5SAubNeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JiBrF6Ff3SlOrbh0w8xlVcZMCiaHhJ5Epv7choC8a6h285S36Ka4RjztF/nuram5n
	 U9rwLgyiOQQvgcK6NHzB1Px8Qk4xHqZpm8HC5g1hjlV0do9efFiJNmUHLECOwaZLCw
	 RzPpu1h0KdKoYuyiUr4AMAkoNHDjohSUgV8xF8jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAQG2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:28:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAQG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:28:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so21517409wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 22:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvF3fPu42sSx+4imIXkbIazKn6wGHRrvMJiDBLGJfPw=;
        b=m/oCh1sDRC/kXqKSFS+sZAhvHDlIfudqzQ2z6ERaO2XxSYSDY1hlY60vrt3yjZ+oV6
         pCmSJgVrL/qxg0vfZOKuBsCO5SvB3blBSkpM2AfI1dbgw6xQpQ/JWEVz0rpLAjOtjFAI
         zOztnxNq/nAvvliHOCGG/LDXa9Ye2pM5O8PR329p9AZ9bQBGXhDEdRFcs7OEXbGE349B
         /Brt1ByzbyUd3xxYuNojF4C6vScOSeGCa7C6pdy+tyTR4eiE18+mnyAPy32lYvh0ESU2
         HtBKneTYfaYyyWP0kCOT/zbt6sIjenyMUg6A08Oi3DmyPBOZ67M1BOcMA4Uy5KbrqJA6
         sAtQ==
X-Gm-Message-State: APjAAAWlW5f8Uep4qvQBJAjeJ6uZ0L8NItIa4cBa3CPuhqRwP0N1sAZM
        H9abWkc4Ra31h31V0lhVgzk=
X-Google-Smtp-Source: APXvYqwkZAR+jobw5u5vprLmpyWrVp8F0lhzB2GzsxGpJhiiei7yRMXMC6rKBJkshfqkczDtHNb/5Q==
X-Received: by 2002:adf:f484:: with SMTP id l4mr1321649wro.207.1579242495892;
        Thu, 16 Jan 2020 22:28:15 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id g25sm1700029wmh.3.2020.01.16.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 22:28:14 -0800 (PST)
Date:   Fri, 17 Jan 2020 07:28:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "buddy.zhang" <buddy.zhang@aliyun.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/cma.c: find a named CMA area by name
Message-ID: <20200117062813.GE19428@dhcp22.suse.cz>
References: <20200116101322.17795-1-buddy.zhang@aliyun.com>
 <20200116121240.GS19428@dhcp22.suse.cz>
 <6EE060CC-A19D-4F9D-BE36-14CB20C44AE2@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EE060CC-A19D-4F9D-BE36-14CB20C44AE2@aliyun.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 10:16:46, buddy.zhang wrote:
[...]
>     So, if device want to use a special named CMA area on module,  
>     "cma_find_by_name()" need export symbols.

My question was whether there actually is any device that would like to
use this functionality. Your patch doesn't add any and there is no
reference to any either. We do not add exports for the functionality
which is not used in the tree.
-- 
Michal Hocko
SUSE Labs
