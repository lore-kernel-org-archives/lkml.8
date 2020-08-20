Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33E8207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927073;
	bh=ZCIaIKK+Z3e8lovzmRzIhNjqbW5hwoLUWSXfDgGyKBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iz1O9TXXG7LtxXf4Vr+PLX/kyZMOYKv0SL8L7G/P27TZ9uzTaPt2mWW23rQd0sUMw
	 hwXH7Y7lpGEM2ZFCmTUmsIabuDgBOzweLFZD7+O1+LD+q3nt5iGjJE+Jc5k/K7GwCI
	 YWpAtiO9owdXCBjxRJv1dzDdKPvgSjO9gFApVWM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgHTMhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgHTJrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:47:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9327322B43;
        Thu, 20 Aug 2020 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916845;
        bh=ZCIaIKK+Z3e8lovzmRzIhNjqbW5hwoLUWSXfDgGyKBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7oMXOBuqA28TWrlo5UFOwQrGufdXPZs5GOnw4j0NGKjMoc8IQQgw3EsJ5ZClYWHd
         oAREbGZYJgARpo023WvxPUdxFQnlL88wPFTksTuiHvindhtGzmE4S0IwHM526yVd4j
         C3GfedXLXp3cddE+pFydPUV4kPgx4m0FxUjOLNsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 5.4 066/152] ceph: handle zero-length feature mask in session messages
Date:   Thu, 20 Aug 2020 11:20:33 +0200
Message-Id: <20200820091557.110918167@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 02e37571f9e79022498fd0525c073b07e9d9ac69 upstream.

Most session messages contain a feature mask, but the MDS will
routinely send a REJECT message with one that is zero-length.

Commit 0fa8263367db ("ceph: fix endianness bug when handling MDS
session feature bits") fixed the decoding of the feature mask,
but failed to account for the MDS sending a zero-length feature
mask. This causes REJECT message decoding to fail.

Skip trying to decode a feature mask if the word count is zero.

Cc: stable@vger.kernel.org
URL: https://tracker.ceph.com/issues/46823
Fixes: 0fa8263367db ("ceph: fix endianness bug when handling MDS session feature bits")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Patrick Donnelly <pdonnell@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3091,8 +3091,10 @@ static void handle_session(struct ceph_m
 			goto bad;
 		/* version >= 3, feature bits */
 		ceph_decode_32_safe(&p, end, len, bad);
-		ceph_decode_64_safe(&p, end, features, bad);
-		p += len - sizeof(features);
+		if (len) {
+			ceph_decode_64_safe(&p, end, features, bad);
+			p += len - sizeof(features);
+		}
 	}
 
 	mutex_lock(&mdsc->mutex);


