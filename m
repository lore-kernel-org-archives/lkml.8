Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED01C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FD42083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="PDz5Oa4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgBOLua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:50:30 -0500
Received: from mout.web.de ([217.72.192.78]:38289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOLua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 06:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581767417;
        bh=HU/2N3E0qmqDHC4/1OMZ5qn9O2Ez51tN26IGhSevr3M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PDz5Oa4PiERxkVzv96xh+knfppMi1Cf3D9GGAnaZdW2ITeYcxcGdmL0TszUC9w/Vg
         qNp2BIXF1oBCzOn88VEiozXLEvva8VgJ/SYGGsX8cUBjbPgeak9Mic9wnaYYcvgWKt
         C3PBkr2GhuWtlo0aqVO1aA2aNk1kb29rEh7BhHIY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.ww002.siemens.net ([95.157.55.156]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lx7Mz-1jZSWu15vV-016f2Q; Sat, 15 Feb 2020 12:50:17 +0100
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] riscv: mem= support, ioremap exec fix
Date:   Sat, 15 Feb 2020 12:49:41 +0100
Message-Id: <cover.1581767384.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.16.4
X-Provags-ID: V03:K1:7utcmur/a9lyoiDKqs9p1IE04ltxLb90ysWQyFgCriS97NlAzPA
 Yk6v8Ulh60rxlwB9pv0HgnieWdheINYRY2hSInFjZGXe16xoWO4bRMYyiFHhOzXKJkBusYM
 1jcuD+XKDqH0WGwbYcYAPjC+69r5RC+RgMURZ13FyFU3v+3ayZBrm6GEeBEAf9GZiVjqgxE
 pRm7/SyTavYd2QIi5H47Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50/pyn/MMEs=:ZuphJuz5BEBSGWUrIOgDFn
 6rIjomYXqEvNwi8rTGEbHs15C/j4o7WD9z0Otu+aOhJLk7A1BPAwYDRLZ81hcEDmySTR14roO
 M1AuQmnSpnc3pE8/mNWksQ4MTXQ6TpUvipISPAoiFahqG2me3qdvEeSjI7rgOZDvCuixFa6Y0
 /dgUR6CdbyzlL7K37bbUY80b54fDn9blYtQMQLgSFklEHXzttBUENh3Eyc/jPW0uHjBX4tgPl
 EBVGZR6isYyLgvgdjr+GJ8oqWin1hbsiQfqYy8drt/wu3RyC4vX1zSKAC3/Ep2hWYjNCT0BcQ
 vKZvRhxvkK7EdlSlpdcneKsQllHi+4OVeAO2v7sMlmjgTMKyGFqbQyuaVmB9MR9jxW1E/vtie
 pUEyrRGjr1ssUzVgXpM0GJHyufLkfKU0LWeqff6WuqU+XST+QhKsRQ4cKseglRrf85iloZzly
 tvY+EsZ09pdFKE7e08dZQgFq/y1iROqd7PwORUkjxmQM/BUcSap4Xzn6vraRVYR7f3QVCBoXK
 cB6JtZ4B3M3oVE2I2Fv1e9yH1almw9k+mZol0wnqaHk7GNpAcVmNDNk3rtFOZivk8nI2XF1IK
 Yy/fseeFscysayZq++7tp4eT3NtQhS0r7hQaHMYDxW/BMQhVppf0QqBblc3F8GvHTOvICj3IT
 QeB75/JKQ3d0fgcZY8udbHhTD3O+Y2NUhK2Kq2ZngT1y3A4x63J6AGgwHWjFF4dRsWn6W3J6w
 uiOYQrLBv3LBLnFjlZcwddUgb7mzsdLl/4Nyglz21SJoueK4j4DruhL/nefl0eGQHKeWh1jqG
 S37t4m8KtNjGQXNn6/Gh8QkOli0Y8LX6fPCr6qcU5MIvw3FrsIbjnsOXCyMFu8tJBUpL0Qlws
 GEYdHvsqgAOOY4EDF74HvKV+5SwTKQSo5kHr9RG6WB6bVp4W3GSaxr2qS0nIsi+6kfRvdafqo
 xaE4HzjT7UlPaGKYTQskgZr8GTTB+Oh6q85PzU6+o8T2NgWdTv40nCoYTpDb2DZjQStcD3fgB
 wtsSpD+oC6jhWGTxDe9l2oVmsCpSRs6palS5yghLRiWbnF/r8UaAnX8H/fODmZrFlH8dVhZoP
 3vZEOQxmjh/M2MrdT3D82JFUhzCSmEEqCxYiKjo1FgYl/1h6g34hkj1XZ3rL6FhM4LXyptkTw
 +MObyQWUIemIQ4MyivNbuNFmoqLMxkda1z+BdKmQTU3ENfnvO/8EY7jylcJEdOKPod+qpkoq+
 R58kJwlkFCCE6+6GD
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 was already sent separately. This improves it by calling
memblock_enforce_memory_limit in order to call set_max_mapnr with the
correct memory size.

There are two more patches in this series. One is a micro-optimization,
the other enables ioremap of executable memory. The latter will be
needed to enable the Jailhouse hypervisor on RISC-V.

Jan

Jan Kiszka (3):
  riscv: Add support for mem=3D
  riscv: End kernel region search in setup_bootmem earlier
  riscv: Fix crash when flushing executable ioremap regions

 arch/riscv/mm/cacheflush.c |  3 ++-
 arch/riscv/mm/init.c       | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

=2D-
2.16.4

