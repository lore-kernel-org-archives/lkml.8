Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF1DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D420F20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858595;
	bh=N4bj3wWm2MzQ/QSbYY4EoGmJ+L24lq7RFP9c2ISdy7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UDCPOSCofDITEla4317Pcw2GFAt5hUhDrHsF32Ogq1R8lqJmdCUbkMKSbC273klQP
	 qrjC7xcQuYdvYWzsXwdfAg6LjjHOATz5IGkLACsf36EkNbXp7Z9x6uyFS5wD8GbUoe
	 9oRiJyo1d4g6fZVi0R2YqAQ86jCHkBxAlU9FKb0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAXJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgAXJgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:36:35 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040352070A;
        Fri, 24 Jan 2020 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858594;
        bh=N4bj3wWm2MzQ/QSbYY4EoGmJ+L24lq7RFP9c2ISdy7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4VFQlhYCOE2ranDIlpBlyLpmJiVRFaMXBQmyx4L/jBPh+oBEVY5QRLJJq3qyUVBV
         ZB6Sj1wwNRSXpaq9jWWmAYzRBMazQ5TBk1r1TFRPAaR5fhwQLpycpyGLIcjSChZaHk
         XCw1CkfXeLhsNWwgl7+fDtm93B9Tm33FOVocYDf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.14 001/343] xfs: Sanity check flags of Q_XQUOTARM call
Date:   Fri, 24 Jan 2020 10:26:59 +0100
Message-Id: <20200124092919.688329843@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 3dd4d40b420846dd35869ccc8f8627feef2cff32 upstream.

Flags passed to Q_XQUOTARM were not sanity checked for invalid values.
Fix that.

Fixes: 9da93f9b7cdf ("xfs: fix Q_XQUOTARM ioctl")
Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_quotaops.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/xfs/xfs_quotaops.c
+++ b/fs/xfs/xfs_quotaops.c
@@ -214,6 +214,9 @@ xfs_fs_rm_xquota(
 	if (XFS_IS_QUOTA_ON(mp))
 		return -EINVAL;
 
+	if (uflags & ~(FS_USER_QUOTA | FS_GROUP_QUOTA | FS_PROJ_QUOTA))
+		return -EINVAL;
+
 	if (uflags & FS_USER_QUOTA)
 		flags |= XFS_DQ_USER;
 	if (uflags & FS_GROUP_QUOTA)


