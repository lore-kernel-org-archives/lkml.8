Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEDFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elpugSEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgFXVJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:09:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388453AbgFXVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593032949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2pN8y8R4hyWs50K8WtCaXoEyYKs6iO9bl9vkpzCFH6Q=;
        b=elpugSEB6rQmqGprf9yjSofBVPZrlFgglPHGBjWs6/gciPOUA/HK4Cwq0jxatCaJq6YQur
        FBiSHJ8efU0oj4YnLY7kw9bLH1vXYm/w3OE2b0EYdtzd4ymgTw5ZI/YMpnJLWPqzimofwl
        OZyEJziMUdv4DS/6pnqQBPOcZIfFKdQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-VQ6x-fTbMEeSR-p4poPtIA-1; Wed, 24 Jun 2020 17:09:07 -0400
X-MC-Unique: VQ6x-fTbMEeSR-p4poPtIA-1
Received: by mail-pg1-f198.google.com with SMTP id a16so2606735pgw.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2pN8y8R4hyWs50K8WtCaXoEyYKs6iO9bl9vkpzCFH6Q=;
        b=oMFu3sRXxZXUbfN2AKZyNoZ4T17kGKsWR7asp5lCxFN+RKSu/sti4zUVKk9xvVEF21
         HsbKyc6Uy9I5DMDb4ZNn3RuFHELq9K7JAq3nH4B0Nu9bbNQjkwoWAkXXfuhsyXV3rSaf
         dIQfuzvhzEC0jv/zHHCpWJNcS+XCiLr+Tg5LlBf4v7fEv9XLbMDbQbmfN/cuUjXTZa5B
         8sAXA2IUVb/jkHnoLBbfx91draA2HCoSL9nFpWR6qEpiiW+v4aZjsB5fguAKR5EzgIoQ
         IwcNE0GfQsO/mLpIiWRHWGqjSezH0AVEqo7R615cZo549ikRhoRB9DmmX0lxoCIB78VX
         SL2Q==
X-Gm-Message-State: AOAM530IiXJ3C+S79vT/NntrZFWVUpVwCUu0lx1fmztthOU2IovpXxqn
        W5wtAfIh0k/paydIt83trwPx8jCilyYSHEyThQ2ajbiR7sqkfz09teXLdiYaMsqZ7nmQyMMPoGx
        O1tNtuybxFz7NV02GcT9NS9Wa
X-Received: by 2002:a63:d10a:: with SMTP id k10mr5986025pgg.382.1593032946546;
        Wed, 24 Jun 2020 14:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgphoFym365/PDSVJrFVtTszek0PwA+6CWAQZQWOuLi3upr+pG1TtMXtwnMnzAZq6bTP4C2Q==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr5985995pgg.382.1593032946284;
        Wed, 24 Jun 2020 14:09:06 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a12sm21038739pfr.44.2020.06.24.14.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:09:05 -0700 (PDT)
Date:   Thu, 25 Jun 2020 05:08:53 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: [GIT PULL] erofs fixes for 5.8-rc3
Message-ID: <20200624210853.GA6242@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.8-rc3?

1 bugfix patch addresses regression recently reported by
a vendor with specific compiler options. Need to fix it
in this cycle.

This commit has been in -next (since next-20200621) and
tested without strange happening.

Thanks,
Gao Xiang


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc3-fixes

for you to fetch changes up to 3c597282887fd55181578996dca52ce697d985a5:

  erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup (2020-06-24 09:47:44 +0800)

----------------------------------------------------------------
Changes since last update:

Fix a regression which uses potential uninitialized
high 32-bit value unexpectedly recently observed with
specific compiler options.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup

 fs/erofs/zdata.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

