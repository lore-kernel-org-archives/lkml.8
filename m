Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C96C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945852495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941882;
	bh=QYHEIKYh0tEZd9a6ZA7grFSKnkw7CeRQNV1c80ry/8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wasSzS3a1RopHbNOCwSy9Xp4xx6yMVoBNZpcR7xbfrPwQS2sQoAY7nNISLv0JmUOV
	 6qcSCiYp+CKKjQpc6415/gnOfVX1VoNb59bDGxo/wkRLHWk4S6AElTvD2wPM37P084
	 s3lCuawGId/9Q++YsMbHF07RrMbpnVAXlQhtu6l4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgEHMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgEHMoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2969524958;
        Fri,  8 May 2020 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941877;
        bh=QYHEIKYh0tEZd9a6ZA7grFSKnkw7CeRQNV1c80ry/8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQFrvN+cenBESZliFY1ATSfGTc6/m1TFVXxkMMU9GG7fU7wp56lBc2qLumHcVYmGw
         u+kqgAx+pQtg0Bkj2LtpzS+1Luvi1dFIxkgtHFIU6hUH2ar2fFd/2PCkyVYGYsvjN/
         9GGJu66dq92bJl3jTdNlWVJn+LxIAfPc9yrePkLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 208/312] cls_bpf: reset class and reuse major in da
Date:   Fri,  8 May 2020 14:33:19 +0200
Message-Id: <20200508123139.042836532@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

commit 3a461da1d03e7a857edfa6a002040d07e118c639 upstream.

There are two issues with the current code. First one is that we need
to set res->class to 0 in case we use non-default classid matching.

This is important for the case where cls_bpf was initially set up with
an optional binding to a default class with tcf_bind_filter(), where
the underlying qdisc implements bind_tcf() that fills res->class and
tests for it later on when doing the classification. Convention for
these cases is that after tc_classify() was called, such qdiscs (atm,
drr, qfq, cbq, hfsc, htb) first test class, and if 0, then they lookup
based on classid.

Second, there's a bug with da mode, where res->classid is only assigned
a 16 bit minor, but it needs to expand to the full 32 bit major/minor
combination instead, therefore we need to expand with the bound major.
This is fine as classes belonging to a classful qdisc must share the
same major.

Fixes: 045efa82ff56 ("cls_bpf: introduce integrated actions")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/cls_bpf.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -107,8 +107,9 @@ static int cls_bpf_classify(struct sk_bu
 		}
 
 		if (prog->exts_integrated) {
-			res->class = prog->res.class;
-			res->classid = qdisc_skb_cb(skb)->tc_classid;
+			res->class   = 0;
+			res->classid = TC_H_MAJ(prog->res.classid) |
+				       qdisc_skb_cb(skb)->tc_classid;
 
 			ret = cls_bpf_exec_opcode(filter_res);
 			if (ret == TC_ACT_UNSPEC)
@@ -118,10 +119,12 @@ static int cls_bpf_classify(struct sk_bu
 
 		if (filter_res == 0)
 			continue;
-
-		*res = prog->res;
-		if (filter_res != -1)
+		if (filter_res != -1) {
+			res->class   = 0;
 			res->classid = filter_res;
+		} else {
+			*res = prog->res;
+		}
 
 		ret = tcf_exts_exec(skb, &prog->exts, res);
 		if (ret < 0)


