Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51B320706
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580077;
	bh=KtAe3ObSg25LYSidXIG8L8qyak2OFEVpw47b12Sn1UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8LmPk+EycNgOzX4nbGsEAQlyy/paXSdPmN8rgBpa6dm6cH82/DW5e2WznTo26V/D
	 fKq6c7dgD0VytTCLR5CGyRJNlrx2BJtthGCw5ouLGVLqUq4x5iZ3NbgUnwhaccIuB/
	 v4HYdY3FkTITtrq0oicXImOAK20ptXhkY50BIWwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392830AbgFSPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392590AbgFSPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A423217D8;
        Fri, 19 Jun 2020 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579913;
        bh=KtAe3ObSg25LYSidXIG8L8qyak2OFEVpw47b12Sn1UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvLaKlLpQk31EZlwf6T0UPT1UuTs+sHoZhu29mYNbvNXtdaf5otO5lHtz2hNwkoeP
         2PLshzTZgoXQ9TAlbrz8wryhvJpInVXYkswUrvLt5pFc3i8MHIcGb7mMY+ePA7OXC0
         LB2KeDpkUgQYV6DIY2xpj9GqcOZhU3jwYR5yWu9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 021/376] selftests/bpf: Copy runqslower to OUTPUT directory
Date:   Fri, 19 Jun 2020 16:28:59 +0200
Message-Id: <20200619141711.365228398@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veronika Kabatova <vkabatov@redhat.com>

[ Upstream commit b26d1e2b60284dc9f66ffad9ccd5c5da1100bb4b ]

$(OUTPUT)/runqslower makefile target doesn't actually create runqslower
binary in the $(OUTPUT) directory. As lib.mk expects all
TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
the OUTPUT directory, this results in an error when running e.g. `make
install`:

rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
       such file or directory (2)

Copy the binary into the OUTPUT directory after building it to fix the
error.

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200428173742.2988395-1-vkabatov@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7729892e0b04..4e654d41c7af 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -141,7 +141,8 @@ VMLINUX_BTF := $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 $(OUTPUT)/runqslower: $(BPFOBJ)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
 		    OUTPUT=$(SCRATCH_DIR)/ VMLINUX_BTF=$(VMLINUX_BTF)   \
-		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
+		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR) &&	\
+		    cp $(SCRATCH_DIR)/runqslower $@
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
 
-- 
2.25.1



