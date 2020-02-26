Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E7C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B42E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgBZCpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:45:42 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728989AbgBZCpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:45:41 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 04FDB154E2232F5125A5;
        Wed, 26 Feb 2020 10:45:39 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 10:45:35 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 26 Feb 2020 10:45:34 +0800
Date:   Wed, 26 Feb 2020 10:44:08 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: Re: [PATCH 3/3] erofs: handle corrupted images whose decompressed
 size less than it'd be
Message-ID: <20200226024408.GB106025@architecture4>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-3-gaoxiang25@huawei.com>
 <20200226023458.GB1053@sol.localdomain>
 <20200226024047.GA106025@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200226024047.GA106025@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:40:47AM +0800, Gao Xiang wrote:
> Hi Eric,
> 
> On Tue, Feb 25, 2020 at 06:34:58PM -0800, Eric Biggers wrote:
> > On Wed, Feb 26, 2020 at 10:30:11AM +0800, Gao Xiang wrote:
> > > As Lasse pointed out, "Looking at fs/erofs/decompress.c,
> > > the return value from LZ4_decompress_safe_partial is only
> > > checked for negative value to catch errors. ... So if
> > > I understood it correctly, if there is bad data whose
> > > uncompressed size is much less than it should be, it can
> > > leave part of the output buffer untouched and expose the
> > > previous data as the file content. "
> > > 
> > > Let's fix it now.
> > > 
> > > Cc: Lasse Collin <lasse.collin@tukaani.org>
> > > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > Shouldn't fixes like this have a Fixes tag and Cc stable?
> > 
> > - Eric
> 
> Thanks for pointing out. *thumb up*
> 
> I reminded Fixes and Cc tags when I sent out. Yet
> I'm not quite sure if these have some other potential
> concernes which could cause unexpected behavior for
> normal images (It seems impossible but not quite sure.)
> 
> I'd like to leave these two commits for corrupted images
> to mainline and our products for a while and manually
> backport to stable kernels and send them to stable
> mailing list later. I keep these fixes in mind all
> the time.

... Maybe I should add "Fixes:" tag in the commit message
anyway. Will resend them later.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
