Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82633C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A521974
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WrXTXVUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDRV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 17:58:50 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:43696 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbgDRV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:58:49 -0400
X-Greylist: delayed 1464 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2020 17:58:48 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id F24C02EB9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 16:34:22 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Pv6UjTcqWSl8qPv6UjvCan; Sat, 18 Apr 2020 16:34:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dol8C6yTEbm6eVsylQDMPTmjSkLMOwBTCtdGcrmhTUY=; b=WrXTXVUnmzs01yjNWlLqJ9GjIb
        Eke5ElK5vNwNUFsBrQy5aw1/7kp53+ET+LS5gHX6/+V4q0U+WIYHkhtDaD0ZUvSSlGzpXETPFQPg2
        3UmtC+eGnZYCDoDWRnczHBSdLHT4ZvWb6VQOUVkFHmcRIpGmF1HyuQsw18+HTwCGuJm7hgKIRq312
        M2lc+3FwbcfvwxODLYDZTCHtrdnL0Zk7LQC1ER9lHXfFyziuyUlnjfK2l2TZiuMc32PhrabRU5rbl
        8z8vIGsbCgS1CSFb0vpSyyPPQZi2D8KnOirSC6Ino2O79eiGNGAzRVd/E3L46ixhhiHsPfd/Ugz8s
        nfHkY6lA==;
Received: from [200.39.29.188] (port=46022 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jPv6T-003JiA-GS; Sat, 18 Apr 2020 16:34:21 -0500
Date:   Sat, 18 Apr 2020 16:38:28 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] flexible-array member convertion patches for 5.7-rc2
Message-ID: <20200418213828.GA10666@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.39.29.188
X-Source-L: No
X-Exim-ID: 1jPv6T-003JiA-GS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.39.29.188]:46022
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-member-5.7-rc2

for you to fetch changes up to 43951585e1308b322c8ee31a4aafd08213f5c5d7:

  xattr.h: Replace zero-length array with flexible-array member (2020-04-18 15:44:56 -0500)

----------------------------------------------------------------
flexible-array member convertion patches for 5.7-rc2

Hi Linus,

Please, pull the following patches that replace zero-length arrays with
flexible-array members.

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member convertions) will also
help to get completely rid of those sorts of issues.

Notice that all of these patches have been baking in linux-next for
quite a while now and, 238 more of these patches have already been
merged into 5.7-rc1.

There are a couple hundred more of these issues waiting to be addressed
in the whole codebase.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Thanks

----------------------------------------------------------------
Gustavo A. R. Silva (28):
      bio: Replace zero-length array with flexible-array member
      blk-mq: Replace zero-length array with flexible-array member
      blk_types: Replace zero-length array with flexible-array member
      can: dev: peak_canfd.h: Replace zero-length array with flexible-array member
      digsig.h: Replace zero-length array with flexible-array member
      dirent.h: Replace zero-length array with flexible-array member
      enclosure.h: Replace zero-length array with flexible-array member
      energy_model.h: Replace zero-length array with flexible-array member
      ethtool.h: Replace zero-length array with flexible-array member
      genalloc.h: Replace zero-length array with flexible-array member
      igmp.h: Replace zero-length array with flexible-array member
      ihex.h: Replace zero-length array with flexible-array member
      irq.h: Replace zero-length array with flexible-array member
      lib: cpu_rmap: Replace zero-length array with flexible-array member
      list_lru.h: Replace zero-length array with flexible-array member
      memcontrol.h: Replace zero-length array with flexible-array member
      platform_data: wilco-ec.h: Replace zero-length array with flexible-array member
      posix_acl.h: Replace zero-length array with flexible-array member
      rio.h: Replace zero-length array with flexible-array member
      rslib.h: Replace zero-length array with flexible-array member
      sched: topology.h: Replace zero-length array with flexible-array member
      skbuff.h: Replace zero-length array with flexible-array member
      swap.h: Replace zero-length array with flexible-array member
      ti_wilink_st.h: Replace zero-length array with flexible-array member
      tpm_eventlog.h: Replace zero-length array with flexible-array member
      uapi: linux: dlm_device.h: Replace zero-length array with flexible-array member
      uapi: linux: fiemap.h: Replace zero-length array with flexible-array member
      xattr.h: Replace zero-length array with flexible-array member

 include/linux/bio.h                    | 2 +-
 include/linux/blk-mq.h                 | 2 +-
 include/linux/blk_types.h              | 2 +-
 include/linux/can/dev/peak_canfd.h     | 4 ++--
 include/linux/cpu_rmap.h               | 2 +-
 include/linux/digsig.h                 | 4 ++--
 include/linux/dirent.h                 | 2 +-
 include/linux/enclosure.h              | 2 +-
 include/linux/energy_model.h           | 2 +-
 include/linux/ethtool.h                | 4 ++--
 include/linux/genalloc.h               | 2 +-
 include/linux/igmp.h                   | 2 +-
 include/linux/ihex.h                   | 2 +-
 include/linux/irq.h                    | 4 ++--
 include/linux/list_lru.h               | 2 +-
 include/linux/memcontrol.h             | 4 ++--
 include/linux/platform_data/wilco-ec.h | 2 +-
 include/linux/posix_acl.h              | 2 +-
 include/linux/rio.h                    | 4 ++--
 include/linux/rslib.h                  | 2 +-
 include/linux/sched/topology.h         | 2 +-
 include/linux/skbuff.h                 | 2 +-
 include/linux/swap.h                   | 2 +-
 include/linux/ti_wilink_st.h           | 6 +++---
 include/linux/tpm_eventlog.h           | 6 +++---
 include/linux/xattr.h                  | 2 +-
 include/uapi/linux/dlm_device.h        | 4 ++--
 include/uapi/linux/fiemap.h            | 2 +-
 28 files changed, 39 insertions(+), 39 deletions(-)
