Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E342C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1F620661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608474;
	bh=WwMWopCX5Uq8MXSKhvMYkBKWyMFv8TndcuJiHSuffrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dMRzMI+Pqc0Os2po+5OeOPaSbXrU2YPzp5/tmE1eMCDkuHrZNn5fN9jlt40F8qb44
	 7lUNde8d5+pCm+sSwwPXAZ2GjSSF90k78iqJ2yAu6JI+ZeAYrgU095yllkevhQEe8m
	 /yOiiK7JDUoT1FsC/HUIj7YHSzSV6inFV33q6xJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgBMPlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbgBMP2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A9C24670;
        Thu, 13 Feb 2020 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607714;
        bh=WwMWopCX5Uq8MXSKhvMYkBKWyMFv8TndcuJiHSuffrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhYvHa1TNltMQ1nkkefRwCCq6SDLTPHFR8ySwG9XWbfwIQv5HJSa4zlWo3GnsMaGG
         2tbHaxf8nPLxnGYtM7BNiHiYxAWvyjmiw+oUFi7xDP4wHs47ImS2II9lKmtoGLwn4F
         etI3OtgEJNEgmPAcMqHubGKpk2v+CQCOoED7JreU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH 5.5 036/120] bpftool: Dont crash on missing xlated program instructions
Date:   Thu, 13 Feb 2020 07:20:32 -0800
Message-Id: <20200213151914.120750684@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit d95f1e8b462c4372ac409886070bb8719d8a4d3a upstream.

Turns out the xlated program instructions can also be missing if
kptr_restrict sysctl is set. This means that the previous fix to check the
jited_prog_insns pointer was insufficient; add another check of the
xlated_prog_insns pointer as well.

Fixes: 5b79bcdf0362 ("bpftool: Don't crash on missing jited insns or ksyms")
Fixes: cae73f233923 ("bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/bpf/20200206102906.112551-1-toke@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/bpf/bpftool/prog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -500,7 +500,7 @@ static int do_dump(int argc, char **argv
 		buf = (unsigned char *)(info->jited_prog_insns);
 		member_len = info->jited_prog_len;
 	} else {	/* DUMP_XLATED */
-		if (info->xlated_prog_len == 0) {
+		if (info->xlated_prog_len == 0 || !info->xlated_prog_insns) {
 			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			goto err_free;
 		}


