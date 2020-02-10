Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A65EC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDED20675
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkr0Q6KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBJSdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:33:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbgBJSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581359601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ah53tJG2kEdSb2jrTYOGXeChilhie7bfMD31S0yM5BQ=;
        b=bkr0Q6KXzjjBFdM241k7EBptI1ertoXL5FTsDq4PxEXgkuXQrAyEFAeTBB0X2Qroj3OVD1
        xwLCyjRyVjaFzsj1WEvuBBpXJ41PamP4hunFs3i0IQ3CDWMN3E87BRaVf33hK4z2paFsYM
        djnffLHh1AzhZGJD7Cqfpfu5fSqx+6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-kXaWGT4QOn6i6j4SdH88Hw-1; Mon, 10 Feb 2020 13:33:18 -0500
X-MC-Unique: kXaWGT4QOn6i6j4SdH88Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56DA218A5502;
        Mon, 10 Feb 2020 18:33:17 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB19810013A7;
        Mon, 10 Feb 2020 18:33:15 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] objtool: Relocation sanity check for alternatives
Date:   Mon, 10 Feb 2020 12:32:37 -0600
Message-Id: <cover.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-2 are in preparation for patch 3.

Patch 3 adds sanity checking to prevent unsupported relocations in
alternatives.

Josh Poimboeuf (3):
  objtool: Fail the kernel build on fatal errors
  objtool: Add is_static_jump() helper
  objtool: Add relocation check for alternative sections

 tools/objtool/check.c | 48 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

Josh Poimboeuf (3):
  objtool: Fail the kernel build on fatal errors
  objtool: Add is_static_jump() helper
  objtool: Add relocation check for alternative sections

 tools/objtool/check.c | 48 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

--=20
2.21.1

