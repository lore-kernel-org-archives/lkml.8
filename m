Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51832C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DA72145D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587439515;
	bh=H29oCtqsrJtGWyg/QmRKF2AXzQxEwBYJaGQqfrdaBIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ttyqxkE8N8Ujj+tSfkO4hCl5S7F6lYrLm53cNHkVy8yjiUd3vmMMuWVEyQvgAuujH
	 XIp4VVDo3fkrDHUfuFetDvrhd/f2/fz3VcvV5JMtup9YQ50KEZsTyt0V416nUdnHzc
	 H6fXv42MSgRusb3PmIE5UUnj45p/1DNKdzt3GlBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgDUDZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgDUDZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:25:14 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C310206F9;
        Tue, 21 Apr 2020 03:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587439513;
        bh=H29oCtqsrJtGWyg/QmRKF2AXzQxEwBYJaGQqfrdaBIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JG7FSWTdN2QwjRKOyL04yifSxZUp8D6NrGwqKaBut9eS5w882u7MYS5c1iXvZaWzV
         p6tdkBdfSdH31LdypXsi3BPb4bgmWo4E830nbs5CKfm6qn8/WOZAKBZhpkwSk3yFB7
         bmkquRPoaiAVVlV68lzal/m9OjYpn2eYa4YVTveI=
Date:   Mon, 20 Apr 2020 20:25:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: fix to avoid page count leak
Message-ID: <20200421032513.GA134303@google.com>
References: <20200415021313.95538-1-yuchao0@huawei.com>
 <634e3958-ee48-90b1-f32f-60e2bc4ca88e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634e3958-ee48-90b1-f32f-60e2bc4ca88e@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Let's drop this patch, I encounter bad page state (nonzero refcount) reported
> by vm w/ this patch.

Ok.

> 
> On 2020/4/15 10:13, Chao Yu wrote:
> > In f2fs_read_data_pages(), once we add page into radix tree, we need to
> > release reference count of that page, however when f2fs_read_multi_pages()
> > fails, we didn't handle that case correctly, fix it.
> > 
> > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
