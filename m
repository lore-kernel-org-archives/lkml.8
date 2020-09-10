Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45910C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E306B207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEZWoPjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJGER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgIJGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:04:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69389C061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:04:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so3645846pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmrRE/cAzT6Pa5rmjyA2UxqDEd0+8qsdczMgIJaVlsU=;
        b=LEZWoPjI4LA8Dv/MZRYuK82FFHbjI9L98lH14pFMFTBbD0RoCkuSYaZTurrF3ogbrJ
         IduTS4B46X3HuwdMjZzBoVS79Orz/g76vTulGQrv4p7RvV6YxqthIMO8H0BjwcGUkkUC
         /fbvwqhXI6uoZMEvZvmLXSebliXRf50ScUhn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmrRE/cAzT6Pa5rmjyA2UxqDEd0+8qsdczMgIJaVlsU=;
        b=ZSRyt5b2K43rS2CmI60pu6NzXqGAFSg69p3dFxzNLLbcE3JrWbwjtBsrKGyfqNms8I
         3ZNmCfxRPXkgS+Lvm1+V+XjPsX8MRKumrl5rOFxY8TviUl1RZy0hZWu738HFlbgqgFTj
         XevPQg9iagUfVAeUCTYJtv9AlMH9mpMRL6ELNUVoanLAKmlhbtYfy9c3N1F7f6RAtnZ9
         SGieVKN747Tx44wt2lPtto/NkxH4P+gfU8WFriAzjP0G33nm3wdov8/2KIAEUr30sYgw
         sKcBNNnNALTnSZYVJXmJUhTlL4Dbrzzo75XiCjyjYqPIZBTNq3/KrDNqiBIJHSYof1ZV
         9v/w==
X-Gm-Message-State: AOAM530GzFp2Ei30mfb1zzJayIDpGytdjend/WlXVdBy59O6LnsYQEfg
        PNzSDMfca8DXmdq80xv9gQaQTA==
X-Google-Smtp-Source: ABdhPJzGYrjJX62SBHU9URsZeDFcnsOS7Ix3hXjVRHeu8ZxSdmNkacTKI+nxmWp+LcsGGhb1Usfuew==
X-Received: by 2002:aa7:9494:: with SMTP id z20mr3939184pfk.144.1599717849282;
        Wed, 09 Sep 2020 23:04:09 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id j14sm893236pjz.21.2020.09.09.23.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:04:08 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 0/2] To support the HFP WBS, a chip vendor may choose a particular
Date:   Thu, 10 Sep 2020 14:04:00 +0800
Message-Id: <20200910060403.144524-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB alternate seeting of which the packet size is distinct.
The patches are to expose the packet size to user space so that
the user space does not need to hard code those values.

We have verified this patch on Chromebooks which use
- Realtek 8822CE controller with USB alt setting 1
- Intel controller with USB alt setting 6
Our user space audio server, cras, can get the correct
packet length from the socket option.

Changes in v3:
- Set hdev->sco_mtu to rp->sco_mtu if the latter is smaller.
- Fixed the commit message.

Changes in v2:
- Used sco_mtu instead of a new sco_pkt_len member in hdev.
- Do not overwrite hdev->sco_mtu in hci_cc_read_buffer_size
  if it has been set in the USB interface.
- Used BT_SNDMTU/BT_RCVMTU instead of creating a new opt name.
- Used the existing conn->mtu instead of creating a new member
  in struct sco_pinfo.
- Noted that the old SCO_OPTIONS in sco_sock_getsockopt_old()
  would just work as it uses sco_pi(sk)->conn->mtu.

Joseph Hwang (2):
  Bluetooth: btusb: define HCI packet sizes of USB Alts
  Bluetooth: sco: new getsockopt options BT_SNDMTU/BT_RCVMTU

 drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++++++++----------
 net/bluetooth/hci_event.c | 14 +++++++++++-
 net/bluetooth/sco.c       |  6 ++++++
 3 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.28.0.618.gf4bc123cb7-goog

