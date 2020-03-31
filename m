Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A7DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15020787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646074;
	bh=AmISZsjwQJs8uncXhFUtLbROEQzrDp9cPvtLrYhGCXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM5tLT/865dSqeplZTFq8AsCkjw7wCdfnqYH5YXWpOBO3sJOdft/yDmBkI+pIpKaR
	 ISkyXb1BEbx42IS4i5hWhk06tcCJ3ihFh35y7jtTJNnVQjpfnekaUuJ+e7zVyummMq
	 UlEBmpVrKnnIQKFdFtoLFMvhWlRiENtJ10e/jbTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgCaJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgCaJOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B232320675;
        Tue, 31 Mar 2020 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646070;
        bh=AmISZsjwQJs8uncXhFUtLbROEQzrDp9cPvtLrYhGCXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnwsCplORvsJOlg4MRq1gvydSFJ9Lvt7pfqQuaFZK6LPwdpWjUfyCr38fUieoQjsg
         CTwmH2Pdz0tGBEOozIUUZQe72Uv+35glMg6EYt1sjY+bVXM+wbEPE08aR4MJiGFfKM
         niuYfUjQ4UKiW9O1FLK4N0RA64ePAHWVMc69y7Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH 5.4 075/155] iwlwifi: mvm: fix non-ACPI function
Date:   Tue, 31 Mar 2020 10:58:35 +0200
Message-Id: <20200331085426.783758851@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 7937fd3227055892e169f4b34d21157e57d919e2 upstream.

The code now compiles without ACPI, but there's a warning since
iwl_mvm_get_ppag_table() isn't used, and iwl_mvm_ppag_init() must
not unconditionally fail but return success instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[Drop hunk removing iwl_mvm_get_ppag_table() since it doesn't exist in
5.4]
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1181,7 +1181,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm
 
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
-	return -ENOENT;
+	return 0;
 }
 #endif /* CONFIG_ACPI */
 


