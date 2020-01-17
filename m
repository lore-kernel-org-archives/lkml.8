Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EDC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CB72176D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579251566;
	bh=o+/jCN9Nx23Qj7D8ajW2G2D+jhGD0zC+zQW0glrAnxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z8WHKqtQxIySc5+NG78Id7byXa2kBj+I2vATjyhcj14uX1MR3Fz/bOA0DWxmx3XHN
	 570mqbe0bcWdQYynC1CdEpSdQyygm/xpcvsuYg6L2NhPv8vy9RqrR9qhQaYadpGBdg
	 AE1zd2hhWj4/KE2rkGYC4b1QlDPAgKQ9/PSYmz7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAQI70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:59:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:48024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgAQI7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:59:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2742DADE4;
        Fri, 17 Jan 2020 08:59:24 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:59:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117085025.GJ19428@dhcp22.suse.cz>
References: <20200117022111.18807-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117022111.18807-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the updated changelog. Btw. do you plan to send a patch to
move WARN_ON_ONCE as well, or should I do it?
-- 
Michal Hocko
SUSE Labs
