Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D09C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B881206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X04dQDTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgFHJNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:13:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgFHJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591607620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IP7Om9jcZMea/xSfbywr8WjcmmhyRTFpllLJCk2X5nA=;
        b=X04dQDTIJbpJ9Y3YhXsj1l8G6i1gMPnznXEYGgNXtC5DXOjfTmsWphhAgBZwPoX3KNpwpk
        XuzR240TNarALrJNWJAFiWwckN2LCcjBQlKua0SU6GMfvpKjgYZOT+o4xrgd4JKUT1T0oK
        QZHalNnKmg0EDJKjwWawNwVz02jmYSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-A0uxM3nfON2Meav7zcRxbQ-1; Mon, 08 Jun 2020 05:13:36 -0400
X-MC-Unique: A0uxM3nfON2Meav7zcRxbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 993AF800053;
        Mon,  8 Jun 2020 09:13:35 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A33367B5FB;
        Mon,  8 Jun 2020 09:13:33 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lib: Fix bitmap_cut() for overlaps, add test
Date:   Mon,  8 Jun 2020 11:13:27 +0200
Message-Id: <cover.1591606281.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 addresses the issue Yury reported with partially overlapping
src and dst in bitmap_cut(), and 2/2 adds a test that covers basic
functionality as well as this case.


Stefano Brivio (2):
  lib: Fix bitmap_cut() for partial overlapping case
  lib: Add test for bitmap_cut()

 lib/bitmap.c      |  4 ++--
 lib/test_bitmap.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.26.2

