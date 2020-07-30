Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F712082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596151208;
	bh=6+2lX73nW5UcKr93op0BObKpUW/HGBjFgSErTy2Tqf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VwPtDv4QHgdCaehkYlLf/sdf5mR1V+7qY4zwd40QF48tXB4GUjs0MFqPDKJB/HOI4
	 SZnKV/MOKO7PD6PtITvCB7C2H2poLGtLykCCNdgHRUTeRWvHZrn6FxU+P/Mhpu+Nvj
	 H9sMINWF+U3JprlKSdSsktZ8Wksmc7tPVdCI3bV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgG3XUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgG3XUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:20:04 -0400
Subject: Re: [GIT PULL] virtio, qemu_fw: bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596151204;
        bh=6+2lX73nW5UcKr93op0BObKpUW/HGBjFgSErTy2Tqf8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XuQjCo6GkzM2EmF2FevkPLAT+vLyZNIU7urr1x0iEIBREBKuwkfHRo1TjWlr2Ta7e
         8J1pclEEe/Cv18yjUltiI2q4Wxn8agFitrxLbs/1fOHYxBVvkdK8z2y2v0UriM1eyv
         FI9pyPX0jjyJeFwTShcmDCHrAA09uBX7sx9iJ4kM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200730152958-mutt-send-email-mst@kernel.org>
References: <20200730152958-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200730152958-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: a96b0d061d476093cf86ca1c2de06fc57163588d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 417385c47ef7ee0d4f48f63f70cca6c1ed6355f4
Message-Id: <159615120411.31670.16532591701270206400.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jul 2020 23:20:04 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, chenweilong@huawei.com,
        david@redhat.com, jasowang@redhat.com, mst@redhat.com,
        rdunlap@infradead.org, stable@vger.kernel.org, wu000273@umn.edu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jul 2020 15:29:58 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/417385c47ef7ee0d4f48f63f70cca6c1ed6355f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
