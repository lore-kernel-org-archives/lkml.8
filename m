Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D863C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437F920838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHXMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:21:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHXMV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:21:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 066CDAC7F;
        Mon, 24 Aug 2020 12:22:26 +0000 (UTC)
Date:   Mon, 24 Aug 2020 14:21:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru, cai@lca.pw,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/12] mm,hwpoison: double-check page count in
 __get_any_page()
Message-ID: <20200824122151.GC7491@linux>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200806184923.7007-13-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806184923.7007-13-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:49:23PM +0000, nao.horiguchi@gmail.com wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Soft offlining could fail with EIO due to the race condition with
> hugepage migration. This issuse became visible due to the change by
> previous patch that makes soft offline handler take page refcount
> by its own.  We have no way to directly pin zero refcount page, and
> the page considered as a zero refcount page could be allocated just
> after the first check.
> 
> This patch adds the second check to find the race and gives us
> chance to handle it more reliably.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
