Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A38C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801624693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846963;
	bh=vtL6h8G/E53HpRe9CbZyuu54AiOY4RSVqqJZvamRaEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6pEH6U2KNQhjjvuGi5SbDQTsfhMi64jtw0WSPD3zA6JB2AwEjB/exEAU3uOp4Pup
	 tjPoFJ5J7DuPO66n7AfhglC7vrAxxwZDSRmdnpecKY5Fwas34fFPrw+JlkXRiaQ386
	 13gdowsP/pvzVhmlmHYZvOzyaPg88LFxFhvTU9FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgCJN3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgCJMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B3D2253D;
        Tue, 10 Mar 2020 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844712;
        bh=vtL6h8G/E53HpRe9CbZyuu54AiOY4RSVqqJZvamRaEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaET+SUBY0G9oKdxYM7O1k6XvwvxQK+4JXNyfwYGvXM2yOf+NKnrtsyQgUKbnmETE
         N29AqcrsdzhrG5Z/jhnk2PiUep1h2K7xxqBRRtNt9AAV4/xRIihkGhO+R3Hh9YNui9
         4kirOYWqv4IZzWMnRZYmVyMguBmMfG8Yh5txyAQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 091/168] media: v4l2-mem2mem.c: fix broken links
Date:   Tue, 10 Mar 2020 13:38:57 +0100
Message-Id: <20200310123644.507777927@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 316e730f1d8bb029fe6cec2468fb2a50424485b3 upstream.

The topology that v4l2_m2m_register_media_controller() creates for a
processing block actually created a source-to-source link and a sink-to-sink
link instead of two source-to-sink links.

Unfortunately v4l2-compliance never checked for such bad links, so this
went unreported for quite some time.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: <stable@vger.kernel.org>      # for v4.19 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-mem2mem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -809,12 +809,12 @@ int v4l2_m2m_register_media_controller(s
 		goto err_rel_entity1;
 
 	/* Connect the three entities */
-	ret = media_create_pad_link(m2m_dev->source, 0, &m2m_dev->proc, 1,
+	ret = media_create_pad_link(m2m_dev->source, 0, &m2m_dev->proc, 0,
 			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
 	if (ret)
 		goto err_rel_entity2;
 
-	ret = media_create_pad_link(&m2m_dev->proc, 0, &m2m_dev->sink, 0,
+	ret = media_create_pad_link(&m2m_dev->proc, 1, &m2m_dev->sink, 0,
 			MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
 	if (ret)
 		goto err_rm_links0;


