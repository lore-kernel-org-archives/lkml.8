Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF30C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E995A2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyjcLiLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgFHM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:28:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729746AbgFHM2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591619291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ClBDHBDktbLIW5J/z+Ht3YsS2xmoHHnGoFvx6CMwhtw=;
        b=JyjcLiLnmVwp8zLWI/xDN54qD/jh+wEgP5yTn9EwTNyuGjCFpHErRpVQNGbte6I7pzkO/F
        VxWD/PxSQPQvjQ/TdYfTrpVXLobtFnzin8z+Uu38rUDf5B4cD8NVaOARuSkTo165yv8DL7
        1DxUguaGvnytM6kQSR1KuB7glF8LVbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-WOF0bhi7OyuMdL1nq3ePNg-1; Mon, 08 Jun 2020 08:28:04 -0400
X-MC-Unique: WOF0bhi7OyuMdL1nq3ePNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74999107ACF2;
        Mon,  8 Jun 2020 12:28:02 +0000 (UTC)
Received: from virtlab710.virt.lab.eng.bos.redhat.com (virtlab710.virt.lab.eng.bos.redhat.com [10.19.152.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C69E57BFE3;
        Mon,  8 Jun 2020 12:28:01 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: [PATCH kvm-unit-tests 0/2] svm: INIT test and test_run on selected vcpu
Date:   Mon,  8 Jun 2020 08:27:58 -0400
Message-Id: <20200608122800.6315-1-cavery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INIT intercept test and the ability to execute test_run
on a selected vcpu.

Cathy Avery (2):
  svm: Add ability to execute test via test_run on a vcpu other than
    vcpu 0
  svm: INIT intercept test

 x86/svm.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 x86/svm.h       | 13 +++++++++++++
 x86/svm_tests.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.20.1

