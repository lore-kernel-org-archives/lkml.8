Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2438C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E352077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585920160;
	bh=CbaY+LpU0g/V5is4GrAjszTSE+0wpVzM2tT7i5LjNM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NNwqB7H5UYS0iY4hqQAwNFKZvEKTp37MLfP7SXidyuGS9yn0P5EMfQB3mnrurOWPQ
	 aGiwj+rz3jdTRuc9DgoXALCOOsbfL06Th3GPmyYYpEZAByKBWCc8JFHTB+quhs50es
	 MB9HgBf3t4OAap5CFmBk2Yl/Phst+QiXKmIvFR/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbgDCNWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgDCNWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:22:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDBF2077D;
        Fri,  3 Apr 2020 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585920159;
        bh=CbaY+LpU0g/V5is4GrAjszTSE+0wpVzM2tT7i5LjNM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4rWr0mhiZcStdlORJxbwdiVIzorMxbbp1FiR+xI/3m18douSW8mTwGRMrMInAp16
         CqJpx+A/MYNWkXz4vq3Kp0TThUTHBNzcDeRUUDnVWszJiSj1kB7YA2/yYEk5+eCaIM
         dSohy3vNXAJr6MWfh8vUZzvZer5aKEt/iKOxK+5w=
Date:   Fri, 3 Apr 2020 14:22:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, g.nault@alphalink.fr
Subject: Re: [PATCH 0/8] [backports] l2tp use-after-free fixes for 4.4 stable
Message-ID: <20200403132233.GA18943@willie-the-truck>
References: <20200402173250.7858-1-will@kernel.org>
 <20200403124557.GA3984782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403124557.GA3984782@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 02:45:57PM +0200, Greg KH wrote:
> On Thu, Apr 02, 2020 at 06:32:42PM +0100, Will Deacon wrote:
> > Hi Greg,
> > 
> > Syzbot has been complaining about KASAN splats due to use-after-free
> > issues in the l2tp code on 4.4 Android kernels (although I reproduced
> > with latest 4.4 stable on my laptop):
> > 
> > https://syzkaller.appspot.com/bug?id=de316389db0fa0cd7ced6e564601ea8e56625ebc
> > 
> > These have been fixed upstream, but for some reason didn't get picked up
> > for stable. This series applies to 4.4.y and I've sent patches for 4.9
> > separately.
> 
> All now queued up, thanks.

Thanks, Greg.

Will
