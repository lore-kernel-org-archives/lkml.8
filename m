Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56ACA22CBB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930398;
	bh=66G90lRavlVdhlnjqF4FluvMXpWwQXugFK+f2oebVQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZO2jKZYKX8eMc9fdQXfrb7Svls0yDbA9YxWOE9BXkJdF+9OuPoiNpJnQn92sW05ib
	 3hiuwtmrUporoU+KvnDrbxdLWI8VATkeGGnxtUpznqSh0+M4so08IBtz/AWhPso2XF
	 zV2qnkRun9TibMAx8B5QCBUF7SA6df9UwBgn4Bmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgHTNdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgHTJbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDDA207DE;
        Thu, 20 Aug 2020 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915863;
        bh=66G90lRavlVdhlnjqF4FluvMXpWwQXugFK+f2oebVQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB61nRW7nAWHpRDyj5vNdyySsxrITd1ZyraEj/cVih8IVQnDFsDzY5QV9yM2mQKhy
         En+aNS1ZnmMLg/AhAveL+fggZdaZYUvuG2xOQlRhY3XsCdfHf1IUNbfh3xdBf4+A7h
         MujNBexaAhwizsz/MzP8xHJxQQ6pgAhr44yTEPF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 131/232] selftests/bpf: Test_progs indicate to shell on non-actions
Date:   Thu, 20 Aug 2020 11:19:42 +0200
Message-Id: <20200820091619.163066268@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 6c92bd5cd4650c39dd929565ee172984c680fead ]

When a user selects a non-existing test the summary is printed with
indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
indicated. This can be understood by a human end-user, but for shell
scripting is it useful to indicate a shell failure (EXIT_FAILURE).

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/159363984736.930467.17956007131403952343.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 54fa5fa688ce9..da70a4f72f547 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -687,5 +687,8 @@ int main(int argc, char **argv)
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
 
+	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
+		return EXIT_FAILURE;
+
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.25.1



