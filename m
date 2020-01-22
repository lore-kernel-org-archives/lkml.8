Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74031C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD692468D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699412;
	bh=2fLv5w3+eifqC4KGzxoRe/B+TKlAwrj8u4H0SXcaz9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pnNQ0YxSZo85Q5a5LjbSrUBeiNe096VMeo51t6LMyAjnZD3NCqHu5I7b3S5zCDbFt
	 UYI0yVvEDl6WLGo9sKAtl3t9ZnJb0qgIR1EJilYB5c7epuyZOS2PyiEsGykbfSH/am
	 4D/qkCeek0aLD6cGVjoRVVzrUVoueKVkO+rQpuac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgAVNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730747AbgAVNXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:25 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4473D205F4;
        Wed, 22 Jan 2020 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699404;
        bh=2fLv5w3+eifqC4KGzxoRe/B+TKlAwrj8u4H0SXcaz9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+/m2BUN/lC6pTTa+9HhS8MhIGlpf9kPFJTRMDpXfyAGy/uzt9ae3xS6jjKYoVQ2p
         SwAuzW6HB1B9fWw5zPhQF7oEGBtVzfUFG2x/6LaJzB+EVzexViYfnsnLKbruyOuQ6T
         st3ut/VLWrpX/JAQS+1KqlaOJqbVLj4x35crQp+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 5.4 134/222] bpftool: Fix printing incorrect pointer in btf_dump_ptr
Date:   Wed, 22 Jan 2020 10:28:40 +0100
Message-Id: <20200122092843.337350817@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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


