Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2533C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B732C20708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341309;
	bh=olCRPt9Dh2xRa/1n1FT+MDS57VFZyyvyVxvWk8826K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2zwE+ebWCpz8iFb2r+CYy+lkBbrcybvap5WI47n33DPslmXSVZNunjbDaSbTejv8
	 WyTrG7j/wK84lUtRjNXJdrW0V4gwRPNYzdS5RnBcSjmfwHabi7rfJUvswzgVm6fKmp
	 zrRpP2aSSpx56YwHeGC2+JGZnhwLn4D3Ph+ge6aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgEANzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729914AbgEANe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:34:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B202173E;
        Fri,  1 May 2020 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340067;
        bh=olCRPt9Dh2xRa/1n1FT+MDS57VFZyyvyVxvWk8826K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiitS3/UqJKTeQsteox88ITJfAh89W3Hn7dKyRfBcck9czxFYZDvww3UzdDkbb320
         3KMJkzOc1J28kbTaznETi8WvL5itRiLyYeBQzfoPKugObaEHh/ooDVUHFaL+0aondr
         UvqVDv3SnFLxnVihExVPNa37q9lOrYx1dMnqgTuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Udipto Goswami <ugoswami@codeaurora.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH 4.14 081/117] usb: f_fs: Clear OS Extended descriptor counts to zero in ffs_data_reset()
Date:   Fri,  1 May 2020 15:21:57 +0200
Message-Id: <20200501131554.456023496@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Udipto Goswami <ugoswami@codeaurora.org>

commit 1c2e54fbf1da5e5445a0ab132c862b02ccd8d230 upstream.

For userspace functions using OS Descriptors, if a function also supplies
Extended Property descriptors currently the counts and lengths stored in
the ms_os_descs_ext_prop_{count,name_len,data_len} variables are not
getting reset to 0 during an unbind or when the epfiles are closed. If
the same function is re-bound and the descriptors are re-written, this
results in those count/length variables to monotonically increase
causing the VLA allocation in _ffs_func_bind() to grow larger and larger
at each bind/unbind cycle and eventually fail to allocate.

Fix this by clearing the ms_os_descs_ext_prop count & lengths to 0 in
ffs_data_reset().

Fixes: f0175ab51993 ("usb: gadget: f_fs: OS descriptors support")
Cc: stable@vger.kernel.org
Signed-off-by: Udipto Goswami <ugoswami@codeaurora.org>
Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
Reviewed-by: Manu Gautam <mgautam@codeaurora.org>
Link: https://lore.kernel.org/r/20200402044521.9312-1-sallenki@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1727,6 +1727,10 @@ static void ffs_data_reset(struct ffs_da
 	ffs->state = FFS_READ_DESCRIPTORS;
 	ffs->setup_state = FFS_NO_SETUP;
 	ffs->flags = 0;
+
+	ffs->ms_os_descs_ext_prop_count = 0;
+	ffs->ms_os_descs_ext_prop_name_len = 0;
+	ffs->ms_os_descs_ext_prop_data_len = 0;
 }
 
 


