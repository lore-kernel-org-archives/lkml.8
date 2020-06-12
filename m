Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A474F20878
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591920818;
	bh=BHDLwQ4NKVsGm3dtY7FyF5hFRMR2IEXbr0Acsm+JZbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvYwbpi6DweN+N662NZksSY+ccz8JVKMgTCNHUYSE5EKQhjUs8qQC2lfM/qK0VwAH
	 XxrZFC/LE890SIi5EC06GK/zATZfoxVM15fsEXeqUKh1cczxZd0L3qSip+7TOOj9Vy
	 lkejucB6VceB8k2sGixKmf/EZT+znvg0TsPuPbxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLANh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgFLANg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:13:36 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3174D2078C;
        Fri, 12 Jun 2020 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591920816;
        bh=BHDLwQ4NKVsGm3dtY7FyF5hFRMR2IEXbr0Acsm+JZbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLL7M/7RBgmclrzLSuEbOGMCOjmaXjUqh/wGQArH/Ct8UwxROcyuO6GQTsLcPKCo0
         86zWe5PlYIr0N9tA5P6U9WiAGQ2XO2N9v2ZlkCtP1cZlfVeS5QWLE46HZzfhHdw0Mf
         aBn5STit0Q6DQjRdofkX5CsHU8R3paLletU8uTkE=
Date:   Thu, 11 Jun 2020 17:13:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200612001334.GB18185@gmail.com>
References: <20200611031652.200401-1-daeho43@gmail.com>
 <20200611162721.GB1152@sol.localdomain>
 <CACOAw_zKC24BhNOF2BpuRfuYzBEsis82MafU9HqXwLj2sZ3Azg@mail.gmail.com>
 <20200611230043.GA18185@gmail.com>
 <CACOAw_zZY4W9PYY4VAZ_5tGB5LxCEZKh6Sc523MRzVCvKNhinQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_zZY4W9PYY4VAZ_5tGB5LxCEZKh6Sc523MRzVCvKNhinQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:00:58AM +0900, Daeho Jeong wrote:
> For the incremental way of erasing, we might as well support the
> (offset, length) option in a unit of 4KiB.
> 
> So, you might use this ioctl like the below. Does it work for you?
> struct f2fs_sec_trim {
>         u64 startblk;
>         u64 blklen;
>         u32 flags;
> };
> 
> sectrim.startblk = 0;
> sectrim.blklen = 256;     // 1MiB
> sectrim.flags = F2FS_TRIM_FILE_DISCARD | F2FS_TRIM_FILE_ZEROOUT;
> ret = ioctl(fd, F2FS_SEC_TRIM_FILE, &sectrim);

Most filesystem ioctls and syscalls take offsets and lengths in bytes,
especially newer ones.  This way implementations of these APIs can support other
alignments later.  The implementation can still require alignment for now, i.e.
return -EINVAL if !IS_ALIGNED(arg.pos | arg.len, sb->s_blocksize).

Also, flags should be a u64, especially since it wouldn't actually increase the
size of the struct (due to padding).

- Eric
