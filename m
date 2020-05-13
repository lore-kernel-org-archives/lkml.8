Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044FC2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0293D2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TOxWqevy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgEMAfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:35:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:35:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b188so15671611qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W0ZQEN7ga0dc2y953RKuwDFvWVmhQkwP4C140g0h9uM=;
        b=TOxWqevyxw3M0QWnWOIOsqppeWkjkLyMF+AVscrFeMUBaHmTzGlwE3IYQMSgbYv/Ed
         DJdfq+6d110SvsA3pceOgF75HPJzGhrqBc9p8KNXNImlaOHS2cbG8mQd1cWNmt+wGiZ3
         5DT8jE8bodoe9o8CLsuvqXzdLXIn+44VoMWCrxikXWmD5yUIQ+MxwMLEFTZR/2Lq+Jh3
         OIs+dTrQbShDSFIB1prGG8a8+K9xkyeK2WSUu0FozX980TOriWzz0Bxch3CzmaLGAsae
         VJYNLPEh/+d78W44RJUNbSW7uAoL7zssbZ6y19uGTnVzrwDPX6oUrkSHn217VSSx+0JN
         InHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0ZQEN7ga0dc2y953RKuwDFvWVmhQkwP4C140g0h9uM=;
        b=cs0qyOSRAPZ0e+elPR76NUrIr7vDk2s+k50COsMb5QrBeGf2gRaZvbq8tTezMpbLFh
         f+2e2WYjVDlY/+V4dSdQnonv/lsb/DCYDUkYU8EwVjfUVKDZ8QiBB600kmZLWLyAHsAb
         DedgkElDUgHlJU5EZ+rVYGDqKo5GPaPy0FFAYul1hrTNWJupDYcAV8ySgWGwdignwzU3
         4g4khufke0ntkQHZvZQi64Jf5UIQM1/RRyhF4ENtvs/ZLQL4yN5KeKV97swq5NJ1+CPO
         fIdseq7LoDLy+U7xNkehaMIrrefNjcC9JJKumYQpwsB2e4RN0EgRLeVqnggiMHtnnpzM
         ba5Q==
X-Gm-Message-State: AGi0PubGN38I3cEjZxiKG3zcQvZ8II3LXyweBvf5aqWphA+QhDohsKV7
        viJkoK0wGc+p8BjS3rnVSF+YcA==
X-Google-Smtp-Source: APiQypJlsdFx0FTVDoPPXKE8IY8M+QewagBieVDSzBEMNEqhPQJ64DnQ4+BbfFKl9ULZx10d7hSN7w==
X-Received: by 2002:a37:a2ca:: with SMTP id l193mr21616494qke.23.1589330109720;
        Tue, 12 May 2020 17:35:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t130sm8830732qka.14.2020.05.12.17.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 17:35:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYfMa-0005DH-PO; Tue, 12 May 2020 21:35:08 -0300
Date:   Tue, 12 May 2020 21:35:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 00/10] Various clean ups to ib_cm
Message-ID: <20200513003508.GA20001@ziepe.ca>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:46:51AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> >From Jason,
> 
> These are intended to be no-functional change edits that tidy up the
> code flow or coding style.
> 
> Thanks
> 
> Danit Goldberg (1):
>   RDMA/cm: Remove unused store to ret in cm_rej_handler
> 
> Jason Gunthorpe (9):
>   RDMA/addr: Mark addr_resolve as might_sleep()
>   RDMA/cm: Remove return code from add_cm_id_to_port_list
>   RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
>   RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
>   RDMA/cm: Add a note explaining how the timewait is eventually freed
>   RDMA/cm: Make find_remote_id() return a cm_id_private
>   RDMA/cm: Remove the cm_free_id() wrapper function
>   RDMA/cm: Remove needless cm_id variable
>   RDMA/cm: Increment the refcount inside cm_find_listen()

Applied to for-next

Jason
