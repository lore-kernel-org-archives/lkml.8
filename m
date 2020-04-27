Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE8EC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5C02073C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588018686;
	bh=FZznVs7DKImH4bMp84GuK30NCRT+ks2QZb0zw61Aw2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MBBbsRElv/VW7l7KVuBOpNEcoF+g6XmG8MaIw9cKQfx2uWSdeuBjCEqmZf/wIm8r3
	 YVhmBgnHtdm1q2UDO7pLwPOaBQwbD/JHo5uhDzae1L5UjehUEv4C1kyiqPQCrkov0V
	 z+fPG8ERAclxCcq9alEg+6mRHTdbws0Rzp+ZN+C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD0USF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0USE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:18:04 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8ED2072D;
        Mon, 27 Apr 2020 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588018684;
        bh=FZznVs7DKImH4bMp84GuK30NCRT+ks2QZb0zw61Aw2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0dPVwJ/H9B7uUoDHVQh+JzhGMmouLB2JEnhplDQk7I3xuAgcbSFK60H1piEfCx5Sx
         t+jKABLjlMrQXuoJB1Wv7UdopSfsHYSYtmSlzWb93RhaIDNLpcyXt7Avmd+0pazZfN
         HbeEsAjiXXS9v7hdBuMksmtrvhaQ+taOUTUIOuQQ=
Date:   Mon, 27 Apr 2020 13:18:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sandipan Das <sandipan.osd@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S.Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
Message-Id: <20200427131802.3d132055a59535a0e6780e9f@linux-foundation.org>
In-Reply-To: <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
        <20200417185049.275845-3-mike.kravetz@oracle.com>
        <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
        <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
        <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 12:09:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Previously, a check for hugepages_supported was added before processing
> hugetlb command line parameters.  On some architectures such as powerpc,
> hugepages_supported() is not set to true until after command line
> processing.  Therefore, no hugetlb command line parameters would be
> accepted.
> 
> Remove the additional checks for hugepages_supported.  In hugetlb_init,
> print a warning if !hugepages_supported and command line parameters were
> specified.

This applies to [4/4] instead of fixing [2/4].  I guess you'll
straighten that out in v4?

btw, was
http://lkml.kernel.org/r/CADYN=9Koefrq9H1Y82Q8nMNbeyN4tzhEfvDu5u=sVFjFZCYorA@mail.gmail.com
addressed?

