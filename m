Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93390C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EE120739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594076657;
	bh=NN0zw6E+k1d9OSCRphweuAXQl0YWLIAiZehjtdeXUhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vE6x15BObj5C7KuZ+yHd+1xltcbFQQ1KfQQ3oqlIWCZV7AnRvMqMYVkTbu6lGWioa
	 Mn8Eou8+bjJOdpqohaEfQTSL8rGk4end+9ws9Sqqk2QG9UATDygN6h6VlJRA9pOceq
	 n/TQxqH0PoLLBTYqTX57lAcXyWzfIMCX3TBGknBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGFXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGFXEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:04:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1137320723;
        Mon,  6 Jul 2020 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594076655;
        bh=NN0zw6E+k1d9OSCRphweuAXQl0YWLIAiZehjtdeXUhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJ7lfb3wtS7Ro4s6pnM5O6styAzoxY3NoA3FIkMSOaqyzksaUZDPG0W/qE0+2QzbK
         xI6Tmked0/xDQwGZzIzeZPO01PSlQEzmLcBa50cM9QTZmSFNgeMTkF6wAHFrjOcSOo
         YKrh4a5hLBDj44+JZ2tii883O820MzmOEuCHTn4c=
Date:   Mon, 6 Jul 2020 16:04:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org, thomas_os@shipmail.org,
        thellstrom@vmware.com, anshuman.khandual@arm.com,
        sean.j.christopherson@intel.com, aneesh.kumar@linux.ibm.com,
        peterx@redhat.com, walken@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 0/4] mm/mremap: cleanup move_page_tables() a
 little
Message-Id: <20200706160414.ad1ff64c5efc2d0abd087dab@linux-foundation.org>
In-Reply-To: <20200706220648.qfzwnitoswbbkdnw@master>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
        <20200706100819.flwgozlstn3zl66u@box>
        <20200706220648.qfzwnitoswbbkdnw@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 22:06:48 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >The patchet looks good to me. I have few nits, but nothing substantial.
> >
> >Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >
> 
> Hi, Kirill
> 
> Thanks for your review.
> 
> Andrew,
> 
> Do you want me to send another version or you would like to adjust it
> directly?

Please resend?
