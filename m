Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E3C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F1F2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595879887;
	bh=0zLbwOrLh3AaOF3vmnAEIzeqmlSo/e9+NLDubtnDas4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eVWtVqnsCewUhhC0KHwVj9vC648zeOqykYd3A8v8oBw7HoX1ZWlJjwwMn8z7YxGTi
	 szk5TniurEZO+fLfepEKwNML5DtlCBcPAzfVo6WYViXxjWH1vr+Vcy+d90RtgXDfCj
	 s1zGgNhaXK1vXxd2SkvCSGAlYChn4YkTy+bDK9lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgG0T6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbgG0T6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:58:05 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DC420759;
        Mon, 27 Jul 2020 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595879884;
        bh=0zLbwOrLh3AaOF3vmnAEIzeqmlSo/e9+NLDubtnDas4=;
        h=Date:From:To:Cc:Subject:From;
        b=XeVsShoCzLPI2FjpnpUwVJS4A1NkUdicvO9ccEvCGXZb+gGFQt1rkJAVVd830abqA
         ZzlaMEy+pLo5zkIHiuuSpz4rtWVZU0hVYANklGuolPq+lI42Y2/hDFlarh5yVGipbO
         3bxmFPf9rO1tkhlGK9lOZzMOaZibkXd7CiP4pDfg=
Date:   Mon, 27 Jul 2020 15:03:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] bcache: Use fallthrough pseudo-keyword
Message-ID: <20200727200357.GA2079@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/md/bcache/journal.c |  2 +-
 drivers/md/bcache/util.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 77fbfd52edcf..c1227bdb57e7 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -608,7 +608,7 @@ static void do_journal_discard(struct cache *ca)
 			ca->sb.njournal_buckets;
 
 		atomic_set(&ja->discard_in_flight, DISCARD_READY);
-		/* fallthrough */
+		fallthrough;
 
 	case DISCARD_READY:
 		if (ja->discard_idx == ja->last_idx)
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 62fb917f7a4f..66965de548d0 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -33,27 +33,27 @@ int bch_ ## name ## _h(const char *cp, type *res)		\
 	case 'y':						\
 	case 'z':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough;					\
 	case 'e':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough;					\
 	case 'p':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough;					\
 	case 't':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough;					\
 	case 'g':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough					\
 	case 'm':						\
 		u++;						\
-		/* fall through */				\
+		fallthrough;					\
 	case 'k':						\
 		u++;						\
 		if (e++ == cp)					\
 			return -EINVAL;				\
-		/* fall through */				\
+		fallthrough;					\
 	case '\n':						\
 	case '\0':						\
 		if (*e == '\n')					\
-- 
2.27.0

