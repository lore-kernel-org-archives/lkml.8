Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7255C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 03:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE902076A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 03:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgEXD20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388290AbgEXD20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 23:28:26 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03490C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 20:28:25 -0700 (PDT)
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04O3SMpE027737
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 23:28:22 -0400
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04O3SHle015502
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 23:28:22 -0400
Received: by mail-qv1-f72.google.com with SMTP id t10so14569481qvz.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 20:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=i58OCaMAvQBYliGiBa5+vTtK/78utl6tdtCjNYsEte8=;
        b=KE3nDEprF4Z6NJolT+pGg7wLgX3RkNBpv8myYJM+Vkx2JBdRwIVj70oGDAgQ/b6jaq
         gJsbl/raCAsLUpObUM2hr/RaY9mvaZeg/DYFDzPPO9HyHKwRcDNGnBalGS9Nw/5yYyO/
         YwD8jR65OBlTwNfKhqnyqPrV5/qv+FEPNaMHYIho2S/UN/9wr2OXJvkrohjIuDDnoYEQ
         SBN4zz+fs+xPey+/eSe3iqao1x4/3wfqpPbNp2NTZZjjGiU0E7hIWVe7xYSJdwSiX+Pb
         tIoDqjFzs5pza6x4qC3PL9lLoUBR/OPZe8rjR7r5ng9kufBdZBr76fTQqn7sojWhb9lg
         ypNw==
X-Gm-Message-State: AOAM533SuYGdUH00PpbkkZZBDIXPmWjCS8rDrVl8PRdvx5LcDhZF0KYO
        Hv4EZ5xKPrw5H3FAN2QHqoRSKVoxxqkN/hQZKbkj3OdZtF8PA2n5q/BkqcwK6p8J/HQNgz62vpi
        3doCo3qh0TR5oV80ieaByJgGn9yiex2eICuQ=
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr22092049qkk.490.1590290897448;
        Sat, 23 May 2020 20:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTv3M8riA+KCQEJ7UovI1OPJ0n7n+QJ0IE5YxSOmpO2i0TDa2rJYRwX0A2430HsIuZYpNvCw==
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr22092030qkk.490.1590290896986;
        Sat, 23 May 2020 20:28:16 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id p25sm2768539qtj.18.2020.05.23.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 20:28:15 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20200522 - build fail in fs/binfmt_elf_fdpic.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590290894_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 May 2020 23:28:14 -0400
Message-ID: <22928.1590290894@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590290894_16657P
Content-Type: text/plain; charset=us-ascii

Eric:  looks like you missed one?

commit b8a61c9e7b4a0fec493d191429e9653d66a79ccc
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu May 14 15:17:40 2020 -0500

    exec: Generic execfd support

  CHECK   fs/binfmt_elf_fdpic.c
fs/binfmt_elf_fdpic.c:591:34: error: undefined identifier 'BINPRM_FLAGS_EXECFD'
  CC      fs/binfmt_elf_fdpic.o
fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared (first use in this function); did you mean 'VM_DATA_FLAGS_EXEC'?
  if (bprm->interp_flags & BINPRM_FLAGS_EXECFD)
                           ^~~~~~~~~~~~~~~~~~~
                           VM_DATA_FLAGS_EXEC
fs/binfmt_elf_fdpic.c:591:27: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [scripts/Makefile.build:273: fs/binfmt_elf_fdpic.o] Error 1
23:14:07 0 [/usr/src/linux-next]2


--==_Exmh_1590290894_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXsnpzQdmEQWDXROgAQKL5BAAjI/OXaLC+STtx047fdE5RkoaXShnqUSw
GhJ1TJnAtDtaDQTtX1BGLWaUtLlBqndad5OBRri0fspOPB2iL4nRscZCojqNupAv
Mja4gDYmlNhvHjO6Vzs/OHGRObz01+WD0SGAs7vEx2Sxpbm2rq37sWe7dzblznVl
VUyc3t+AUJek45kuOyxP6MrvvakLQLJdLWTHbg0bqUh0byRU6LT97Xu5gdyYoGsi
a/DfSNQFJHYbAzqR8cZA+/u9m04uEaJ+1eaz1NTQqq9fxN4fFFSXkqokkUAhezbq
OyFz8Q1cW7R3rB/EsrcmQ+hpGrZmlFR/N8qtK7Frp6ALwM1kgvpLpRAOWsVdlFTq
W7km69mUe3eBrUNGQ0UD0SUxGDIYwu2Z1GKUjmTDe3kPzH2PCk+/TIpYtVvXMnCe
T8vmu/yR37VgEOepko8Zgo9pNY6V5CGr/e/UiZHnA7DgFp5cT2YD3G6OLoXsibnf
k/qzNNJ0mmu+iDduIH+rBIOE5bpFn41Un8vuZRxb8FQD1PLFdwlT/V6BHqIuhAnU
ZtIjOlC0AUu15jzFZFrpUsOKC22BCNBSMzrHlli+G5BsDB4hR/xWSMHaedTAQwdH
cxOm75EAhXpwBj5xlnXyujyRvTSw52Lt5fNzVVGboYP4SEFIeePuenaKmkpCYs0e
3HPmljnddXE=
=6Us+
-----END PGP SIGNATURE-----

--==_Exmh_1590290894_16657P--
