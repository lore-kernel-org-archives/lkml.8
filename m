Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9479CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6840F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N8KwPRQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgH1OVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgH1OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:21:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0CC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so449443qvt.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTI6+GkcETTpHWIvvBypzVxQQpyEAhXbsVHo/bIanMg=;
        b=N8KwPRQVWfqwX32CjhM1MWZNedWHxDfw6QHu2eKgwvj9vZXqN5mcjL5D9YkLqZDqct
         qVdRY6y2fQd5JqyhniJ/tWcO1kt9vPsrCbbIbQXo+iG2GLNyJPMdkKtsmiuk9BxGJtim
         sYY782s/qFCyOcqJnIfqSkt3Mey4xuCjGbAzCME0dqtOf9yt+Oh3qnkDrmC2ueY6rOxF
         W9/Ocv6Pq7/EYz8n7ZAcDH/9kMa9jBAWYr0uJcvBCbv9K3HdEAlny7to5qpZ6rD9BmS+
         aeSPb8vfkGvF2XTgF18OVl35YbtXeH/Z5hi33XQem9U/qSlsPnsyh8Mw6NQ/8rFoA4iI
         qCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTI6+GkcETTpHWIvvBypzVxQQpyEAhXbsVHo/bIanMg=;
        b=juueA/FAO/wYOF10AEpPySC75QWU836lleuyngZxbeMVnuqdh5gd3Optk1mZZtQLgz
         LRovyJqhjZyeSxnRL2EHcK9Lc3RQuRPS0UKfZ8eW7Ejfe6/gmej9NXWQLTUWgB7anAMc
         QAKynjPoHztAqa52YeiyK2V3kdbeBrWNOfJtRqc8ByxgrCE8D1Epj2F1wdfcrvqtrE8T
         9JJrZQdH1J9lbYV/7pt9amw9MR2pZfIOc2Oub90zUASm1Y5fA1B15fpf67ZWvIXv1KV3
         0nwhtC9AmYjz1vCku7RK9WmNyhkKxaRZCZe7V2dRsC/OS5wW/q2jAS1TeynmL6Xh9LSO
         Xuyg==
X-Gm-Message-State: AOAM533vLXwKDScGQB4p0GrgvvBZId/bhwlerCLBMZLLpeZ65S21JzJA
        02puvY8MM69+xz3tYEsU0XF1XepcuZMOTg==
X-Google-Smtp-Source: ABdhPJyEOuyU0xtQdqC+cKFxXBrGrcvFZATJ82c4w6FNraYAEqPXVCLM//u0MJDGSkHpJPB93i0WeA==
X-Received: by 2002:a05:6214:184a:: with SMTP id d10mr1927526qvy.190.1598624498625;
        Fri, 28 Aug 2020 07:21:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m17sm931967qkn.45.2020.08.28.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:21:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBfG5-000hDT-3F; Fri, 28 Aug 2020 11:21:37 -0300
Date:   Fri, 28 Aug 2020 11:21:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828142137.GX24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 04:03:12PM +0200, Gerald Schaefer wrote:
> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> code") introduced a subtle but severe bug on s390 with gup_fast, due to
> dynamic page table folding.

I think the page walk code in mm/pagewalk.c has similar issues to
GUP. I've been noodling on some patches to add the missing stack
copies to pagewalk.c as they are clearly missing..

It would be good if this could be less GUP specific?

Generically this is about walking the page table without holding the
page table spinlocks using READ_ONCE.

Jason
