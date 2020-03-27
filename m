Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EEC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BDA20663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RUaNUpoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0TiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:38:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:36853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0TiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585337871;
        bh=TarnDvK03R5OkAwxQLkYshS6zrE7QtGDv0yDW0/OpmU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RUaNUpoEaB6PteNVLmClccvLXaT2/KjRwkUKp4U/TkJwEbYyZf/Mp4aZ8f/Sm2hdx
         4J1MPuTG/rK0DpTkNJGq9mR6BwqbQMFYDbDMyzS1DA6nIsMD5jRqlguTWG9JU9petZ
         k1srTGU5wSquc0t5LEo7y2KvXJYuhrC65HmOOQko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MK3Rm-1iwOrx1gyc-00LWIu; Fri, 27 Mar 2020 20:37:51 +0100
From:   Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     Alex Dewar <alex.dewar@gmx.co.uk>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: Remove some unnecessary NULL checks in vector_user.c
Date:   Fri, 27 Mar 2020 19:36:25 +0000
Message-Id: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kVSEqb+E7PCctOfuSvs+ejr1Qi393zTPSWxd19Z9576GecgGm7n
 foEqUO34lrbD8dF74F7iesFAz51fS8w/TkeQk8JH43ITcAC8RRw12fRrvv+tG5v7GIKrEjV
 F+EH+YXuos/y3U8NVnEUWSorfA8XeN3H1tw3BD5CtyRYSiQcoIE3T5WOkzit/iTU1stpVx2
 EoabZ6jpOHyx8ms0q8Zmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wym9GrTofkQ=:RmM4uceM7nIXWNuFgZreVv
 enZ7UYCyfpkqUUqUW/cetOvpm5p7u457rqrSajlZy9Wt21iK1ILrSbkAIJEQkX1S0JBSJQv+Y
 0D7yujHwZPFTfDQj1pIoPs94oUL29xvB58NED+I42+dqEngYm9cxFb+2TqZ499+jz51zVcYRw
 kCaf/gnfk6KpTNLywwZlp1nEq4n1FhM9pQml+WxbOt/wM3eKeeF7OYjA2qlwD8Ogi9Ibok6uZ
 apJ9FdNiwfTvNoKgWRESz6yvyygUZaDFpFavIW7Pi1njR5u+PRYL6/37rFdgmpMFcqqPudCsn
 8ccI8EktL+XFVssfHx9LA2a910n4POYdbkPpIlCAJVoAvf7oYrqTgrZKSe6hYcasBH0IxADOu
 NODhZzSXIMTOcFF1n6fW4iL4dTz2d/0T5v7jQNP1jtb4vWZFt1BUvqIsmtVzBOspPSHbQk7pT
 lyv2nF71oW106IId/xyEnAVBsneXw+22yiPvMgfkJDrCWEqT+LhGTxkKEm2Tv3BDP46YxT4X5
 YrX0/W0hJILILidnvJGimy5+Oc/LhQKu2Tfr/a0vZ0ZaG1mdfxwCzElnD4XgTU80P9jPR4QZg
 mumdhhvSB4QGHiwLxPIgfZ5J5MV4K/nrkv4H3sI6Dc9poHOh9JS1i3370WEMHjJv2VRasFqcj
 Cq92X4eTpGcl9onILqP79elsD8XeCWI3GwB8ssu/NZWwYISUcdPtZ9mb/84wct3JMevZNMroi
 kqK6hk6ZuDroMmhaQNi9QXyb5Tt00kJ56YROuXZsUDKycKI9zGV74zMpAnf416vSDQuawzMOS
 kAgipk6LK7InGU4p5eFy0zjnK0zEY0MIcWqRTqSFCCW1bpRHw8MygifSxeIDh9v8HHAJZHtOJ
 9HSeSODrPnj0RMTrvfQwApPavXIm4WDI7I/+2PecVfS14lLM0ETOHgwG+M0Y0XBBI0eAcrvAh
 Z2jV7GzkLSxIaonyKRMiTn4tFtcSK8Ko7mwT1h/c3LTIV5gJ+8qAOXgNPYsEyOOesnbaoRsc8
 CT4OrTnW6Mdkyj35jiQGeskgfvu09/j8zbYIiq5MNDL4Disa0V57CC2uz5TFr2yXFUQ6gZUBF
 OUi3p13iJad1D3ogR3y9U1/CZUPQK1+gkdHJjouE3/CPmVDS4Y4cOk6LdlB3YnUxsbJdKTtu9
 87+YytRBEz3UBTGwI4iikkLZERPsoUrdrJPZKX/q4M5qGURCw2dvZQ7rDoBa6ZtOWDYmfm/c4
 /xY793jGivdw1cQm0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() already checks for null pointers, so additional checking is
unnecessary.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 arch/um/drivers/vector_user.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..aa28e9eecb7b 100644
=2D-- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -221,8 +221,7 @@ static struct vector_fds *user_init_tap_fds(struct arg=
list *ifspec)
 	return result;
 tap_cleanup:
 	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", fd);
-	if (result !=3D NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

@@ -266,8 +265,7 @@ static struct vector_fds *user_init_hybrid_fds(struct =
arglist *ifspec)
 	return result;
 hybrid_cleanup:
 	printk(UM_KERN_ERR "user_init_hybrid: init failed");
-	if (result !=3D NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

@@ -344,10 +342,8 @@ static struct vector_fds *user_init_unix_fds(struct a=
rglist *ifspec, int id)
 unix_cleanup:
 	if (fd >=3D 0)
 		os_close_file(fd);
-	if (remote_addr !=3D NULL)
-		kfree(remote_addr);
-	if (result !=3D NULL)
-		kfree(result);
+	kfree(remote_addr);
+	kfree(result);
 	return NULL;
 }

@@ -382,8 +378,7 @@ static struct vector_fds *user_init_raw_fds(struct arg=
list *ifspec)
 	return result;
 raw_cleanup:
 	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
-	if (result !=3D NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

=2D-
2.26.0

