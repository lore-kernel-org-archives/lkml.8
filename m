Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DF4C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FDB216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340607;
	bh=YnuX65jq8EaYvxfRFmT84kpNqXmtcobQTJ4XRRMDfEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=THNbj4NXbNsGLwk0V9qJj6QYWfs4DQ2sZl6rXNVBiIkzXF1wOicAyuyEjakPlVZCf
	 ChDs7/MLBwas6GBqg0I1NBWMOhKwBY5pr/UwQL31so/BZbA8V9/XD2Lcww6oDF2zRz
	 k0bAxg6dPjNKrna10SQ6WZttYMoo9zFEy9evEYGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgEANn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731622AbgEANnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:43:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B2820757;
        Fri,  1 May 2020 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340603;
        bh=YnuX65jq8EaYvxfRFmT84kpNqXmtcobQTJ4XRRMDfEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC6DoCWB1KaiWoG0/0ayQ4o34IygNEBRFIpAKCoxCfgSg2jB/nLTdFVK2QpAxytth
         fdW8LV0d/epK4z8TGZpopSet3FmADI+zGEcANFb3a+Stf1LVlcxEIrxqqobwdNpaTt
         8JpiYYEWE7duuKG/GF2o5OH3mx8izQ4PTOBZH14k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5.6 049/106] cpumap: Avoid warning when CONFIG_DEBUG_PER_CPU_MAPS is enabled
Date:   Fri,  1 May 2020 15:23:22 +0200
Message-Id: <20200501131549.584542242@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit bc23d0e3f717ced21fbfacab3ab887d55e5ba367 upstream.

When the kernel is built with CONFIG_DEBUG_PER_CPU_MAPS, the cpumap code
can trigger a spurious warning if CONFIG_CPUMASK_OFFSTACK is also set. This
happens because in this configuration, NR_CPUS can be larger than
nr_cpumask_bits, so the initial check in cpu_map_alloc() is not sufficient
to guard against hitting the warning in cpumask_check().

Fix this by explicitly checking the supplied key against the
nr_cpumask_bits variable before calling cpu_possible().

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Xiumei Mu <xmu@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200416083120.453718-1-toke@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/cpumap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -469,7 +469,7 @@ static int cpu_map_update_elem(struct bp
 		return -EOVERFLOW;
 
 	/* Make sure CPU is a valid possible cpu */
-	if (!cpu_possible(key_cpu))
+	if (key_cpu >= nr_cpumask_bits || !cpu_possible(key_cpu))
 		return -ENODEV;
 
 	if (qsize == 0) {


