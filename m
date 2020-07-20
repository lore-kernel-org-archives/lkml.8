Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E96C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3D20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261814;
	bh=K8BnlKWbx51fDnS7WXBDrKEyvYzspamqjSRyQDeBlAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BnTm0wCmiJvg3RzumBJgR7gNrp1cwsGqSDYMaQXtExlfKBeGGbiGZ6EmJJEC6u/z4
	 aZirbSVJ6n59yYkORbpE9X1oViieTzccUr9/coeHJ2RtkcI4N4VkNu66Evnp9+mbjp
	 WYTFFgb5yAtJunSqqK8y8k8Ii82TYxgS2D+FQ4sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbgGTQQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388176AbgGTQQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8317320656;
        Mon, 20 Jul 2020 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261808;
        bh=K8BnlKWbx51fDnS7WXBDrKEyvYzspamqjSRyQDeBlAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ut9sELf0KTNj6g1Paun9XeiKkzPF2d15+Sn+sD0CgplhvpjUc93l0k/ia6TYcUaNM
         lt7PXeRaihH52gtdPYJftw1I5TQiD9r1H6lj3xjfvyW8qCbWCDwOPjlXiIyVvgnipb
         J/DPqCjodpFe8mD5i6yrHVun+2oRuirIwB6Yg/to=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.7 242/244] bpf: sockmap: Check value of unused args to BPF_PROG_ATTACH
Date:   Mon, 20 Jul 2020 17:38:33 +0200
Message-Id: <20200720152837.350344065@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

commit 9b2b09717e1812e450782a43ca0c2790651cf380 upstream.

Using BPF_PROG_ATTACH on a sockmap program currently understands no
flags or replace_bpf_fd, but accepts any value. Return EINVAL instead.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200629095630.7933-4-lmb@cloudflare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/sock_map.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -70,6 +70,9 @@ int sock_map_get_from_fd(const union bpf
 	struct fd f;
 	int ret;
 
+	if (attr->attach_flags || attr->replace_bpf_fd)
+		return -EINVAL;
+
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))


