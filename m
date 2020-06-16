Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D54CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="luIax2dj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lMGdsSPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgFPNt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:49:26 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39276 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgFPNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:49:25 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 757C8C0B8A;
        Tue, 16 Jun 2020 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1592315364; bh=bQSK4cfAZLZjwBkEMrI0YN/F4fwmrQ0FJbBnIPvFiF4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=luIax2djIxeMu/Rn3i/Hswhj99ymLBOuSWW2oj9uu6X5F2d6lNSu3nRDwnTe0O8D+
         XSsaM5WTzcwiq5Vdpz6rsVCfXTo0yWgia42IY6XDVsG3BtGZoEdwLIElBKSIcZspCc
         O3DhOayp3hByqPW5Yaf5uHA57SUtzyJLJ/G2pbyC4S+BFK3LHPU/BSaGBXRm6kPZdW
         61c1BykuPlCBGl5vKPpguauhJuMH8dYk4JefHeh6fryPpb8lsjRiiTsbKMpfQouPQv
         1gaRzP72YCHLxidVw5Hytz7EVU6v7vfGvziPM6CKBfG++uzwgPRdJ2hymwnp/bwAIr
         ZbZw73dqqVRjA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D409BA00A0;
        Tue, 16 Jun 2020 13:49:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 585C34006D;
        Tue, 16 Jun 2020 13:49:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lMGdsSPj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxFSgHrgqyUEeFBBNLeIa5xGSW7HjXG2GZus49tS57U7ojbYggtJmuSjZ3GthyAM4tKZbY4xs/Ohy0arXy22CkL+d8JnSPa3aUmSUqH+ntzq9kHXN+fSDnvjZwwuJEPqE+/J54wLwrlB5wHZrKOqS6bcFtAiZfwrzjz9I60K3WAij4n1yYcjEDME1p7WT5CCSvEMyKN25ysHH044Ae7eo3DQG6xvWT0wM8Y9Selrdh5g75F9X7PHJjGcgep5Fqa8vV5ocq4MIPeq1Oii+yOPhYnZYPHSRRV4TEEhXo7mKS7YP4FTEFZJP9J0euaiuwwQyBPSN/T3iFnkt2EUVkK94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQSK4cfAZLZjwBkEMrI0YN/F4fwmrQ0FJbBnIPvFiF4=;
 b=hTrLiRMgZ817vNZUTjfjk2m4IJAUPUSmvgcgG8mo1eFK7yuUbF6TTHfN4GRl01SibkiR160SPDBQYzNFyR2wyw8m9N6sNkYY/p1F287yxOntfC9LsTvZD79Jb8IaD1K/5VV8LuL6RHLgRgKTcByZJ1z9mS23zPeQOaBTGuohkpfI5Ptf0T+kNBWPqR3Y8EDI5WrLSluVtJ/k723FUSzIB95bjaIz3VKSRwF8dqtOyMAJmW5CJJ7IYzNmX64DWieX+ei9/13CthQid+P6HlOxxdDXgZ7/nX6UroMacV1dBXpo6UzfeKRpRkDfz+5kfdBgfMTeDgNqlku7XUNDQIWUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQSK4cfAZLZjwBkEMrI0YN/F4fwmrQ0FJbBnIPvFiF4=;
 b=lMGdsSPjDverNNYP0GbzoL1yWud1q3AKUmf/GLx6uazUNhCJp2PyUaL50drQnDnnUcZsaagQTK9NTYarm72mR+HyZ43bPhl9r/4VemldhS+Y12+UOf/efN76SWyMsB1rljU9L+kDPf7DlWxKIWstWb1tt4H972HgKcx4/0IshmY=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1383.namprd12.prod.outlook.com (2603:10b6:903:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 13:49:20 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3088.029; Tue, 16 Jun
 2020 13:49:20 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: use well defined macros for power_down
Thread-Topic: [PATCH] usb: dwc2: use well defined macros for power_down
Thread-Index: AQHWQ7feUgY1eX/yvUWTxv++2MOm66jbQm2A
Date:   Tue, 16 Jun 2020 13:49:20 +0000
Message-ID: <5f719cb4-d5bd-c9be-3a81-62d0a413d22b@synopsys.com>
References: <20200616162617.38365cc8@xhacker.debian>
In-Reply-To: <20200616162617.38365cc8@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
authentication-results: synaptics.com; dkim=none (message not signed)
 header.d=none;synaptics.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.92.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b34bdf67-1748-4d9e-c985-08d811fc121c
x-ms-traffictypediagnostic: CY4PR12MB1383:
x-microsoft-antispam-prvs: <CY4PR12MB13833704040A3DF07921C0E4A79D0@CY4PR12MB1383.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOLTOxyaMrr3BjcNhjv8F2F/NfV85xFkwsfQ3Xk4QsjNnRvQFIJXb/uJsHe7AEY34KyvoX4E7TapYbXzHaf1cALpmSJtsjXaLXnKSqQA3F/i3QVUQ8uoXCIwHDibtYG+FJL7TDFKgMHbKAl3DRaL8EW9ixrdqngwv9pPYAqP48pPuWVXoiyRyFlUaVc2WS/8S3vKD7qUy3Xjdif6RUGjPVicR1/378asCwkOTOFrBddH1Z0W+5VrQqQ9ABZZNaQ6FovhmV6+AMlESXjw4QsVH+OxijLx9Jf5YlWbnuc3O6mvOvhK6T+RhEn+Ep43n1W0zQr1ALbp4ZVPvcNSPx5HDDURJXFIbZes5ie8iE5w9UWBCVoRmmXhmVuhdxl+rJx9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(71200400001)(86362001)(26005)(8936002)(76116006)(66556008)(316002)(6506007)(66476007)(66946007)(64756008)(91956017)(66446008)(186003)(110136005)(54906003)(8676002)(53546011)(6486002)(31696002)(478600001)(4326008)(36756003)(83380400001)(2906002)(31686004)(5660300002)(2616005)(6512007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SsQkN8AETbs6HLPINq4Wg1ka9Bs2KKK4g/jdnB3piZoNgwVui96IvL0wwMRs6Bvy6dMtI41M7CoE9DssBtCkQJ2jSB3HssqdJMjD3OCHiWOfvlEEWeFf8Q0V1U8cNRxg084qU2T85HhBEbLVau2kpzqPjK1QQWUkT6sGXE1holb7R9InWWVXUn2ZpqXK5PbK7ayp3m9emyELvP5zbBdHK0j3Q5duO5WpV67zYKrIab8xXkq7DEG6N93UvmL5LiGzWvZnIR/Iu8Ts6pH0ifPZejeUK2iHpoEdArhDG0ByI4LrOWDAE6gHUhtojnpAdL4rnsjSkyd6AKPqKjjjdGgE2XaVT6VHixExcgHFzHWN4PnfRHTtA7BYcYiCweLmsaFhvjhptsfvxEzbsp/WweV1HhUknF1Rxrdmv/0jrCWloywenyxgMlUdbdzQxyWlwyo+k1hODc5zR5Y/Z6ulMZaabytr93cEZkmhWMXuTnyQTw0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E670DF65CAFEA846A70A031C6C111E0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34bdf67-1748-4d9e-c985-08d811fc121c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:49:20.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZfJj03kDIFem7aTlnIS/OYdQHpHFVhhPMLy8xdTixLnEYzO160n+VxjHCpIPcZrgGkc8rY8mzt2qmgRbq57qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDYvMTYvMjAyMCAxMjoyNiBQTSwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4gVXNl
IHRoZSB3ZWxsIGRlZmluZWQgbWFjcm9zIHN1Y2ggYXMgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05P
TkUsDQo+IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9QQVJUSUFMIGFuZCBEV0MyX1BPV0VSX0RPV05f
UEFSQU1fSElCRVJOQVRJT04NCj4gdG8gbWFrZSBjb2RlIG1vcmUgcmVhZGFibGUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKaXNoZW5nIFpoYW5nIDxKaXNoZW5nLlpoYW5nQHN5bmFwdGljcy5jb20+
DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0K
PiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5jICAgIHwgIDQgKystLQ0KPiAgIGRyaXZl
cnMvdXNiL2R3YzIvcGFyYW1zLmMgfCAxMiArKysrKystLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCBi
OTBmODU4YWY5NjAuLmU5YWMyMTViOTY2MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
Mi9oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC0zNjI4LDcgKzM2
MjgsNyBAQCBzdGF0aWMgaW50IGR3YzJfaGNkX2h1Yl9jb250cm9sKHN0cnVjdCBkd2MyX2hzb3Rn
ICpoc290ZywgdTE2IHR5cGVyZXEsDQo+ICAgCQkJCSJTZXRQb3J0RmVhdHVyZSAtIFVTQl9QT1JU
X0ZFQVRfU1VTUEVORFxuIik7DQo+ICAgCQkJaWYgKHdpbmRleCAhPSBoc290Zy0+b3RnX3BvcnQp
DQo+ICAgCQkJCWdvdG8gZXJyb3I7DQo+IC0JCQlpZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3du
ID09IDIpDQo+ICsJCQlpZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duID09IERXQzJfUE9XRVJf
RE9XTl9QQVJBTV9ISUJFUk5BVElPTikNCj4gICAJCQkJZHdjMl9lbnRlcl9oaWJlcm5hdGlvbiho
c290ZywgMSk7DQo+ICAgCQkJZWxzZQ0KPiAgIAkJCQlkd2MyX3BvcnRfc3VzcGVuZChoc290Zywg
d2luZGV4KTsNCj4gQEAgLTM2NDYsNyArMzY0Niw3IEBAIHN0YXRpYyBpbnQgZHdjMl9oY2RfaHVi
X2NvbnRyb2woc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLCB1MTYgdHlwZXJlcSwNCj4gICAJCQli
cmVhazsNCj4gICANCj4gICAJCWNhc2UgVVNCX1BPUlRfRkVBVF9SRVNFVDoNCj4gLQkJCWlmICho
c290Zy0+cGFyYW1zLnBvd2VyX2Rvd24gPT0gMiAmJg0KPiArCQkJaWYgKGhzb3RnLT5wYXJhbXMu
cG93ZXJfZG93biA9PSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fSElCRVJOQVRJT04gJiYNCj4gICAJ
CQkgICAgaHNvdGctPmhpYmVybmF0ZWQpDQo+ICAgCQkJCWR3YzJfZXhpdF9oaWJlcm5hdGlvbiho
c290ZywgMCwgMSwgMSk7DQo+ICAgCQkJaHBydDAgPSBkd2MyX3JlYWRfaHBydDAoaHNvdGcpOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYyBiL2RyaXZlcnMvdXNiL2R3
YzIvcGFyYW1zLmMNCj4gaW5kZXggY2U3MzZkNjdjN2MzLi44ZjlkMDYxYzRkNWYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
Mi9wYXJhbXMuYw0KPiBAQCAtNjgsMTQgKzY4LDE0IEBAIHN0YXRpYyB2b2lkIGR3YzJfc2V0X2hp
c19wYXJhbXMoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAlwLT5haGJjZmcgPSBHQUhC
Q0ZHX0hCU1RMRU5fSU5DUjE2IDw8DQo+ICAgCQlHQUhCQ0ZHX0hCU1RMRU5fU0hJRlQ7DQo+ICAg
CXAtPmNoYW5nZV9zcGVlZF9xdWlyayA9IHRydWU7DQo+IC0JcC0+cG93ZXJfZG93biA9IGZhbHNl
Ow0KPiArCXAtPnBvd2VyX2Rvd24gPSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9ORTsNCj4gICB9
DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZHdjMl9zZXRfczNjNjQwMF9wYXJhbXMoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHsNCj4gICAJc3RydWN0IGR3YzJfY29yZV9wYXJhbXMgKnAg
PSAmaHNvdGctPnBhcmFtczsNCj4gICANCj4gLQlwLT5wb3dlcl9kb3duID0gMDsNCj4gKwlwLT5w
b3dlcl9kb3duID0gRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05PTkU7DQo+ICAgCXAtPnBoeV91dG1p
X3dpZHRoID0gODsNCj4gICB9DQo+ICAgDQo+IEBAIC04OSw3ICs4OSw3IEBAIHN0YXRpYyB2b2lk
IGR3YzJfc2V0X3JrX3BhcmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCXAtPmhv
c3RfcGVyaW9fdHhfZmlmb19zaXplID0gMjU2Ow0KPiAgIAlwLT5haGJjZmcgPSBHQUhCQ0ZHX0hC
U1RMRU5fSU5DUjE2IDw8DQo+ICAgCQlHQUhCQ0ZHX0hCU1RMRU5fU0hJRlQ7DQo+IC0JcC0+cG93
ZXJfZG93biA9IDA7DQo+ICsJcC0+cG93ZXJfZG93biA9IERXQzJfUE9XRVJfRE9XTl9QQVJBTV9O
T05FOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBkd2MyX3NldF9sdHFfcGFyYW1zKHN0
cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gQEAgLTMxOSwxMSArMzE5LDExIEBAIHN0YXRpYyB2
b2lkIGR3YzJfc2V0X3BhcmFtX3Bvd2VyX2Rvd24oc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0K
PiAgIAlpbnQgdmFsOw0KPiAgIA0KPiAgIAlpZiAoaHNvdGctPmh3X3BhcmFtcy5oaWJlcm5hdGlv
bikNCj4gLQkJdmFsID0gMjsNCj4gKwkJdmFsID0gRFdDMl9QT1dFUl9ET1dOX1BBUkFNX0hJQkVS
TkFUSU9OOw0KPiAgIAllbHNlIGlmIChoc290Zy0+aHdfcGFyYW1zLnBvd2VyX29wdGltaXplZCkN
Cj4gLQkJdmFsID0gMTsNCj4gKwkJdmFsID0gRFdDMl9QT1dFUl9ET1dOX1BBUkFNX1BBUlRJQUw7
DQo+ICAgCWVsc2UNCj4gLQkJdmFsID0gMDsNCj4gKwkJdmFsID0gRFdDMl9QT1dFUl9ET1dOX1BB
UkFNX05PTkU7DQo+ICAgDQo+ICAgCWhzb3RnLT5wYXJhbXMucG93ZXJfZG93biA9IHZhbDsNCj4g
ICB9DQo+IA0K
