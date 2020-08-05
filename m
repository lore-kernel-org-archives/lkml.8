Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B79BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4868422B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zhYY4m0W";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UTk3KRlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHEIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:52:20 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39930 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHEIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596617534; x=1628153534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i6uvpNCVxwejvRPJtGq7mng3TNDoVpDfXj6uZLJ32wM=;
  b=zhYY4m0W16blGGprtrgwpmd8GaZtSncHYEc77PuXIw4gUZRIZY37+VMz
   +vKObeDSOPIgHU76eSxFYFpemv9VGGpSL3j96qA0Hwvmj+3KvmHu70Du0
   3kzhhivboFeCiI5OyNaVeIQuvJ9B0Jgyn2nz1z147KVs7DluhLiB3Fwgh
   83nDtLX8iU8wWcsPNvNNClo9fCqxGySU0rPbTsJRhWr9XGWjLRsXEH0AC
   rRzPj6uJtLEOuV5NvaqvuP54pkhvHxGt/3O04fdLO+RQR9vF39/Mflf6g
   n96ScJSbyhRcgqeGO7HgIlPqX09n/2CCiSDHT69NgswUZn4P+yE15nLRC
   w==;
IronPort-SDR: inueMiouxpdorRPJCM14eTEFQ1U6nBnMZO8z3/DYAWa+Q6N16EH6EKP1aCFDtIQJ/sGKsdFUfu
 zoUpDMajlfcKCJKrX2Xn4PHFk3i6Wr08fE3FuZ/Z66qHZWIt4hDwMwb1dxoeblrVvXl3Z9kR4K
 g2Y1wysXkMn/O5N0hbSZwo2IaXkXo55LyGN5iISLcyRQrD/5IjmNHiBNtlLn5Zot+RQnDfAYiU
 vOi1ENSwMV9LtZ87b1RlJUYHwT+rKFlZeWOftVn4k6lOcxLd0vhOWF7RUrH0jhG2bHiAbOM6Hu
 orE=
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="82448604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2020 01:52:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 5 Aug 2020 01:52:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 5 Aug 2020 01:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDm/8/BCXjb4mUT3WvdtmM/sLoYZgRfEYYb0vbVPKcxmCzHR85rqHxrnLZKKfUB0L++DwgyiQ16IsbQqjsyZ0BBMalSX0W8UFeH/cLUkp3SLBGqKDTrDVBmMGBzyRmgoiM4Zsmfki2KVjIhR67imZvl+wRZ1tFbRwWwcaeUvjEfnUgQcxW6jRan/I2qqc3nb71/3sgadBA05oFe8t/9EF2U7Vb/V3NuhUXXUSc4Pul2qsqrRqy9yKJD+VNqei+Q/ZwRlUD6Camz1rkCZcsF8xqDTlmV6fCrZIL0A5TfAgpITOzM8LyeyRKT4NozYsSFQJBgnEUMDde3CvhbVVf9mGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6uvpNCVxwejvRPJtGq7mng3TNDoVpDfXj6uZLJ32wM=;
 b=ajSn0xyyfrLoimmVHn7OIgxt9mEypXp3fe6ri28zbeNV+R9KsE8DZRqBA0oydRY2fBrR1M21lYg9gnR/YR5Ssjhf7l9MxP1Q+W+kjzyq7ecQnyZmOm/Kc5O6bz9vILd1EJXbixl7vSNFEhJy7Zywjwqf2qWDJX53fYKLasKJ/9lHOoQpbjuv+mhSFTaBAK5CzZO3tKBEQT+l7ry5aYHP49OWNjKUJeGrkAV6cXCnh/7q+HNvGAxrUqsIYXhyHcQqx16y3p0Cgcv/Ou7GRd9nLIoey0leChwU/faEzYwlG3eiw94YfhUpcRg4BPLYLpP7sIXPVTTYL7W1EwpAy5WWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6uvpNCVxwejvRPJtGq7mng3TNDoVpDfXj6uZLJ32wM=;
 b=UTk3KRlJwHCTYbU2LpfS6pk50FAgFhlli33Y+ff/J7s0xb6qknbmzeVX1OAwxzPzfZOM823P533WpCX6u0p6vV5bU9EO8Gtd1ijv8p7lrNGCtYGDxJco8PcOo5llHbV3lqnnG2+aCovesXQZC/Tr8NipAboq4GOuGsHE/4kr87c=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15; Wed, 5 Aug 2020 08:52:07 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 08:52:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Nicolas.Ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: pm: remove unnecessary at91sam9x60_idle
Thread-Topic: [PATCH] ARM: at91: pm: remove unnecessary at91sam9x60_idle
Thread-Index: AQHWawWyfEciSst8QEuSnJvK6xP8Cg==
Date:   Wed, 5 Aug 2020 08:52:06 +0000
Message-ID: <1af8bb51-85e1-d58e-cc5c-4c4e379f83c4@microchip.com>
References: <20200804115622.63232-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200804115622.63232-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98428bf5-0092-4286-caea-08d8391cd527
x-ms-traffictypediagnostic: DM6PR11MB3514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB35148BE810388A4EF8A3AE1B874B0@DM6PR11MB3514.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8s4HeQwU7fwstnsnqDsWEVT4E1iygoD7y3bEixqqhNIrCM7PdzeOwdhYHX7vnPgBRGTAUf3oZxTvBaxT2fd717ilz21my7LK3T9yFKuWBKPFCxHlcE2E1MTRye2oThTqNGz/1NwieXc7NYepYUv2JrIUH+X9Fbf6gMiEDnhXo0k5iB/jC4bIgkdkv31r69ZcPAXN+ytDuB8NOJU0atecXMT3EVCXZ0+zPRBaTEeCUdc+MvsDFkf4RcjO4JST4R9Ly0A0QkxHfsQUtX1FO71MJgaEPlqVY23fX02u1jbbMz08b+nKEi57MKz1i/Xokxgy8Gqa/Y5DMTFFCh1V9GS6IFovbYZ+98Q7A/EAeOocRA42yW+kuJV/Uf5CvSyNWj8Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(186003)(2616005)(26005)(6506007)(6486002)(8676002)(110136005)(54906003)(53546011)(4326008)(83380400001)(6512007)(8936002)(71200400001)(6636002)(316002)(5660300002)(2906002)(31696002)(478600001)(86362001)(31686004)(64756008)(66946007)(91956017)(66476007)(66556008)(36756003)(76116006)(66446008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: prVYnGCNelo/+vo/M09ZjAMCzS49l7Ax27Gr+hcwxqBjXmCB6PT3qAd9Hw77qrprpaM4+gkTbvY7JCgfY7XsD/e9q7ifECTrPGropfFT8CLfoBswOCkoayGVVTMS2gYREJ0QePiC2BrcqmkFohYqSvlp0CLxWIViYIBc6yHCow+GPOLMX+5PO40/E4PzJqBRE4pcYb6hAV6f4f09heTZeXc6R31O02bI8NEDYbdr7j/Ig34dj3hHjVL2u0QB5G7bTD5wo4npbFaXtlY3P6eamsoZdalwMYIxkNWx2E+frAOicM2GDtD4lBTfmOwAIkOTMHgbDqApSqkEoum/lqmUHyeKYvO7fiXUPc7E+VgzEDMifrCQez0L9pwGU82nYC7S2D5eo9zpZcVF527RJSCvWMjZnDr1TiO231CKgmAy56ItwkIEZXgkVTYokRxqVS0dAmrcWt5MSVuYXyjma1cOTbjM9rUgggjX6T8vIA8NmB9ToToHZg2QF2A8+LpA3bGnvB+i4h+fVUoU6tEkQH8gYL9oms4nFsOb5YNgh5v17VouZEgwNVpiUSoFtYhfT2+v714s11cowkfzD538O1phARgdvti3l4ptd8jib2z4Y95WP5Fz4piKryxLmnWEm4UXSnA8VQ8hzJHDPfwv6Hriqg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A338D6E6DB76C4489A725905A4875AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98428bf5-0092-4286-caea-08d8391cd527
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 08:52:06.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgAp38N7Tm2fDtXaXhowVLPJeeT009GGAuZUtlWvmg3NrZtPT9I1Vp+kvwZ1mAw5SDxbMvw3o9byFvudG5JEvCQsDG3jb7HtnProxoxZ44k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjA4LjIwMjAgMTQ6NTYsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGNwdV9kb19pZGxlKCkgaXMgYWxy
ZWFkeSB0aGUgZGVmYXVsdCBhY3Rpb24gZm9yIGFybV9wbV9pZGxlLCB0aGVyZSBpcyBubw0KPiBu
ZWVkIHRvIG9wZW4gY29kZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBCZWxs
b25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgYXJj
aC9hcm0vbWFjaC1hdDkxL3BtLmMgfCA3ICstLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLWF0OTEvcG0uYyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jDQo+IGluZGV4IDA3NGJkZTY0
MDY0ZS4uMTljYzBkNWIxNDliIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvcG0u
Yw0KPiArKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvcG0uYw0KPiBAQCAtNTU3LDExICs1NTcsNiBA
QCBzdGF0aWMgdm9pZCBhdDkxcm05MjAwX2lkbGUodm9pZCkNCj4gICAgICAgICB3cml0ZWwoQVQ5
MV9QTUNfUENLLCBzb2NfcG0uZGF0YS5wbWMgKyBBVDkxX1BNQ19TQ0RSKTsNCj4gIH0NCj4gDQo+
IC1zdGF0aWMgdm9pZCBhdDkxc2FtOXg2MF9pZGxlKHZvaWQpDQo+IC17DQo+IC0gICAgICAgY3B1
X2RvX2lkbGUoKTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZvaWQgYXQ5MXNhbTlfaWRsZSh2b2lk
KQ0KPiAgew0KPiAgICAgICAgIHdyaXRlbChBVDkxX1BNQ19QQ0ssIHNvY19wbS5kYXRhLnBtYyAr
IEFUOTFfUE1DX1NDRFIpOw0KPiBAQCAtODQyLDcgKzgzNyw3IEBAIHZvaWQgX19pbml0IHNhbTl4
NjBfcG1faW5pdCh2b2lkKQ0KPiANCj4gICAgICAgICBhdDkxX3BtX21vZGVzX2luaXQoKTsNCj4g
ICAgICAgICBhdDkxX2R0X3JhbWMoKTsNCj4gLSAgICAgICBhdDkxX3BtX2luaXQoYXQ5MXNhbTl4
NjBfaWRsZSk7DQo+ICsgICAgICAgYXQ5MV9wbV9pbml0KE5VTEwpOw0KPiANCj4gICAgICAgICBz
b2NfcG0ud3NfaWRzID0gc2FtOXg2MF93c19pZHM7DQo+ICAgICAgICAgc29jX3BtLmNvbmZpZ19w
bWNfd3MgPSBhdDkxX3NhbTl4NjBfY29uZmlnX3BtY193czsNCj4gLS0NCj4gMi4yNi4yDQo+IA==
