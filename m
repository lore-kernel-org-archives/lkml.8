Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE554C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C022A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543107;
	bh=Ffa0UUL/xpJ/nxtbCjUwo2iMiLWWnTrAOJN+u9GLnzI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Wc5IFZMQ3aHDn8xgbEGmfyh1IokbHruCH8c1naoP6Dcp6ZEsfyYWKoxLJsQScgpVr
	 Qi55CCdCELufbGlb6rPdHX2XpbSZ14P/PHaCY6tVvQIwx3eO6Jk/bS3h9tTHm4YWnI
	 ei1PIwtMMebFLelXQ+mMRKVEF5W+gLwbiULUqfyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGWWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgGWWZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:25:06 -0400
Received: from embeddedor (unknown [201.162.245.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2923520714;
        Thu, 23 Jul 2020 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543106;
        bh=Ffa0UUL/xpJ/nxtbCjUwo2iMiLWWnTrAOJN+u9GLnzI=;
        h=Date:From:To:Cc:Subject:From;
        b=1WlAGbGura2Mywk7fAeHMZpDaNL9uYqONbbPFaqcR1wUBKdEaJYbJmnsL1Q6xu6kP
         t3PUw70GJIavlFtmR/RMfem4YSbpRFXkBhY/ASTayUPxIb4tJ8J9323KOmU2vsQcuK
         DY7Lit9pbMv3iJmEYbaX5uE4DNIXkXQ11uPQ7BDQ=
Date:   Thu, 23 Jul 2020 17:30:48 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/3] Avoid the use of one-element arrays
Message-ID: <cover.1595543280.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to:

1. Remove one-element arrays.
2. Fix identation issues in struct serial_struct32
3. Use the preferred form for passing a size of a structure type

Thanks

Gustavo A. R. Silva (3):
  tty: Avoid the use of one-element arrays
  tty: Fix identation issues in struct serial_struct32
  tty: Use the preferred form for passing the size of a structure type

 drivers/tty/tty_io.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

-- 
2.27.0

