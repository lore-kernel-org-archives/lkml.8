Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9D82078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M4ITrRhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393989AbgDOO1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbgDOO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:27:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:27:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s63so13193794qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UT8lst5nDXa5EduKqboY813zRQkbwrz0jocGjjJQg4=;
        b=M4ITrRhk7dfzvUeRdnL4el+TCzeHs3naP4MrWW4R1ebq1UIOWnrl93o0W9yRfnjzHy
         NT032XMp1hFXo56VJAe4LrTAJy3eE/dHu37RBmLt2Zl5j5aNPUg7XgPdeK5Nc0z8l935
         msisJ0cQFtktiusujfESKJ+ZOURH6tbRVKt6mnLWAQuba28l/jNyCYQCghrerFGhW0cJ
         VrTpFPgcobc3NRi5mFK/mbFhgNMIjkl6q6wtEucefdcmM++kvP83i7hObsP1GN96TDcG
         xrqPzBLivfZkOewyhTOIO+Hq3K1umGyG+P0qUutNW6Dm6RzqofYyRH65wS2ceiYOi19V
         QUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UT8lst5nDXa5EduKqboY813zRQkbwrz0jocGjjJQg4=;
        b=e1wEpdhKOMYnX4mc6BL6L4UgVMP58cuZGrBHSekJPa1N/YNnKUMS14kLu6bUnziLPC
         En3d2tpYLTuiJ5ta42uFPMSaeLd3zbX5o/xmd+t3d3VxbB6nGAwloBXvACz2IyQDaK+3
         yyRWFn5uZIQHXDBIy9aWk9JtBLew0fqFPaxlHjtG+ZQhnz12iLktQHeFJB2gero7+ywH
         Jv+5Pelc0m6yo0NHoudnGMl0IoDeL5GJTbNnoVS1tGCSxri2mj6/DGsjrlvDoNn7oF+s
         mvZ13ADr6iLGKrsnSfwJ5Gxk+gKGQHNw/ANldzRU9rO6u7MeTrntRxuW5XcNQifAEgfB
         ehLw==
X-Gm-Message-State: AGi0PubKMc0NoRHOmtK1LNULCqe/UQWUO6c0lQY1fjxAIu/kVwIIiiCC
        7SvXup21ACGXWiRNnWEQXT4PJw==
X-Google-Smtp-Source: APiQypLaOI+L9pCKFHu2QPiB6b7nqxtp36pMRhQOjDoNH7Il0R7qpTY/S9EZXVMsSsn12k0BoKrNtQ==
X-Received: by 2002:a05:620a:5fc:: with SMTP id z28mr27276673qkg.346.1586960856921;
        Wed, 15 Apr 2020 07:27:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v187sm12740442qkc.29.2020.04.15.07.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 07:27:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOj0p-0005zU-UU; Wed, 15 Apr 2020 11:27:35 -0300
Date:   Wed, 15 Apr 2020 11:27:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in
 nr_add_node
Message-ID: <20200415142735.GP5100@ziepe.ca>
References: <20200415140910.GN5100@ziepe.ca>
 <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <OFF7AE12D1.38AFBC66-ON0025854B.004E30DB-0025854B.004E73A2@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF7AE12D1.38AFBC66-ON0025854B.004E30DB-0025854B.004E73A2@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:16:54PM +0000, Bernard Metzler wrote:
> Fine with me in principle, but we would have to return
> directly here as well - since we do not have a valid mem
> to be put back.

Woops, yes, thanks

Jason
