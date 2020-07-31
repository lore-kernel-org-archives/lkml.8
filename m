Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6953FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470E32245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596215166;
	bh=pLbeAibfw5n2vkRG3FD5oxVwpEDd8hei+OHLkZgRQvw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0ebfKj3DCiOiHlRtBfhagjJYKIIp2/YgMrJMMIM1gMiorkYgb+dvvifsGykMLGynJ
	 T72qP7YdHhUmBsfSww5UU3oTfhe/Gb7wvBivQmR967XxnTjy+fgW0O+D90hZFTAfP6
	 clOvC4Ve1mAMmDNXScGImp4gMkN6M9IDv0lbywwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbgGaRGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgGaRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:06:04 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A966D2074B;
        Fri, 31 Jul 2020 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596215164;
        bh=pLbeAibfw5n2vkRG3FD5oxVwpEDd8hei+OHLkZgRQvw=;
        h=Date:From:To:Cc:Subject:From;
        b=Hjwd8hIOq2+YnSWgcfAaNT3mNNczNPK0tA7gx9oFNc8GF8v0yf3VaLACd2KhJjoA4
         SIBdIPBq9kLq+UFq5caZc18jgsGVVHJAAN4S4KuZl0bk1v34gwmAQXYRpLaaKeVLNu
         6C9M00qHahqAzb6E2MjmIm1ZUkDnfk6pTmD+ahFE=
Date:   Fri, 31 Jul 2020 12:12:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/2][next] Use flexible_array_size() helper in memcpy()
Message-ID: <cover.1596214831.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series aims to:

1. Make use of the flexible_array_size() helper in a call to memcpy()
2. While there, use the preferred form for passing the size of a structure type

Thanks

Gustavo A. R. Silva (2):
  mm: memcontrol: Use flex_array_size() helper in memcpy()
  mm: memcontrol: Use the preferred form for passing the size of a
    structure type

 mm/memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.27.0

