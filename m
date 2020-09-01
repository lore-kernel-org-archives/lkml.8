Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8567C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700E32064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975578;
	bh=oEudZmBVC1qylg631g3iIyD/7H99ow7aYXrEHbFr2wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GgvGsqVzCyu+6S9lXGj1vgoZ3JsHNdFlfnTr74VXRRS+1H7jjAwTkN3Lg9m1C/dtT
	 2AYGn7/uTzD+UbENuMWoPosg1RBQ9U9nQB1ryIjQWEPU3Vlv956qPybFizFGu3yQgi
	 YCfr2CDEAJO4acdrUgim1jvxlYNi1clBGyLeo3b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIAPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbgIAPrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:47:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2737D2100A;
        Tue,  1 Sep 2020 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975231;
        bh=oEudZmBVC1qylg631g3iIyD/7H99ow7aYXrEHbFr2wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/rWdJJPhn2Qpb2bP/RgV57AmGAKIwLdMOqWR9F59fq6ZiJFd0m4bGOmEUU8nsF9D
         UQc4hfX7POeSE9dlhyUoaK4QuVxfAFSzrajhog+xGV/6oPto20FbZmHYbSR2ztoQKS
         Bewy7J9ZzhI5Ho7rdiPhZnuYP4NFT7Bs4EZZkI1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.8 253/255] libbpf: Fix build on ppc64le architecture
Date:   Tue,  1 Sep 2020 17:11:49 +0200
Message-Id: <20200901151012.892407769@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

commit 3fb1a96a91120877488071a167d26d76be4be977 upstream.

On ppc64le we get the following warning:

  In file included from btf_dump.c:16:0:
  btf_dump.c: In function ‘btf_dump_emit_struct_def’:
  ../include/linux/kernel.h:20:17: error: comparison of distinct pointer types lacks a cast [-Werror]
    (void) (&_max1 == &_max2);  \
                   ^
  btf_dump.c:882:11: note: in expansion of macro ‘max’
      m_sz = max(0LL, btf__resolve_size(d->btf, m->type));
             ^~~

Fix by explicitly casting to __s64, which is a return type from
btf__resolve_size().

Fixes: 702eddc77a90 ("libbpf: Handle GCC built-in types for Arm NEON")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200818164456.1181661-1-andriin@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/bpf/btf_dump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -876,7 +876,7 @@ static void btf_dump_emit_struct_def(str
 			btf_dump_printf(d, ": %d", m_sz);
 			off = m_off + m_sz;
 		} else {
-			m_sz = max(0LL, btf__resolve_size(d->btf, m->type));
+			m_sz = max((__s64)0, btf__resolve_size(d->btf, m->type));
 			off = m_off + m_sz * 8;
 		}
 		btf_dump_printf(d, ";");


