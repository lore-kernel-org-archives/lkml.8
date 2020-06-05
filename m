Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21503207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFEFdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:33:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20989 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEFdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:33:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49dWXM1Fddz9v0tZ;
        Fri,  5 Jun 2020 07:33:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xfGxKE40S9_E; Fri,  5 Jun 2020 07:33:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49dWXM0Nnvz9v0tS;
        Fri,  5 Jun 2020 07:33:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CF178B7C9;
        Fri,  5 Jun 2020 07:33:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id srH8dyVMDp9S; Fri,  5 Jun 2020 07:33:40 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2A188B779;
        Fri,  5 Jun 2020 07:33:39 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: linux-next 04 June: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is
 not defined
To:     Chuck Lever <chuck.lever@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <868915eb-8fed-0600-ea5d-31ae874457b1@csgroup.eu>
Date:   Fri, 5 Jun 2020 05:33:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Getting the following warning on linux-next from yesterday,

   CC      net/sunrpc/svcsock.o
net/sunrpc/svcsock.c:227:5: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" 
is not defined [-Wundef]
  #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
      ^

Bisected to ca07eda33e01 (refs/bisect/bad) SUNRPC: Refactor svc_recvfrom()

Missing #include <asm/cacheflush.h>

Christophe
