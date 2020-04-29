Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A86C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240C0206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fRznkPLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD2PjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:39:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:47331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgD2PjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588174751;
        bh=8z1MF8q0T1lLTf5F8R5lHUb5+8Yh6vfgzjQGK5iyFXI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fRznkPLVfE6ME8fN54Fqwg3quSFBEYvFficZbE/OGczvciwLhXx/rqzzFhpCuvOT8
         TmHxJS1s7CCoTMLnhWFF1U6OfX7qJcKx3A2cOf/9ulvjDluuicC6BXksQJ4yj8E+5x
         lq7f93iWc0NaG+3NgPvf6OwAjU0k5BqlTSbdtkNI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N0Fxf-1jHtsn3hwt-00xGLj; Wed, 29 Apr 2020 17:39:11 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Refactor the vnt_rf_table_download function
Date:   Wed, 29 Apr 2020 17:38:38 +0200
Message-Id: <20200429153838.7216-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U82pnMTQRa3lfCfOyaP62GlsK9cfo0XGqPo0uQM8kaVdjqeT5Ou
 CNThO1MA3x5fLAFTgE9z2Wv2+6YZpB6h+nWRAgNcIxX4IPx1pgJuNO1xPf07VUOGTrHcV3P
 mHte+V820d9Df7xsubFMmvSZSwGwhudHN/gtvZBHJj+GLR1aFlJfZH1Qr0BqdyFPosKGJ8S
 EXu043m8G/p+E6EPP0Clg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wwoh4W94p0M=:ILNRWVH9MH4/qz6fPiIrld
 ffEuMKaXz0dkvBsWnZ1P8aJlsQnyg8ma+C934+TOoO7K0OrKwyd3MOIjkPKW87NYpgps8xfEC
 7qw9nmiosx7FvVICJWu7imqwEFuEcjrc8chvDj2zEVBqvNqrW782jS7FoD5vAvHp2zj0E/fTx
 IpRDbBS2JFgP+dAwm0MkjNDaUBXPXY/PKvEqr8D/SGNSC8cx5sHoHoy3tRdIjhzAkTea3Nk1L
 jeniJ3sHU+6GJoTRY8FYnofijqlX2yGmEB1LIxfCds3HxSFfoWWwCwt9xYgIVB5uzICzfiNJr
 +xvAELBKTw12KZyyBVLoXJapUEC7rXo3DVX9XHmKJwh1P7jdSMqp2Lym6fbPicuheq49QPwnC
 7CkUKY5Jzds7qvU+Ncj1B1Vq4JFs4zYjAZptHYMSsRNQPbUTyIlXLof6JDvPnzRw2l6fHCgZT
 9zw90nQxCIpqyk3Tk8n/24UCvctglvkJRAMM1nWtLlwolhDOB+uDMUFc/DD2bsCJ+zMggJsK9
 WKR9jQuTHGH7x8dVkrv5iuoA20NG8yxdlig2rIKb8ekNxwjEtSclG73QO+IOxethFNemG+BBc
 pzT394g/1B6bvsqo0aQnMyN/2/aCyp2YKgNgfGrghzGCm5ZddrgShr+zTIrfWhQUgEdw2LJlf
 zSXifEdTIaqXcPEj2KAgAKgBOo8wJ6voQOmTcL9BOxRnv2NBxKCcQ04LddCud+7QLJ318Xuu8
 j6+JwCJRu/NAeK9yp+QPkTn64CXRpgSwXQOODbl9xU7140jhCLODektKrwI2O7285h4EUjV1+
 dPJ/gu9WLuUSQK53Lr7/t6OXeqvgRDQr7xxr4YN4rLNPh3n3O3UaKECCooQVRlTwyacbV3Il7
 3zU59AsAfsRCaOYe2CXj7WUuSHC7ZoHzm1CRkP4plPGmUYX21clZcQOh/DjQVwkFXAaCR/I5J
 Fgc8WCXgVBR1Gvr7jaVENBC81u6m1DpvRlYUh4Pv7PEXsrm8/MdIOr1izhNHMWd7r4uH5gvgz
 jdFadSh33OF6miySQ+G1OZiqzJ0BVqP7kIRJ5bPpf5faUxWUAt03/TFJi5bj70ibjpk4qCU2m
 7p0/JNFz48hhBUtAXQlGPC3lhrS6zeBl6jgcvjy3C9K4KP96Jio6Bvfea5bJ1URNh4lvvONQh
 TEz+e12vy39TT6EySQQX5NzUTGfN0VOesC7If9Y50nVX8vpKJ2O+wq0StOPlgiT82//r2xWcE
 qBh3lvVgw3O5sJ5cY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a constant array of struct vnt_table_info type elements with the
necessary info (address and length) about all the rf tables for every rf
type.

In every case of the "switch" statement replace the hardcoded info about
these tables with and index to the new constant array. Moreover, use
this array index to extract the necessary info in every call to the
vnt_control_out_* functions.

Check if this index has been set and return without error otherwise.
So, avoid the execution of code that previously did nothing due to
lengths with values of zero for some rf types.

Also remove all the variables that are now unused.

This way reduce the stack footprint, and make the code more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/rf.c | 111 ++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index f18d456a8f5d..fb708467b99b 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -518,6 +518,47 @@ static u8 vt3342_channel_table1[CB_MAX_CHANNEL][3] =
=3D {
 	{0x03, 0x00, 0x04}
 };

+enum {
+	VNT_TABLE_INIT =3D 0,
+	VNT_TABLE_INIT_2 =3D 0,
+	VNT_TABLE_0 =3D 1,
+	VNT_TABLE_1 =3D 2,
+	VNT_TABLE_2 =3D 1
+};
+
+struct vnt_table_info {
+	u8 *addr;
+	int length;
+};
+
+static const struct vnt_table_info vnt_table_seq[][3] =3D {
+	{	/* RF_AL2230, RF_AL2230S init table, channel table 0 and 1 */
+		{&al2230_init_table[0][0], CB_AL2230_INIT_SEQ * 3},
+		{&al2230_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
+		{&al2230_channel_table1[0][0], CB_MAX_CHANNEL_24G * 3}
+	}, {	/* RF_AIROHA7230 init table, channel table 0 and 1 */
+		{&al7230_init_table[0][0], CB_AL7230_INIT_SEQ * 3},
+		{&al7230_channel_table0[0][0], CB_MAX_CHANNEL * 3},
+		{&al7230_channel_table1[0][0], CB_MAX_CHANNEL * 3}
+	}, {	/* RF_VT3226 init table, channel table 0 and 1 */
+		{&vt3226_init_table[0][0], CB_VT3226_INIT_SEQ * 3},
+		{&vt3226_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
+		{&vt3226_channel_table1[0][0], CB_MAX_CHANNEL_24G * 3}
+	}, {	/* RF_VT3226D0 init table, channel table 0 and 1 */
+		{&vt3226d0_init_table[0][0], CB_VT3226_INIT_SEQ * 3},
+		{&vt3226_channel_table0[0][0], CB_MAX_CHANNEL_24G * 3},
+		{&vt3226_channel_table1[0][0], CB_MAX_CHANNEL_24G * 3}
+	}, {	/* RF_VT3342A0 init table, channel table 0 and 1 */
+		{&vt3342a0_init_table[0][0], CB_VT3342_INIT_SEQ * 3},
+		{&vt3342_channel_table0[0][0], CB_MAX_CHANNEL * 3},
+		{&vt3342_channel_table1[0][0], CB_MAX_CHANNEL * 3}
+	}, {	/* RF_AIROHA7230 init table 2 and channel table 2 */
+		{&al7230_init_table_amode[0][0], CB_AL7230_INIT_SEQ * 3},
+		{&al7230_channel_table2[0][0], CB_MAX_CHANNEL * 3},
+		{NULL, 0}
+	}
+};
+
 /*
  * Description: Write to IF/RF, by embedded programming
  */
@@ -760,85 +801,71 @@ void vnt_rf_rssi_to_dbm(struct vnt_private *priv, u8=
 rssi, long *dbm)
 int vnt_rf_table_download(struct vnt_private *priv)
 {
 	int ret;
-	u16 length1 =3D 0, length2 =3D 0, length3 =3D 0;
-	u8 *addr1 =3D NULL, *addr2 =3D NULL, *addr3 =3D NULL;
+	int idx =3D -1;
+	const struct vnt_table_info *table_seq;

 	switch (priv->rf_type) {
 	case RF_AL2230:
 	case RF_AL2230S:
-		length1 =3D CB_AL2230_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL_24G * 3;
-		length3 =3D CB_MAX_CHANNEL_24G * 3;
-		addr1 =3D &al2230_init_table[0][0];
-		addr2 =3D &al2230_channel_table0[0][0];
-		addr3 =3D &al2230_channel_table1[0][0];
+		idx =3D 0;
 		break;
 	case RF_AIROHA7230:
-		length1 =3D CB_AL7230_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL * 3;
-		length3 =3D CB_MAX_CHANNEL * 3;
-		addr1 =3D &al7230_init_table[0][0];
-		addr2 =3D &al7230_channel_table0[0][0];
-		addr3 =3D &al7230_channel_table1[0][0];
+		idx =3D 1;
 		break;
 	case RF_VT3226:
-		length1 =3D CB_VT3226_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL_24G * 3;
-		length3 =3D CB_MAX_CHANNEL_24G * 3;
-		addr1 =3D &vt3226_init_table[0][0];
-		addr2 =3D &vt3226_channel_table0[0][0];
-		addr3 =3D &vt3226_channel_table1[0][0];
+		idx =3D 2;
 		break;
 	case RF_VT3226D0:
-		length1 =3D CB_VT3226_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL_24G * 3;
-		length3 =3D CB_MAX_CHANNEL_24G * 3;
-		addr1 =3D &vt3226d0_init_table[0][0];
-		addr2 =3D &vt3226_channel_table0[0][0];
-		addr3 =3D &vt3226_channel_table1[0][0];
+		idx =3D 3;
 		break;
 	case RF_VT3342A0:
-		length1 =3D CB_VT3342_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL * 3;
-		length3 =3D CB_MAX_CHANNEL * 3;
-		addr1 =3D &vt3342a0_init_table[0][0];
-		addr2 =3D &vt3342_channel_table0[0][0];
-		addr3 =3D &vt3342_channel_table1[0][0];
+		idx =3D 4;
 		break;
 	}

+	if (idx < 0)
+		return 0;
+
+	table_seq =3D &vnt_table_seq[idx][0];
+
 	/* Init Table */
 	ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
-			      MESSAGE_REQUEST_RF_INIT, length1, addr1);
+			      MESSAGE_REQUEST_RF_INIT,
+			      table_seq[VNT_TABLE_INIT].length,
+			      table_seq[VNT_TABLE_INIT].addr);
 	if (ret)
 		return ret;

 	/* Channel Table 0 */
 	ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-				     MESSAGE_REQUEST_RF_CH0, length2, addr2);
+				     MESSAGE_REQUEST_RF_CH0,
+				     table_seq[VNT_TABLE_0].length,
+				     table_seq[VNT_TABLE_0].addr);
 	if (ret)
 		return ret;

 	/* Channel Table 1 */
 	ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-				     MESSAGE_REQUEST_RF_CH1, length3, addr3);
+				     MESSAGE_REQUEST_RF_CH1,
+				     table_seq[VNT_TABLE_1].length,
+				     table_seq[VNT_TABLE_1].addr);

 	if (priv->rf_type =3D=3D RF_AIROHA7230) {
-		length1 =3D CB_AL7230_INIT_SEQ * 3;
-		length2 =3D CB_MAX_CHANNEL * 3;
-		addr1 =3D &al7230_init_table_amode[0][0];
-		addr2 =3D &al7230_channel_table2[0][0];
+		table_seq =3D &vnt_table_seq[5][0];

 		/* Init Table 2 */
 		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
-				      MESSAGE_REQUEST_RF_INIT2, length1, addr1);
+				      MESSAGE_REQUEST_RF_INIT2,
+				      table_seq[VNT_TABLE_INIT_2].length,
+				      table_seq[VNT_TABLE_INIT_2].addr);
 		if (ret)
 			return ret;

 		/* Channel Table 2 */
 		ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-					     MESSAGE_REQUEST_RF_CH2, length2,
-					     addr2);
+					     MESSAGE_REQUEST_RF_CH2,
+					     table_seq[VNT_TABLE_2].length,
+					     table_seq[VNT_TABLE_2].addr);
 	}

 	return ret;
=2D-
2.20.1

