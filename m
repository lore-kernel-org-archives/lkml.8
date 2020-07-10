Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF503C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0A42078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="g5BJSzZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJIMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:12:50 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:40215
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgGJIMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpaFD+8lfoAP1xGuN+Kk5b85vcM85fZ9wSHtb+AsJbDKp0NZQGe/fSfBmFYzaQ/fAvxLBDO9KmYwruuJQW7frVShyJ0kayPV5wuvmQGHjK+hj81M6sf9Ueom6Af6KU6599MTE2NCfkzX4UmwtERspQ/OUUMwGUHdMUfzOnzBPFyC92AWJZf7w4l7OhZfymgm2OhOvJ/kllitKcAiIg9FZy5JJNiIq12b8qY7tALTmDg086BaU0tdHRW972V+3kN3SWFIP3johDY8yNivxUkqzXmYz6WdqI0MRHCWNJqB0sBdnj3TvBY2SsCaXVjvozHeJUWZ0JdTwk0n26XRmJnxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKE1NozSs1KEqGB/SDdve87RQ7b5MtU6tIUxOBRy/8U=;
 b=BBb50dINsXYfJ/rXNUzMQC0AVCV0mRGWcu5dNCQFTt9n7p0YKI3BIurqYlIwDxiR87A1HGJ6yPCToJnTw4arSFAG5KbvGksgf7oZwLUEAxW5W1TK/jkTeLiNVzB19fqUDdwpIn0wtwCdyNiOPNhF1h0HeGW19Fevj4TnjwPxMaRhCWDoouAnWHEHFLREMoCUnCoX3y94O2w3r4Jec/gSRPNmJcpuB/IYgL3VD2oLlYzXQxX3di3ZTRtlEtzcUyEaX7j2/0BXwQT7GfNJ2qh6CkSbOeVA56FU/GyoYkf9RLv7f1pCCd0AtjcvcZm7FNtk/SxHToyeotDot3EH+TEVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKE1NozSs1KEqGB/SDdve87RQ7b5MtU6tIUxOBRy/8U=;
 b=g5BJSzZ6JHVTS30FxdeN/0YwJGqndLzMoWjntFrkGX0RonOFPBiKbtgfvoS+DoVvJC5KepG2cH3SqVeozwTa9EEr3OiqiOVIhxQzRPSBFjEp+Ps8Hu0KlXEr1hRLaVbpjMoj0f24vFXTWd/HZpM1DdHJl4T0AjYhDKplZoer6X0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3111.namprd11.prod.outlook.com (2603:10b6:a03:90::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 08:12:43 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 08:12:43 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     syzbot <syzbot+c190f6858a04ea7fbc52@syzkaller.appspotmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        "pavel@denx.de" <pavel@denx.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: =?gb2312?B?u9i4tDogV0FSTklORyBpbiBzdWJtaXRfYXVkaW9fb3V0X3VyYi91c2Jfc3Vi?=
 =?gb2312?Q?mit=5Furb?=
Thread-Topic: WARNING in submit_audio_out_urb/usb_submit_urb
Thread-Index: AQHWVfW6rT2+FcWDuUOyXNqePQbkQqkAczUc
Date:   Fri, 10 Jul 2020 08:12:43 +0000
Message-ID: <BYAPR11MB263211A6842402F1EE47F6F8FF650@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <0000000000001ad77805aa024889@google.com>
In-Reply-To: <0000000000001ad77805aa024889@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df6c2b75-a1b6-4763-db22-08d824a90597
x-ms-traffictypediagnostic: BYAPR11MB3111:
x-microsoft-antispam-prvs: <BYAPR11MB31115BD7FC9A027705907E92FF650@BYAPR11MB3111.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USJMHE2k/sB9HSOe7sTcxRWKcudSjy/wo7yLFPHT29qnm3SZh5Snw0zWqvhSKV3k34JZEW/pVMAPCKcWluA1tnBKoCOm36eSXRr86NnvON4oboDueL7yfZieQNlRibEXfHVbXhIDe5v9YuculrvfoeqYIl0BAEVsLITjf9G0jkKU7B0w5lqmUb1uhohR4uf3ZjwUsiZZWD0tWkvz/t8fUy3tKfmhKQOV86X9P15l5zrXtOpuzMQWCbJTCHw7ahFlE7ygI/w1CNMjIpgJjP46l1fevMjzzxjYfNOxdaQg4WJLqS/RDWkUzPBqzn4u78iwzCWjtDBaED57MHbTzNuXQwMdLm+rQXrrthkbO7DksMNe4z1uLyQ5Yp/C48icn0QxCczHiDvrY4TVNy2F4S+myT4cM5LXX5bhhml4n3EOXecRB6nTLuM0mQ4xNcbtWjtXrHZ7fhiKbZib97bw1pjG5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(376002)(366004)(396003)(346002)(91956017)(64756008)(71200400001)(7416002)(66446008)(76116006)(66946007)(66556008)(66476007)(86362001)(54906003)(8936002)(52536014)(2906002)(26005)(224303003)(33656002)(316002)(6506007)(966005)(5660300002)(478600001)(83080400001)(7696005)(186003)(83380400001)(9686003)(55016002)(4326008)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UBjCAhEAR7N4QRAyM5x6mFZVoPKNQqrncvAA1lI9WjhM/TAqSUhrXtTfnvKLLu9IMmsrQHj0gXGQHLfeskFqGzLF9CIAcO8FClFuQPQxPhhZqwYRm+m68t0IOtPHENeFBqhxhRULCe3HUFRz8ZZppGaw3CrQItikFnqtuycLUuEz/l3TwbS8N2fpmEsBRFGNMtM6ThpDbKWNfi4grtFDzgBY7fqK/o7ZUEaahyQfTF07GRAJ4XQCdlA4N04pdVsaq22yv7z8eWrATR1s2k1/LM4oxUzjTOqtn8kKt/NzTBwQpetV5+ws5dPD11g9/S1YNKVErSs3iHeY0c4dQH5AzEJebnL6kLXPcO8s81LXK9cZeXrNBYLZcnEijThDPpLlTdaaXiWjC+uokIwCxuj4zmuxdy28tvgpSjHoET2lexH2NbX/JYaVb5P8TGuWUiMowKlzEoF188f+kUTYMYZv17v0LaAbeaoX6+IILWoFD6Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c2b75-a1b6-4763-db22-08d824a90597
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 08:12:43.3017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL/haaWv1+o0xTwhfMyc7HggmAUmHIxfiIUtSTsVvpnedpTruD24YSZQDY5+knb7JeVwou4q0tlbk5U6aVzG8eG2X775bu0htbcJgLDkjr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogbGludXgt
a2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLW93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gtPqx7SBzeXpib3QgPHN5emJvdCtjMTkwZjY4NThhMDRlYTdmYmM1MkBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tPgq3osvNyrG85DogMjAyMMTqN9TCOcjVIDIxOjM0CsrVvP7Iyzog
YW5kcmV5a252bEBnb29nbGUuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgaW5ncmFz
c2lhQGVwaWdlbmVzeXMuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11
c2JAdmdlci5rZXJuZWwub3JnOyBzeXprYWxsZXItYnVnc0Bnb29nbGVncm91cHMuY29tCtb3zOI6
IFdBUk5JTkcgaW4gc3VibWl0X2F1ZGlvX291dF91cmIvdXNiX3N1Ym1pdF91cmIKCkhlbGxvLAoK
c3l6Ym90IGZvdW5kIHRoZSBmb2xsb3dpbmcgY3Jhc2ggb246CgpIRUFEIGNvbW1pdDogICAgNzY4
YTA3NDEgdXNiOiBkd2MyOiBnYWRnZXQ6IFJlbW92ZSBhc3NpZ25lZCBidXQgbmV2ZXIgdXNlZC4u
CmdpdCB0cmVlOiAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9ncmVna2gvdXNiLmdpdCB1c2ItdGVzdGluZwpjb25zb2xlIG91dHB1dDogaHR0cHM6
Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTU2OGQxMWYxMDAwMDAKa2VybmVs
IGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTk5OWJl
NGViMjQ3OGZmYTUKZGFzaGJvYXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD1jMTkwZjY4NThhMDRlYTdmYmM1Mgpjb21waWxlcjogICAgICAgZ2NjIChHQ0Mp
IDEwLjEuMC1zeXogMjAyMDA1MDcKc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFw
cHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTIzYWEyZmIxMDAwMDAKCklNUE9SVEFOVDogaWYgeW91
IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRoZSBjb21taXQ6
ClJlcG9ydGVkLWJ5OiBzeXpib3QrYzE5MGY2ODU4YTA0ZWE3ZmJjNTJAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQoKdXNiIDEtMTogc2VuZCBmYWlsZWQgKGVycm9yIC0zMikKc25kX3VzYl90b25l
cG9ydCAxLTE6MC4wOiBMaW5lIDYgVG9uZVBvcnQgR1ggbm93IGF0dGFjaGVkCi0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQp1c2IgMS0xOiBCT0dVUyB1cmIgeGZlciwgcGlwZSAw
ICE9IHR5cGUgMwpXQVJOSU5HOiBDUFU6IDAgUElEOiAxMiBhdCBkcml2ZXJzL3VzYi9jb3JlL3Vy
Yi5jOjQ3OCB1c2Jfc3VibWl0X3VyYisweGExNy8weDEzZTAgZHJpdmVycy91c2IvY29yZS91cmIu
Yzo0NzgKS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IHBhbmljX29uX3dhcm4gc2V0IC4uLgpD
UFU6IDAgUElEOiAxMiBDb21tOiBrd29ya2VyLzA6MSBOb3QgdGFpbnRlZCA1LjguMC1yYzMtc3l6
a2FsbGVyICMwCkhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29v
Z2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2dsZSAwMS8wMS8yMDExCldvcmtxdWV1ZTogZXZl
bnRzIGxpbmU2X3N0YXJ0dXBfd29yawpDYWxsIFRyYWNlOgogX19kdW1wX3N0YWNrIGxpYi9kdW1w
X3N0YWNrLmM6NzcgW2lubGluZV0KIGR1bXBfc3RhY2srMHhmNi8weDE2ZSBsaWIvZHVtcF9zdGFj
ay5jOjExOAogcGFuaWMrMHgyYWEvMHg2ZTEga2VybmVsL3BhbmljLmM6MjMxCiBfX3dhcm4uY29s
ZCsweDIwLzB4NTAga2VybmVsL3BhbmljLmM6NjAwCiByZXBvcnRfYnVnKzB4MWJkLzB4MjEwIGxp
Yi9idWcuYzoxOTgKIGhhbmRsZV9idWcrMHg0MS8weDgwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5j
OjIzNQogZXhjX2ludmFsaWRfb3ArMHgxMy8weDQwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjI1
NQogYXNtX2V4Y19pbnZhbGlkX29wKzB4MTIvMHgyMCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRl
bnRyeS5oOjU2MwpSSVA6IDAwMTA6dXNiX3N1Ym1pdF91cmIrMHhhMTcvMHgxM2UwIGRyaXZlcnMv
dXNiL2NvcmUvdXJiLmM6NDc4CkNvZGU6IDg0IGU3IDA0IDAwIDAwIGU4IGE5IDEwIGNhIGZkIDRj
IDg5IGVmIGU4IDQxIDc5IDEyIGZmIDQxIDg5IGQ4IDQ0IDg5IGUxIDRjIDg5IGYyIDQ4IDg5IGM2
IDQ4IGM3IGM3IDgwIGEwIDVkIDg2IGU4IGRiIDc3IDllIGZkIDwwZj4gMGIgZTggODIgMTAgY2Eg
ZmQgMGYgYjYgNmMgMjQgMDggNDggYzcgYzYgZTAgYTEgNWQgODYgNDggODkgZWYKUlNQOiAwMDE4
OmZmZmY4ODgxZGEyMjdiMTAgRUZMQUdTOiAwMDAxMDA4NgpSQVg6IDAwMDAwMDAwMDAwMDAwMDAg
UkJYOiAwMDAwMDAwMDAwMDAwMDAzIFJDWDogMDAwMDAwMDAwMDAwMDAwMApSRFg6IGZmZmY4ODgx
ZGEyMTE5MDAgUlNJOiBmZmZmZmZmZjgxMjliNGUzIFJESTogZmZmZmVkMTAzYjQ0NGY1NApSQlA6
IDAwMDAwMDAwMDAwMDAwMzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogZmZmZjg4ODFkYjIx
ZmU4YgpSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMDA0IFIxMjogMDAw
MDAwMDAwMDAwMDAwMApSMTM6IGZmZmY4ODgxZDZlY2QwYTAgUjE0OiBmZmZmODg4MWQzZDhjNjkw
IFIxNTogZmZmZjg4ODFkNTRjNDAwMAogc3VibWl0X2F1ZGlvX291dF91cmIrMHg2ZDYvMHgxYTAw
IHNvdW5kL3VzYi9saW5lNi9wbGF5YmFjay5jOjI3MQogbGluZTZfc3VibWl0X2F1ZGlvX291dF9h
bGxfdXJicysweGM5LzB4MTIwIHNvdW5kL3VzYi9saW5lNi9wbGF5YmFjay5jOjI5MQogbGluZTZf
c3RyZWFtX3N0YXJ0KzB4MTg3LzB4MjMwIHNvdW5kL3VzYi9saW5lNi9wY20uYzoxOTUKIGxpbmU2
X3BjbV9hY3F1aXJlKzB4MTM3LzB4MjEwIHNvdW5kL3VzYi9saW5lNi9wY20uYzozMTgKIGxpbmU2
X3N0YXJ0dXBfd29yaysweDQyLzB4NTAgc291bmQvdXNiL2xpbmU2L2RyaXZlci5jOjczNAogcHJv
Y2Vzc19vbmVfd29yaysweDk0Yy8weDE1ZjAga2VybmVsL3dvcmtxdWV1ZS5jOjIyNjkKIHdvcmtl
cl90aHJlYWQrMHg2NGMvMHgxMTIwIGtlcm5lbC93b3JrcXVldWUuYzoyNDE1CiBrdGhyZWFkKzB4
MzkyLzB4NDcwIGtlcm5lbC9rdGhyZWFkLmM6MjkxCiByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMCBh
cmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI5MwoKIEl0J3MgbGlrZSBBbGFuIFN0ZXJuJ3MgcmVw
bHkgdG8gdGhlIGVtYWlsIHRpdGxlZCAiS0FTQU46IHVzZS1hZnRlci1mcmVlIFJlYWQgaW4gbGlu
ZTZfc3VibWl0X2F1ZGlvX2luX2FsbF91cmJzLiIgICBJdCdzIGFsc28gbGlrZSBhIHByb2JsZW0g
d2l0aCBhc3luY2hyb25vdXMgb3BlcmF0aW9ucy4gY2FuIHJlcGxhY2UgImNhbmNlbF9kZWxheWVk
X3dvcmsiIHdpdGgiIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYyIKaW4gImxpbmU2X2Rpc2Nvbm5l
Y3QiIGZ1bmOjvwoKWmhhbmcgUWlhbmcKCktlcm5lbCBPZmZzZXQ6IGRpc2FibGVkClJlYm9vdGlu
ZyBpbiA4NjQwMCBzZWNvbmRzLi4KCgotLS0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90
LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuClNlZSBodHRwczovL2dvby5nbC90cHNtRUogZm9yIG1v
cmUgaW5mb3JtYXRpb24gYWJvdXQgc3l6Ym90LgpzeXpib3QgZW5naW5lZXJzIGNhbiBiZSByZWFj
aGVkIGF0IHN5emthbGxlckBnb29nbGVncm91cHMuY29tLgoKc3l6Ym90IHdpbGwga2VlcCB0cmFj
ayBvZiB0aGlzIGJ1ZyByZXBvcnQuIFNlZToKaHR0cHM6Ly9nb28uZ2wvdHBzbUVKI3N0YXR1cyBm
b3IgaG93IHRvIGNvbW11bmljYXRlIHdpdGggc3l6Ym90LgpzeXpib3QgY2FuIHRlc3QgcGF0Y2hl
cyBmb3IgdGhpcyBidWcsIGZvciBkZXRhaWxzIHNlZToKaHR0cHM6Ly9nb28uZ2wvdHBzbUVKI3Rl
c3RpbmctcGF0Y2hlcwo=
