Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3564EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B562070A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577630;
	bh=MavuaE6RpHO1pjmAVmuBsMf1W73U+3iUQqhX42rPWaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAHPY/FyLTADpz09bdm+vE9RBELXRi3CC+4h6A6Qox+9iYsPV6YT2SW6+wudJUPxA
	 NCXuZN//5BOcZadraw3wF2Mr10yip/AnXQzOCtysvz5dCvxyu6chZiQPhZ4INwSpX4
	 h9SERu4itZ0I6GLSyZbXI6FXehYJOZW25taHt+vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbgFSOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388099AbgFSOkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:40:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370FF20773;
        Fri, 19 Jun 2020 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577617;
        bh=MavuaE6RpHO1pjmAVmuBsMf1W73U+3iUQqhX42rPWaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beKqaWlRG9UNvuOM7xuZYzgOech0BvaV3I2Zms2USAuShbB6MplnDX5E+/ufsH2zD
         xt2ZhI8OJ0VCbfay8gYx/J1h4lXaS6EQxjOQepleUbUYCwUGhqCDrs3sKtjW1+vh91
         S5YFf2VGnzK6oR7K0cftUDGiggK39owzEcAn6Ir8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 020/128] cgroup, blkcg: Prepare some symbols for module and !CONFIG_CGROUP usages
Date:   Fri, 19 Jun 2020 16:31:54 +0200
Message-Id: <20200619141621.241491386@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit 9b0eb69b75bccada2d341d7e7ca342f0cb1c9a6a upstream.

btrfs is going to use css_put() and wbc helpers to improve cgroup
writeback support.  Add dummy css_get() definition and export wbc
helpers to prepare for module and !CONFIG_CGROUP builds.

[only backport the export of __inode_attach_wb for stable kernels - gregkh]

Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fs-writeback.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -269,6 +269,7 @@ void __inode_attach_wb(struct inode *ino
 	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
 		wb_put(wb);
 }
+EXPORT_SYMBOL_GPL(__inode_attach_wb);
 
 /**
  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it


