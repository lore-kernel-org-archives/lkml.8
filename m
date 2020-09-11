Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F3221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlm5X4kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgIKIqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:46:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A284C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:46:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so6793525pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1GkA0UL55bpOzq1799709zbI1L7Jh544dh/Usr44kfY=;
        b=Qlm5X4knHMrYRafI9yPXpq/lAMmN7kMUumWHzSyktdaHpfYBjRf1L0i48OjrFnD4fM
         QC5/LOrJI4cjoM4qJqWw9UqmT0WvVcjx03RbQaUbQLjEmaxWdw1M/dcHa0maDsXfUJ0W
         wM5ZIAfEEoRPx0B/75qP+WTBhhOJylPJkkUHV79aUXsMANVTl3BIpBjXp4ena4YTrf1r
         3mxNqotZn8thYnV+HLFlVfvzhOmi1AOSCxKWWohGR0wi+6t8I1S4276qyF/Y6m44RkZl
         jJfGxLqFjGk/gV5j3dHxwjKVa7HqscPsihjNOTSQqVx1Vjca8hPk22xcCdmXm/Jlj+Uy
         6K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1GkA0UL55bpOzq1799709zbI1L7Jh544dh/Usr44kfY=;
        b=PsgD9GOrwSOnS0m15EsX+ChpWrh/HZEK14BWQ96W9AUs1pspfNMpdidh1sC9nYUcTs
         iOvheBSP29c3IJB4rL9xb0zEM5wwWmeJqua0O3B9BhnezQaiIYxMkD1Vk+DslYRYK4WS
         fDuzMP8zEjHKbHlUT3ucdFOVAARqmiZAhoYsRHHU7wao5jTyvybseW9Zv8UvfzhibGIP
         EdguDStJZ7vLq9v1pVJSk97CKMxRa8UUiHLr8ZD3i7JSTee1ndwKu7kDsaq4kW58n4CW
         tm1nGsxo8uJoCMPI/j6NJcuguwFUx+dg9gPpI5LefClh5y6wu0a/jndsj8pV9phtK7je
         e60A==
X-Gm-Message-State: AOAM533mjg86bmztJDtBrlHy6bH7eaB6/oWKlM0ghexr5/Zn5rFab19t
        PmhW91EKh1PpZfvLx4np0sY=
X-Google-Smtp-Source: ABdhPJy14gOgqqZY97TQbIkEVgxM3qq0OMF4Cuu0NkODRuyBetn3P5gFLShii+KjF6Qfx1erVNJ0hg==
X-Received: by 2002:a17:902:fe08:: with SMTP id g8mr1051664plj.122.1599813977903;
        Fri, 11 Sep 2020 01:46:17 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id k3sm1602956pfp.41.2020.09.11.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:46:16 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:46:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     yezengruan <yezengruan@huawei.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>, joelaf@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        suleiman@google.com,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
Message-ID: <20200911084613.GA562@jagdpanzerIV.localdomain>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (20/08/17 20:03), yezengruan wrote:
> Hi Sergey,
> 
> I have a set of patches similar to yours.
> 
> https://lore.kernel.org/lkml/20191226135833.1052-1-yezengruan@huawei.com/

I'm sorry for the belated reply.

Right, quite similar, but not exactly, I believe. I deliberately wanted
to untangle vcpu preemption (which is a characteristics feature) from
pv-lock, which may be somewhat implementation dependent.

Perhaps vcpu_is_preempted() should not even be implemented on per-arch
basis, but instead it can be more of a "core" functionality.

	-ss
