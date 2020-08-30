Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E63C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 03:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C894520656
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 03:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598757504;
	bh=W6gvSV7CV73LG+TEALyfCdBQYH0N27F4Auc5GectvNk=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=1hKYmpf4HKJcr7EpEocf7VfxRxkUkGX4yFkRUikpMyVe858X1eV6Tb5AG614Ep6JI
	 ywdltfg+gtHgcCfp3Rb25RFMipOUMXSM93/3CSpy+fFET+2IVt640yuXx4LAncfIri
	 EHV0VxBAd5eIKztxIFPgedwYowa9p4V0m8mFSv8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgH3DSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 23:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgH3DSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 23:18:20 -0400
Received: from [192.168.0.108] (unknown [49.65.245.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2176B204FD;
        Sun, 30 Aug 2020 03:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598757500;
        bh=W6gvSV7CV73LG+TEALyfCdBQYH0N27F4Auc5GectvNk=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=jYcS40rDc+LO9fgIx5/k/mWN7//WBVceF8mCLUZTALS7pizOkh0l9NCq7MQPC8A39
         GT5dA2YJc/kgrk+T9j9kORwTcygmWFPh+CHH2FXHAxwUpIX7NFUfWTKMBMMxbAjGrA
         TIpGUt9Cy9SbVRlzXD5lR4WAnrJQ6YTY1Cmlc9e4=
Subject: Re: [PATCH] f2fs: Simplify SEEK_DATA implementation
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200824214841.17132-1-willy@infradead.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <e2b8c2e2-3a99-88c0-d47e-547d2b3517d3@kernel.org>
Date:   Sun, 30 Aug 2020 11:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200824214841.17132-1-willy@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-8-25 5:48, Matthew Wilcox (Oracle) wrote:
> Instead of finding the first dirty page and then seeing if it matches
> the index of a block that is NEW_ADDR, delay the lookup of the dirty
> bit until we've actually found a block that's NEW_ADDR.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
