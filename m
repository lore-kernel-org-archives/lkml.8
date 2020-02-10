Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CEB2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340397;
	bh=yxHvfVkE0ShiQirOUmTXBJyoL/hXcWMzQP9HRoxwcBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hZe3rw+jL893VRXsw7HEEfEbBJHkcYIRBW37JeKUnvWskyl0olufTXCZf55XiCx5
	 IF1Rdi8dJb928HeggWkRC3GkmYUNEJRiOdPFKCG3dWiTaCDmiEEZnAujWR4Q3r3SaZ
	 MBjATHJh4qoozStYpQQGFNl73loEGm2tfZTgBHt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgBJNNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:13:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbgBJMim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:42 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F06520661;
        Mon, 10 Feb 2020 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338321;
        bh=yxHvfVkE0ShiQirOUmTXBJyoL/hXcWMzQP9HRoxwcBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kNWIJKWF8hF4nuhrRklKOPTjU3ikFvvkKESZ/bEo1rPN5w4ZzQLdT4NOAVpfu9OE
         d3/Xl2hayPq3z1/FKO5wq0+qnItSQ21hFY0Uaq6+oEXb4KJMJmchrxc/lELZbyp8cs
         ZJQhJuKn+ig6OK8ngGHZMmbq8Vd7O5qJj9UDbH6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.4 253/309] nfsd: fix delay timer on 32-bit architectures
Date:   Mon, 10 Feb 2020 04:33:29 -0800
Message-Id: <20200210122430.863928581@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 2561c92b12f4f4e386d453556685f75775c0938b upstream.

The nfsd4_cb_layout_done() function takes a 'time_t' value,
multiplied by NSEC_PER_SEC*2 to get a nanosecond value.

This works fine on 64-bit architectures, but on 32-bit, any
value over 1 second results in a signed integer overflow
with unexpected results.

Cast one input to a 64-bit type in order to produce the
same result that we have on 64-bit architectures, regarless
of the type of nfsd4_lease.

Fixes: 6b9b21073d3b ("nfsd: give up on CB_LAYOUTRECALLs after two lease periods")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4layouts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -675,7 +675,7 @@ nfsd4_cb_layout_done(struct nfsd4_callba
 
 		/* Client gets 2 lease periods to return it */
 		cutoff = ktime_add_ns(task->tk_start,
-					 nn->nfsd4_lease * NSEC_PER_SEC * 2);
+					 (u64)nn->nfsd4_lease * NSEC_PER_SEC * 2);
 
 		if (ktime_before(now, cutoff)) {
 			rpc_delay(task, HZ/100); /* 10 mili-seconds */


