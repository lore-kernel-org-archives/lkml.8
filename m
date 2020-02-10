Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F25CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC520708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339614;
	bh=BqnlbCiXH63Epcz+lc02oqm7krVwoZ59t11L6PvqMQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dB0p5PKJsml1tM/rnzTiwjHK/nRcqFpr+ZCzv4Ho8uF5YyCr8AdgBzJXEYCjYFMhO
	 FsKp637DI/ZWw/KdW+zduqwWixMs2j+On1U84lLqSK7DU4Ff9M9DMczjSHXNasMmrN
	 erJTINRU5t/RbMB03AztX80jnwNDNvSBl7o0FhrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgBJNAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgBJMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18C924672;
        Mon, 10 Feb 2020 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338461;
        bh=BqnlbCiXH63Epcz+lc02oqm7krVwoZ59t11L6PvqMQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+zPGGMEqjPlBy3jtPAYgQBTckHT4bmzRtz/1o6E3aa4go6FjvvCpddEaJQ8P65vO
         Cxo/ClI2Wa2Pk/jIXMVco0mfIQ3e/wyOiB/Ii+fWYGG1ScCRo7g9om2+wolwQ6IsoH
         JHTFXDI72ZO1NUH7c9xT4+c0dD8tCLPJCnBoRICQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 5.5 219/367] xen/balloon: Support xend-based toolstack take two
Date:   Mon, 10 Feb 2020 04:32:12 -0800
Message-Id: <20200210122444.353771977@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit eda4eabf86fd6806eaabc23fb90dd056fdac037b upstream.

Commit 3aa6c19d2f38be ("xen/balloon: Support xend-based toolstack")
tried to fix a regression with running on rather ancient Xen versions.
Unfortunately the fix was based on the assumption that xend would
just use another Xenstore node, but in reality only some downstream
versions of xend are doing that. The upstream xend does not write
that Xenstore node at all, so the problem must be fixed in another
way.

The easiest way to achieve that is to fall back to the behavior
before commit 96edd61dcf4436 ("xen/balloon: don't online new memory
initially") in case the static memory maximum can't be read.

This is achieved by setting static_max to the current number of
memory pages known by the system resulting in target_diff becoming
zero.

Fixes: 3aa6c19d2f38be ("xen/balloon: Support xend-based toolstack")
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: <stable@vger.kernel.org> # 4.13
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/xen-balloon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -94,7 +94,7 @@ static void watch_target(struct xenbus_w
 				  "%llu", &static_max) == 1))
 			static_max >>= PAGE_SHIFT - 10;
 		else
-			static_max = new_target;
+			static_max = balloon_stats.current_pages;
 
 		target_diff = (xen_pv_domain() || xen_initial_domain()) ? 0
 				: static_max - balloon_stats.target_pages;


