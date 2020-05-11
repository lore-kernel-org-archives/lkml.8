Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F5C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B6520720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YB259rZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgEKOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:19:39 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:38018
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgEKOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAOc/rnGD6RT2NpZMSOnun2LyZWRKNXxeCqDjgaTlw2vpLoyXXqdqocHeGyoITbPQOJqnL9/K7bvPyRf15TDcIGzkojrwAF9zvHvVSnATXYdRpsIZ1/cZZiA/1KBOaNgPorRR512aZwa7fWauLMkAyTKBqfWKqfW2rEoY4fhqlofDk/op05x5uQSsxYyY4zLxrib7prtxym8qbVLHTy4iwMBW9iOQdupBy7hdgFQkB0ZNqGEeuWAUEt1APbC4/6ijkeibhjQXhnMyrv+Cdxp/jeaL8g4rpxbpNlz72SJWcP9r0KUUJTG021El3Bc5azU6NiA52aCE/2NBPcNAQNifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUkTUCcExqaKJA4Rj2+JEMQ9cc7Gp1JpAhT6Eg2RVtA=;
 b=mNHXmFYxkucE3ivzVN7eqeyss4d3Ko9HMe3N/U3QsjzOAoTsNkDWrs0dZHqBh9nndFVf7mPgIdWqN1PD75TQm7UYK97sXhy0P45bF/yKU40C6nHRW2WZSeaXJbzID8Ap/Sry0EmlL/c54tl5mNGR4NEgoy/5mSME1p6bx0RRY0/SQ+xhpgZEmX2dS8xoMZBRzXvVtVtPZznzRVnRU88iQG3IACjgi4UgENrGsus/tJ/hQQOc3A2KrCxDqqli5JRdzAe12pH62XdOfcV9T1l8ye2fMn/t/1yl0Fqskn+dBrwjgmcPOd/cX4YQlZvOGH9zGYTtO2Rpzn8ENLCi2iUFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUkTUCcExqaKJA4Rj2+JEMQ9cc7Gp1JpAhT6Eg2RVtA=;
 b=YB259rZYNpcetv1AexuI1YJ3cmdXlXYOEugHxLkNu+wdAIwbJ5RJY5tEiGhr23jvKo+gaichGVBGsaRcMfrSTcsqzblYD+0/oSjIQiDFeizdysDVmGWr7pXRn6EjDXpxNxJTyeOYZyCOvjtqLesm7WjCFUftuAALJdZ/87XhZEs=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4294.eurprd04.prod.outlook.com (2603:10a6:209:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 14:19:34 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 14:19:34 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: reset: Convert i.MX7 reset to json-schema
Thread-Topic: [PATCH V2] dt-bindings: reset: Convert i.MX7 reset to
 json-schema
Thread-Index: AQHWJ4yy+z4Jpw7g40y+P/D//QH5jaii7ugQ
Date:   Mon, 11 May 2020 14:19:34 +0000
Message-ID: <AM6PR04MB4966123682B6883E41BA6CC780A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589198262-21372-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589198262-21372-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8042e9e-ee49-4c55-c1b0-08d7f5b65450
x-ms-traffictypediagnostic: AM6PR04MB4294:|AM6PR04MB4294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB42944FA4A7B408AC2905306880A10@AM6PR04MB4294.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXNkEe1CYHoyr0td7kWKhJa9k7b9mHbElhnFegVI2mceEDqBxwxpDSUyvaQhqVO49uWqe2mnUBxHIBnx1bP4zmTvRwoyvyliYeWBH8hf25OQ6vpz3Y6vNhhR3n2LFdvLlH7tfYPKhlqh1b6XOxgNaQx+n3KfltevCBY9YcjWLDBKPVJlAYce8bRVCKoDSzSTMKIDMQLIjNbnso58txtu/eS2FsZBR5QDpLimAjJGuhp7Ifd7uyrG8Q//y3wU5cWv7sS3w+hEB56IELGEyvqPbTAoQuTGfbAOZriZ4vyp3L9i/LikaHM3wnrdZZ9uuNFu9U6dhBw9nSq5rW6ptwCCfqsVgksiT4nm+l9GAnkXAeX2FwiWclUqGNp6iKpOFAA1jsgCsCEQAbN3SiUqZqXqOupvXYieUoZsfbrBFq1LyIWZumFYUtOxZfz45LEuGt42RXs2ChRz7pgW5CqINyVJA0qHbedqEdBH49949gQLhBNnU6UqCSJJpPIMZHc52zTIbA8Hk27pN6RpBH1hC43OaG2sHd+7Ou/BKKdprftjDKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(33430700001)(26005)(7416002)(478600001)(8936002)(6506007)(186003)(7696005)(8676002)(5660300002)(71200400001)(316002)(64756008)(66476007)(66556008)(110136005)(33440700001)(66946007)(66446008)(9686003)(558084003)(33656002)(4326008)(86362001)(55016002)(44832011)(2906002)(52536014)(76116006)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4NYtl0wjx4wfwL9wyPe4xM3b0mhvVw/MoE3BdXtkF6yW+miSjg/T3ec3UOUuSYkBefi08Oakvh1CL8sjVBKfFeZJDyc5HkhhZM4l5uv5siy7AejqPhvKTYqKgI9yFa/WA8qN6rnuRDqXB4Va6c5L+ne46zBI27/q2Dc0ThdZijHUJTzWAX5xaoIaYM4erolqZGztFIrsn2TCxoujUIREhMwmr7srSMlM/khJo+6kptXxktHIJI/B/8qpl0VoBh88xGngErftLOXgXHITvaYtTMuUEr8QGEvDB4n4wYDv7Hnt1rcdedQZysZhQX28aPrXbUQZr/jwlTy3ULtVDXEebnYuYy/Zh4TG2iYI6nwnAI1dZsPNnJEdsEysjO+xwnFylO1ULo1A7NQDu2ICj4w39VhxPCrRyIsEi52HneUW1lib23ChjoJSI1lxFXgUuQtcFstVoE1Dg5JVQQ6J2CM3CE+nKypkUNVAYEp1aghmAYToN/HDIRLvsfpQUB54wo/o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8042e9e-ee49-4c55-c1b0-08d7f5b65450
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 14:19:34.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6faGv/7QGxyuAeRbh3zfDU+XvtPDASFxd/hV4Yvy7WCdhdg3o/cBjmYrbD8rY606A7ASLgnB5rYGrDgxe7VJnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTEsIDIwMjAgNzo1OCBQTQ0KPiANCj4gQ29udmVydCB0aGUgaS5NWDcgcmVzZXQgYmlu
ZGluZyB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5
OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5n
DQo=
