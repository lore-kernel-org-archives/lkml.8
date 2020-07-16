Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F862C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3413E20825
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JWGK3bQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGPOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:38:21 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11132 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgGPOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594910300; x=1626446300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=BxqBZUXK0tvmhEQw0AfMkmeDsnjHLMzKZTV9LKCn1OU=;
  b=JWGK3bQHWezkgdqkr5fKxL/n+cWZ81ERgS1wBbLYjLQqFKxkUH3BDTNA
   vHWAGy8eIeVIdY9fxsySLxagiLot9Dq83AghSN0mOJV8J0NqCbxftND81
   4Vi0SdtI+l7bBxHPN6SlJDCLR6+3KHvQ5QVRdYSzNdDkcYCqGTPncH/6x
   A=;
IronPort-SDR: SUuXoBasqWfXl0S667eDlnFpc/RsZ1xHBJeVlNM02wCBwcR1p9tYim55e9SW8XKevVNZ9tdo1s
 zV4bliU2lSUA==
X-IronPort-AV: E=Sophos;i="5.75,359,1589241600"; 
   d="scan'208";a="52126875"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 Jul 2020 14:38:17 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 40E78A1CF2;
        Thu, 16 Jul 2020 14:38:16 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:38:15 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:38:11 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: drop duplicated words in <linux/mm.h>
Date:   Thu, 16 Jul 2020 16:37:54 +0200
Message-ID: <20200716143754.29792-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d9fae8d6-0d60-4d52-9385-3199ee98de49@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D48UWA004.ant.amazon.com (10.43.163.61) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15T18:29:43-07:00 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled words "to" and "the".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park

> ---
>  include/linux/mm.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/mm.h
> +++ linux-next-20200714/include/linux/mm.h
> @@ -491,7 +491,7 @@ static inline bool fault_flag_allow_retr
>  	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
>  
>  /*
> - * vm_fault is filled by the the pagefault handler and passed to the vma's
> + * vm_fault is filled by the pagefault handler and passed to the vma's
>   * ->fault function. The vma's ->fault is responsible for returning a bitmask
>   * of VM_FAULT_xxx flags that give details about how the fault was handled.
>   *
> @@ -2613,7 +2613,7 @@ extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
>  extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
>  
> -/* CONFIG_STACK_GROWSUP still needs to to grow downwards at some places */
> +/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
>  extern int expand_downwards(struct vm_area_struct *vma,
>  		unsigned long address);
>  #if VM_GROWSUP
> 
