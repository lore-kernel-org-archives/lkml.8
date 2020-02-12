Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA85C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D4420658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="IK9pxZec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBLRBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:01:11 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:47105 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgBLRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:01:10 -0500
Received: from [100.113.3.77] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 65/3D-54715-25F244E5; Wed, 12 Feb 2020 17:01:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTbUxbVRjm3Hvb3iFdDgXSQ6UCdV/gWlox7i7
  bzIyE1cR9yNwfnbgLvaM1/cC2ZIUlZnyoFGRsDNxoKGOzRNwoYHGTMaYGjKNEHGMQYQKRrGOA
  oigoyEZnb2839c/J87zP+z7nOSfnkLioSCAhGZuVMRtpvYwfTmhThKnyjJS0TGXJdUAN3ezGq
  ObiUoyqmfTxqd6eQpz6ayhAb3XW8akOv4dPrTycwqiJtimcGm9ZJai2JTfY+YS6baGIr77iGB
  eoGzx56o+7ZjC154Kdr673vqpu/XyYUC94ntpHvs7TGbNMtkM87cS9y7zcxihbqX2cOAZKosp
  AOAlgI44qHxQBjnxLILurGONIO0D3K/7ms4SAvThqWKwPKiJYhSHf7bkQGQdo4kFFgKwh+ZBC
  p3p/Co5Ew08BuuavDjrjsA9HV2vb8TJAklFwPzrZRLID0fA15D9djHHYhAbGFoKYgOvRWF0Hz
  mIhfBN5J77mcbu5eGjs+AcC1mcNfAmdc8exPQBK0WLhxWA/DsXotu9s0AdBiFxdN3AOx6CZO3
  4e188gb9EI4OqbUf8PvhBORF3fnwvNStHg2fJQfTfqW+gL4WS0cvV+qIdCrvL3CDYOguuQvzu
  fK+vR8PQAj8Mb0MgvpaEIcehibUvwKAi6CdR4vJA4AZSO/8R2BKxwmIRaO1O4ciKqLp8UOII3
  EYm8tT6iARAXAJVl1uVorQZap5erlEq5SpUqV8m3bFHQBXJaweTJsxmj1UwHRAV9xKKw5Buy9
  RqFkbF6QOAJat4BuzvATfdvim4QS2KyGOFsQlqmaG2WSZOvpS3at8x5esbSDeJIUoaEWfKAFm
  lmchjbYZ0+8JAfyYiMkEULD7Ky0JJLGyy6HE7qA1vJEzPO8zjZ7mwMrN+wq4gwmoyMRCwcZgc
  gO6DNMz62e/Q1BoFUEiUEYWFhoohcxmzQWf+vzwIxCWRRwhLWJUJntD7edTYQCAsEqkgKBrLS
  /0qSY9i+z1Kdp5Pmn7xSCXbGXnIb91eRvFWt4+EmDP6Ysp3fHb634M/1f4hXP/pK5mxR8Zol0
  S9MZZnemEkfrZ5/UdB/RvOzt2AOXRt6zjT74dzyweVs1UjzAf8zbunSnW1ltshdmwa+WEzY3P
  C7Y7UuQzDfceDd1qr4dTtG4s7YJjMlM7727Zobtl1NR7eOvp/cpah+pZYUJ9y6nLdBtG2ghFd
  jt/fugXcH6zw9lU0bpwWHv0x/marUxKc545cyNi6PP902fy/hSHKlpTPd3hYjkhqEPcqKX+fv
  To9Yvmsc9sDrz4fhO55dWUsl1nhOuuS2S/V+a6dyr/uo/9Dy2/2jhk/yY50ywqKlVcm42UL/A
  14sn0qVBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-233.messagelabs.com!1581526865!1083509!1
X-Originating-IP: [104.47.13.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9140 invoked from network); 12 Feb 2020 17:01:05 -0000
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.51)
  by server-6.tower-233.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 17:01:05 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auYkxJ4dhXxeKRbP8K/gga0OroGV5kAqkgIQOCLn/nplUw5B+9Z5LQY7yFBfVs/umdVU6iBZeR7inr5cZcSZz3R/qC0qMpX3qppmhUQwF4dJps78bikNbvK0Q40EZXfHU2HS5Rgfh23GaCqmBacsCKn3PTH1jTWoc5wt20O6x+lm3+fXYdbvH6T6tnt7oIvG8TjpoB7xO2nYkxZNjtMn0/z93405j4Mpa51AJ4cFOd9mglo2QQK1R2uBLEXJtQZGQ8BDPb5glPVINklFaMhbkedvJhFzEEdlu0yUoYoDbcGZHEWKRX2HxM1NLggJPWtybfnDWe8pljuqeDOrqf5/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhpGFwof2GNhCRRD26ntc9hHvmXKpz85pZfAR6EE2TY=;
 b=IlghsstShRM4h0i7Y4j/+N1COuZ+r3RT47rFTYIzxsuuTpvxyo2lRnUtt083AJoA7J6ZU/gbQfN7UPUHq73PEs2iJCPz6btx/JAGNSdWwfpAjct2XZS3mD/YFsgSc9Cf443ZiH+7G3VtJCTEi2+v1U7Vw2qy65Johlj5oJ2fge7wY95uNLUH7u/+L1YPcAoZY9enLmV0n4MRqfbNqO/gHRTngBrPffr8BcFbJaNch886I5YCs2U71ksZROKM6VWlyJvhBiZKPxdgk3UazDoIL4xmhJq0EmHdgOVKMmqPrdoLyjbNcPCPvZosYt2Ye9PAfczw3XfqhDK6oF1Rlfkv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhpGFwof2GNhCRRD26ntc9hHvmXKpz85pZfAR6EE2TY=;
 b=IK9pxZec0qltlqVcKAQlgkbYJ6c78DwDVqs8fXXa0lnmwwbe4hcwaMqnyFomBXEsVF3i9kUn3MwJLE01AzqK+ocCD4p6http3M9rN+8ZrHsu2YVXacaW8F8D2ERWWG/6f1bJmw0iRmB7P7j6Zbuea7bhYjtPN76ca3HQTJJHusc=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2952.EURPRD10.PROD.OUTLOOK.COM (10.255.122.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:01:03 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 17:01:03 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "cychiang@google.com" <cychiang@google.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
Thread-Topic: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
Thread-Index: AQHV3+t05QGFzNuez06VZ5VdF8K2kqgUfAmAgAFKeYCAAGrTgIAARPoAgAAJp4CAAAclgIAAAzgAgADQubCAAFzUAIAAEt9Q
Date:   Wed, 12 Feb 2020 17:01:03 +0000
Message-ID: <AM6PR10MB22636A4193260B94F17EB9FC801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
 <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
 <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
 <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <043c8384-6ce2-c78e-f52c-6a37a4bab3a0@linux.intel.com>
In-Reply-To: <043c8384-6ce2-c78e-f52c-6a37a4bab3a0@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4598d1e0-e647-4365-475c-08d7afdd24ab
x-ms-traffictypediagnostic: AM6PR10MB2952:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB295218A3A4F6B07319F111F6A71B0@AM6PR10MB2952.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(199004)(189003)(86362001)(186003)(7696005)(52536014)(26005)(66556008)(64756008)(66446008)(55016002)(33656002)(8936002)(2906002)(8676002)(4326008)(81156014)(81166006)(7416002)(71200400001)(478600001)(9686003)(55236004)(53546011)(6506007)(5660300002)(66476007)(110136005)(54906003)(76116006)(316002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2952;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4H933pgnTXGUvOLyVwxmuwDDvK/yw+AiwIwUN5XgnnDlv101OVNxG7B9/WlkyoQv4ciIZV5gVK/YA7BaxLsZ555qM/YIK8lWlcPw/lJQ3qOP7g1yN+SJN6wBo9cF0IQxIQbeK7Zpp+91rAM2AhMU6TdJJMAHMuuSr5PMNWWx48gOTkfPRTL+5Iv5oUBS79/cHv3zHazo/bM2z0SjgLlibvCx5d7xMtJpfRBuQad2bi0dym2TLi9ryBu5jScRrP+/NcpbOz60lww+jQtg26RbAFQ5G5WR4Oc+HYljauaIIhxCrDeuXt2tM4RivOGwWljjkESo1Ry4YykV3h/PR4nhGTiHGIlPl5oxESRtHAHcPp6vSTER5Ez/WMobYTU2wXdZBJ/j5gEaZIfgD9oVHnAAjT1TjmNPQLTE40bqwUuz6WfzgnRGZiMqTSKB/CA+Ww9+
x-ms-exchange-antispam-messagedata: VvVnlXU9e+ZaSI3Fkv/6y1Jc1DYZx8F+QgCoIBmBpRxNIApuUcReOn/68gNrzXCSyBo7wSY4v0dHGpZ61ev6iX7zw0ie5XROcXUDvXpXiYYbLCbITA+GUH1JCLSjeMZ3Q2JyXSNQlMwQKpYy7Hx5xw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598d1e0-e647-4365-475c-08d7afdd24ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 17:01:03.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aTMzBTjpFUAkcBu7VK13jgXRiQs2IC4buoqp2sGTPnZPe+YIt0+Bkx0X4lTH0Kr+8vCN5Skz3n4JtsMZERo1iRyxjpBBR6vpUfc83RHqPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIgRmVicnVhcnkgMjAyMCAxNTo0OCwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQoN
Cj4gPj4gVGhhbmtzIFJhbmphbmkuIFRoYXQgaW5mb3JtYXRpb24gY2xvc2VzIHRoZSBkb29yIG9u
IHRoZSBpZGVhIG9mIHBsYXlpbmcNCj4gPj4gd2l0aCB0aGUgdHJpZ2dlciBvcmRlciBzdWdnZXN0
ZWQgZWFybGllciBpbiB0aGUgdGhyZWFkLCBzbyBteSBndWVzcyBpcw0KPiA+PiB0aGF0IHdlIHJl
YWxseSBuZWVkIHRvIGV4cG9zZSB0aGUgTUNMSy9CQ0xLIHdpdGggdGhlIGNsayBBUEkgYW5kIHR1
cm4NCj4gPj4gdGhlbSBvbi9vZmYgZnJvbSB0aGUgbWFjaGluZSBkcml2ZXIgYXMgbmVlZGVkLiBJ
IGhvcGUgaXMgdGhhdCB3ZSBkb24ndA0KPiA+PiBuZWVkIHRoZSBGU1lOQyBhcyB3ZWxsLCB0aGF0
IHdvdWxkIGJlIHJhdGhlciBwYWluZnVsIHRvIGltcGxlbWVudC4NCj4gPg0KPiA+IEFtIG5vdCBn
b2luZyB0byBtYWtlIG15c2VsZiBwb3B1bGFyIGhlcmUuIEl0J3MgTUNMSyBhbmQgRlNZTkMgKG9y
IFdDTEsgYXMNCj4gaXQncw0KPiA+IHRlcm1lZCBmb3Igb3VyIGRldmljZSkgdGhhdCBpcyByZXF1
aXJlZCBmb3IgU1JNIHRvIGxvY2sgaW4gdGhlIFBMTC4NCj4gPg0KPiA+IFNvIGZhciBJJ3ZlIG5v
dCBmb3VuZCBhIHdheSBpbiB0aGUgY29kZWMgZHJpdmVyIHRvIGJlIGFibGUgdG8gZ2V0IGFyb3Vu
ZCB0aGlzLg0KPiA+IEkgc3BlbnQgYSB2ZXJ5IGxvbmcgdGltZSB3aXRoIFNhdGh5YSBpbiB0aGUg
ZWFybHkgZGF5cyAoQXBvbGxvIExha2UpIGxvb2tpbmcgYXQNCj4gPiBvcHRpb25zIGJ1dCBub3Ro
aW5nIHdvdWxkIGZpdCB3aGljaCBpcyB3aHkgSSBoYXZlIHRoZSBzb2x1dGlvbiB0aGF0J3MgaW4g
cGxhY2UNCj4gPiByaWdodCBub3cuIFdlIGNvdWxkIHByb2JhYmx5IHJlZHVjZSB0aGUgbnVtYmVy
IG9mIHJlY2hlY2tzIGJlZm9yZSB0aW1lb3V0IGluDQo+IHRoZQ0KPiA+IGRyaXZlciBidXQgdGhh
dCdzIHJlYWxseSBqdXN0IHBhcGVyaW5nIG92ZXIgdGhlIGNyYWNrIGFuZCB0aGVyZSdzIHN0aWxs
IHRoZQ0KPiA+IHBvc3NpYmlsaXR5IG9mIG5vaXNlIGxhdGVyIHdoZW4gU1JNIGZpbmFsbHkgZG9l
cyBsb2NrLg0KPiANCj4gU29ycnksIHlvdSBsb3N0IG1lIGF0ICJ0aGUgc29sdXRpb24gdGhhdCdz
IGluIHBsYWNlIHJpZ2h0IG5vdyIuIFRoZXJlIGlzDQo+IG5vdGhpbmcgaW4gdGhlIGJ4dF9kYTcy
MTlfbWF4OTgzNTdhLmMgY29kZSB0aGF0IGRlYWxzIHdpdGggY2xvY2tzIG9yDQo+IGRlZmluZXMg
YSB0cmlnZ2VyIG9yZGVyPw0KDQpJIG1lYW50IHNvbHV0aW9uIGluIHRoZSBjb250ZXh0IG9mIHRo
ZSBjb2RlYyBkcml2ZXIuIFRoZSBhcHByb2FjaCBvcg0KZXhwZWN0YXRpb24gKG1heWJlIG1vcmUg
c3VpdGFibGUgd29yZGluZykgZm9yIHRoZSBkcml2ZXIgaXMgdGhhdCB0aGUgcmVxdWlyZWQNCmNs
b2NraW5nIGNhbiBiZSBlbmFibGVkIHByaW9yIHRvIHRoZSBEQUkgd2lkZ2V0IGZvciB0aGUgY29k
ZWMgYmVpbmcgcG93ZXJlZCB2aWENCkRBUE0gYXMgcGFydCBvZiBhbiBhdWRpbyBwYXRoLiBUaGlz
IGFwcHJvYWNoIGhhcyBiZWVuIHRoZXJlIHNpbmNlIHRoZSBiZWdpbm5pbmcsDQpmb3Igd2FudCBv
ZiBhIGJldHRlciBvcHRpb24sIGFuZCBJJ3ZlIGFsd2F5cyBoaWdobGlnaHRlZCB0aGlzIG5lZWQg
d2hlbg0KcGxhdGZvcm1zIGFyZSB1c2luZyBvdXIgZGV2aWNlIHdpdGggU1JNLg0KDQpZb3UncmUg
cmlnaHQgdGhvdWdoIHRoYXQgdGhpcyBpc24ndCB0YWtlbiBjYXJlIG9mIGluIGV4aXN0aW5nIG1h
aW5saW5lIExpbnV4DQptYWNoaW5lIGZpbGVzIHRoYXQgdXNlIHRoaXMgZGV2aWNlIHdpdGggU1JN
Lg0K
