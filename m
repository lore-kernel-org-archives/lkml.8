Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD27EC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A657D22B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582068256;
	bh=cE1KL7ESu7HCICcE8VORkQLYSFi1c/bNZgc87tvL56Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O4MX6BqwqV3ja30XsHTA4iOL5D5tiopGh+3jBTyUxVQ7faezG6r2eFRxQLqwKf66A
	 t3tBodXvxF5ZhC/C/+iYtZ0rm5i1eKg1jBhzCEVttxUlraus1k0/15tKTtxoDkNAyR
	 Q8qYzXBjXLQV+a4PrXeeb6OU357ayUCeDlKaz1gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBRXYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgBRXYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:24:14 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5F024655;
        Tue, 18 Feb 2020 23:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582068254;
        bh=cE1KL7ESu7HCICcE8VORkQLYSFi1c/bNZgc87tvL56Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsp/4FRD1CWCCkP19KOIGA2baZ6zLP1vyNzO4mvzKrtGjtLqeHFRIYQeEnd2esFwO
         wbMHNod93deJ4d6Ail3dsW7kuEAu0Sdp0li82EdFJJEEBZHNaUbstYpaYm3H1kKvvn
         C3m/D9fZth1r/Hq9e3B5rjhKACO4QK2KwIjn63eU=
Date:   Tue, 18 Feb 2020 15:24:13 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/4] f2fs: clean up lfs/adaptive mount option
Message-ID: <20200218232413.GA10213@google.com>
References: <20200214094413.12784-1-yuchao0@huawei.com>
 <20200214094413.12784-3-yuchao0@huawei.com>
 <20200214184150.GB60913@google.com>
 <c0436553-a1b6-8124-a096-15d2c3d5bd79@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0436553-a1b6-8124-a096-15d2c3d5bd79@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17, Chao Yu wrote:
> On 2020/2/15 2:41, Jaegeuk Kim wrote:
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 5152e9bf432b..d2d50827772c 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -91,8 +91,6 @@ extern const char *f2fs_fault_name[FAULT_MAX];
> >>  #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
> >>  #define F2FS_MOUNT_DATA_FLUSH		0x00008000
> >>  #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
> >> -#define F2FS_MOUNT_ADAPTIVE		0x00020000
> >> -#define F2FS_MOUNT_LFS			0x00040000
> > 
> > I don't think we can remove this simply.
> > 
> >>  #define F2FS_MOUNT_USRQUOTA		0x00080000
> >>  #define F2FS_MOUNT_GRPQUOTA		0x00100000
> >>  #define F2FS_MOUNT_PRJQUOTA		0x00200000
> 
> You mean getting rid of this change or we need to fill F2FS_MOUNT_* hole as below:

nvm. So, we can reuse the removed bits later in other features.

> 
> #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
> -#define F2FS_MOUNT_ADAPTIVE		0x00020000
> -#define F2FS_MOUNT_LFS			0x00040000
> +#define F2FS_MOUNT_USRQUOTA		0x00020000
> +#define F2FS_MOUNT_GRPQUOTA		0x00040000
> ...
> 
> Thanks,
