Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2289C8300B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71D821841
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099068;
	bh=HoZ1jmKaAFJOPrM4P+ug3uY8Rfr2dLp6MGHRka+OT7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D5wy0LHO6wwld9aLNXI776IZd7Ks7VW5LbUh673fZRipS1GSJTtw6130QA+bL52XK
	 AZQ+7lMlw72uh80ZKitwZ8DNV+kkR5a47nlFW+olmCRB100qB1dpLuyjPUO0+H+bLK
	 TFO52yXYEVeSsD7tRHI8fyd/cimEYXaaIePFxlgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgD1Shr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgD1Shl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE2320575;
        Tue, 28 Apr 2020 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099060;
        bh=HoZ1jmKaAFJOPrM4P+ug3uY8Rfr2dLp6MGHRka+OT7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdgjTTom0IfPvoBfYUIFm/cJO745p3cDZTPNT8tLB4cJj+el9txpQ28PCmz543BVV
         Y409toJhntwur5CEbCEC98gtU+7U74/jWnEMVHrvdbVoHKdEPoSH6S425tRDEHqCLp
         SIGi8vDwB34SQqFHgAClD++h5r8BVqPLDd+btyuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Udipto Goswami <ugoswami@codeaurora.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH 5.6 150/167] usb: f_fs: Clear OS Extended descriptor counts to zero in ffs_data_reset()
Date:   Tue, 28 Apr 2020 20:25:26 +0200
Message-Id: <20200428182244.534530387@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
@@ -1813,6 +1813,10 @@ static void ffs_data_reset(struct ffs_da
 	ffs->state = FFS_READ_DESCRIPTORS;
 	ffs->setup_state = FFS_NO_SETUP;
 	ffs->flags = 0;
+
+	ffs->ms_os_descs_ext_prop_count = 0;
+	ffs->ms_os_descs_ext_prop_name_len = 0;
+	ffs->ms_os_descs_ext_prop_data_len = 0;
 }
 
 


