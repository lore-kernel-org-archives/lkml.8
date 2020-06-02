Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E20C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56424207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591071210;
	bh=WRqm2lsnI1KzaGBXl1+TuoJhcuKWeMyjbWFeacov+5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YGDGQxfKFz5tNLLGCjdtf155lgGZlvIBnhDSapFNehenQqDOvn2FwiN8vp8s+bw/8
	 BO78835V/2ETr4fUpY5ApM7Ssq2mqMnBcaKOP8pUE7veIKMIHYi7jjiIoOHkysF8Q2
	 0HqeH6JyjJc96WtahzPWE7i+QVNLuIgDruO+2+xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFBEN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgFBEN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:13:29 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DD4206F1;
        Tue,  2 Jun 2020 04:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591071207;
        bh=WRqm2lsnI1KzaGBXl1+TuoJhcuKWeMyjbWFeacov+5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ef2OorvJBpLzv02TECmUVV1crdNvOQeMy5XRVPoOO0CllbC62Lxr1i7hHU2zpSZ4s
         KPVV7prX/kBb2SA0etLuYn8BPwdGGudNqByHZ9bmC34f+ee4Yy/XwlvBU7su1s3rMi
         zk0ICFhpYNbAfrBOhfneHa1W9gj/bgZFM3Xk1lOk=
Date:   Mon, 1 Jun 2020 21:13:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
Message-Id: <20200601211326.8ea8dd37230b28022fd5581e@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2006012022440.1288@eggly.anvils>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
        <alpine.LSU.2.11.2005231650070.1171@eggly.anvils>
        <alpine.LSU.2.11.2006012022440.1288@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 21:05:25 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Andrew, I've noticed that this buggy
> mm-compaction-avoid-vm_bug_onpageslab-in-page_mapcount.patch
> was still in Friday's mmotm 2020-05-29-16-09, despite its replacement
> 6988f31d558a ("mm: remove VM_BUG_ON(PageSlab()) from page_mapcount()")
> getting into 5.7, thanks to your "incoming" to Linus on that day.

Thanks, gone.
