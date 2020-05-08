Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE7C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06E224958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941890;
	bh=x/gFrVpT3Ffj+PZBClFJzWrlSI7AG0PbmewHrFiUroo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdK6678Vxx+NspyxXAYloVlpSek96nR9LZILNILxhovGzYuhnsq7J1c3ZZ9/03HOn
	 x6FIZDaMqbgNoBE8HJA6N3C4S8hN7ykAJCcio1i3bAD/ULefBdem7S0ILrG0YBfV+D
	 8okQME4AW7au8K9bGj1smvyz4HSq48lEId4pt8ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgEHMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgEHMoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E4821974;
        Fri,  8 May 2020 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941885;
        bh=x/gFrVpT3Ffj+PZBClFJzWrlSI7AG0PbmewHrFiUroo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNADdHmCWjEKw+kMkX0PX/i9uS1LfaVBck/Rd4Pk6rIGIifjd20CCHlusJP7RTtHi
         WjerH2C0BPeIEj893Bg9kZB/xVKCoSRWSo+GC8sePswaA066dQZAbPQVArQIrcBZ9T
         jPk6KGV/SH9CHU9STYCIdaXSQAW0R1/6ev5X2o/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 211/312] bpf: fix map not being uncharged during map creation failure
Date:   Fri,  8 May 2020 14:33:22 +0200
Message-Id: <20200508123139.247890347@linuxfoundation.org>
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

commit 20b2b24f91f70e7d3f0918c077546cb21bd73a87 upstream.

In map_create(), we first find and create the map, then once that
suceeded, we charge it to the user's RLIMIT_MEMLOCK, and then fetch
a new anon fd through anon_inode_getfd(). The problem is, once the
latter fails f.e. due to RLIMIT_NOFILE limit, then we only destruct
the map via map->ops->map_free(), but without uncharging the previously
locked memory first. That means that the user_struct allocation is
leaked as well as the accounted RLIMIT_MEMLOCK memory not released.
Make the label names in the fix consistent with bpf_prog_load().

Fixes: aaac3ba95e4c ("bpf: charge user for creation of BPF maps and programs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -152,7 +152,7 @@ static int map_create(union bpf_attr *at
 
 	err = bpf_map_charge_memlock(map);
 	if (err)
-		goto free_map;
+		goto free_map_nouncharge;
 
 	err = bpf_map_new_fd(map);
 	if (err < 0)
@@ -162,6 +162,8 @@ static int map_create(union bpf_attr *at
 	return err;
 
 free_map:
+	bpf_map_uncharge_memlock(map);
+free_map_nouncharge:
 	map->ops->map_free(map);
 	return err;
 }


