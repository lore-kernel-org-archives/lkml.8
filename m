Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD59C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3EA20731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941840;
	bh=yGfNa+n5Nyg6FPVOOg9qf7jiROMVkZog5tzowtrAA5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQbAx+aSXmyaKN14cQe344GHlhOcr5y0+f6u5cMz5Hy9FKn1UhgATespZ7uGLsQ3u
	 0P98SVAsXGRLTtMQQ/wPVAp+2lOV3YmXx91In6c7jsGymJjxKWrCbmODq75cVZ6W+l
	 1fdGEC33NCetsJRxvLLv0hcQq+L5koIHK/iW/5Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEHMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbgEHMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00CF20720;
        Fri,  8 May 2020 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941835;
        bh=yGfNa+n5Nyg6FPVOOg9qf7jiROMVkZog5tzowtrAA5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fVqGiaCDbdAeHADlfS1YqVmqy8MjhY3qvmxrYGHGGIon9gtEC9Qs3dfKugwBIKf4
         lDM+HODyFf4xCfjDkkBhCRwO3O3ULZhQrS5KH9Gs3vTMp/XBa8LbiB8g7hkuLpPoOS
         yxgW72hidAK3bYzGIkErAFJ+PMas4H4qPOUGOKCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Ricard <christophe-h.ricard@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 4.4 151/312] NFC: nci: memory leak in nci_core_conn_create()
Date:   Fri,  8 May 2020 14:32:22 +0200
Message-Id: <20200508123135.083649102@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit c6dc65d885b98898bf287aaf44e020077b41769f upstream.

I've moved the check for "number_destination_params" forward
a few lines to avoid leaking "cmd".

Fixes: caa575a86ec1 ('NFC: nci: fix possible crash in nci_core_conn_create')

Acked-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/nfc/nci/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -610,14 +610,14 @@ int nci_core_conn_create(struct nci_dev
 	struct nci_core_conn_create_cmd *cmd;
 	struct core_conn_create_data data;
 
+	if (!number_destination_params)
+		return -EINVAL;
+
 	data.length = params_len + sizeof(struct nci_core_conn_create_cmd);
 	cmd = kzalloc(data.length, GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
-	if (!number_destination_params)
-		return -EINVAL;
-
 	cmd->destination_type = destination_type;
 	cmd->number_destination_params = number_destination_params;
 	memcpy(cmd->params, params, params_len);


