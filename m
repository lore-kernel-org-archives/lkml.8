Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ECC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D2124694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844786;
	bh=RUb0YOqHYOHlRRcJrr7TNAMVJsnIqoIrk9pzaoOBF9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WWciy3SJTxQcbJWXp3+KGC0DoLtqhVfBPC4754fZIGCKkeCBWt530Yl0K6GHgJv6i
	 VFzW43skjXIZ8+nUTqcj/p9Bkekgfs216iTLOd02CxsJRrYAXn5p9rKcEQa2W+IuPR
	 U3wY+OJVxsg3FAF68Pd9dLTC2cIxKiMXVtOASM6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgCJMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgCJMxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE7120674;
        Tue, 10 Mar 2020 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844781;
        bh=RUb0YOqHYOHlRRcJrr7TNAMVJsnIqoIrk9pzaoOBF9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyqXz9g3GxikMeEU0c55iuvrJ+HhRgAO+a7LkQijKXWM0XtBkgSYKcvFjbl4S7kC5
         n3qukpeW9OZN5qmJNpEHZLJbsvfoh2SQ5U0Vqgj+sj4myV4UntBBcqvaaG/rZnjeNH
         NsCUVu8OgbkTI+sN1wLp/Z+wxff+4YXoniZ2TcZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 117/168] ASoC: topology: Fix memleak in soc_tplg_link_elems_load()
Date:   Tue, 10 Mar 2020 13:39:23 +0100
Message-Id: <20200310123647.251499097@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

commit 2b2d5c4db732c027a14987cfccf767dac1b45170 upstream.

If soc_tplg_link_config() fails, _link needs to be freed in case of
topology ABI version mismatch. However the current code is returning
directly and ends up leaking memory in this case.
This patch fixes that.

Fixes: 593d9e52f9bb ("ASoC: topology: Add support to configure existing physical DAI links")
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Link: https://lore.kernel.org/r/20200207185325.22320-2-dragos_tarcatu@mentor.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-topology.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2320,8 +2320,11 @@ static int soc_tplg_link_elems_load(stru
 		}
 
 		ret = soc_tplg_link_config(tplg, _link);
-		if (ret < 0)
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_link);
 			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size


