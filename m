Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E45C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20570206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vXoxx6s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgEDRth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:49:37 -0400
Received: from gateway20.websitewelcome.com ([192.185.45.27]:28175 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729839AbgEDRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:49:36 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 8E81C400E7A61
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:22:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Vf4pjrBjRAGTXVf4pj8YlB; Mon, 04 May 2020 12:40:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+5a4Lppw4lJsYvc8K58j+1uvME/U/HnGj1dRIM7HnuA=; b=vXoxx6s5atXqWdZuR4go1HOx0W
        NUnwKJnlkXujGKpqLinY3IWWFwB3UgrRPYAuxKXwFuhAD4uuFByeFbqJRSH3XykGBKVGQ1mxsm0av
        pNGsl79FaNZj1HGTaOOOrxAcpANWPYL72d5awFeui5z2XBN2LdpRSC0QawZD9kugc5vfcwGMAyAOH
        JKMetNK+U5LllOkNo09A7PM7PGZbVvzdT6YfR3KjTZzjbp5A6FzXK2oHRoqRmCu2Aq58VPRBrnppC
        ljgf60vdXCIMzeWFH3Cvm0uI7WD6h9in8TnvFcietYkWhK4rB6oAk2bYu3bytG3RWsemDJbPf24AU
        0A8usVYw==;
Received: from [189.207.59.248] (port=55708 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jVf4p-000sBs-FO; Mon, 04 May 2020 12:40:23 -0500
Date:   Mon, 4 May 2020 12:44:49 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] flexible-array member convertion patches for 5.7-rc5
Message-ID: <20200504174449.GA15934@embeddedor>
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
X-Source-IP: 189.207.59.248
X-Source-L: No
X-Exim-ID: 1jVf4p-000sBs-FO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.207.59.248]:55708
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-member-5.7-rc5

for you to fetch changes up to 1e6e9d0f4859ec698d55381ea26f4136eff3afe1:

  uapi: revert flexible-array conversions (2020-05-04 11:30:15 -0500)

----------------------------------------------------------------
flexible-array member convertion patches for 5.7-rc5

Hi Linus,

Please, pull the following patch that reverts changes in include/uapi/

These structures can get embedded in other structures in user-space
and cause all sorts of warnings and problems[1]. So, we better don't take
any chances and keep the zero-length arrays in place for now.

[1] https://lore.kernel.org/lkml/20200424121553.GE26002@ziepe.ca/

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      uapi: revert flexible-array conversions

 include/uapi/linux/bpf.h                        | 2 +-
 include/uapi/linux/dlm_device.h                 | 4 ++--
 include/uapi/linux/fiemap.h                     | 2 +-
 include/uapi/linux/if_arcnet.h                  | 6 +++---
 include/uapi/linux/mmc/ioctl.h                  | 2 +-
 include/uapi/linux/net_dropmon.h                | 4 ++--
 include/uapi/linux/netfilter_bridge/ebt_among.h | 2 +-
 include/uapi/scsi/scsi_bsg_fc.h                 | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)
