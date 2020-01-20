Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F556C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D02C22527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXGWBQr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:14:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgATSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579544066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DffCrwEtoqXEWPOqeJbtVuBGvdg2skMrjjXRh5TdRho=;
        b=FXGWBQr+u8oi3CKQk03XYo+zLBmXa9tdawh9d1jwDLkLFt15nIawwNdGIuqxlHrooUkD7v
        VFPGEuYTvlJdJas8JC79EhMPxqmTUmSS1rzU9EOGjrL7SMy6nbihlJLnf/zcrlzRTUFJqR
        dCHFvHcl/BGnNQ4BsbM3O5i9X93//dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-5EY_tmCfMyG5M7QKHKWS7Q-1; Mon, 20 Jan 2020 13:14:25 -0500
X-MC-Unique: 5EY_tmCfMyG5M7QKHKWS7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 341558017CC;
        Mon, 20 Jan 2020 18:14:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95DDB1001B30;
        Mon, 20 Jan 2020 18:14:23 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/3] objtool: Skip samples subdirectory
Date:   Mon, 20 Jan 2020 12:14:09 -0600
Message-Id: <c4cb4ef635ec606454ab834cb49fc3e9381fb1b1.1579543924.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1579543924.git.jpoimboe@redhat.com>
References: <cover.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in the 'samples' subdirectory isn't part of the kernel, so
there's no need to validate it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 samples/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Makefile b/samples/Makefile
index a1848d674e9d..53867d9af971 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux samples code
+OBJECT_FILES_NON_STANDARD :=3D y
=20
 obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+=3D binderfs/
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+=3D configfs/
--=20
2.21.1

