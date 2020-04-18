Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 23:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBC921927
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 23:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kioM6o8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDRXT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 19:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 19:19:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15877C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 16:19:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id r5so6171084pfh.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5+OU+kk7gBRhrOajisWPSOlUOJGHcphtukUia7SFCns=;
        b=kioM6o8Tn3+JdhtYi4wpNbms3VD5EJaUVGk5v+iRB/fpfvTnXbAz1DsHz6U6fhywHi
         /E//DL5EXAC7e6JC8hFlfOqzjLUoc8x5wwEIOznzrVR4W5HbpcmeQphuCHQfs/npAqGA
         cgS2qmgKcwi+hJXojVrd/L5ykG6wVvO2BK1Ptsu+T4/0MIGVUK2GQ1nKKwW8J+IXebVL
         zIg0GKoQl76nz32/mJvxwg7esQkKZVlh31VaNHTWgOcvtFF+AxgZwjI8Z57KN5wpEnvw
         2LR2lDzbmohZabIa2Z/MNaAmrCE4wdL+gV5BsU8WWsOZy4Q1LVxyf+JpuqFalP8OGO6F
         nbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5+OU+kk7gBRhrOajisWPSOlUOJGHcphtukUia7SFCns=;
        b=g1n7w+vCisUTR6lYxtWEdWdKfZ4UyyZ4qKIBBTwz89W92ocHYe+eLLfQBUg19Nm/U6
         npOGlovRA7GMs9cFWWvveDG16uRVCg2uyIkAXzrBjAjt974q3he1Lt+O3/yUJA+5+HJg
         g/dvNF8I7f22e5iepM0rqbWG8UW2ozlDkGjTVUGyU8/M5/GLjqd9bcbvGTDXflNa4UrY
         O+1UKjW8TO+U32TG7QLs11xoYpUEp0ldz9+Xfflea3QK8Og8nF46RNLw3swuJbzuyvHy
         3azIqvxI/hA+prNuKkMkgQ20YoboSciL/MplXDS2Un78auaN1DdDTVuxa13El16vU1HF
         QP1Q==
X-Gm-Message-State: AGi0PubkADxUcsBSNMDrpzaMMd6W+ul34YHcfmEb86WG2gbAD7E6eVsX
        IGgzsFC1YdAKRXDq7uMkZj43TNrkpE3Dv2nHF/PIsr3bxThdsTF825C+kpq9wwLQg8JJSSpXXaG
        XjQ1QKtMaYlODXYKKlhG7W1uVzFrDR2ekpTHszQ42jX3vvJczuGvdYPBXYoqRNkygwywi4URm
X-Google-Smtp-Source: APiQypIY2F/WbKr2ZYdWKm88gP38oKDYswZNpH/PW/N41rbYNjWgf9XcFW++fR3iRKAY28xc7x6f+mkmK/ma
X-Received: by 2002:a17:90a:23e2:: with SMTP id g89mr12893148pje.105.1587251963143;
 Sat, 18 Apr 2020 16:19:23 -0700 (PDT)
Date:   Sat, 18 Apr 2020 16:19:08 -0700
Message-Id: <20200418231908.152212-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] perf/script: remove extraneous newline in perf_sample__fprintf_regs()
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, irogers@google.com, ak@linux.intel.com,
        kan.liang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing iregs, there was a double newline printed because
perf_sample__fprintf_regs() was printing its own and then at the
end of all fields, perf script was adding one.
This was causing blank line in the output:

Before:
$ perf script -Fip,iregs
           401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

           401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340

           401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

           401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340

After:
$ perf script -Fip,iregs
           401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
           401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
           401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/builtin-script.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1f57a7ecdf3d0..0c0b6e807d06e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -604,8 +604,6 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 
-	fprintf(fp, "\n");
-
 	return printed;
 }
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

