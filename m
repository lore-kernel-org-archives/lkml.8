Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2CDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C3B2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034788;
	bh=G5znw6b3xcWoE98cHwMwBHm1ZG+kgcYl3ptVUaPg7Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TmE/sdBB7Mqd8LJM+jQp7HjPM9EhI+8wSiRFwHXwW+QLQcSUkEGrTGoxJ+7yLqWPL
	 8sRsF3aAOVTuG3sbh8YsVhqDJ/OwycllnMHz988cOiW2SkaldiBGIbb1au8AU5puK9
	 OQ0jqo3JEK4kuuvz/5tDrz8UDz7PQpsI5Y8oaX38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgFASG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbgFASFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C17A2068D;
        Mon,  1 Jun 2020 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034754;
        bh=G5znw6b3xcWoE98cHwMwBHm1ZG+kgcYl3ptVUaPg7Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxQkaNM4I4kk5aNf1rNOOrnci9/ozxUt2brVSgMOeodYZffptFOozqbYOHV2IJFY7
         jy8yoLXJAvdKK36bLXbYUq9XbbV7LXOQe/gyIjpSq5w9viM6bQmC/WXLUabPo2OQLm
         0VvVyyu9a8pxGaDA2EjGGZo9XmfpRvnWWr15O/nM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 94/95] netfilter: nf_conntrack_pptp: fix compilation warning with W=1 build
Date:   Mon,  1 Jun 2020 19:54:34 +0200
Message-Id: <20200601174034.695664262@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 4946ea5c1237036155c3b3a24f049fd5f849f8f6 upstream.

>> include/linux/netfilter/nf_conntrack_pptp.h:13:20: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
extern const char *const pptp_msg_name(u_int16_t msg);
^~~~~~

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 4c559f15efcc ("netfilter: nf_conntrack_pptp: prevent buffer overflows in debug code")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/nf_conntrack_pptp.h |    2 +-
 net/netfilter/nf_conntrack_pptp.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/netfilter/nf_conntrack_pptp.h
+++ b/include/linux/netfilter/nf_conntrack_pptp.h
@@ -5,7 +5,7 @@
 
 #include <linux/netfilter/nf_conntrack_common.h>
 
-extern const char *const pptp_msg_name(u_int16_t msg);
+const char *pptp_msg_name(u_int16_t msg);
 
 /* state of the control session */
 enum pptp_ctrlsess_state {
--- a/net/netfilter/nf_conntrack_pptp.c
+++ b/net/netfilter/nf_conntrack_pptp.c
@@ -90,7 +90,7 @@ static const char *const pptp_msg_name_a
 	[PPTP_SET_LINK_INFO]		= "SET_LINK_INFO"
 };
 
-const char *const pptp_msg_name(u_int16_t msg)
+const char *pptp_msg_name(u_int16_t msg)
 {
 	if (msg > PPTP_MSG_MAX)
 		return pptp_msg_name_array[0];


