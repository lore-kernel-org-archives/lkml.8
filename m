Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20CF206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BC/hGUuj";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="thMiMp+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENFD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:28 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:54623 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgENFDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432593; x=1620968593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGFjrzf3ctrks6Ga8hfYMU+SwWU/PMN3PiqLrDvTS40=;
  b=BC/hGUujmqX/Hh0aSjkUb1ZfNg5o8THxd6L4/Argpe4ALUOOrLcsep/0
   qu2gRz/QCA5FD1wSy0M8KE3aGZxt+uvTqFgeX5NQpotmr6nZg8SJpqRl6
   k1bqhCM7zsrvD/3NIEmY46nzoN7nwzzH9CAFrLtrE4ggimbaIIV6cjsF7
   dHx1kTFmrkAVzNHHSprqJUIDkUy0RxKHijReNOxqEtDH2AhVKeboTdlzY
   xof77YTMQ8wPsBfyUiDBJ//O1ZXECYnIRw+nbpY4QBOXrFt6FUg4/D3yi
   McamOql+0AaPD4M/UOTHyldqnsNlY9tIrQ+9gF7kmi/5kO8VWFx4ctzQp
   A==;
IronPort-SDR: aZZNzTOuhyuQe+qbUvdSC+qXCtnFu27mfAKEB1/cS2iG+KFkCC4j0EuMxzJRiTNH99e3D6Kn3V
 d13mFMQ1WLylE0rxfOm+sl2x6L8JvOOcf1pEN8/O4V3owPUBQ25gkSQNvz814iuU59MjeJzl5I
 2Oqsrq9mkwu+iXQIioy8CKtJLXzPIuqQg4dwTMeNCQPMgvEfcY1wMfQpqcNwn1Y6I+MUWbcqw+
 c2ZW0/4OWAZXiuPdo/YhtNLqqvfXN0mDztS3WdSO3DPa3OqZBpf4cE4+wO7eBlVMw2ff3T4SmP
 +Dk=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="76601050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QipiVPBi1b0rKZqya6GFu7lctqLnfLN9j+i76QnLy+hk9vLr8O68Y3sbPVhx6OVVjejS65zaNhMrGQr3bbt1ymn/QNIDLeWCoKEIbeIDWKOtuktz5vX3fmT8YeAkduWHW46gwzN6mR3sjFgJ+dzKe9GxZ5dxwlBq55lmjESSB+2vQH9TeMAvjQTXofHDZtM01Et3HvhliVVVwoLdhCLHja1mcpJB6VUEKlBi+hJyB/0MCCPjpUVxzBsV32dm01t1Tbpuy1vLaMV9xtrVOvKW/jQ0OjCq106AYjzls1ZwzsIMW6E37ILL9TX4dSM3XNyRHoygVTfZkIcm7nxV95VfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOXjD0MmMz1bWn/7spjw2fhX99s7eJoIOnV5JCn8V+s=;
 b=UfxPpve2ZmqZ9LjvNHJYKsCuV+5voxskHmo+DKMF4ZlxQ299j11eHvkfGfwhvwgYI6CoFx8YxD0LEAjWdTSFE1e8/02wVNoSiK52BjJgAIfM8I0rXzWAU+FUzuuNfcc740cknVxe5OQW5a1aslL5egbx/dDiiIYwzPxN1T1KMQL1PPef6LIBKnYLRd9yvdGj9bi8lZaFNrYVMpKskbzdbkZJPdWopn1DlszIqYjQ2QpO1/VfpwmC4GJLCF+d4o5rFvhBMo8mo1G0dxv5AFKYJYS9Y0koKOFkdUDJb0hwaK5JXcH2hZ5kEERkV+a+uP2zKzgO4P0g8KORUSowesZS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOXjD0MmMz1bWn/7spjw2fhX99s7eJoIOnV5JCn8V+s=;
 b=thMiMp+fY3qQosr4iSJZ931N5s3GsKgrYNKmySCRbj03ja+vojpJATTko65e5LLAhDApjbxvQJUtxEqqgRqxQKZmqh1VqXVlzbRhqw77GzhbupY/sEAEnPU8XWI47K9Xji3zyQJpn3EUhdtYZcwxPYKiEir+ux3rSoMk/s/xR+8=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:11 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 07/16] ARM: dts: at91: sama5d2: Specify the FIFO size for the
 Flexcom UART
Thread-Topic: [PATCH 07/16] ARM: dts: at91: sama5d2: Specify the FIFO size for
 the Flexcom UART
Thread-Index: AQHWKaz3dpMmKuACXkmCJQFwirMG6w==
Date:   Thu, 14 May 2020 05:03:11 +0000
Message-ID: <20200514050301.147442-8-tudor.ambarus@microchip.com>
References: <20200514050301.147442-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28573468-0748-4df3-2175-08d7f7c419cc
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB448330CAAD8C4DFACA1716B8F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwYyofis8n7sVy29BcjytiAE+rsrus9+03HLmowTXaYxABNvKvbDQL1NI+768H9owvSKoVKorSpjU3fnb5uFm/Uve1uwuDWImcyZ83aeQVpGT8+CU900S7tWcRx+ZonRkvbGWc4MwFEmKykRDFKtM4wgPu/BO7sQAFRRVHwIa9bUx2bCYxWV5ULHWxuwo4edrOK5WJxTyJR9zq9WJbT3hgHOGTDFT5SYdqtNjXjPYKfwdHPzerONu/n6pStI6oc7cpo3tWV9sugS7R0Ge42UO8XL/njfYeHDAGVGagF1MjEMHp2CER/DHCMJ5574HyvyqIQcjj3aWYT18DJopSFt5r7bVLP+txK9+SIqXmDccbFteh20k2Q7NbIP2qqAJhLKao+ZzbcbesCzQck20tS8qMDibcDgqyE9RZq7vHDVdrbN2Q+czkVQiWsM3BvD8wpC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(4744005)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HKLED17pvp6vHaHRXi+DlReSMjrsdA0zcdiH2+siFII1Ito0+CSEdCGf5PrSuSnQEBgsO59cZ/txKVHroHCcfmpW/pXNezMixP3DQLwDUk0FfCiKISAzJ+7eCbeCzpQgamGekdF99F8OwqNoYxaB/fnt2lJplodtJx4FPgWf4I8Yx/d2iToJAqbIzv1T+llSBAGAABoKhtC4srZnTvDy3C9+5SL7Atf09JFDKja9EBhyBaWVoRwfSE+cmWgWYS03Aw9E908RSe7o8fCa+TdNp/y8nESUmQZZK5BA8VboW5OvJbOCF+TmiPLjz6SXqoSvdVNh/bBsDpZgtoV9oxl6J5bq1MOqgGjUF9Zf326PDzhPBVBrXCBlEpQYyZdHWgEgS5/rd/rxCO/srGRE/g/NDmIL1YzmsSPc9rXbwplIfzghp1j8qXx+GkqyIUtjS+YF18CccjfxxdZJOu3ck+Zj9aHWw7dwGSQdkLgmZSmuMabda/R8CzNy6A9YdGR8oVDF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28573468-0748-4df3-2175-08d7f7c419cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:11.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZClpZfZj/lXx7J/GZ8M9xbnRSykMhyQNhjVeU7g2CYNh7thrbBgtJ5VXKYt3M5NWn16VkBHrOpNoqn90ENIvd+MIuOzz6mxzxJS0Ha2A2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The UART submodule in Flexcom has 32-byte Transmit and Receive FIFOs.
Tested uart7 on sama5d2-icp, which has both DMA and FIFO enabled.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index acb91908bd74..dde969a140b4 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -701,6 +701,7 @@
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>;
 					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <32>;
 					status =3D "disabled";
 				};
=20
@@ -879,6 +880,7 @@
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>;
 					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <32>;
 					status =3D "disabled";
 				};
 			};
--=20
2.23.0
