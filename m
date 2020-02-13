Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84C4206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607825;
	bh=IrTAExo0GMcygchAtn0puJ0Ay//ICD8FkZHzXTXCYGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E90ZnmHc/g0RVBOTcLMIJuzvUCJEQ4kV7zMobLgqCuPlS0TGvIkzdKFpXUM6K5Twt
	 C4wo/BMqSupnrHn5A4EEslT5fZ1DDjBs2tBkGx82o/vsetelUVQlbjJmuDJLIY9uSZ
	 WJDK/BbVKYdqzi1XAkce14daUBTkDtDMOGU0UCBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbgBMPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgBMP1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:18 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BFF24670;
        Thu, 13 Feb 2020 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607638;
        bh=IrTAExo0GMcygchAtn0puJ0Ay//ICD8FkZHzXTXCYGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkd6V+7PxGzTdwJpT0b0+HLCvyRqi/0OTC6757ByotR3sl5ZukaDaBw9Ahg+5qXM4
         5sPM7eVoA6h/58ihyWB2RgIUsF6vucR7NaaKUdSc4XK6zyUofcXbceXSThIJgeeYhM
         YXuKEl8/TwEU49rZCS6w4ojqStX0SB7BeumKwBg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.4 25/96] bpf: Improve bucket_log calculation logic
Date:   Thu, 13 Feb 2020 07:20:32 -0800
Message-Id: <20200213151848.861853002@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

commit 88d6f130e5632bbf419a2e184ec7adcbe241260b upstream.

It was reported that the max_t, ilog2, and roundup_pow_of_two macros have
exponential effects on the number of states in the sparse checker.

This patch breaks them up by calculating the "nbuckets" first so that the
"bucket_log" only needs to take ilog2().

In addition, Linus mentioned:

  Patch looks good, but I'd like to point out that it's not just sparse.

  You can see it with a simple

    make net/core/bpf_sk_storage.i
    grep 'smap->bucket_log = ' net/core/bpf_sk_storage.i | wc

  and see the end result:

      1  365071 2686974

  That's one line (the assignment line) that is 2,686,974 characters in
  length.

  Now, sparse does happen to react particularly badly to that (I didn't
  look to why, but I suspect it's just that evaluating all the types
  that don't actually ever end up getting used ends up being much more
  expensive than it should be), but I bet it's not good for gcc either.

Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Link: https://lore.kernel.org/bpf/20200207081810.3918919-1-kafai@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/bpf_sk_storage.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -643,9 +643,10 @@ static struct bpf_map *bpf_sk_storage_ma
 		return ERR_PTR(-ENOMEM);
 	bpf_map_init_from_attr(&smap->map, attr);
 
+	nbuckets = roundup_pow_of_two(num_possible_cpus());
 	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	smap->bucket_log = max_t(u32, 1, ilog2(roundup_pow_of_two(num_possible_cpus())));
-	nbuckets = 1U << smap->bucket_log;
+	nbuckets = max_t(u32, 2, nbuckets);
+	smap->bucket_log = ilog2(nbuckets);
 	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
 
 	ret = bpf_map_charge_init(&smap->map.memory, cost);


