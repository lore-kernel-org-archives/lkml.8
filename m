Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE874C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A328206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YLSPhcwv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uX1MQbk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgESGqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:46:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43794 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbgESGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:46:24 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0DD8A4024E;
        Tue, 19 May 2020 06:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589870783; bh=86ZI/JfYrMDwwbsz7m1Hnzciap/Y/ikqTATRmmQXXv4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YLSPhcwv7CmUgoHPY65Nej7kMbZ8JB33fBLYyBGJTkSyu6ogZQ5akLzu0N6ZQTJsl
         y93EOAVuOrlNeGGkgSu3gT5QBcQS7oWmM6ST06Y4ac6FoXJjqYqaesWMX505FKvcpQ
         t3RyeCjJ6PSvr9UUJSBehtT7qktHN5fGvPcJgjN1RNOQsOgZwyZxlJ7PgoVgSkVz0A
         BEVHwck5owsfC+yV/UKUJUKFKKlsislTNbQU1vXp3F10WjyxpxYAsC72xfC7QK2GYs
         nTgBwX87HOUdrr4+DZdwsNi712oEWoPtoRrkbcVSb71QamUF0fDdu8494FINR0+0Mv
         ezXQ/qTlsoTsA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C6839A0079;
        Tue, 19 May 2020 06:46:20 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 May 2020 23:46:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 18 May 2020 23:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8628dgwl9caeLnWrVDz68NM4sBLLhTsFz1nN3MF89PBSqTHVQeDPW7YZpKKxn82eYtieoWNa7vXe7cmWFQGB/lrIDQozzSXXD0VNH7lOrMwJa9fdGOqTeWvjSOTnnVTlOtinNj85MTd/Vx8BPttqodSMiAEnmNPi9eUnaQsrFzMANThYasnRenlBECc4JsXso9gkdQ/xb9l8FE77GIfrfGLae63C1pr47YQI/mKIifiA/iUwhkE2MbFJrh+mavrAMphkyufYmqbMnXCV9XKm7dn/l1nXJkx4tTqsGXXgObhbrF4dtP8m8KNOdDG+SP3VW1J/XYMJUM7EOeC4HgshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86ZI/JfYrMDwwbsz7m1Hnzciap/Y/ikqTATRmmQXXv4=;
 b=MZ23Ueb0+m5dLBN1Ib50qJbllGnhqfrimStRIGmuFc5rwRmyu/6ytReLXp+v3Pqc6FsF426s4sJfod7JblNHquac5K1L+Y8xgb4DHvvqy/R2ElysxMnSR8ZYcejRYhVVFAnDzJUocM47qppzcVlo2CotMPq6Z0qRIXREkDmZnvM5iw1FU+LItAsl+HX/It1/XW+k8bdsi47EtOE96zBKvADtgbokyohEomlF1DkcxODEqaTK1ZyYMSp4yfejCNpJrfUD/zze4Sm7aK9+K7327/psWk8s/F0IyND9aPrMjDONiybwFxEqKcbkGgZ4Zay1QDBsvfkQg2wDZ6/XPNuA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86ZI/JfYrMDwwbsz7m1Hnzciap/Y/ikqTATRmmQXXv4=;
 b=uX1MQbk9YqgyTc0d6llNiYozRcEr+40D6zfv+7TAYaXoXCJca8YiRuE2gjvp4sB7mYBIKKz+tBqQczqLlZmyMEXlki5WureWkvMvwLDEByR/hlH3waWBfbGyLV7ys4/TuiPCcudotQdEWj+L5kIlxSRQWEBZG4j6iXgidk7GOko=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYASPR01MB0020.namprd12.prod.outlook.com (2603:10b6:a03:72::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 06:46:17 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 06:46:17 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jun Li <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Jun Li <lijun.kernel@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHVjdstgzFrMkrXvkaRRkMvFUhS+Kio62yAgAAEAECAAiXGgIAAcduAgAAjyICAACvNgIAEFssAgABEXACAAATjAA==
Date:   Tue, 19 May 2020 06:46:17 +0000
Message-ID: <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
 <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <87d074xfbq.fsf@kernel.org>
 <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
In-Reply-To: <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b27ba465-5b79-4aae-107c-08d7fbc054f9
x-ms-traffictypediagnostic: BYASPR01MB0020:
x-microsoft-antispam-prvs: <BYASPR01MB002057583531CEB64F58D116AAB90@BYASPR01MB0020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62k0g6QVWQtIBCrx7l1n8QkPiXn3wtMyXOkPlqGbOKj0W34rRBzFTuXmOyLuuNpCOgKViZ9awy84/LU6SJgNKkGiaDQ0zDdYkk74crd5JDXEh61VHdpd+RhA38Wi3nwsMcjrNnfkDvt6A9HrqdRb+MAeaG9jeKdzZ1F09g8cQii+0JPcV0yr4R7JXphUK+u/z/R+q6JCalPokHQysMCt8RjxrJ+piDTw1GeK3YZpkQgx/QIecSTjMRa55WNC+UK3xCZ2lbQyBtZ6t+oQRe+B1AmbNerwAQdb6iovHEEmteaiaKVj6LzAeSUEmyvsFHc0NWQi4PRtZtUxTC6ez5DC5HODh2+cUOn9kwWHOPL8l8Blk6eonSLont/X7TwgsoQMxngujgz27QC7ii5EhOcDFYPk1cObPlT+GX3Xefy5+Gd1M6x0+A+SboGCB7MpMyHypL1+e4ghs+n0hKHrwLUuyJElVD/hj9LZdd3B5JAhUR2M2Ak1S7rtACmHAIWxINA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(7416002)(5660300002)(4326008)(86362001)(31696002)(316002)(6486002)(8936002)(54906003)(110136005)(31686004)(186003)(26005)(8676002)(6512007)(6506007)(53546011)(36756003)(2616005)(71200400001)(2906002)(66476007)(66556008)(76116006)(66946007)(64756008)(66446008)(478600001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jG4zf2XZ4rgImuBdfaTgiKImMIy19mtq1OFf/Im5XdJQvHcm47sR7E6Zfhk/178aeVLqGfYwNgB8wF/3KywYgGv0YLFtxpB2y/i8COfxxuFdbWbGVD0vRWV5esfEjJPMRtKPYWlQ99vej6TSy9gfjMpPNbVFUHfaKehEa/iO2tmTeT3fITeBQkDYJbU6eh85tndiXoRtOLJj60oxten/8eGLhtF5t1uBurz1vIsOj5fga5Xs7C3B90dO/Jw6WB6vKNBcAWcwVl4mL1KCryqXU6nuBKppIQ/qd/+HPbOVHaBcaQDRiN2I1AP2z2zfgvB80GPLjj3/DZ3kxBJCIyMVPBOtwnx3fhC52JHAm5h4o9p7t6Y9Rui5hgZKWfhhOqQFLj4TdCJ0Iql3yRvOZgMylqZt24M01J8k9lzZrvzMpHYBGA45RNx+xTdwl/WdIFE8uJBN/yUo9FFn1DAnnNrbzXchWbqHZmOLHWVpeA2cqBDAf1m/IK+8Yf0UNrdAEiJI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <212EED2CC5554040B81BFFB45E645E22@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b27ba465-5b79-4aae-107c-08d7fbc054f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 06:46:17.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Menjtl+wwz508Q15U1E3EOFGOX/9NU/ZycsUtyiJwmrx2kKdUDRZwPXigN1+kg5DaQfqXIyhSQPaXQZksANlbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0020
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBKdW4gTGkgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpZkBnbWFpbC5jb20+IE9u
IEJlaGFsZiBPZiBGZWxpcGUgQmFsYmkNCj4+PiBTZW50OiAyMDIwxOo11MIxNsjVIDE5OjU3DQo+
Pj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+OyBKdW4gTGkNCj4+PiA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4NCj4+
PiBDYzogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+OyBsa21sIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUNCj4+PiBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29t
PjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJvYg0K
Pj4+IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRs
YW5kQGFybS5jb20+OyBTaHVGYW4gTGVlDQo+Pj4gPHNodWZhbl9sZWVAcmljaHRlay5jb20+OyBI
ZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+Ow0KPj4+IFN1
enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+OyBDaHVuZmVuZyBZdW4NCj4+
PiA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4+PiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNv
bT47IFZhbGVudGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+Ow0KPj4+
IEphY2sgUGhhbSA8amFja3BAY29kZWF1cm9yYS5vcmc+OyBMaW51eCBVU0IgTGlzdCA8bGludXgt
dXNiQHZnZXIua2VybmVsLm9yZz47IG9wZW4NCj4+PiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZM
QVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+
Ow0KPj4+IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT47IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4+PiBTdWJqZWN0OiBSRTogW1BBVENIIHY0IDMvOV0g
dXNiOiBkd2MzOiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3QgY2xlYXJlZCBieSBkZXZpY2UN
Cj4+PiBjb250cm9sbGVyDQo+Pj4NCj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gSnVuIExpIDxqdW4u
bGlAbnhwLmNvbT4gd3JpdGVzOg0KPj4+Pj4+PiBIaSBUaGluaCwgY291bGQgeW91IGNvbW1lbnQg
dGhpcz8NCj4+Pj4+PiBZb3Ugb25seSBuZWVkIHRvIHdha2UgdXAgdGhlIHVzYjIgcGh5IHdoZW4g
aXNzdWluZyB0aGUgY29tbWFuZA0KPj4+Pj4+IHdoaWxlIHJ1bm5pbmcgaW4gaGlnaHNwZWVkIG9y
IGJlbG93LiBJZiB5b3UncmUgcnVubmluZyBpbiBTUyBvcg0KPj4+Pj4+IGhpZ2hlciwgaW50ZXJu
YWxseSB0aGUgY29udHJvbGxlciBkb2VzIGl0IGZvciB5b3UgZm9yIHVzYjMgcGh5LiBJbg0KPj4+
Pj4+IEp1bidzIGNhc2UsIGl0IHNlZW1zIGxpa2UgaXQgdGFrZXMgbG9uZ2VyIGZvciBoaXMgcGh5
IHRvIHdha2UgdXAuDQo+Pj4+Pj4NCj4+Pj4+PiBJTU8sIGluIHRoaXMgY2FzZSwgSSB0aGluayBp
dCdzIGZpbmUgdG8gaW5jcmVhc2UgdGhlIGNvbW1hbmQgdGltZW91dC4NCj4+Pj4+IElzIHRoZXJl
IGFuIHVwcGVyIGxpbWl0IHRvIHRoaXM/IElzIDMyayBjbG9jayB0aGUgc2xvd2VzdCB0aGF0IGNh
biBiZQ0KPj4+Pj4gZmVkIHRvIHRoZSBQSFkgYXMgYSBzdXNwZW5kIGNsb2NrPw0KPj4+PiBZZXMs
IDMySyBjbG9jayBpcyB0aGUgc2xvd2VzdCwgUGVyIERXQzMgZG9jdW1lbnQgb24gUG93ZXIgRG93
biBTY2FsZQ0KPj4+PiAoYml0cyAzMToxOSBvZiBHQ1RMKToNCj4+Pj4NCj4+Pj4gIlBvd2VyIERv
d24gU2NhbGUgKFB3ckRuU2NhbGUpDQo+Pj4+IFRoZSBVU0IzIHN1c3BlbmRfY2xrIGlucHV0IHJl
cGxhY2VzIHBpcGUzX3J4X3BjbGsgYXMgYSBjbG9jayBzb3VyY2UgdG8NCj4+Pj4gYSBzbWFsbCBw
YXJ0IG9mIHRoZSBVU0IzIGNvbnRyb2xsZXIgdGhhdCBvcGVyYXRlcyB3aGVuIHRoZSBTUyBQSFkg
aXMNCj4+Pj4gaW4gaXRzIGxvd2VzdCBwb3dlciAoUDMpIHN0YXRlLCBhbmQgdGhlcmVmb3JlIGRv
ZXMgbm90IHByb3ZpZGUgYSBjbG9jay4NCj4+Pj4gVGhlIFBvd2VyIERvd24gU2NhbGUgZmllbGQg
c3BlY2lmaWVzIGhvdyBtYW55IHN1c3BlbmRfY2xrIHBlcmlvZHMgZml0DQo+Pj4+IGludG8gYSAx
NiBrSHogY2xvY2sgcGVyaW9kLiBXaGVuIHBlcmZvcm1pbmcgdGhlIGRpdmlzaW9uLCByb3VuZCB1
cCB0aGUNCj4+Pj4gcmVtYWluZGVyLg0KPj4+PiBGb3IgZXhhbXBsZSwgd2hlbiB1c2luZyBhbiA4
LWJpdC8xNi1iaXQvMzItYml0IFBIWSBhbmQgMjUtTUh6IFN1c3BlbmQNCj4+Pj4gY2xvY2ssIFBv
d2VyIERvd24gU2NhbGUgPSAyNTAwMCBrSHovMTYga0h6ID0gMTMnZDE1NjMgKHJvdW5kZXIgdXAp
DQo+Pj4+IE5vdGU6DQo+Pj4+IC0gTWluaW11bSBTdXNwZW5kIGNsb2NrIGZyZXF1ZW5jeSBpcyAz
MiBrSHoNCj4+Pj4gLSBNYXhpbXVtIFN1c3BlbmQgY2xvY2sgZnJlcXVlbmN5IGlzIDEyNSBNSHoi
DQo+Pj4gQ29vbCwgbm93IGRvIHdlIGhhdmUgYW4gdXBwZXIgYm91bmQgZm9yIGhvdyBtYW55IGNs
b2NrIGN5Y2xlcyBpdCB0YWtlcyB0byB3YWtlIHVwDQo+Pj4gdGhlIFBIWT8NCj4+IE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhpcyBlcCBjb21tYW5kIGRvZXMgbm90IHdha2UgdXAgdGhlIFNTIFBIWSwN
Cj4+IHRoZSBTUyBQSFkgc3RpbGwgc3RheXMgYXQgUDMgd2hlbiBleGVjdXRlIHRoaXMgZXAgY29t
bWFuZC4gVGhlIHRpbWUNCj4+IHJlcXVpcmVkIGhlcmUgaXMgdG8gd2FpdCBjb250cm9sbGVyIGNv
bXBsZXRlIHNvbWV0aGluZyBmb3IgdGhpcyBlcA0KPj4gY29tbWFuZCB3aXRoIDMySyBjbG9jay4N
Cj4gU29ycnkgSSBtYWRlIGEgbWlzdGFrZS4gWW91J3JlIHJpZ2h0LiBKdXN0IGNoZWNrZWQgd2l0
aCBvbmUgb2YgdGhlIFJUTA0KPiBlbmdpbmVlcnMsIGFuZCBpdCBkb2Vzbid0IG5lZWQgdG8gd2Fr
ZSB1cCB0aGUgcGh5LiBIb3dldmVyLCBpZiBpdCBpcyBlU1MNCj4gc3BlZWQsIGl0IG1heSB0YWtl
IGxvbmdlciB0aW1lIGFzIHRoZSBjb21tYW5kIG1heSBiZSBjb21wbGV0aW5nIHdpdGggdGhlDQo+
IHN1c3BlbmQgY2xvY2suDQo+DQoNCldoYXQncyB0aGUgdmFsdWUgZm9yIEdDVExbNzo2XT8NCg0K
QlIsDQpUaGluaA0K
