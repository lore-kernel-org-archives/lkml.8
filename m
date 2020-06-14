Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352CDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A86206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQNnCw1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFNRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:41:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbgFNRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592156486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zeu+4hZ5PFeY+mhbg51DL7JPlfldoxh5r8wzAPCAElM=;
        b=FQNnCw1wyq9kOlk4+rSfkG+VdS0C1nQR41RTLKhGatRjuiN7Im8cjfc3RLP0ALP0ybJSZV
        +2Myg7Fh2YM69V0vRswEYdEKEteTCsNEnFesmkuPvrnGOwYnMmNi8bswzNSsYca6JclOaX
        LmM7uJt7FodDItjh/9TuIrkst4qRTDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-yswleE7LPEOFQ_UijQk1dQ-1; Sun, 14 Jun 2020 13:41:24 -0400
X-MC-Unique: yswleE7LPEOFQ_UijQk1dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C787F64AD2;
        Sun, 14 Jun 2020 17:41:22 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40E061002396;
        Sun, 14 Jun 2020 17:41:19 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lib: Fix bitmap_cut() for overlaps, add test
Date:   Sun, 14 Jun 2020 19:40:52 +0200
Message-Id: <cover.1592155364.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 addresses the issue Yury reported with partially overlapping
src and dst in bitmap_cut(), and 2/2 adds a test that covers basic
functionality as well as this case.

v2: In 2/2, use macro to verify result, drop bogus Co-Authored-by:
    tag, both suggested by Andy Shevchenko, and avoid stack overflow

Stefano Brivio (2):
  bitmap: Fix bitmap_cut() for partial overlapping case
  bitmap: Add test for bitmap_cut()

 lib/bitmap.c      |  4 ++--
 lib/test_bitmap.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.27.0

