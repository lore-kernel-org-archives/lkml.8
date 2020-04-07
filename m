Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2365E2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255161;
	bh=5/sL9mCXly5jrq1A3Z9N4VVG6JUPKXdB9TUdv7LPc+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fHy6/GIerrJZopLqtC4IDj7w/Hqo7HQDTyf6mqlY5QYv9OhONsuAmxrbKGvqEP7+9
	 MLBLND4OsNb8clWhFL8NevD9lUH/B/bew/g8laDmb88TtYdWmIpeAkj0L0seJFnUvM
	 VWbVpsrDS2HuHSQ41azTVwoe7yGyeRFTYLcQn0WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgDGKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgDGKZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:25:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589492074F;
        Tue,  7 Apr 2020 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255156;
        bh=5/sL9mCXly5jrq1A3Z9N4VVG6JUPKXdB9TUdv7LPc+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIdUbJiJPT78BdFcL1S7HXCMq2aHT6E6mRM/jQNup6YOQTW0lBF0+eFq/oqyB2rxf
         XMBQvH+gfRMj0WExnIWSnuQcI0Kg46FBOYRo85OWSKRRKR5v8A5cOCircp9Bpy/kJi
         O/MnT+5Gf5Eh0xJ535n1TWlbrzskg6WomhjpsWvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 5.5 35/46] iwlwifi: consider HE capability when setting LDPC
Date:   Tue,  7 Apr 2020 12:22:06 +0200
Message-Id: <20200407101503.219777386@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

commit cb377dfda1755b3bc01436755d866c8e5336a762 upstream.

The AP may set the LDPC capability only in HE (IEEE80211_HE_PHY_CAP1),
but we were checking it only in the HT capabilities.

If we don't use this capability when required, the DSP gets the wrong
configuration in HE and doesn't work properly.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: befebbb30af0 ("iwlwifi: rs: consider LDPC capability in case of HE")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20200306151128.492d167c1a25.I1ad1353dbbf6c99ae57814be750f41a1c9f7f4ac@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -147,7 +147,11 @@ static u16 rs_fw_get_config_flags(struct
 	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	/* consider our LDPC support in case of HE */
+	/* consider LDPC support in case of HE */
+	if (he_cap->has_he && (he_cap->he_cap_elem.phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
+		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
+
 	if (sband->iftype_data && sband->iftype_data->he_cap.has_he &&
 	    !(sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))


