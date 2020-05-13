Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB04D206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363416;
	bh=YoXHFMlvuBDLbaC0h6kGRTwYbgdqwB7bsZo21oJfg20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDdNaOF4oHSs4QEvrmGTlKVTlH8YlRJvIC7u8/RHZ/rWNBx/l41mPgcXDUeWjbf0E
	 r2+uSZWBtsSbtukrG6NhbAiPy5dSg4waTRRLIylHMLS2pDln/RB2jxnTf5Zh0WU8lM
	 UUJChp6VCvJEvXY7oLJhA6bmiJXKvZuIv3wVcPA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgEMJuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387448AbgEMJuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:50:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8A9206D6;
        Wed, 13 May 2020 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363409;
        bh=YoXHFMlvuBDLbaC0h6kGRTwYbgdqwB7bsZo21oJfg20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/d3MjjDIldbEH7tyEeMzbDw8CNYJzunGGQBFQ3/NmOdFIp7zi8ZcKW0UwMx49ldW
         0SIvYKdZLNWlDwOs35xLOyVSuZNaSfbqDxhhurB4+B2Tj+DOBrMODBCoNMdo+RnEvy
         ++XopfF0mvS1JgcrEWxh8WFHaXN+tpoh2qWCEaww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH 5.4 62/90] ceph: fix endianness bug when handling MDS session feature bits
Date:   Wed, 13 May 2020 11:44:58 +0200
Message-Id: <20200513094416.106484588@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 0fa8263367db9287aa0632f96c1a5f93cc478150 upstream.

Eduard reported a problem mounting cephfs on s390 arch. The feature
mask sent by the MDS is little-endian, so we need to convert it
before storing and testing against it.

Cc: stable@vger.kernel.org
Reported-and-Tested-by: Eduard Shishkin <edward6@linux.ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3072,8 +3072,7 @@ static void handle_session(struct ceph_m
 	void *end = p + msg->front.iov_len;
 	struct ceph_mds_session_head *h;
 	u32 op;
-	u64 seq;
-	unsigned long features = 0;
+	u64 seq, features = 0;
 	int wake = 0;
 	bool blacklisted = false;
 
@@ -3092,9 +3091,8 @@ static void handle_session(struct ceph_m
 			goto bad;
 		/* version >= 3, feature bits */
 		ceph_decode_32_safe(&p, end, len, bad);
-		ceph_decode_need(&p, end, len, bad);
-		memcpy(&features, p, min_t(size_t, len, sizeof(features)));
-		p += len;
+		ceph_decode_64_safe(&p, end, features, bad);
+		p += len - sizeof(features);
 	}
 
 	mutex_lock(&mdsc->mutex);


