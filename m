Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A50C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F9720719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIADTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIADTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:19:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8CC061366;
        Mon, 31 Aug 2020 20:19:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCwpl-008RqV-Sx; Tue, 01 Sep 2020 03:19:45 +0000
Date:   Tue, 1 Sep 2020 04:19:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+c282923e5da93549fa27@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __fput (3)
Message-ID: <20200901031945.GE1236603@ZenIV.linux.org.uk>
References: <000000000000438ab305ae347ac4@google.com>
 <20200901023547.14976-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901023547.14976-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:35:47AM +0800, Hillf Danton wrote:

> Any light on how a9ed4a6560b8 ends up with __fput called twice is
> highly appreciated.

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0decff22ae2..8107e06d7f6f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1995,9 +1995,9 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			 * during ep_insert().
 			 */
 			if (list_empty(&epi->ffd.file->f_tfile_llink)) {
-				get_file(epi->ffd.file);
-				list_add(&epi->ffd.file->f_tfile_llink,
-					 &tfile_check_list);
+				if (get_file_rcu(epi->ffd.file))
+					list_add(&epi->ffd.file->f_tfile_llink,
+						 &tfile_check_list);
 			}
 		}
 	}
