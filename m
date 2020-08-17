Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01929C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3DE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689942;
	bh=pajey29gSXI0arRFwJ6hX2XK+ZtRgpb5HmOTMiRFEzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01E9j+sSmRyrx4KGk4jS5xUKxy7dFhJrhtjrL2+3ycxbG1EKONrrddEB/s3pgz736
	 zBvwmdVkJI9i5KTCE8+9v+XKGt0tXdzAeeiHzMvZc7feIZm2K3si3WVUf1UqBsaBB+
	 h3M/cuwZ16d6bdde08UwSJoR0Qe0faZt67K96it8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391452AbgHQSpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbgHQPzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:55:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87037207FF;
        Mon, 17 Aug 2020 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679754;
        bh=pajey29gSXI0arRFwJ6hX2XK+ZtRgpb5HmOTMiRFEzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6f6EMFoN/CImELkHg9AwOkpiw5XruNF3A1LoWsCkEQp4urKyj/XYW9w2rLumITQn
         36re5/9jIcJqb5dqdsSwuwDYaWE1WGwwMTkQBUU6sWafAQY3oNfyRs5TG+L1XG9Sf9
         XJAB9USyMbckZiuYpKB2ncdkaJ+daeFSQnpKh9PQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 292/393] tools, bpftool: Fix wrong return value in do_dump()
Date:   Mon, 17 Aug 2020 17:15:42 +0200
Message-Id: <20200817143833.786643800@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

[ Upstream commit 041549b7b2c7811ec40e705c439211f00ade2dda ]

In case of btf_id does not exist, a negative error code -ENOENT
should be returned.

Fixes: c93cc69004df3 ("bpftool: add ability to dump BTF types")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200802111540.5384-1-tianjia.zhang@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index bcaf55b594982..81a77475bea61 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -597,7 +597,7 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		if (!btf) {
-			err = ENOENT;
+			err = -ENOENT;
 			p_err("can't find btf with ID (%u)", btf_id);
 			goto done;
 		}
-- 
2.25.1



