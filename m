Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1773D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943810;
	bh=5qwJ1HXduhShhqO66V2xRuZoNmsgUkmpW5HiZw1jGHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lB3SatDiAqyjC7HNs/jU9r/Qt2i8/4bKXCX0LKWWNv0f08p8Bcinm+9cvRJCtXQTa
	 tudpj7CR3aRMAAkL3j1X12C7KRYsJHbwUQc9KR1EwcbrKAnRVVFKdkRZOCkS1ANwwJ
	 WrsQttJT61y80c02NBDBHmqpfSlr8an+HnswWDf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgEHNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbgEHMom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1512145D;
        Fri,  8 May 2020 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941882;
        bh=5qwJ1HXduhShhqO66V2xRuZoNmsgUkmpW5HiZw1jGHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0zOpcfs8wvyvdfWO888M0Ib4t/7wRE0MxS8fRcHBPKkkhah6aOjsDKgs8X5RnNv3
         UHUZ67/UY5dhMnPaP3UVCmnjKCO2AoF9BEykWQe+TaeKSrs7dGZGBqnDzUvMPrsSOr
         eaLpegonuDfQl+L2jCCrgmQQrt2zYiEubnEicjrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 210/312] bpf, trace: check event type in bpf_perf_event_read
Date:   Fri,  8 May 2020 14:33:21 +0200
Message-Id: <20200508123139.179064292@linuxfoundation.org>
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

From: Alexei Starovoitov <ast@fb.com>

commit ad572d174787daa59e24b8b5c83028c09cdb5ddb upstream.

similar to bpf_perf_event_output() the bpf_perf_event_read() helper
needs to check the type of the perf_event before reading the counter.

Fixes: a43eec304259 ("bpf: introduce bpf_perf_event_output() helper")
Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/bpf_trace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -206,6 +206,10 @@ static u64 bpf_perf_event_read(u64 r1, u
 	    event->pmu->count)
 		return -EINVAL;
 
+	if (unlikely(event->attr.type != PERF_TYPE_HARDWARE &&
+		     event->attr.type != PERF_TYPE_RAW))
+		return -EINVAL;
+
 	/*
 	 * we don't know if the function is run successfully by the
 	 * return value. It can be judged in other places, such as


