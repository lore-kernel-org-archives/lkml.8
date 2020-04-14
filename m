Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC315C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F99F20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KR6ctP5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440703AbgDNPkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:40:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:44211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440639AbgDNPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586878781;
        bh=9OBF6gIjnTCjWkLOnZw3x33tS8mKryfNv0za8UnranA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KR6ctP5E28ExNfQyU4nYL19Thd+6hjEDhiVKcsF77siheMnXF/whNUnEMxzcgYRK3
         xjlsJ41JvCplpQY/+yzOGwWtMobzasntqtLpcZpwkZAUjIJNVx73dWVxk2akb2anTS
         IBlNvTSrnvBPXdvIJI4EKTFwpNr42ZRYDawtAFUA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MPokD-1jbloF3z63-00MsVj; Tue, 14 Apr 2020 17:39:41 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: vt6656: Use define instead of magic number for tx_rate
Date:   Tue, 14 Apr 2020 17:38:47 +0200
Message-Id: <20200414153849.5785-4-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414153849.5785-1-oscar.carter@gmx.com>
References: <20200414153849.5785-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lxuWUOiVxukpQ2P1v0kvR0BBk5n4QGoskbxEewLD2Q2qXZ6+QNZ
 JXOXB/XgnuoS/bgvRFm7LhcZX6TxmTt4QEd2e0yT68u3VkwECvKNCVYoxpmxx1p+GFL2GLc
 1qZUYdaYDdpd4d5mq2tXnitAsQZnNpeK8kXWTTJdY/jw27Czr36oafo4rE043sdCJ1QnE1N
 1e8fPVj5LQVEGIYr13oWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4fp2YI8ohc=:OHdWikw8B0zzCa595ZMPoV
 j1Ti4zhYfcSJdu03kXfZFaG6Tk5aLGK1YkfWB01k8DXtxNT38UIO7DTxbRLwLQM6H5yjJiQd2
 T2YT34U0fHl/inq1C64CZHzp3OF106H3xWPee/m2RiFjoTW/Mz2IIX01jR56B5/27BrH7EXMJ
 j9+CEqzTs84U+Yq4DFIdYPDVhotKGtuqZjH92mBDYCkPQsx4U5USliuBAXj3N8r/mEygO/665
 83RPVmIu3KX2sQBBlmpXLukuBERZb0+UGl4c34xU/AcdsjHVXpL9UY+9aGj9fNur6Q0k0Vrdd
 +tDP+niIhJE8AGW/S95CtAGvtp8NRxvFsiZhP7gMG8rN/ztQjQp3U4ODrxqk9dPW8ZxtisU5Y
 Di+edi9gRbWu1TqtMeWtdicySfOijZxho2TBP7Li64X9DMFlUs5/0Uoe9ENzJ+Ue3Y7TgKCT4
 bV14tXOoR7PQZXSerayNO2ly/XZ1qaKJ1FD3OmOVjaWen1NV+O2ypfQhwRrwq7gf1YZAqnd5C
 pBVFezB5ppDWAwyRxzOq0X8663yRqlBgWuU+ThAqn38wwqKc+SFsv2eU0n4MvAl4lP65LUAaI
 v0+0mX3ZIBClnYa+kISKrjKsu/iFCdthSf2HlxchSvUiDzlxzLV5MAWcTe92mx2IZ143lgkF2
 BNCXLWfv4zcAnVmX/XUc7MDtvxLnd0ZtWlwDHb0hoOwOzFom0hixXSAm41qOBt/brb5ytgBzX
 LmjUa+OHTJFZAzrJMnvhwP3Zh48+j6h6TstgCLH+WYVn3GO4AEpcbgcIr0xiMKdLvBEXi2oLF
 P3yZ8SjjVKVrcG4ZwcaUI+3GzTHFIEIgqZNeJKIk/j2UXj17OCMIIegsLVBsAAcFjhcXXyWK/
 myI7uJC7Q++n8VtS+Pd3RJjRPlmjoGRLREHSiStKZ4e4Ou8w+98rY7t4wisuQkGc2khTxcrU9
 ZYsrUilsBs6pZ5+cOIm1gTNzDKI0ZzNZvvqB/3aFHMgITYUBa35BhW53Yp0VUK0eJkBqVqVgM
 wmQpZijVk56AKVLyA/ihiFI0BC5tBGOYg5cbyJc21nYL+q5XfL30D/Hw3cpXqZNpgjYrbCxoD
 0t3vlp2RgxElGnSfWVgrXzP1WAphK9MmSbZKQGuAeFrlp443I+cphSbr98wuzCXG0d/y6K0Pa
 Myc6/G7uEOCdo4giCascLHWwaCKCItWej0R5B8pLZ2AuR4+PpU3ie56IgRuJt8mP4yDRLtMKV
 wvoTtKDJ6ybZq5gaU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the define RATE_11M present in the file "device.h" instead of the
magic number 3. So the code is more clear.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index e0352405e4cf..149c9bba7108 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -24,6 +24,7 @@

 #include <linux/bits.h>
 #include <linux/kernel.h>
+#include "device.h"
 #include "mac.h"
 #include "baseband.h"
 #include "rf.h"
@@ -221,7 +222,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,

 	rate =3D (unsigned int)vnt_frame_time[tx_rate];

-	if (tx_rate <=3D 3) {
+	if (tx_rate <=3D RATE_11M) {
 		if (preamble_type =3D=3D PREAMBLE_SHORT)
 			preamble =3D 96;
 		else
=2D-
2.20.1

