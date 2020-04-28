Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF908C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1E02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100384;
	bh=hqyHi7zWQspvFxstGg1ufZOoVKACa+6uKafUFdzpYdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uigafvB+9jKW5gHaGurg3n+7J23+qFb/LGn/s6L+DDqWYsrHd07Y4F9bHr/jeofAG
	 OdzIshcCL4f5vzTDjUnKKQlFT6ZiWJfoSH1VS9Zg4cFI7+DlMzUscIR/DRgA7lK0/k
	 rvZIvKF0ITmHesQ2rGO3Hf+lzJSPZiM/6Pt4vq90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgD1S7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgD1S2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:28:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80280214AF;
        Tue, 28 Apr 2020 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098500;
        bh=hqyHi7zWQspvFxstGg1ufZOoVKACa+6uKafUFdzpYdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGchVsfXRaZdts/xHH8TjShZPQnQL/WpxtsI+Qi5OqnfXWNWrzbksZYdcCU7JizS8
         SNR0try5U1wouHt6RHxPxPUnYTo0PxMP3TCGY3XDamJVtQHBE99w0eJKGer2AVEhhd
         KCbZXXDy50oBdJ6DlnlD9Jg2MMstf435M6Ct+RwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 003/131] bpftool: Fix printing incorrect pointer in btf_dump_ptr
Date:   Tue, 28 Apr 2020 20:23:35 +0200
Message-Id: <20200428182225.839842521@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

commit 555089fdfc37ad65e0ee9b42ca40c238ff546f83 upstream.

For plain text output, it incorrectly prints the pointer value
"void *data".  The "void *data" is actually pointing to memory that
contains a bpf-map's value.  The intention is to print the content of
the bpf-map's value instead of printing the pointer pointing to the
bpf-map's value.

In this case, a member of the bpf-map's value is a pointer type.
Thus, it should print the "*(void **)data".

Fixes: 22c349e8db89 ("tools: bpftool: fix format strings and arguments for jsonw_printf()")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Link: https://lore.kernel.org/bpf/20200110231644.3484151-1-kafai@fb.com
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/bpf/bpftool/btf_dumper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -26,7 +26,7 @@ static void btf_dumper_ptr(const void *d
 			   bool is_plain_text)
 {
 	if (is_plain_text)
-		jsonw_printf(jw, "%p", data);
+		jsonw_printf(jw, "%p", *(void **)data);
 	else
 		jsonw_printf(jw, "%lu", *(unsigned long *)data);
 }


