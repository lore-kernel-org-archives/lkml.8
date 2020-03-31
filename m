Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DE3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F7C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645599;
	bh=orhVSCEBXcC5KwzEYYjTBBxBvxGMor1crpLbKes0erU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oqo5l0VbJtG7cbWEFkXQJC1ApxZeoZhpPe+oSb5q8gipEXHLJSKw45f7TdlojwiYV
	 heJqoqrDYdTN3sfriAXtKWmRL7ytA+2kCKlFy/6s3ujmxaMXATvJbrvbCBL79RHXIh
	 El3ktuHzgOwAH7qOdLWuGgLSw+ntdbBGyvDqvuHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgCaJGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbgCaJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:06:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660EE20787;
        Tue, 31 Mar 2020 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645593;
        bh=orhVSCEBXcC5KwzEYYjTBBxBvxGMor1crpLbKes0erU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1W+vn6l/Qz4DRY3B/KCaO1kIK2OPxRQxyDomyfEC7A93uKkO06psFS/1VyfNcdGl3
         bgnmbrR9H6+z0UrnGHzRTMmtnZdd8676yFK3h1JegrP3Zf3J+Gb9MMvfhmzg/ugS2Z
         izvPApkmJW+UTw1O3U6ER4ekX/oTeOCec/tNhkY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ashish <ashishkumar.yadav@students.iiserpune.ac.in>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 100/170] rtlwifi: rtl8188ee: Fix regression due to commit d1d1a96bdb44
Date:   Tue, 31 Mar 2020 10:58:34 +0200
Message-Id: <20200331085434.862354516@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit c80b18cbb04b7b101af9bd14550f13d9866c646a upstream.

For some unexplained reason, commit d1d1a96bdb44 ("rtlwifi: rtl8188ee:
Remove local configuration variable") broke at least one system. As
the only net effect of the change was to remove 2 bytes from the start
of struct phy_status_rpt, this patch adds 2 bytes of padding at the
beginning of the struct.

Fixes: d1d1a96bdb44 ("rtlwifi: rtl8188ee: Remove local configuration variable")
Cc: Stable <stable@vger.kernel.org>  # V5.4+
Reported-by: Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
Tested-by: Ashish <ashishkumar.yadav@students.iiserpune.ac.in>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -561,6 +561,7 @@ static inline void clear_pci_tx_desc_con
 	 rxmcs == DESC92C_RATE11M)
 
 struct phy_status_rpt {
+	u8	padding[2];
 	u8	ch_corr[2];
 	u8	cck_sig_qual_ofdm_pwdb_all;
 	u8	cck_agc_rpt_ofdm_cfosho_a;


