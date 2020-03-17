Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA9C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BB820663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443666;
	bh=XjYT1b6paNI3ACUNi7k83KjMPu2yA3xLoAtWOv4tEL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RBzde2Er+M45kT11+oKidJ5hyZ5Z8ig3WQCv2+t+YMnsTfKajpREPy+98hWuUQ1Jh
	 LYVN+R3BTAYRPA1kNL5n8IlP1+ISSq2RoySBJLCbHWBAWw1PefEShS7juzalZx5Shh
	 ctEtAPtH1ghMbN4GwFZBew7ylGZyczlEvFBapy/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgCQLOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbgCQLOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:14:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86314205ED;
        Tue, 17 Mar 2020 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443661;
        bh=XjYT1b6paNI3ACUNi7k83KjMPu2yA3xLoAtWOv4tEL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCiIrJ3QdS0MF+RrgkeLgpuVZLHJ/3I0jqSavSgN4TchSWPZMfXfuOwaReq47vvdT
         ngwFZGpI27yOTUAatKW0yqp120+t+jJjsdpFMeXEmrqm1ZwVuoi1E0rSFizlAncs9T
         R5KAUsF6b4bGv2l042fHwgcKAs+jtoI5kdZU7taI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.5 141/151] netfilter: cthelper: add missing attribute validation for cthelper
Date:   Tue, 17 Mar 2020 11:55:51 +0100
Message-Id: <20200317103336.689222535@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit c049b3450072b8e3998053490e025839fecfef31 upstream.

Add missing attribute validation for cthelper
to the netlink policy.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_cthelper.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -742,6 +742,8 @@ static const struct nla_policy nfnl_cthe
 	[NFCTH_NAME] = { .type = NLA_NUL_STRING,
 			 .len = NF_CT_HELPER_NAME_LEN-1 },
 	[NFCTH_QUEUE_NUM] = { .type = NLA_U32, },
+	[NFCTH_PRIV_DATA_LEN] = { .type = NLA_U32, },
+	[NFCTH_STATUS] = { .type = NLA_U32, },
 };
 
 static const struct nfnl_callback nfnl_cthelper_cb[NFNL_MSG_CTHELPER_MAX] = {


