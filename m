Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E491FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86FB20786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947638;
	bh=ua2CwIbuX9rW6cSbfOZaPkhnt2NKjBdgLpNFabwYfcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGcs0w5VnhNcihFlAuxjsjj1s6+iqkIauMW1/a/bcFzs6375M2nLG6bDJSItc5vAS
	 +aXAbjLZ/XKRRC3/5Zd04rfu/v5Z8/L3VYnRW3yn2W14iWmjPO824yzr6x5Hy3yxbM
	 KTH7GirWdaSXSIKUgrUJ7KZEJgFOXEbbCG6ZO0u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbgFWURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388879AbgFWURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E36C2080C;
        Tue, 23 Jun 2020 20:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943424;
        bh=ua2CwIbuX9rW6cSbfOZaPkhnt2NKjBdgLpNFabwYfcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXF/bVh8aXbnNBfJQq+ICqkPWucdcqQaQg/Y3yInOCaJmZag2siCzdDY/KE46GuSQ
         UafWRpKg0okj7Mmce+kx6PgA7G2u8uym0sZgUhqZDoNdiMXBS7kkjuoNTPb5fAKAkO
         0HPiorbqWMfITvIy0EwYNrqEmIzg7y4dI2/hcGFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 369/477] tools, bpftool: Fix memory leak in codegen error cases
Date:   Tue, 23 Jun 2020 21:56:06 +0200
Message-Id: <20200623195424.972829781@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

[ Upstream commit d4060ac969563113101c79433f2ae005feca1c29 ]

Free the memory allocated for the template on error paths in function
codegen.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200610130804.21423-1-tklauser@distanz.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/gen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index f8113b3646f52..f5960b48c8615 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -225,6 +225,7 @@ static int codegen(const char *template, ...)
 		} else {
 			p_err("unrecognized character at pos %td in template '%s'",
 			      src - template - 1, template);
+			free(s);
 			return -EINVAL;
 		}
 	}
@@ -235,6 +236,7 @@ static int codegen(const char *template, ...)
 			if (*src != '\t') {
 				p_err("not enough tabs at pos %td in template '%s'",
 				      src - template - 1, template);
+				free(s);
 				return -EINVAL;
 			}
 		}
-- 
2.25.1



