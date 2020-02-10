Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957220838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338235;
	bh=868tlg1DuwDywdnzsV4fTcAhhf7kZR1YZPpVNvPkJC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcBUbyrPGQ5XwcBDtPgoLKoDrvBZyz4X0Ps60aycxfJG4/XJ5dFzf3OC3OfiFer9c
	 SFEI7TpymuqMFym2bLxphDk9QIx6dlSLVLC1RtzQsefXEDfaCvARRFHdLtoF88izk2
	 U76Qm6myH3nKC/njGLJzhipsr2H067+5Glt9+Ffw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgBJMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgBJMgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:08 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA9821734;
        Mon, 10 Feb 2020 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338168;
        bh=868tlg1DuwDywdnzsV4fTcAhhf7kZR1YZPpVNvPkJC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=id0OlfB52cS3CBq11b8hvkej4cv/rLTy1rZZu3VllX31ZY2yHA5iwbAEzwiZexkoj
         6U2HSD82MUg2C6HqyuZQQGd6Bfg5L+43YRB9VdmqrhTldOxIXLXR+diRxBsNrCqDp7
         iu2+N8B4N2bnLnM+XRc61xtIhkrvKN9Uk6N8Fp3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 148/195] scsi: ufs: Recheck bkops level if bkops is disabled
Date:   Mon, 10 Feb 2020 04:33:26 -0800
Message-Id: <20200210122319.731762402@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

commit 24366c2afbb0539fb14eff330d4e3a5db5c0a3ef upstream.

bkops level should be rechecked upon receiving an exception.  Currently the
level is being cached and never updated.

Update bkops each time the level is checked.  Also do not use the cached
bkops level value if it is disabled and then enabled.

Fixes: afdfff59a0e0 (scsi: ufs: handle non spec compliant bkops behaviour by device)
Link: https://lore.kernel.org/r/1574751214-8321-2-git-send-email-cang@qti.qualcomm.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5044,6 +5044,7 @@ static int ufshcd_disable_auto_bkops(str
 
 	hba->auto_bkops_enabled = false;
 	trace_ufshcd_auto_bkops_state(dev_name(hba->dev), "Disabled");
+	hba->is_urgent_bkops_lvl_checked = false;
 out:
 	return err;
 }
@@ -5068,6 +5069,7 @@ static void ufshcd_force_reset_auto_bkop
 		hba->ee_ctrl_mask &= ~MASK_EE_URGENT_BKOPS;
 		ufshcd_disable_auto_bkops(hba);
 	}
+	hba->is_urgent_bkops_lvl_checked = false;
 }
 
 static inline int ufshcd_get_bkops_status(struct ufs_hba *hba, u32 *status)
@@ -5114,6 +5116,7 @@ static int ufshcd_bkops_ctrl(struct ufs_
 		err = ufshcd_enable_auto_bkops(hba);
 	else
 		err = ufshcd_disable_auto_bkops(hba);
+	hba->urgent_bkops_lvl = curr_status;
 out:
 	return err;
 }


