Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A456206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S1+IdWNR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dqvUkQiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgFRTvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:51:10 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49530 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727960AbgFRTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:51:09 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C5D44006B;
        Thu, 18 Jun 2020 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1592509868; bh=iDThbQOOSK2MXTZshP5kfRh3W2+BO8CLhi+G7m2v5Cc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S1+IdWNR6jiosKE28uyu8JlOoDF/Jm8wGhkwp2uDdlX2/KZlLj2Ck6wkks4oECYmq
         f/AXPNLBB+Pge4OOV+7+cXhPeQlsuIamR4uNusR60YFVD9NcskOAqFYaDYRLZxpQht
         H9EiVbUXvALVHQjosMyViu5/PsgfwwrOmOXt6abPLl6akwBrzbND43r1zGeqIpdaLo
         eYhMbSJIfsfncAb+5benT+a6f2ZfcD7+/2uup7uVzODRr+U51QwdOIo3qdez8kb3N/
         dy66cYqSaGLxtYjvLVrQ0kXXXDS3YQhOlV3lGSzQ9z81cclZvnOEwYFQr1UjKieITY
         rvy0YGRtlKUGw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4D726A0272;
        Thu, 18 Jun 2020 19:51:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6575C800E0;
        Thu, 18 Jun 2020 19:50:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dqvUkQiJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiHBuFOkk86m3ETV+SCfWDNCcs3dr+pkWTv0dDcjvXj+o+lTmeUM6pMBUbKkkbaURj0PnI9bBl+4l3sBtnsxPBpkf78qHi+p/LgHkyAlWSRSPhJdMQpO948ELsvQ6Ls4zBf7/O7nMf4rbyjraggsKjlHorebfZmMMe1emXNFjZhvus+nAa5CMVzIDrGStRHItDwzWIekF5JHobwBG5t+0tfAiPDH2i+VlDvv4ZPnIzqJvPtVJ5RRW7qgD22kd7TeGKesobp+nk9xeopoZVzBYCAkKA692ojoDMPsVq1cSxCJGfjWk9DUbhoUCfksVKYp1ZzdlO6YLc6coUkc0Ocdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rSy8diwxe9Yu9sJgpl830iACpqfLc1KbXk1+tqz/Zs=;
 b=OqLspD8dtGPiMK5TFWaW/+WEV6jCXwcHx4LgfuDdZk/pYWlgB+c84HFKbola2gtVgbW2BjQpBB8ot7xD7+EzZE7aCOSQYug+1lAVy7HK5pQtk4lo+eOev2s3FHqsW6zyDk0siLxEslfZfFLzNvBKalqNNBcjDHouBKT4uX2M+VuuSq6TqbaS7sqlo8S7RYw41EKJU6ADaDaFQa07aaWTT0HhqOq4oVeKIepo0yxoMc2vC4+WZqcpfQ8qWrHJZRBP/YBhiuQsMxwTtbnRcdCCYooP7RY7eI7xhx7CvIkhorT6lRXUJRlnycR8hwR20O2v0rmCVRItipNvFdyAjS5l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rSy8diwxe9Yu9sJgpl830iACpqfLc1KbXk1+tqz/Zs=;
 b=dqvUkQiJHhWBJuKr9rFmYwmri4slr7tc+B41Q6dRlrnrieVwJ+roxnGO54NaXq2DAKKGVz/YvNgcTvWa8KFmdKlQOB3spXPBt3Z+1qcwVfXxjkSku345KCWpL7lbkzQCdA16+yQiqxBpB+fdHzN7PrhTTdXRywDhuNVG3MbJ1y0=
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0229.namprd12.prod.outlook.com
 (2603:10b6:910:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 19:50:56 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 19:50:56 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: ARCv2: support loop buffer (LPB) disabling
Thread-Topic: [PATCH v2 2/4] ARC: ARCv2: support loop buffer (LPB) disabling
Thread-Index: AQHWOpc6GC+HtF2bMUyiUEtu5I1E/Kje3VlF
Date:   Thu, 18 Jun 2020 19:50:56 +0000
Message-ID: <CY4PR1201MB0136B3C5A25EA943379FFCD0DE9B0@CY4PR1201MB0136.namprd12.prod.outlook.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>,<20200604173927.23127-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200604173927.23127-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.207.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a939bbd2-40a5-4df3-09de-08d813c0eabf
x-ms-traffictypediagnostic: CY4PR1201MB0229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0229CB5C937A9370B651C799DE9B0@CY4PR1201MB0229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iya72gotR1A9K2qUlI0Mhh/SQLCYfAk9TUr3+Ip6tv6pBRaaqgRvUdBaMON8o07vbsj1J2qlitsZ7xLsTEB8rT7VqIdlaULt4qKfBiAztfn8/8/hW8fZJioDWLYoBkGKShPe0FpoOPUbbcEVp9V7EIYDTMa0ki3XSuaF8s/KQMY4SCipLhL6Ngpt5uMlQMRGJFsh5850kfyElDpCvNJeVo7Cn0MXP/ARrJp8r7y6KPNkWp71okfy8Rml/I2VUdjGDFcYoF7YGKadz26ul1T3qWq+uhgDpRer49S+izANv7F88qfy5L9Rh2ZpNtnwnN8kNPnFCOIu0UxsHwJn7EuWrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(52536014)(110136005)(54906003)(83380400001)(86362001)(5660300002)(316002)(478600001)(2906002)(4326008)(26005)(107886003)(186003)(55016002)(8676002)(76116006)(33656002)(66946007)(64756008)(66556008)(66446008)(66476007)(71200400001)(8936002)(6636002)(9686003)(7696005)(6506007)(53546011)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kGHucKCOUGmcSEIB0Y+FIrxIU4rpkgKqKWWh1Hc5eSGTfOk+BmWoTKQUbcRNiTzzdkzYVLE9xpVg9gxiuVpk92LVERdcfjCfk7htxmf2quboraTUJOjosOquC+Y+m4g0xVWeamVfAcpjs2JeP4W+MQ0121GVYe5zcuNc0/TBVSIK1AInFpdfxoetQr/oyEQpH8Y4OVzRK1JXGVafgaqh5V31C1fiZPUHNza2WsoEeZmrIK6MNxnnILMU0xp8cvciwzPd9mm7Jm8oIZdZf7o261Ck/PbwVBbpMhkPeTVSf2Gc28VhGq9dRgWBmHyvB0gf4vAh/98/I7NSkXpBBuQl4XOOrZoH337PXDM/ZTXS33Z1rGtQCaCYl9DfvPB5NUcOtWN6GAaIl6Rhi0r9pjA9n9YmaGwwOQRQwx6HerTXB80MUNQttCQYQbloQRB/JJYwRko4biZk/zIThHFb2l9TsfvLO1bHUjOpQvJpB4dkAJE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a939bbd2-40a5-4df3-09de-08d813c0eabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 19:50:56.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqlYaUHt6fe97+abztkhvfswQUQS22mNxy+G+c4oIyfhYX79JJv1k94gau+f13cXCnjNIwjmYd1Nf3wuItEPFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,=0A=
=0A=
could you also peek this patch to for-curr as we don't have any disagreemen=
t about it?=0A=
=0A=
I'll respin the rest of the patches later. Thanks.=0A=
---=0A=
 Eugeniy Paltsev=0A=
=0A=
=0A=
________________________________________=0A=
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
Sent: Thursday, June 4, 2020 20:39=0A=
To: linux-snps-arc@lists.infradead.org; Vineet Gupta=0A=
Cc: linux-kernel@vger.kernel.org; Alexey Brodkin; Eugeniy Paltsev=0A=
Subject: [PATCH v2 2/4] ARC: ARCv2: support loop buffer (LPB) disabling=0A=
=0A=
On HS cores, loop buffer (LPB) is programmable in runtime and can=0A=
be optionally disabled.=0A=
=0A=
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
---=0A=
 arch/arc/Kconfig       | 6 ++++++=0A=
 arch/arc/kernel/head.S | 8 ++++++++=0A=
 2 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
index 7034c217708f..2dc142c8e1f5 100644=0A=
--- a/arch/arc/Kconfig=0A=
+++ b/arch/arc/Kconfig=0A=
@@ -473,6 +473,12 @@ config ARC_IRQ_NO_AUTOSAVE=0A=
          This is programmable and can be optionally disabled in which case=
=0A=
          software INTERRUPT_PROLOGUE/EPILGUE do the needed work=0A=
=0A=
+config ARC_LPB_DISABLE=0A=
+       bool "Disable loop buffer (LPB)"=0A=
+       help=0A=
+         On HS cores, loop buffer (LPB) is programmable in runtime and can=
=0A=
+         be optionally disabled.=0A=
+=0A=
 endif # ISA_ARCV2=0A=
=0A=
 endmenu   # "ARC CPU Configuration"=0A=
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S=0A=
index 6eb23f1545ee..17fd1ed700cc 100644=0A=
--- a/arch/arc/kernel/head.S=0A=
+++ b/arch/arc/kernel/head.S=0A=
@@ -59,6 +59,14 @@=0A=
        bclr    r5, r5, STATUS_AD_BIT=0A=
 #endif=0A=
        kflag   r5=0A=
+=0A=
+#ifdef CONFIG_ARC_LPB_DISABLE=0A=
+       lr      r5, [ARC_REG_LPB_BUILD]=0A=
+       breq    r5, 0, 1f               ; LPB doesn't exist=0A=
+       mov     r5, 1=0A=
+       sr      r5, [ARC_REG_LPB_CTRL]=0A=
+1:=0A=
+#endif /* CONFIG_ARC_LPB_DISABLE */=0A=
 #endif=0A=
        ; Config DSP_CTRL properly, so kernel may use integer multiply,=0A=
        ; multiply-accumulate, and divide operations=0A=
--=0A=
2.21.3=0A=
=0A=
