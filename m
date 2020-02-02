Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C14C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E32020661
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VK5rhb2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgBBAU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 19:20:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:60861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgBBAU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 19:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580602846;
        bh=f+zPvhIF10NZ+fPK3wRSAJN5xlV3fRtp56Osd4BOzFk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VK5rhb2m+cQ20TwunmdLt6169V29Pz+tTv1SxHOInX00crRvg3dyUyB//WQ/ZXb6y
         H9yl7aE+IPrBCtP2dnQXSVn7wvHc/Ob8RMv4xFh9nBSroJ7KP190xR35L4wMbpzVdu
         FzjF6T70yU8t5/jOCI/IUSj1Z5fyrLeENkua8MeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([212.114.250.16]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MUowV-1j7Dw7211l-00QmZF; Sun, 02 Feb 2020 01:20:46 +0100
From:   Julian Sax <jsbc@gmx.de>
To:     Joe Perches <joe@perches.com>
Cc:     Julian Sax <jsbc@gmx.de>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdkfd: Make process queues logs less verbose
Date:   Sun,  2 Feb 2020 01:18:01 +0100
Message-Id: <20200202001801.2493508-1-jsbc@gmx.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com>
References: <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KDqP/Jp9PNQtcCCr/i9Z9e9bWbi+49sN4qzcwl7g0/WLn2XtU+W
 5JLZZ78o5DWHvfEP5jM8gFSSQMnKhkfJWrHD+kdV/kJoky3+wJsUui1vTm7H3qu/f93qLRf
 Q+FUZTo/Ebq1DGsGDI/pqxIaKvrfh+R1r5uan9IGYfQWZrCWY/xzVa3pkGVAgmHQTV/mAWN
 chwl+u5XATv4vlseU0CDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uCCszD1rJxE=:W/2heqmdFn2806zXcUe/L3
 lS/eAMiNIeab8Sx7wylOvFeNlrgot5YT9WryVjZWSnyUN71ygq3NPiEGyw1jjKHXsm/Cb0J9t
 fBcb8m9mzP7n6GFA5203xsEVqXlPpp044VY2zztHL1ga7IbsPN0eluP+TSFbMMRtKfWU9szqX
 0A7pONt2xh3P+Utp4l1AMlwboSWgochRvScriQki/Zvk4laix+7HSi2c3dt8/8RfxVwhg2ntl
 zp6sylB3KudzEMxeFkGS164jws5T4UCi6NoMEkippNAQeTIAR2h9DF/VzdPWoZ8c/Mc7a5AJb
 QHOQ4kRXn3NDW4pFyxHAanrO3tv+bH/Vr6Q4KIj/AywqNCXbFLLEcydgwS0r8Rb5/leQYpG2J
 zp7AlapcuZo4Chy223SWLxo4Jd9tzDMzIOoqeoG4g+JPA6S9J+9Lj7yCXNHlX6+AX0A3aCAZS
 Qfb0vBd8yUDnFGkOzXatj01W6gWAoJWuu1b9tiU+BEb3IFZ8Qy3jNc7U71H//8s0vP212gwqp
 pgKu3Djcl5cko89PIEss5fxTjrc0coR2P7s3FGsIbhfWnPnuUZ72GmS3J2m6WydyLMrgj20pP
 Tuhj3mZrMRd8VqQDnO/m5Ou50jz83Ats+0uZ6FG1qFcVu3ltrqsRE+DycN455KHi62grMnweK
 MFBPFsRY77bOiublep/XP39GT8NUNpiW18wYyhjZtxHyk3GGxTgSe9hVz4cx35gTNKPdp+RAC
 +bM0RA+N5X76ne4hr7W5zI83Lm68ZntLyFep6tgDfbgLAuYuUCyEDT4IkPseUhfJsnjlPbzjb
 V2Y4TXWke/ipF1Q4K9hnRiGktgrBTTmTdUDsvoAL+xd/2q6zzSxRVAqbpcEuKtj2QtokVlrkR
 8e5EFLxOYjmyxANcB+xsGVCXyK1kC8+BbsNujku8lL7IsM+GYYNZKeLeYjwkM+U5alDaB2nKT
 zk/SBQ3CEGGyImOT2CcJZElDVaUfM/p+JVOF6H08wyibb/9sFWfxbfUu1xWnQkhVTmzYIWaxW
 4X2T2HaO1Ot7Jqfa2r7qUhEwnQV3e9NeHBuZpxjdqSb2LTtYuZ1ydt9mfW6SLUIzfZO2pAQTH
 6aGN4T05HQ778ZSVULzcSB7oLXgcFZ6l6ZnmTTcdYu+DS3xOn6VrqfscZ5f5RKxw9yBdfApyz
 PA991+3xne09JtkJf6w+iYdcd+IVgNfNUhtumBUzHDGD7I6spfnNr8Xa01NKcEt1D1t5Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During normal usage, especially if jobs are started and stopped in rapid
succession, the kernel log is filled with messages like this:

[38732.522910] Restoring PASID 0x8003 queues
[38732.666767] Evicting PASID 0x8003 queues
[38732.714074] Restoring PASID 0x8003 queues
[38732.815633] Evicting PASID 0x8003 queues
[38732.834961] Restoring PASID 0x8003 queues
[38732.840536] Evicting PASID 0x8003 queues
[38732.869846] Restoring PASID 0x8003 queues
[38732.893655] Evicting PASID 0x8003 queues
[38732.927975] Restoring PASID 0x8003 queues

According to [1], these messages are expected, but they carry little
value for the end user, so turn them into debug messages.

[1] https://github.com/RadeonOpenCompute/ROCm/issues/343

Signed-off-by: Julian Sax <jsbc@gmx.de>
=2D--
v2: fixed indenting of following lines

 .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2870553a2ce0..13bd588c4419 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -604,8 +604,8 @@ static int evict_process_queues_nocpsch(struct device_=
queue_manager *dqm,
 		goto out;

 	pdd =3D qpd_to_pdd(qpd);
-	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
+			     pdd->process->pasid);

 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
@@ -650,8 +650,8 @@ static int evict_process_queues_cpsch(struct device_qu=
eue_manager *dqm,
 		goto out;

 	pdd =3D qpd_to_pdd(qpd);
-	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
+			     pdd->process->pasid);

 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
@@ -696,8 +696,8 @@ static int restore_process_queues_nocpsch(struct devic=
e_queue_manager *dqm,
 		goto out;
 	}

-	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
+			     pdd->process->pasid);

 	/* Update PD Base in QPD */
 	qpd->page_table_base =3D pd_base;
@@ -772,8 +772,8 @@ static int restore_process_queues_cpsch(struct device_=
queue_manager *dqm,
 		goto out;
 	}

-	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
+			     pdd->process->pasid);

 	/* Update PD Base in QPD */
 	qpd->page_table_base =3D pd_base;
=2D-
2.24.1

