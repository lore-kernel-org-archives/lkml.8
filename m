Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17DBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFCC20855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919894;
	bh=H5Yk/M5cqaUgNP3OsbDB380S9GO0SXXJgrLFMOVXvfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPB03qBmnuShMaArJr5PScTqGUHLEpQt/f51daUkzJrs9+e3GODcSsG9ttolBJIJg
	 1se0sy/OfE/7Pn3kBhbMZ46KY/IjVsKUkN4z12hEGQrviRM6k4xJnxiZpnubbS6Lyk
	 sdjuPcu2SsQqaSx018tQN2CC8crid1PUipMEHdlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgHTKiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbgHTKSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF38208E4;
        Thu, 20 Aug 2020 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918688;
        bh=H5Yk/M5cqaUgNP3OsbDB380S9GO0SXXJgrLFMOVXvfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/9+9wDEtp2SF1EpMGdtc5K8WY779uSMpkk40cWURAK6JQMRwj5S+me9YsTKJiOdk
         L5/CE+htRx12JbulgH3iccYLYOv0ry6EDcUv3RzUjM+qhRINCuszscNtXXl38alMjr
         wOQ5WJjRdcrIb+ZkA4M33p62rZX/7ujGPJ4ku3ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Emese Revfy <re.emese@gmail.com>,
        Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 030/149] random32: remove net_rand_state from the latent entropy gcc plugin
Date:   Thu, 20 Aug 2020 11:21:47 +0200
Message-Id: <20200820092127.184424955@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 83bdc7275e6206f560d247be856bceba3e1ed8f2 upstream.

It turns out that the plugin right now ends up being really unhappy
about the change from 'static' to 'extern' storage that happened in
commit f227e3ec3b5c ("random32: update the net random state on interrupt
and activity").

This is probably a trivial fix for the latent_entropy plugin, but for
now, just remove net_rand_state from the list of things the plugin
worries about.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/random.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -47,7 +47,7 @@ struct rnd_state {
 	__u32 s1, s2, s3, s4;
 };
 
-DECLARE_PER_CPU(struct rnd_state, net_rand_state) __latent_entropy;
+DECLARE_PER_CPU(struct rnd_state, net_rand_state);
 
 u32 prandom_u32_state(struct rnd_state *state);
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);


