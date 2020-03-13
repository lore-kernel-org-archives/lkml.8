Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039EFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37120724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aB7dTDeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMMWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:22:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44274 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:22:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id f198so12014112qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M68LOzWrZXFkDlXwdy0ZNT0fx/04UzLIGSmzsrY5jic=;
        b=aB7dTDeWRO4el1VBMvTJwNIIBoz2Wjnhxho0HYufVMJEfjmBfOpuXLwrcL7DLYTSVL
         iXSb0m0D+aT/tYpWBsL2bNpvPSJWkIZjs2CfdAUan/l98zTxRdtTma6YYvzo8IsdjmeC
         XjpTXwss/3scxmXZ1vucQUgiPyTk1Jlr3ieck4Dq0IQzCKdB9GNugPvvl2PU66GQC0ba
         r3+0UJMv2E+3dxC1Pp2bQ1aBHqUttR8DiIv7dEy+02WZk7GEVLrH8xgIr8IkFraOVMwa
         fvZKJh6aF9YuCjcvg3hbWNErJpk7l5MvrGncuH2L2y+/HWZyoRfI4t6qe0Y3hOR0A85C
         4iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M68LOzWrZXFkDlXwdy0ZNT0fx/04UzLIGSmzsrY5jic=;
        b=E42cl9QuE4I3QdzZqklXNO2oBrsm0lOoJc2/xJyGg1wq3rtsqZCdEr85wCoxYjcDm1
         +sL9Zkn1H/Ll9ZOVyP8oOQ7SNp49AYwh/uMEuKfjSXDR4JuBSeqpphuzFIlV3dUhSbJ5
         fESZMQgZsThULcvbTu9J7fRhZ6TmG9DxoA/h9Li9PpDXvw7FsAms9bNUTOpXxZAUR3mQ
         qC+Vy0+NzC1GO6hBzb/Wu8PUOmuSRLKOiVjZ81zK9L0rwzAD1zvdNXITPYh3s1z1yETu
         xOTBcWAPXMHIEUfB5ys0nqrVG3kkC3l1JnFn6lwl1KcD6q7LRg0zArNQn77ZaV5Nf0T4
         SvzQ==
X-Gm-Message-State: ANhLgQ1HJhrkbUBNrXnjJD+seQjhNKeU5R4yRFdyM59mK4MSpefFvNPv
        WUv5HUgt2SY/itG7KpThI1pY8w==
X-Google-Smtp-Source: ADFU+vu2uTBKtOSnaTFVMBpQbNxa0sfETj3EWskkZER6lw6bscuPlfohRdlH9YY8sBRl2pVyOlrNHA==
X-Received: by 2002:a37:648:: with SMTP id 69mr13005055qkg.353.1584102131258;
        Fri, 13 Mar 2020 05:22:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t55sm30553520qte.24.2020.03.13.05.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:22:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCjKM-0001tj-5O; Fri, 13 Mar 2020 09:22:10 -0300
Date:   Fri, 13 Mar 2020 09:22:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jglisse@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for
 lockdep_assert_held()
Message-ID: <20200313122210.GB31668@ziepe.ca>
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 07:41:00AM +0530, Souptick Joarder wrote:
> walk_page_range() already has a check for lockdep_assert_held().
> So additional check for lockdep_assert_held() can be removed from
> hmm_range_fault().

Is there a reason why you think this redundancy is bad?

IMHO it makes it easier to understand the API contract if key top
level APIs have their assumptions coded in lockdep.

Jason
