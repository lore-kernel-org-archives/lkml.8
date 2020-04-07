Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80334C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510612075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A2xmSSgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDGQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:31:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:42475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgDGQbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277031;
        bh=dRrnNHMV0G1JWqD9csNXwBisLe5gckVpiKr95ecTaME=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=A2xmSSgoRNLUHu1/Szg6r1vDXUsZTOb+KG/SzV/HDceLZWBO/U+Oj6HDrV1WnDhko
         pZONpBSR2un/s1WzpCBwdlNsEXB1ArF8I4rMsRAUI4I2meaksyoywhLJQwfZtLVpft
         JZLwizq6DZjy+zoHK0ZZayf0QKAisQygb+nN8OGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MxlzI-1j5qfp01K2-00zFIB; Tue, 07 Apr 2020 18:30:31 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: vt6656: Cleanup of the vnt_get_frame_time function
Date:   Tue,  7 Apr 2020 18:29:57 +0200
Message-Id: <20200407162959.7318-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NC+4dIil97qHJle9P/jL4lfVPLU6zXIGv3DcNsA37CN31QtovPX
 g7fC2WiIKUbfZfLe+tWJ81AyrwAkQRoJb1waEYYfBFIGlt01IJeZLY8c6h2SuLhTXyoOqCu
 QdbyepCYd+xIjSrQABk1eOP7vfnjvOujorDEly3sdLmenh1JbXdWPDQ5TadppU4ww9j7Msd
 MyGcNYOv90QOACHIxHshw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGXCBEHfOME=:awlMunGY2CwfFgGND6vS6a
 Sj8Eg86ye8tBzkbBpLedSEy1NZP08VL0lFBpCa9LyqtbFy3H2M0PnzB4r+i6wI4xEHGeiuh4v
 RfoOegHBOARWSVd9hw7MyTKTj3GvG47PjLtiExj8EQ5P8GwIR9byBlZmPUdDKTnqa9osGv0UQ
 oI67n5/JuTw9UlvLW9NK0B1TxHZcX+0I51Oa0N+1InDVzQikHOu5+MwiKl73skTMpPMBGSEbh
 3SsiOuM1W7lhLe9gUA0codB4JVdNT873A8IjkjJ6ufdVjEhF2GVzZspLfUXmKKs732+O5PD/x
 3NZKDoT9AsuZtQWwxfhiBYYKFq29csza+BnG2ASLImn0U2N/tIpxVSPSmAPcnQ4vnGXHbtFBj
 6Hm1kGn0iSs2jcEzFdL/diJenSzPN+Y4s67/gIHsnSeiMBvTyfYtMSryl5wJhJIp5BaySAvfm
 nY3KgGlSq9vUGjFBv2ZZVTJ+uHYIfHtQgLpvHqroM4ldgEMDd3m2q7iCnVI5xQvK+U0HVnj8h
 724JzXWiYdSBPxIzq+hMCjOl+mut7n7TQluS35+jH4b3QFJj8W5q6KsmIpVAVbv17A2bTGYUF
 xGDIfB+Z0pQ9jg8n6FtOTY5QTwu2IqMrNGbcypYRCP1GTEn367P8TAi54xgUBYo/lhsdoACGw
 fIqodTTbCTmq5kfTN+c+tnJVd0rD+T8tTha3Ps2V77wCNaN1lJSUXSpMY0vvZd7f1RvY/a8x8
 1TBRgiDjkmRQLLntOmfZCIflAbNgWVtyIbk+TCUBtWjuNVhzj8h5rMzlXWQi4tGKV0/55mLfP
 9dw6xFD1LA96LHPkW7QvC/Th0K+Yn55L7lqAj3iCiFDzFKfCXhJTCZTpbmRXPuSn7FeLv2a6w
 yPe8fZH5uyh9gA/86Vd8M1xtCEYlo7237h90vznZNdLIZZwRjpquvf4N48SIuZvjzLCPTZ4FE
 6JaJCD5dY38FvtNSzn7B9YvEDVxJ4PwM4MMYsK3CYo5kdlbWVI+dmHoEXXqL3pInTywrj3YXJ
 M8OJ3cnxShFT0MOmUYVHt0x2hTM3B1NHHIoujU96DMZBlUMj0Px2tZhnRHEP3UnqWSZpxwy15
 5yIdaDXzpAkwJxAx0UMktmwtMGoAxgx9M2rPOo4WCHlLe6xj8hmO+3XAgZ5dUwo8ZDW0dypsb
 bUEcsI/EIM0NQIKUoC7yAkekUICa6f6I00PI/Pm0r7iu5N7aBWwS9rPIO6u6tcbjOyBUJQDn7
 kQ9GDukuzpk4ptoAs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes a cleanup of the vnt_get_frame_time function.

The first patch makes use of the define RATE_11M instead of a magic
number. The second patch remove unnecessary local variable initialization.

Changelog v1 -> v2
- Not use the ARRAY_SIZE macro to compare against the tx_rate variable.

Oscar Carter (2):
  staging: vt6656: Use define instead of magic number for tx_rate
  staging: vt6656: Remove unnecessary local variable initialization

 drivers/staging/vt6656/baseband.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-
2.20.1

