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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6050C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74BB2081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="svIz3e/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBOLua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:50:30 -0500
Received: from mout.web.de ([212.227.17.11]:58951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgBOLua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 06:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581767418;
        bh=jCA+u/iWeunXisbMKKiKA03JHhtYvtZt9+PJ1WArJLs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References:
         In-Reply-To:References;
        b=svIz3e/SRwMfRYktOnp10mrv0KT3SN7Sf3QB7z7Taq7Iqod+wP9H4AozfN+WU/Xly
         RUttwDku9m4AkgE9SSl0Ut0nn7nxyLb+Lw/1f19tGsBmJnEqUDXp/D6SB8HDjyxVaP
         FK/yPv3HbAKxuJ9LT1I74K8TV9kL34hxeFjMPJus=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.ww002.siemens.net ([95.157.55.156]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MfqAq-1ioYKz3qVQ-00N8Df; Sat, 15 Feb 2020 12:50:18 +0100
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] riscv: End kernel region search in setup_bootmem earlier
Date:   Sat, 15 Feb 2020 12:49:43 +0100
Message-Id: <b11898805c2f9f01b10867a05701aa0fafeaa886.1581767384.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
X-Provags-ID: V03:K1:dRJ78LiuZpsCOAaRFt2kX6CRQY/zfwNmeS/wQDiU3z1AmAFRFhs
 a7pkspN8g5TqXQti6GoOwOTcxgRVpyBAlFa2EVziRbawhY4KUUiD3I1zy4Lq8ZsWFN+e6A7
 Com3Vi66HeXM9fYCztbS55ZxjeSj1+Ty1jIUpdedhzMyzAONSnzJ3u1FDDZ5BIv8FQLimun
 ok88tzo/ZaDd94JCMqDvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4l0FGfFSd8=:fcKAdv9BAbt2EL6f6a/gnV
 XDc+YpOCOmmpw5Jp3Vf6XlH/UWBcdQnDFV44NqM4kAc5oNlPgOkrvYcScwcoCV52QV1dy3bO9
 NlWJ/Souni9qfUD5D4XoYkd7kjuv40xQvLDPB1PP5FUmBfCsidbNwrsBoRpQADynbELRhui5D
 WLI6MwPCKxettX+mH19d5W+T2tUezhfZFdtIonKLWukREWLFUXVK9cDMY0UaM4ntnGoH/aU4Z
 aq+TKlC5SWF46s4iJhT71Ly7GRDaIsf4B3vZYNdZRHzz70fWpR4Ips/BQhwFqJrW2XFZHVUre
 zZt88wwNbgkTIWOwlVFwKOFHdeIxRlx0DbEhLvuh2zROEkKSKXcDrU5A6UzhroK/khKd+eXVC
 M6UKThz43vnyVpknsDrgAMCZTvLw2HkJXFJzIchUY20V3TdGlTx6yIPABi0+gB4V4gSspQ/2h
 K8e0en6TmHPWW9OzgikSHpRidAM0WMBxp1OpDE3wqQn2A01kSdVhPpyR/TX5twZn8zgsQFeMv
 AVpIyln9OS9KpsuK+T3zSZtmge4qRv663UYveu28/KEdxOBLTJCdtIGk8cf6uYO2FQ95Cok4I
 zoi/PZdUrgCxItKxd+LcPj+ntp0D7Iet+23K7Do4a9fKNRVX81/01GcRmjFj9kBhbaNq3zgSB
 0f3DXSQoje+FJXJkUxt3TGH0EpNlaiySAnIdz9YVLLz5dTB1TBc5Bn5tZywz9QKxVyN7eCWAg
 HP+/JB6FY6zd9MPjYbE77A50g4ntoDcoCb3+2fZTqSgPZH2ivq6wiWZ2PcUTTMn5URGye2qWt
 ukwBGnxKtJPJkPdfzpHfXqo3R23oVQnc2fVJ+/LyDmuzBGHffZ+6EfhesP9k+ayVUaCzPW0xX
 hmSqAmLgJMibFEHKXFTE//Ps4EpI7S2vRRvjvlBNZTbZTy1AqUb/g8kyJRJ0UyU8F2C56jkfN
 Zj7LRnPykC813bq+JK7Dj8wGma8aDILHJOabhx5RE+Tjw68Mjx2WP+CwK0+lRjajpK+UkrUXI
 AXALhvcd159vwoyDN2z+Ls1F/1fEHwOymLGgqXz503JaJ2aOzHYkSK5YhL7hQFGHy0Ovx5DmP
 Q8JSoBrJKe/uMtULDUyNpnHEcsmlmvWnQ/cz8SP1u1XUuxLiXVXSToJxrzLiShG4CMIp4eqBz
 zvIx6EUxxodLvTGvGG/XIjFhl/MhFoTOck8Rh9uVUvp/Z2bBNg/FbcZgUhOeuysNiLfL9vORl
 jxUgSQKNrv44U5AMB
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

No need to look further when that single region is found.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/riscv/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index aec39a56d6cf..a774547e9021 100644
=2D-- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -160,6 +160,8 @@ void __init setup_bootmem(void)
 			if (reg->base + mem_size < end)
 				memblock_remove(reg->base + mem_size,
 						end - reg->base - mem_size);
+
+			break;
 		}
 	}
 	BUG_ON(mem_size =3D=3D 0);
=2D-
2.16.4

