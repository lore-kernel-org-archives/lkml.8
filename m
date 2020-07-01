Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85ACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9267C206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXswDIRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgGAL6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgGAL6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:58:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF393C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 04:58:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so13399464lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FngerGx+Z5bL+zQp+gRa3OHqb+iHnO+8szZfp6ABIkU=;
        b=QXswDIRI0olpd5LGQpszZas5wQUORTduSg4uJG9RILvfjUpvGoT477I++1uPyBpAAf
         E+pqxzQoc6tfBnaMMM7Fl+1fPThqd2m0pRbw+pNpWX6Qv5T51ezcpusq/7MI/k7vaPRd
         0h/tA5953uVKw0MWxcYwUgK0NPGFmaLtxTXWfI/vWKl5THsuuxy1mr7XT31La4vVn/6F
         BWU4to9wvrzNyNo1CF/4t3K26mg8qKKtrW+JtZ5fodxErNZLMTCq6zfq2OG7FhA7j/Za
         cjoNk/viQe9hDYlsraX6dEblLhpuivqKjNF7Sornpe2HGdmOPQdeFfexrEQg77+tjUgl
         stHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=FngerGx+Z5bL+zQp+gRa3OHqb+iHnO+8szZfp6ABIkU=;
        b=PYlfnu6c7mYSyQKmCbwdmMJvrcl22EQeMRFZH1k28j8cJoJ+4vMLEMmfFDlgp6VaVc
         zmN8ksk/5BCwIIbsaN0fFWNopLDx71CREakptPgFRhf6osmgkKq1GIgiO4zCLJsU8w5S
         XdpgGxynCLSoxNSNiaSKVOPNoD+xG+E/7y++or80ToI9HyN91HSfAcPV2Qyn6ZH4qbbU
         BaRp0B1uxngkdWvjWlB1d2Q9Q22xYm0qdoE8qXygVp8wOC9IYVrmvWfTfgEXTnmD6y56
         302BNugscYkFNTm3hR8HmMtZukZxUYrloyRw6fTAsYjxLTR8lLpvPFXAJ22qmAweAXoP
         2EvA==
X-Gm-Message-State: AOAM530ELMOBuVSQ0bKYf+ltQwQeUBo52sD5Dj4mkGB2i/NKs/GIDw60
        q6isQfuZ2xkWmTHOWV+8AZcOkDVp
X-Google-Smtp-Source: ABdhPJxvK+UyDeM6BoBaXlOfzlLcGRehPPKG1I43B/jF4cpPDWLBYIZHj/8wtD/TdVzigdBSGQI00w==
X-Received: by 2002:a19:ca48:: with SMTP id h8mr14923741lfj.161.1593604694061;
        Wed, 01 Jul 2020 04:58:14 -0700 (PDT)
Received: from localhost (109-252-27-141.nat.spd-mgts.ru. [109.252.27.141])
        by smtp.gmail.com with ESMTPSA id s13sm1974077lfd.13.2020.07.01.04.58.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2020 04:58:13 -0700 (PDT)
Subject: [PATCH] mailmap: add entry for obsolete email address
From:   Konstantin Khlebnikov <koct9i@gmail.com>
To:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 01 Jul 2020 14:58:11 +0300
Message-ID: <159360469186.24918.10108157093572183535.stgit@zurg>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map old corporate email address @yandex-team.ru to stable private address.

Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
---
 .mailmap |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..b15c836ea7fe 100644
--- a/.mailmap
+++ b/.mailmap
@@ -146,6 +146,7 @@ Kamil Konieczny <k.konieczny@samsung.com> <k.konieczny@partner.samsung.com>
 Kay Sievers <kay.sievers@vrfy.org>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
+Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Koushik <raghavendra.koushik@neterion.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>

