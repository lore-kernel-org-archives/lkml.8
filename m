Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF27C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E0021973
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3TqNZ+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgD1D2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgD1D2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:28:06 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDFC03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:06 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c89so20403156qva.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oz1fQ07v4YKej2hlWP6qWEvyAtsuOx0qHOmBf6H8EEU=;
        b=I3TqNZ+omoMhei62DCjjFhvToBgLQ/mzKXtTiQk26/Z5mE9W3slhueOYb+z8GilAMC
         uJiJnXNo6zMWUJK5fxe8p2Clt0BrANXorqf5ejL3fjOyojaAeijiBitnGvTxkfmUvtk5
         Oo7NlfGIo6V3y/5pocLkkx6t8Ss8qBGDmgrARr+67qmzWEXVLYp/RFVVh/KoqwASWwPE
         LeSD+Oj61O/Z74sMssGhSL5Fu1c3GwuoL3JonPdkpa7ffE2p5AG02vHLj7jS4QiYw7q5
         cGhGmYlwlCMnZ+TzyelO2CkY4EzLolMoho7DCGot0I1FyuWa+tJ3zOEFil++xSYeEETq
         eZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oz1fQ07v4YKej2hlWP6qWEvyAtsuOx0qHOmBf6H8EEU=;
        b=os33Y1AWUdadbwxAPZnvMcDLDD1fA/AvQIQvbFf3GBOJgzme1KsM7kk7YUkrm4qy6e
         OG5nvfTu9GAHAw99fVgmGuyXG1hoose6hmFxiblnQYHE3Ov724KVyfDjPrQkgDAKz/ld
         NqU/sERHKxRFRVGUaOxLuflnF1+0fkaCRMCbQ1M+rtYGyqbFleu/m0/wiWeY8oeLvojb
         fhV3MWjBXs6WZ3yFlBYQ5O9g12JyhmnmuvYTxCjJzxL1YKhadFznzEEFRMsOpNVLHOx7
         GAoj99c4nDwatRr7GcdrgVK+GhMG2Ljndo3RwphIYOCukfz7ExBSpcRbBAk5VTa1FByh
         xNFw==
X-Gm-Message-State: AGi0PuZrmvpVHPzkAo6577QZRNnm3/8XUiKcG5SX3z9PVY4E8bE/qawN
        DtJa97Q9r3YpGd7RiwR9wYsBDMw9rw==
X-Google-Smtp-Source: APiQypJE2oducFJ7QqE/S1GqpExEa0j+XC+oVynygSXLNhNvPC4n0hoqiHIFqgoaUYcyeTNIUgqu5F2EbA==
X-Received: by 2002:a0c:8b48:: with SMTP id d8mr26408306qvc.195.1588044485433;
 Mon, 27 Apr 2020 20:28:05 -0700 (PDT)
Date:   Tue, 28 Apr 2020 05:27:42 +0200
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
Message-Id: <20200428032745.133556-3-jannh@google.com>
Mime-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a partial write, we have to update the input buffer pointer.

Fixes: 2507a4fbd48a ("make dump_emit() use vfs_write() instead of banging at ->f_op->write directly")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 408418e6aa131..047f5a11dbee7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -833,6 +833,7 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 		cprm->written += n;
 		cprm->pos += n;
 		nr -= n;
+		addr += n;
 	}
 	return 1;
 }
-- 
2.26.2.303.gf8c07b1a785-goog

