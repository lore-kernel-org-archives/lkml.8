Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6C20848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="tm6FrPTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCIIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:40:43 -0400
Received: from mx01-muc.bfs.de ([193.174.230.67]:36452 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgCIIkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:40:43 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id 459D7203DF;
        Mon,  9 Mar 2020 09:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1583743240; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FodbOqKeyeMyCZ4IQTFd+GWKlGWuxwo5OizxmI3M9Pc=;
        b=tm6FrPTIru2zahVatlu6aWk9FdbiSp3wHuaNMrF/4sVbF1v4B15GAn3A51KMycIGGDNHDx
        oHeqT8sLJizvZxG6zbFXLVMYGC1HTrf0s0Z3MpHWEHo3EtGs2KtYilE9M0Z5XZDPTP7UPo
        7NnLf9i+0bzhvKuLWvqiNKXDU3dY/7JEMJ7V+JaTYYocdRO4L4MCqQFVUkpYsHdgtq/aDC
        Sl4Irvkdz0421p9dKgminVuqsYlNvOe/S6h3+M56hWlao+UWtVO/SVLrbps09G7KGmT6XW
        n75TFZK2cPT8nXw7XVM/Jtp/uPywvzeVYQ0EX/O8p3Lg1co3cdEipcFkF8Yxow==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Mon, 9 Mar 2020
 09:40:28 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Mon, 9 Mar 2020 09:40:28 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] bfs: prevent underflow in bfs_find_entry()
Thread-Topic: [PATCH] bfs: prevent underflow in bfs_find_entry()
Thread-Index: AQHV9EblEVE9iA1yzEeR1GKKiiXYdag/8Iot
Date:   Mon, 9 Mar 2020 08:40:28 +0000
Message-ID: <ba294b1d861142ca8f7b204356009dd0@bfs.de>
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
In-Reply-To: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-muc.bfs.de
X-Spamd-Result: default: False [-3.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.991,0];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[99.99%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Samstag, 7. M=E4rz 2020 07:08
An: Tigran A. Aivazian
Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
Betreff: [PATCH] bfs: prevent underflow in bfs_find_entry()

We check if "namelen" is larger than BFS_NAMELEN but we don't check
if it's less than zero so it causes a static checker.

    fs/bfs/dir.c:346 bfs_find_entry() warn: no lower bound on 'namelen'

It's nicer to make it unsigned anyway.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/bfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index d8dfe3a0cb39..46a2663e5eb2 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -326,7 +326,7 @@ static struct buffer_head *bfs_find_entry(struct inode =
*dir,
        struct buffer_head *bh =3D NULL;
        struct bfs_dirent *de;
        const unsigned char *name =3D child->name;
-       int namelen =3D child->len;
+       unsigned int namelen =3D child->len;

        *res_dir =3D NULL;
        if (namelen > BFS_NAMELEN)

hi Dan,
the namelen usage is fishy. It goes into bfs_namecmp()
where it is checked for namelen < BFS_NAMELEN, leaving
only the case =3D=3D.
bfs_namecmp() expects an int, so i would expect a warning.
Perhaps in this case it is better to change the if() into

if ( namelen <=3D 0 ||  namelen >=3D BFS_NAMELEN)
 return NULL;

note:  bfs_add_entry has the same "issue"

jm2c,
re,
 wh

--
2.11.0

