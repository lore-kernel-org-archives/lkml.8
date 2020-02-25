Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50456C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C21A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YulCSFeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgBYSXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:23:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41211 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbgBYSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:23:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id b5so95520qkh.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eau5VULTn0g2cg26CZfaFmmdDpyEbl+Poc4gdYHXnvE=;
        b=YulCSFeQwMWMd8X2Q9XXl+VGM7pLvFqtCdUQkdbz+1V1tZ5Md0EV8VBmid0D2rpFXb
         5v5E/Z87tq1N+haOuMyE+wAVn70RX0OD4uFzy3iUq3VjrnzU2VtAcGcVQTJLOT1Yu78b
         mu4/PrVnkNp7dJod1+77YPtJHhW1syhL5evLUbIQDDE/7w8I9FG13IXd7pt0BQIU3FSC
         +IZzzpnnx74gBOepkBI+KN95ZimOsO8qWRDOi/qq1cMjhz6yrGqIQapQfugZJHcjZwrI
         G7C5PkoNfJWyA7Igdf/Y7mDSJBPggt40I98QjKWD9bbuUez/ypWTt62M3clTIihlusFm
         PgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eau5VULTn0g2cg26CZfaFmmdDpyEbl+Poc4gdYHXnvE=;
        b=GQkrDpim0d3EqboIkuP//T4wiXjMWJ9I4VWVCCdTnjfqcqLryXgm6YJ2ptI8w+kOXz
         D1MiYevdr8NAlL4btez6fsBOHtm/Tg/+ETtoPi2BQaCfjg+cHsoAC89QS4e/IV2jZSrc
         D56VdRY0WgUoKxM1jDpiBcY8dvFqZ7KIj4jPMmmEWEKHz1IR+EyUsMNufIHJfbrpVlV9
         9E7/jsYCG7YbmE1Zgqm1y5iFKirXiX05/JvmWJDtyJY7GheoNSw/1hgtJZn/qczDOiXk
         p3U9ZgGfSN8YHOX0nQItAb5i3EF96Qv3Hm9AMZXfAyfpEfekOquKVNLt6muA88PVvHWN
         TF9Q==
X-Gm-Message-State: APjAAAUgkUa9RMGtOsTlwxCWZlboSM85NwH9rdjceSalLd+UuFEp3J3N
        taOEuJ6Q/hbuVkJ/1T0GPzoXe2/rDAQ=
X-Google-Smtp-Source: APXvYqzHzTEZDBrq6YQ5dMY901YvFpjixaEtZzSwpviQstu+mluVhiT619QbcL/npwlJzojcsA1mtA==
X-Received: by 2002:a05:620a:2185:: with SMTP id g5mr159440qka.4.1582654988641;
        Tue, 25 Feb 2020 10:23:08 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b5sm2938736qkh.58.2020.02.25.10.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 10:23:07 -0800 (PST)
Message-ID: <1582654986.7365.120.camel@lca.pw>
Subject: Re: [PATCH] xfs: fix an undefined behaviour in _da3_path_shift
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Feb 2020 13:23:06 -0500
In-Reply-To: <20200225180725.GA29862@infradead.org>
References: <1582641477-4011-1-git-send-email-cai@lca.pw>
         <20200225180725.GA29862@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 10:07 -0800, Christoph Hellwig wrote:
> I think we code do this a tad more cleaner, something like:
> 
> diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> index 875e04f82541..542a4edfcf54 100644
> --- a/fs/xfs/libxfs/xfs_da_btree.c
> +++ b/fs/xfs/libxfs/xfs_da_btree.c
> @@ -1986,7 +1986,8 @@ xfs_da3_path_shift(
>  	ASSERT(path != NULL);
>  	ASSERT((path->active > 0) && (path->active < XFS_DA_NODE_MAXDEPTH));
>  	level = (path->active-1) - 1;	/* skip bottom layer in path */
> -	for (blk = &path->blk[level]; level >= 0; blk--, level--) {
> +	for ( ; level >= 0; level--) {
> +		blk = &path->blk[level];
>  		xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
>  					   blk->bp->b_addr);
>  

Yes, indeed. I'll send a v2 until Darrick is still not convinced that

"path->active == 1" could reach here?
