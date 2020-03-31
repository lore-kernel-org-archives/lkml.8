Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85400C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A47E208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646252;
	bh=yOKg1tKJy2bt2wOT/yU5kFgS1IBYg+vcjwOpadC+8l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=roIEKl+eCieiBYAbhR9aq2YzXbUU1qOc/M6cCmrlnptrU3YQAmAl55pFb36Tlo8BD
	 ooPreljfhi8pBHo28yC/cUIL3bAFpQaPOYJ/lI4O8/byPLkB/8HgLW17F/c4lQAOXr
	 ZCGI3tCWgZXeno7AZIkznY/TvwAqu50YoweB+CrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgCaJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgCaJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:17:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3F5208FE;
        Tue, 31 Mar 2020 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646247;
        bh=yOKg1tKJy2bt2wOT/yU5kFgS1IBYg+vcjwOpadC+8l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7DN2Ijcg/RB5J894pwwnAgXalzy0Ct6M0FSSSSLnQKFfhL/V7S+1myv8vAZc/iUN
         UMIPZLbRRhu/71jhvnfLGenBv7YFzuYSFWm9l2H21+WS+2qWd9dJVRGdSpzDTDsrBC
         D5efQhn99SjqRdAM4zUONVCzSZiDFs/KF9+xtrfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.4 129/155] bpf: Initialize storage pointers to NULL to prevent freeing garbage pointer
Date:   Tue, 31 Mar 2020 10:59:29 +0200
Message-Id: <20200331085432.766853128@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

commit 62039c30c19dcab96621e074aeeb90da7100def7 upstream.

Local storage array isn't initialized, so if cgroup storage allocation fails
for BPF_CGROUP_STORAGE_SHARED, error handling code will attempt to free
uninitialized pointer for BPF_CGROUP_STORAGE_PERCPU storage type. Avoid this
by always initializing storage pointers to NULLs.

Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple cgroup storage types")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200309222756.1018737-1-andriin@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/cgroup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -303,8 +303,8 @@ int __cgroup_bpf_attach(struct cgroup *c
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
-	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
-		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;


