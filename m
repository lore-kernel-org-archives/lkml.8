Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA58C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3A82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339659;
	bh=Ah3y0Faj6m51bO7okuTL13gZstjS4JflCio3GOBle/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KHPqh/S42SKxwo/WPU5Bd+2O3R+D//NHjlHrWba8nS269DlB02Ks5cXh12W4xWypi
	 kzqpHWv8mJcaJIKYRKb3jwX/80fTq82sUQBp2diQCor1kytk0tx8tICY+kfGXBDPsH
	 3XfulS96R6aN363J7IEUo86AzystyNZGJeMhXpvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgBJNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgBJMkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:55 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32102051A;
        Mon, 10 Feb 2020 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338454;
        bh=Ah3y0Faj6m51bO7okuTL13gZstjS4JflCio3GOBle/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDkvZiHtnIL7/uMfLRi3mgoiZZeXQUkPlZJNJcjMjJ1r3YMwAghTi09P2tiYqaUz/
         9jZvJF3e/NNcqHv2sAADE30xf0A4xxYLo9lI3p9EEP37npfTqsAVKQGlb1ZuUoMiqF
         vDkjqsi1CB4AReVH88tjhcZsStCls5NxmiXnfPAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.5 164/367] libbpf: Add missing newline in opts validation macro
Date:   Mon, 10 Feb 2020 04:31:17 -0800
Message-Id: <20200210122439.992841802@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit 12dd14b230b3c742b80272ecb8a83cdf824625ca upstream.

The error log output in the opts validation macro was missing a newline.

Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20191219120714.928380-1-toke@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/bpf/libbpf_internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -76,7 +76,7 @@ static inline bool libbpf_validate_opts(
 
 		for (i = opts_sz; i < user_sz; i++) {
 			if (opts[i]) {
-				pr_warn("%s has non-zero extra bytes",
+				pr_warn("%s has non-zero extra bytes\n",
 					type_name);
 				return false;
 			}


