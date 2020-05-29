Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32327C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFE12074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a79vdBoU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rf0OM4U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgE2MLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:11:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49040 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgE2MLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:11:02 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A8F43400C5;
        Fri, 29 May 2020 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590754261; bh=+55pFRiW4soVyXlol/9RbbKCR7NNoqJSnWQfcQT3YJQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a79vdBoUQsfQLbcYkxVktUBPqrT2FEfunqkFNCzw9gHLZ7euIn6P5CwefOuwXcmYO
         8UpDbZpX13JQ82EN2IT/JtfMMpiGLlV5yscPocJq7NSz4XncDWt1JLqZNvPacZ4ojC
         x8128UWtEqQsptq9m7kWlY7Ebajnwk2MTiDifK3r2GTG5VVx23sf6kHThFmdncXcv8
         JljUc5nu0ELD8Szmy3BD37x8oTQqdL0v2FZlWUZ4Ki7uf26aenGSnjkeF9yNCaYdO5
         /Xz5xGAAEHnKP/rJlvbUfavCM96oZNtEmdz/yjaDO8oFmvb3rC2e/PrWywabulrk7L
         x7yEp/37KIHSw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3740BA0079;
        Fri, 29 May 2020 12:10:57 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 May 2020 05:10:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 29 May 2020 05:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEd669l4XSwcZZsYU3BiMD467REERbUVa3TsRI4P/6w0Q4s6nybIu3QkUVV66ehzPYxVYs4MVAJvG/Ba47OtdKqDeRiTPciePc23nXV7AI8xFlV94yL+XzFN1tA3k3NWNyBA7RCOyJIFcDuJpUdHiJTRySkwosJ53WtQGHm0zM/9zXWJ9BKVX8VIuUM8g5gLXK0F3JVhNuz+eO9DLJpfLsbfbUcJZMggzrm+ygcrpDHgocUOPqIhAI06HBUsZYDwKBpd97qYbl68rR5PiUKnHputQMRNgtxAlvhATO9LJk1GxxOy5G/hJ12S32gncRGLpWqVv/NU6vT9Bhf4I0ly2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTDPNJwEQlV1kzk4zw/bPZ2maPd0nwfHnvckKZW+HfM=;
 b=KNWmKysu+V2C5NekT134Tq7xLMGa2XumRmqRRFaohk2F/tpVVRb7OeOVvbK7sS1OPtRS2H3/Y4haeq/qKI/VTOdiGzFnG/U3ODhisPlYTR/KiNIxaoZnw4HRP3IiNLL88gh4K8c3Wj8S7nkz7IhPS+IQTqBF91n4a8ri0xWj3Q+eDUqUk7yvwFPdpTGdANfmAT/BQjkMZr4Yno2RaTSkKkVW6Be/5q7gNPTfvo/O78LeHr9Itd4z4T97UjNIHvGfufgJNQlI6BgGRgHmgVfJy18orJrVpdsgO/5/P3FWCr4qU6dvanR5M22rEk/3h8CJHVA9G2wFbvIz7Cm4xMve1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTDPNJwEQlV1kzk4zw/bPZ2maPd0nwfHnvckKZW+HfM=;
 b=rf0OM4U0SOExGI98kG23ewQy9FJxcYpyLvkhnwnKoXrD2gklrxtMmjyM3Loh4Qe4mipJK+YklLgK1sj0RfzgYRHdnh1eEaKzWd1OIqqzIXD5hmvbe/XjGXF0PmYYNdvrJ19uSb+l22onJJujYBybYIC0sY7z6JhXb70520pndLw=
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB2469.namprd12.prod.outlook.com
 (2603:10b6:903:d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Fri, 29 May
 2020 12:10:22 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 12:10:22 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH private 1/3] ARC: allow to overwrite default mcpu compiler
 flag
Thread-Topic: [PATCH private 1/3] ARC: allow to overwrite default mcpu
 compiler flag
Thread-Index: AQHWNbAtvWfDMoTb5Eu1W2a2wecORai+9ZDP
Date:   Fri, 29 May 2020 12:10:21 +0000
Message-ID: <CY4PR1201MB01368C541FED4F50C3ECF8DDDE8F0@CY4PR1201MB0136.namprd12.prod.outlook.com>
References: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>,<20200529115534.22883-3-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200529115534.22883-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3793a6e-1285-4917-4341-08d803c94309
x-ms-traffictypediagnostic: CY4PR1201MB2469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2469030A6260271B105DE8E1DE8F0@CY4PR1201MB2469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ApZypS48TI8qu/ddNKYDajdKtmbci2/0fb1QX0/MtQ9PYm+sbEoDyulqsoaemF8/cDQsK5h15DGed9kTWCLjvjXVokSoFQKLcSdSwh+HU+BcZXBkoxAutykjJiMdPxTvSQCwHY1ajF/jv16Pcu4J0PJcG2fuimIbiDWmOZ7moOxyRavt62J/T+Th5cKt+T0l1p1lF0u0BeIHYKSbNoICYyTizpuOdvtR/euC9ndmjN6E4c+Thn7da3yv7PxJBgyROczmAPApUjSQN7vvofi2VRlcxDYtQ1GgVUWX2mYaXiTPiaGVVp31foX0fg4nUZ8cI/8rcJ8YUDPggHkIaBBGPBEHZFy4plxaz8iVFEPDvQCX5M8wUrWAskTdZpWayIN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(5660300002)(66476007)(66946007)(7696005)(66556008)(64756008)(66446008)(8676002)(8936002)(33656002)(55016002)(52536014)(4326008)(76116006)(9686003)(91956017)(107886003)(186003)(110136005)(2906002)(71200400001)(478600001)(86362001)(83380400001)(6506007)(53546011)(6636002)(316002)(26005)(54906003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eiCIVS6+1YQUqJOft9xw9XVFt0XMfd/ZloBeFqHuar83AcLyjdUlNTWCdDTG7xb8E4xOvOMwK2FWc8wbz+SdHQXjqxAWTBJkIvTW/q0BNoQUgmEfOwdYQXgLfMhcERSYC+ywviMGG0Nog6TIYCwRKQ4CvWDsw+9fJFFINjoBEn7v+TI9S6GRDm/4b53M4Ow8C9G1+S15kXd522yVJaE2JxSEv5J6EfydBGksXw0rkzOI5qE+kzMNY7G3buXgN00s2Kri+Et3iV+bS/5TLHUlgnbw93B4Ahz7pKJeMAUJ4cewF99En2Q1aOI0hw7LtsNfBMvnQw9Jkkdja/HmACuF+E2GPhoTdM7dbwdcbRX+xov++q08C/ceWlUNxoURXd5N5Zpib1V4v/FJVPvaqn7Y6A0fDm/ThHaDTfioUiM/anpjWvwp4t3oHvdPEKOAr/mVDIVwJLJ4Yqm38yv4jfTX4CPbMuUWeXFji6+EDgT89y/hJXC9FaKt2uSd+4XPTl/Y
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3793a6e-1285-4917-4341-08d803c94309
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 12:10:21.9046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBuz5g+coKSmOWZSqVzv51GgsnmYOyQknZ5yHpZsArOyeZ1Y0oc8rIBFYduyo0e1e8OYzfKHeugmMNM4pKlA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oooops, this one is duplicate and should be dropped.=0A=
=0A=
---=0A=
 Eugeniy Paltsev=0A=
=0A=
=0A=
________________________________________=0A=
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
Sent: Friday, May 29, 2020 14:55=0A=
To: linux-snps-arc@lists.infradead.org; Vineet Gupta=0A=
Cc: linux-kernel@vger.kernel.org; Alexey Brodkin; Eugeniy Paltsev=0A=
Subject: [PATCH private 1/3] ARC: allow to overwrite default mcpu compiler =
flag=0A=
=0A=
By default we set -mcpu=3Dxxx compiler flag depending on the CPU ISA=0A=
version. It's good starting point, however that may be not enough=0A=
as for some platforms we may want to use some specific 'mcpu'=0A=
options for better optimization or to workaround HW issues.=0A=
=0A=
We are going to use this option for HSDK-4xD board support.=0A=
In addition it also allows to awoid patching 'mcpu' in ARC Makefile=0A=
when we building Linux for some non-standard simulation or FPGA-based=0A=
platforms.=0A=
=0A=
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
---=0A=
 arch/arc/Kconfig  | 7 +++++++=0A=
 arch/arc/Makefile | 4 ++++=0A=
 2 files changed, 11 insertions(+)=0A=
=0A=
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
index ff306246d0f8..e7805db10f7a 100644=0A=
--- a/arch/arc/Kconfig=0A=
+++ b/arch/arc/Kconfig=0A=
@@ -377,6 +377,13 @@ config ARC_HAS_SWAPE=0A=
        bool "Insn: SWAPE (endian-swap)"=0A=
        default y=0A=
=0A=
+config ARC_MCPU_OVERWRITE=0A=
+       string "Overwrite default -mcpu compiler flag"=0A=
+       default ""=0A=
+       help=0A=
+         Overwrite default -mcpu=3Dxxx compiler flag (which is set dependi=
ng on=0A=
+         the ISA version) with the specified value.=0A=
+=0A=
 if ISA_ARCV2=0A=
=0A=
 config ARC_USE_UNALIGNED_MEM_ACCESS=0A=
diff --git a/arch/arc/Makefile b/arch/arc/Makefile=0A=
index 20e9ab6cc521..1b37e44d9b57 100644=0A=
--- a/arch/arc/Makefile=0A=
+++ b/arch/arc/Makefile=0A=
@@ -10,8 +10,12 @@ CROSS_COMPILE :=3D $(call cc-cross-prefix, arc-linux- ar=
ceb-linux-)=0A=
 endif=0A=
=0A=
 cflags-y       +=3D -fno-common -pipe -fno-builtin -mmedium-calls -D__linu=
x__=0A=
+ifeq ($(CONFIG_ARC_MCPU_OVERWRITE),"")=0A=
 cflags-$(CONFIG_ISA_ARCOMPACT) +=3D -mA7=0A=
 cflags-$(CONFIG_ISA_ARCV2)     +=3D -mcpu=3Dhs38=0A=
+else=0A=
+cflags-y                       +=3D $(shell echo $(CONFIG_ARC_MCPU_OVERWRI=
TE))=0A=
+endif=0A=
=0A=
 ifdef CONFIG_ARC_CURR_IN_REG=0A=
 # For a global register defintion, make sure it gets passed to every file=
=0A=
--=0A=
2.21.3=0A=
=0A=
