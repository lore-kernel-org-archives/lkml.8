Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B451C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5945620772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="el1oruQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgF1NlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgF1NlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 09:41:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E953C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:41:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so2419512pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E7C2nlYyzEXhj0UodvzYvLRuLFmatdLU8PtxJ5GudS4=;
        b=el1oruQZ1InEuxRcRFVe4P70xLPIM55B7PNfKTNw8XCA/vXEJkMcNv+NWynPeJGWN8
         wtYT1MxeOAjB67syqKT37LoZVmLn2POZSwrXWCZOY8K3cMrOCZYRZ15xeXTr2jwPm7la
         UrDVgm0KTnCd5utNgzhepWbgYsgpxIWbIMPvd4VuBDrQrrChhBGqUJXeAZD844czHQ7h
         wBKvvrm+dTVYN2jouvM/3mAwJbGowfcx5NvCzOg72kAlZ0mApdzq6NZub7cJLnElVbG0
         o6STn9sp7v6YJQVAKJClbLgAjRMtusz/CYrcCPV40BPucjiaMvtGYbCn/t3ItYV6SPsZ
         P5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E7C2nlYyzEXhj0UodvzYvLRuLFmatdLU8PtxJ5GudS4=;
        b=U3K45em5Dq3LW7eUruLjJnxHzqCN9TgyKzrmcglERnvQSbVjDI41EY8kkJ/S+TtUp2
         G+u1VvJbj9MyadTmiqlottluXtj1opCEWAkMA7IQLCSdv1oBgWVCeBkIJxN5JVyPkfPb
         PCJsTPy0fssLXJd9aYW+YcIfFijbAhq3W4LK/8kjjLyYKxNaW6XOxEbA+630VTygutqB
         Sd7kZ4mlnRAVkLzSWexibIrcAT45smDuzAp+s1nHr8cB38dvJhRzrm74YK/wTnjP4xaA
         XujuD7iHPOexrzsQEIS5gRvgaEPKe5cRGfJ4Mt3Jzq6sZdOe38HWb6HrLiO+Z/CtRoix
         0TEQ==
X-Gm-Message-State: AOAM531G7jfANtLl7J0S22t32GxzULWdYgOjQjPr9pIpqfh+PdwmcNtR
        M8Q3Qp1TAFNkUE2TKtZw/9jVYw==
X-Google-Smtp-Source: ABdhPJwNaOaSwE4mUP7Qbam7f76dNGDLoPL5jA3rPe5zbEfDgYD3wOckbQkQ94EFH1/xzXURxV7Nkw==
X-Received: by 2002:a17:902:c1cb:: with SMTP id c11mr1408915plc.88.1593351666992;
        Sun, 28 Jun 2020 06:41:06 -0700 (PDT)
Received: from localhost ([2406:7400:73:ff29:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id c12sm3859003pfn.162.2020.06.28.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 06:41:05 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sun, 28 Jun 2020 09:41:00 -0400
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "glider@google.com" <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init: main.c: Fixed a brace coding style issue.
Message-ID: <20200628134100.mseebxf3dot56eia@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6pzcdaahqypt7d2"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6pzcdaahqypt7d2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a coding style issue.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 9127b240fd26..d8477fb95bec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -385,11 +385,11 @@ static u32 boot_config_checksum(unsigned char *p, u32 size)
 static int __init bootconfig_params(char *param, char *val,
 				    const char *unused, void *arg)
 {
-	if (strcmp(param, "bootconfig") == 0) {
+	if (strcmp(param, "bootconfig") == 0)
 		bootconfig_found = true;
-	} else if (strcmp(param, "--") == 0) {
+	else if (strcmp(param, "--") == 0)
 		initargs_found = true;
-	}
+
 	return 0;
 }

--
2.20.1


--b6pzcdaahqypt7d2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl74newACgkQ471Q5AHe
Z2q38Av/SdhDrBu3oSwjTsUQefl+Vf1E56ytJhBW/EgN6DftJKbTq1gNCK0lba98
OJrlPXWlPRFZqy95KdnRO9UEsxKKVRjxoSkmJTbTLpLWAeohakv+VouPtHDiNCo/
1jQ01PdDDZ+tQYxq4yMPT4j3VPz7sp7AhtLVmwhdUeyX+6Nnuh3RpArYPpTBFA0O
v4dygyRTQKKOd2XWeD8zqncE791hcjWs44kme2vDyHGgwEnFKymm5PeMwl3hySpX
iWiJqs0zSzXkKZSxdYhy568L7E8kZHpin7Mj3eAX3Z7yqk8v2H7emjf8g3R1GLHK
HbJEb9XaFkcGCfIr1ICU1qMRPqxz81cKfgG5ximedk7c280QazTfKDFw1eN38SXJ
u+BdZNCykFp53kb4+2b9naHA1UEKYT/aW13SjMudsZzjqL0Vn39GhOoathcccW8S
32+1Y1Gfl8kfhjvFN3rfGpUcX7c46ole1bbnN66B9Kdb4v/VWgC1G91IvNbUmTEb
Q+dNf2Ee
=5uT2
-----END PGP SIGNATURE-----

--b6pzcdaahqypt7d2--
