Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13967C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1BE2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pbYVr6IL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBOLub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:50:31 -0500
Received: from mout.web.de ([212.227.17.11]:49723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgBOLub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581767417;
        bh=muQBD9SPvw+3aONjZcQUJc+xZO6shhqoY1/LvaKF8U8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References:
         In-Reply-To:References;
        b=pbYVr6ILx787Y60KjtnvKCJ+yTlTxbRDM4WtGBlJSJF+yhz6sqqkN9+ub00mbAQGB
         HOOdBG2aRNzg+u6ZIMYMAcZgxf2weHcqOOw9vzfojMaotl61BE7fMXSRJ+jx9d6044
         vrknk+A35DJRv6A6FTB3Ma60S+fqHZyS/61qntRM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.ww002.siemens.net ([95.157.55.156]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MQNiS-1ivCAX2XOe-00Tjup; Sat, 15 Feb 2020 12:50:17 +0100
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] riscv: Add support for mem=
Date:   Sat, 15 Feb 2020 12:49:42 +0100
Message-Id: <617f75f4eaacb02cd9d0a7044434e3e9b65e9e8b.1581767384.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
X-Provags-ID: V03:K1:3S/9It4FAsUZJCi6+Sy0g2D79OQG9MLyYgTZXZ9nUs5XLvx8DzI
 ooiWxCBCyVHmKstdJ9+eF0vioL+swsjnJQC2ZkeDJH06wucpqRWKY5owhO9Sz011BORVWyU
 Qq/laO/AwQkpRZqG070Mv9K2jn8T/tpzSYS9/q4pahovz+4jc3YvYZt8iIItjJvjLHqevLL
 GAWME8nx5vQb4wVt88QTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:12f8oFkUa0Q=:U0+Tvh3IFJCRgaBZDWRtWc
 YWQqUeJRKaQgWAgA6P0tBgn2xXN6Oug0mnDeNrG+2rgCszMpyP7SUeikQvfc5xSGgQkqwG+zf
 /d6m5wBjZyHHH92HTsqskjuZdaaU7nDBw+dues+B49jKfMMsThbL5/wNx7Gl06bClx8Kb9lsT
 r13VP6IHoTUxpfCnOiehsYCWeGTH4XIcrVmPOHqPQp1Tm1DyOUtD/IYtabmDb9+6kYPeRz1PR
 TvRRLO0olr5R+ezEBzDe+6NomPx/5TGnR9sRh1NNP1DcqV1Dqwp6rRAa3QeeUboo3wH3g2tDj
 kwBfE7+O1WwbhZK16vPlF4iH0BKEVoOCcvXIUookUOjYiXO2Jk1oUiZP6Amj42PdQuSvvi1so
 YonZUDeth4oagB1DIZ5ueYSiiSSISBXg/zR9qZj1AVVsnv51E6tJvZgMuscmBBDEcgIeKuH9n
 nQeC3y0zykmGkl0U3G6CsOb23TztQZjxyN6eZAHVrhuSKA1jWB4pTkJ4FkFX0A0qCS235IrNi
 toYuwVsdea8B05vhZEXPdhaP7xiTQvew73kaF7wwl28Xj9OaeHK1PbfALA8RY/9aps+Y453hH
 +u1SjRDY0JKqxZEu3dWmTfDnUmhSzUKEQ7bfZYZsLNDpgUsMubZ+JAnz4KKJ8x6AfLCqjb1Xy
 2q8xIiK4ZaXvgu17M5CPpKogo9fVJwQoK/FA3KD1vxNryovgHfkCFbOuQ55k6l3kv/q6lH/Xc
 K77AODMf7HL5R3W58Mv+MPjqhi6pzOnfAkr8ApR5e7D0Jc1zvDSwuIiwM/8S5/yNsDGkFYD5O
 QY8q/jHxZpTklIBhFE3E9NfP0vs1ULsvVMWIo/QgvN3KeJohTbpcfIjOgPT6hRX3Gxw/PZLEf
 ttt+gnoCJ339khOAQ2m+967fqoX+6Jrxp+T2T9/mKKvUQIdHwpbW7AQJ/8gOZ/f7u410nzpkA
 CMNjAdaXCNLzpNZAvEpJRDMEHxdZbGfSlZmYvFwaJoh1h/e3HT2w9SdmvUaxqdmQEemBwl7vU
 rtIGUxaziK4XZkijZwvz9JExvdVVKphBJcGZkWBXB3yOZw8bfrLldUUYgCnaW7G4le0UH8TbK
 07a/ViLG75ih+ibNBA1dBQigtgHEEEmXwbg9Z/kvKp4LWmPG5C4ubmyctNdVxueYoMAWyY2Gi
 oALHjbBuIjZQ+Qor8AbDQDJdy4gOXrU1D6F9sKtLnkz3zpvCmEgf/HJW1F6YXTRh9KZRfkcvq
 wZOTdF6ZNSGffTWBa
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This sets a memory limit provided via mem=3D on the command line,
analogously to many other architectures.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/riscv/mm/init.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 965a8cf4829c..aec39a56d6cf 100644
=2D-- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -118,6 +118,23 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */

+static phys_addr_t memory_limit =3D PHYS_ADDR_MAX;
+
+/*
+ * Limit the memory size that was specified via FDT.
+ */
+static int __init early_mem(char *p)
+{
+	if (!p)
+		return 1;
+
+	memory_limit =3D memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+
+	return 0;
+}
+early_param("mem", early_mem);
+
 static phys_addr_t dtb_early_pa __initdata;

 void __init setup_bootmem(void)
@@ -127,6 +144,8 @@ void __init setup_bootmem(void)
 	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
 	phys_addr_t vmlinux_start =3D __pa_symbol(&_start);

+	memblock_enforce_memory_limit(memory_limit);
+
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
 		phys_addr_t end =3D reg->base + reg->size;
=2D-
2.16.4

