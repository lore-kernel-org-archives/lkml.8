Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E4EC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4E321927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047348;
	bh=xl7673xMCxZLA8+BCaQwHav7o+Wj5R0wofxcq25bs3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/yQ4Jp9Bj0NyxQjwGygUIgoCjTEIyp7ItxcTsvZabyaIBdSnCjDCEqdoPUBDIWQf
	 MoHZSCzOeC4S4tS7UKdw8+W3r+uc7C2710yVyvvETC9BxCVncR1KWgPV8hbWZPyfPz
	 Ros7HAbI4tDK9Xk869o3cDCHB76EXwaxeJ9AvCL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436912AbgDPO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392645AbgDPOAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:00:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD1182078B;
        Thu, 16 Apr 2020 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045640;
        bh=xl7673xMCxZLA8+BCaQwHav7o+Wj5R0wofxcq25bs3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBw/4/YTzK8eBjWyN6VyNKZVBn/DniuZTsWMwWibtA0Bjp0f/nRs3gjT162b3/4r0
         JO2hN3sE6PlHdarbDyDiEwYhr8r12z6NYuQZZHpea3KIgegH69ytWzIiOsN1BuxAI1
         LrGYSRNv6ta0IBcK/FMjC9YzORFfwpwdkEn/tUtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <aglo@umich.edu>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.6 216/254] NFS: Fix a few constant_table array definitions
Date:   Thu, 16 Apr 2020 15:25:05 +0200
Message-Id: <20200416131353.023090263@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

commit 529af90576cfa44aa107e9876e2ebaa053983986 upstream.

nfs_vers_tokens, nfs_xprt_protocol_tokens, and nfs_secflavor_tokens were
all missing an empty item at the end of the array, allowing
lookup_constant() to potentially walk off the end and trigger and oops.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Fixes: e38bb238ed8c ("NFS: Convert mount option parsing to use functionality from fs_parser.h")
Cc: stable@vger.kernel.org # v5.6
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/fs_context.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -190,6 +190,7 @@ static const struct constant_table nfs_v
 	{ "4.0",	Opt_vers_4_0 },
 	{ "4.1",	Opt_vers_4_1 },
 	{ "4.2",	Opt_vers_4_2 },
+	{}
 };
 
 enum {
@@ -202,13 +203,14 @@ enum {
 	nr__Opt_xprt
 };
 
-static const struct constant_table nfs_xprt_protocol_tokens[nr__Opt_xprt] = {
+static const struct constant_table nfs_xprt_protocol_tokens[] = {
 	{ "rdma",	Opt_xprt_rdma },
 	{ "rdma6",	Opt_xprt_rdma6 },
 	{ "tcp",	Opt_xprt_tcp },
 	{ "tcp6",	Opt_xprt_tcp6 },
 	{ "udp",	Opt_xprt_udp },
 	{ "udp6",	Opt_xprt_udp6 },
+	{}
 };
 
 enum {
@@ -239,6 +241,7 @@ static const struct constant_table nfs_s
 	{ "spkm3i",	Opt_sec_spkmi },
 	{ "spkm3p",	Opt_sec_spkmp },
 	{ "sys",	Opt_sec_sys },
+	{}
 };
 
 /*


