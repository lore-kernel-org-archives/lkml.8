Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD1C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1F21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="0AMepv7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgBYKIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:08:10 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:62160 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729129AbgBYKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:08:10 -0500
Received: from [100.113.3.112] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 16/DD-43755-602F45E5; Tue, 25 Feb 2020 10:08:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRWlGSWpSXmKPExsWSoc9orsv2KST
  OYN8SRYv7X48yWlzeNYfNgcnjzrU9bB6fN8kFMEWxZuYl5VcksGa8/vmTteCmfMWTK2dYGhiX
  yHcxcnEwCixllji0aDkrhHOMRWL/v//MEM5mRonfvT/ZQBwWgRPMEjvmPwErExKYyCRx5ec5Z
  gjnLqNE27JdLF2MnBxsAhYSk088YAOxRQQiJXZ8PckIYjMLlEvs//GNHcQWFkiS2PnlCFCcA6
  gmWeJMnxxEebjE479LWEDCLAKqEkvu1IKEeQViJeb/Owq1ajGzxN8VHWCrOAU0Ja6sXMAKYjM
  KyEp8aVzNDLFKXOLWk/lMILaEgIDEkj3nmSFsUYmXj/9B1adKnGy6wQgR15E4e/0JlK0osefc
  QqheWYlL87uh4r4S61euZYGwtSQaT/1mg7AtJJZ0t4LdLCGgIvHvUCVEOEfiz6O37BC2msT2a
  +ehRspI9LXNAweohMB2Fonbqz+zTWA0mIXk7FlAo5iBXlu/Sx8irCgxpfsh+yxwUAhKnJz5hG
  UBI8sqRsukosz0jJLcxMwcXUMDA11DQ2NdQ10jAxO9xCrdRL3UUt3k1LySokSgrF5iebFecWV
  uck6KXl5qySZGYMJJKWQ8s4Nx1/L3eocYJTmYlER5GR+ExAnxJeWnVGYkFmfEF5XmpBYfYpTh
  4FCS4J3wASgnWJSanlqRlpkDTH4waQkOHiURXqa3QGne4oLE3OLMdIjUKUZLjgkv5y5i5th5d
  B6QPDJ36SJmIZa8/LxUKXHeUJB5AiANGaV5cONgCfoSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ
  5GJWHene+BpvBk5pXAbX0FdBAT0EGr/wSDHFSSiJCSamBKCje5pPx+S9eZqq3Msn8C079MCNr
  ic1XoW7JU4EG5dPsnBkm3J1g+SF57wj/OQ/UUq1ZNcWbavOVb7X4x8r3RzmG17b+/9Nm5r9fi
  q+Qzji1sevE+aFJgmkOIy5Sv6yYFrv339NC761VtzdJb7q+p5/ns5ffU42jbpI6algi3s48Wf
  JZznxF1+dmk6aZOWfYBIW/ixd5l8H5pmX5wH2dm/a19LqYTaz9/qV1+yczt1ZbDfOm/9wjzT1
  +2taGPc1uB8s3nX9TypjYzqHP9W8Oz+UzmSufz74L31d8LVVrgbXTIUqHeXoF/ger1sPL/8yy
  enHvgtaPr7+XgmVu+6i+2YSk4lLbqpOiL6Vm8HJcilFiKMxINtZiLihMBF8LwzksEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-14.tower-223.messagelabs.com!1582625286!1064825!1
X-Originating-IP: [104.47.1.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19828 invoked from network); 25 Feb 2020 10:08:06 -0000
Received: from mail-ve1eur01lp2055.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.55)
  by server-14.tower-223.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2020 10:08:06 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV11CyaTs8NEXT2IZxMdCH2WNNz5fQR1ct57vTeMUbtomXdKdq861ngJ6LpBHaXkIFICR/h+nPZs0R2mfWARHMv5UX8KTESJIPcfiejymnASyO38uYqiRBPuWISAMFjco71XGFhA0ED2SNhIX8B4ul14iTGcLNoqMHsZ35bq21egVrzqWObkYgVoaeiprBxTC0vtoJQ9w4iePuIdTXTBQ1Gogf09875oRiCFzfzZZlm6KLY2uRqQjdB/XgrAMr6CYIuiRLKdW0UZGoB1btH4lOohap7HZxFFWr1Jx5bN/r1b200v9NUj3+46QBMBgE/IwA1emrMLWdVNw/dm8tcZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgQBd4ryewbIVidsn71uvx+8ifRhYDWe6drKOT5yBTs=;
 b=FtEMBebAiOY5imoIu0bzz8ExlF0Q8ZpZpwON/vI8gGTGAFkLRdWCgbFtDQP8B01IZMu0f2I7oTjd8VFCK+XI2+j6mgFhbe6hkgeNTRa/OcjNcL6OxxjIXB0aGJ9/DRg3k9NdWqxxmriXu+kUJwh2tcGrMtxO6PAT0XaKxwrdeUqaNOi7HfMErUabml6gc5+q4N2wSfR1dJvydC0EY5g3ClBVucWyi+WoRve3VWBEjHzC+511Ebho9gwmHcMksRjx/7oHuAeTdCwOdX81Ros2jFeWedEBul/RxpOsxA1XIsYmPH3uPwNoa15IHFl1r6p710UhNmwGkpvfCRPVuOr25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgQBd4ryewbIVidsn71uvx+8ifRhYDWe6drKOT5yBTs=;
 b=0AMepv7TSNrGs+lSVGX3OHjfkQLwnQITEc/PVBttPAcgDlvWdRCo0EMuh0tH4bzlNpIIYjEtPaBJ2PYSZRlR2tCzNQ9sEvSdvDZiCSEgkJSO8DkzrFh9uBGpW+rq4PVJoS098bgVzOBQeFjWOle1fdqx6gz+zcAiAEt8FkXQKMI=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2967.EURPRD10.PROD.OUTLOOK.COM (10.255.123.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Tue, 25 Feb 2020 10:08:04 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 10:08:04 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHV0qj+Kh78pvF+10az+5Z3RzvBLKgqTCoAgAANAuCAAAw7AIAAC5BggAFdugCAABLMMA==
Date:   Tue, 25 Feb 2020 10:08:03 +0000
Message-ID: <AM6PR10MB2263116205FAAE470E1F23C380ED0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <20200224095654.GI3494@dell>
 <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200224112714.GT3494@dell>
 <AM6PR10MB226325120B64509E3372C21980EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200225090020.GX3494@dell>
In-Reply-To: <20200225090020.GX3494@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a30fce73-2fa5-49a9-abb4-08d7b9da9a73
x-ms-traffictypediagnostic: AM6PR10MB2967:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB29671B870ADEBA668AEE07D0A7ED0@AM6PR10MB2967.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(76116006)(66946007)(66446008)(186003)(66556008)(64756008)(9686003)(55236004)(66476007)(6506007)(55016002)(2906002)(26005)(107886003)(53546011)(316002)(81166006)(4326008)(33656002)(71200400001)(81156014)(966005)(8676002)(8936002)(52536014)(7696005)(110136005)(86362001)(54906003)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2967;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPJ70NDGD8hzHX04dXkw4fKwi18tLjViHg3WnsdJ1gTzHbb2QqoF6naPOF+OlkOItPbCydBdY1IuBo0L7xH90MdWgp11sHYDFRvM9OgpzmQXIZr5rzblJ0bBze24uyTrXRx0P6LsBx+7+tONtqIDlW15VyuCBIrHkVPr9nEuY7TSq6X1LMvah9EH9pwxlUf2O2J/CciNb7hlxSDypNH3SDqP9SoWvhb22tvJyxNrtYNAnwW8f7yoRmwoOPW6PVcnoS7UctthqNdDpgm4R66ZkHTjiUDa7LKFvN1tXNEB1DoI+1wIXG04X/B2U+IZqQzF71BOZ0T5gHDzfY6onXAFuEv6msHMDAhtsLwD4/VhkoRUxHfgoq7Y4DgeAbf/ySdZZ3qaLM8iV/Nan27o5TNUOVUVh287WdpkCOHquwQkH0WoHY7DhqY3RSdJRH52UVJLa/+U5Eqk5d5SQr9AMZtRqTXLCKQmTYYe+LxhYgBNAP3tZHr9Lv7YeI7OYYnHl5zkSRbl29t3mvRQKwehNwGodg==
x-ms-exchange-antispam-messagedata: iPtSoEjSIxWR6kxfJE7oHtSfwse9QBHJzXNEeqP3mxVoTr16dC3dZQzZ6LuFfR12q79ifZ9Je4ugCyKLp74CVhntmsMMvwukQf6kLAVHBhU0e7tNguwK/PX9HI7Ioth0gY48k39DkwXrohAP3HcJmQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30fce73-2fa5-49a9-abb4-08d7b9da9a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 10:08:04.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9T7kG5Y5i8DgA/h5G+S5aFd1Ef0yCvQB6wVXp4iF2HudHSsowl+70WDL1cntmF3o07k7CnzAqqvwY+r66U5hsEV5LfvwjxHiGDrj08iF+8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUgRmVicnVhcnkgMjAyMCAwOTowMCwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IE9uIE1vbiwg
MjQgRmViIDIwMjAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gDQo+ID4gT24gMjQgRmVicnVhcnkg
MjAyMCAxMToyNywgTGVlIEpvbmVzIHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBNb24sIDI0IEZlYiAy
MDIwLCBBZGFtIFRob21zb24gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBPbiAyNCBGZWJydWFyeSAy
MDIwIDA5OjU3LCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCAy
NCBKYW4gMjAyMCwgQWRhbSBUaG9tc29uIHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBU
aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBwZXJmb3JtcyBjaGVja2luZyBpbiB0aGUgaTJjX3By
b2JlKCkNCj4gPiA+ID4gPiA+IGZ1bmN0aW9uIG9mIHRoZSB2YXJpYW50X2NvZGUgYnV0IGRvZXMg
dGhpcyBpbW1lZGlhdGVseSBhZnRlciB0aGUNCj4gPiA+ID4gPiA+IGNvbnRhaW5pbmcgc3RydWN0
IGhhcyBiZWVuIGluaXRpYWxpc2VkIGFzIGFsbCB6ZXJvLiBUaGlzIG1lYW5zIHRoZQ0KPiA+ID4g
PiA+ID4gY2hlY2sgZm9yIHZhcmlhbnQgY29kZSB3aWxsIGFsd2F5cyBkZWZhdWx0IHRvIHVzaW5n
IHRoZSBCQiB0YWJsZXMNCj4gPiA+ID4gPiA+IGFuZCB3aWxsIG5ldmVyIHNlbGVjdCBBRC4gVGhl
IHZhcmlhbnQgY29kZSBpcyBzdWJzZXF1ZW50bHkgc2V0DQo+ID4gPiA+ID4gPiBieSBkZXZpY2Vf
aW5pdCgpIGFuZCBsYXRlciB1c2VkIGJ5IHRoZSBSVEMgc28gcmVhbGx5IGl0J3MgYSBsaXR0bGUN
Cj4gPiA+ID4gPiA+IGZvcnR1bmF0ZSB0aGlzIG1pc21hdGNoIHdvcmtzLg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IFRoaXMgdXBkYXRlIGNyZWF0ZXMgYW4gaW5pdGlhbCB0ZW1wb3JhcnkgcmVn
bWFwIGluc3RhbnRpYXRpb24gdG8NCj4gPiA+ID4gPiA+IHNpbXBseSByZWFkIHRoZSBjaGlwIGFu
ZCB2YXJpYW50L3JldmlzaW9uIGluZm9ybWF0aW9uIChjb21tb24gdG8NCj4gPiA+ID4gPiA+IGFs
bCByZXZpc2lvbnMpIHNvIHRoYXQgaXQgY2FuIHN1YnNlcXVlbnRseSBjb3JyZWN0bHkgY2hvb3Nl
IHRoZQ0KPiA+ID4gPiA+ID4gcHJvcGVyIHJlZ21hcCB0YWJsZXMgZm9yIHJlYWwgaW5pdGlhbGlz
YXRpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJSVVDLCB5b3UgaGF2ZSBhIGRlcGVuZGVuY3kg
aXNzdWUgd2hlcmVieSB0aGUgZGV2aWNlIHR5cGUgaXMgcmVxdWlyZWQNCj4gPiA+ID4gPiBiZWZv
cmUgeW91IGNhbiBzZWxlY3QgdGhlIGNvcnJlY3QgUmVnbWFwIGNvbmZpZ3VyYXRpb24uICBJcyB0
aGF0DQo+ID4gPiA+ID4gY29ycmVjdD8NCj4gPiA+ID4NCj4gPiA+ID4gWWVwLCBzcG90IG9uLg0K
PiA+ID4gPg0KPiA+ID4gPiA+IElmIHNvLCB1c2luZyBSZWdtYXAgZm9yIHRoZSBpbml0aWFsIHJl
Z2lzdGVyIHJlYWRzIHNvdW5kcyBsaWtlDQo+ID4gPiA+ID4gb3Zlci1raWxsLiAgV2hhdCdzIHN0
b3BwaW5nIHlvdSBzaW1wbHkgdXNpbmcgcmF3IHJlYWRzIGJlZm9yZSB0aGUNCj4gPiA+ID4gPiBS
ZWdtYXAgaXMgaW5zdGFudGlhdGVkPw0KPiA+ID4gPg0KPiA+ID4gPiBBY3R1YWxseSBub3RoaW5n
IGFuZCBJIGRpZCBjb25zaWRlciB0aGlzIGF0IHRoZSBzdGFydC4gTmljZSB0aGluZyB3aXRoIHJl
Z21hcA0KPiA+ID4gPiBpcyBpdCdzIGFsbCB0aWRpbHkgY29udGFpbmVkIGFuZCBwcm92aWRlcyB0
aGUgcGFnZSBzd2FwcGluZyBtZWNoYW5pc20gdG8NCj4gYWNjZXNzDQo+ID4gPiA+IGhpZ2hlciBw
YWdlIHJlZ2lzdGVycyBsaWtlIHRoZSB2YXJpYW50IGluZm9ybWF0aW9uLiBHaXZlbiB0aGlzIGlz
IG9ubHkgb25jZSBhdA0KPiA+ID4gPiBwcm9iZSB0aW1lIGl0IGZlbHQgbGlrZSB0aGlzIHdhcyBh
IHJlYXNvbmFibGUgc29sdXRpb24uIEhvd2V2ZXIgaWYgeW91J3JlIG5vdA0KPiA+ID4gPiBrZWVu
IEkgY2FuIHVwZGF0ZSB0byB1c2UgcmF3IGFjY2VzcyBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+IEl0
IHdvdWxkIGJlIG5pY2UgdG8gY29tcGFyZSB0aGUgMiBzb2x1dGlvbnMgc2lkZSBieSBzaWRlLiAg
SSBjYW4ndCBzZWUNCj4gPiA+IHRoZSByYXcgcmVhZHMgb2YgYSBmZXcgZGV2aWNlLUlEIHJlZ2lz
dGVycyBiZWluZyBhbnl3aGVyZSBuZWFyIDE3MA0KPiA+ID4gbGluZXMgdGhvdWdoLg0KPiA+DQo+
ID4gVG8gYmUgZmFpciB0aGUgcmVnbWFwIHNwZWNpZmljIGFkZGl0aW9ucyBmb3IgdGhlIHRlbXBv
cmFyeSByZWdpc3RlciBhY2Nlc3MsIGFyZQ0KPiA+IG1heWJlIDUwIC0gNjAgbGluZXMuIFRoZSBy
ZXN0IGlzIHRvIGRvIHdpdGggaGFuZGxpbmcgdGhlIHJlc3VsdCB3aGljaCB5b3UnbGwNCj4gPiBu
ZWVkIGFueXdheSB0byBzZWxlY3QgdGhlIGNvcnJlY3QgcmVnaXN0ZXIgbWFwLiBJIHJlY2tvbiB0
byBwcm92aWRlIHJhdyByZWFkDQo+IGFuZA0KPiA+IHdyaXRlIGFjY2VzcyB3ZSdyZSBnb2luZyB0
byBwcm9iYWJseSBiZSBzaW1pbGFyIG9yIG1vcmUgYXMgd2UnbGwgbmVlZCB0byB3cml0ZQ0KPiA+
IHRoZSBwYWdlIHJlZ2lzdGVyIHRoZW4gcmVhZCBmcm9tIHRoZSByZWxldmFudCBJRCByZWdpc3Rl
cnMuIFVzaW5nIHRoaXMgYW4NCj4gPiBleGFtcGxlIGZvciB0aGUgbGluZXMgY291bnQ6DQo+ID4N
Cj4gPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZl
cnMvbWZkL3RwczY1MDd4LmMjTDM3DQo+IA0KPiBBaCwgdGhleSBhcmUgSTJDIHRyYW5zYWN0aW9u
cz8gIE5vdCB0aGUgbmljZSByZWFkbCgpcyBJIGhhZCBpbiBtaW5kLg0KDQpZZXMsIEkyQyByZWdp
c3RlciBhY2Nlc3Mgc28gbmVlZHMgbW9yZSB3b3JrLg0KDQo+IA0KPiA+IEkgY2FuIGtub2NrIHNv
bWV0aGluZyB0b2dldGhlciB0aG91Z2gganVzdCB0byBzZWUgd2hhdCBpdCBsb29rcyBsaWtlLg0K
PiANCj4gV2VsbCwgSSdkIGFwcHJlY2lhdGVkIHRoYXQsIHRoYW5rcy4NCg0KTm8gcHJvYmxlbSwg
SSdsbCB0cnkgYW5kIGdldCBzb21ldGhpbmcgYmFjayBzb29uLg0K
