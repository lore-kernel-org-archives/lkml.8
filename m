Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B62051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338674;
	bh=UUQFGP3pj9DJoqDSltpk18FQw+I+6J/hACUTurBQtEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BW/0dA2Gc7Dyq031Oo79fNc7NWhC1/n2uxrXxH+8gE+NwFNJ1FCyYmfy849fCR8rm
	 2sNyFPjYwP31dO2411Zubx9Pb4GTr2RqpfLbbUyD7eO2fDHaHWkugoYlW4/Rmi9nv7
	 9oWLHZ2O7KYCLDHlzbnNCm5Gd99N8tNo8xbs0Nds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgBJMod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgBJMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:38 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFDA420661;
        Mon, 10 Feb 2020 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338438;
        bh=UUQFGP3pj9DJoqDSltpk18FQw+I+6J/hACUTurBQtEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egih3imhOsgzU+xsKR6nop60763Y/8C+P1ekdgShlG9Bj/zhGjC8TAQ8b77Q8le+F
         KJf42j9bcCwBhy8HgJbJiJLslKZ5BHDk+vUboUc0qzQXZrGr2RuOdlmQ0tbgUrk4Q9
         /O1z4VOO+gv5EGnzolw+BMz1m+SzveT1hzVsfJFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 5.5 173/367] selftests: bpf: Ignore FIN packets for reuseport tests
Date:   Mon, 10 Feb 2020 04:31:26 -0800
Message-Id: <20200210122440.824564923@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

commit 8bec4f665e0baecb5f1b683379fc10b3745eb612 upstream.

The reuseport tests currently suffer from a race condition: FIN
packets count towards DROP_ERR_SKB_DATA, since they don't contain
a valid struct cmd. Tests will spuriously fail depending on whether
check_results is called before or after the FIN is processed.

Exit the BPF program early if FIN is set.

Fixes: 91134d849a0e ("bpf: Test BPF_PROG_TYPE_SK_REUSEPORT")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200124112754.19664-3-lmb@cloudflare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -113,6 +113,12 @@ int _select_by_skb_data(struct sk_reusep
 		data_check.skb_ports[0] = th->source;
 		data_check.skb_ports[1] = th->dest;
 
+		if (th->fin)
+			/* The connection is being torn down at the end of a
+			 * test. It can't contain a cmd, so return early.
+			 */
+			return SK_PASS;
+
 		if ((th->doff << 2) + sizeof(*cmd) > data_check.len)
 			GOTO_DONE(DROP_ERR_SKB_DATA);
 		if (bpf_skb_load_bytes(reuse_md, th->doff << 2, &cmd_copy,


