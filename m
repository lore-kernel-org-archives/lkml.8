Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB8FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF9206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="kvDpQs+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgGOK6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:58:41 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:14574
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbgGOK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSWLcvSCeK0WvG9I1zjOejYbjj1t7rbU0NF388+9/4ZXJmrsxjOHAOW+390qIdsuAb7GR+/wKmA0Q6u3aE8E67o6fqLhkrx9mIcwCxg5Ot15Q+igy3F2ucGJiul+SNBA4wlO/vby0zMEQSFMqU4kSMQkheEq+zufmXALyzg3Qxki0UT+2BSghnpXObY57cz6v9znKq4lRhWC8LxNAdiJCNJOCFTTPFzFNECEKds1WkqnZBTtMhPYpvZYs/D+UQo9JIneE/MzZVFvWmkMCSSoJfIEb9F+b0YBa9P/1Es3uk088fd0b4kdQE117wWZt3oSd1boXsFQOfeVIfpnsu0egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmbRwYOpdqkkq8KpePyOha1yUi2SW5UCqeN6311cWV4=;
 b=OHvO/1EFYeHTVyR78HBZ4KMghsToAOtyQBA0vkrl9bRzbfuZkgkm9n4yZOsEQ0SOQI+ya6vtxAR8wqnLxsnhhBnsIGNmqZfuYXbzEMrmMH4g599tSCaE6pnb0FQF6BtJNKF4MiIHkPHMSySHaKVJMe3p1F+mcr2aYmuaXAJfE7w5DK8d0ZueOdTTD3rJ3zarZS8bZSUMXE+pGTAHXh2/I5fsmv1AIYRPMIIPkl5ivbYxNMx0CcCO9quTH3nEkE6GDJVFt5dnrjZW/J71wdMzA/uRFJLG4FT6psMoHCaGFmIV0IIQBakuM3VKnnrViF9PZcq0+VvCJ4NmOjj97cIQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmbRwYOpdqkkq8KpePyOha1yUi2SW5UCqeN6311cWV4=;
 b=kvDpQs+GOxUtV+XYOWkWtAA6Hx4jsYafGKLTlOOq/PUoseap0cZuXx4fb1PZshFFgdnsCXOL8S6qxyc798T/iBpVTNrI4SgR39KdIsfMuRA55V9QgEToR2pTZvhhGHaAte4pEut+gHHSn38iO4NADolvddXXjgfTw7OiD/CaTmg=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM4PR02MB2978.eurprd02.prod.outlook.com (2603:10a6:205:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 15 Jul
 2020 10:58:36 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::dd30:3782:bf4e:2316]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::dd30:3782:bf4e:2316%7]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 10:58:36 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 3/3] habanalabs: update hl_boot_if.h from firmware
Thread-Topic: [PATCH 3/3] habanalabs: update hl_boot_if.h from firmware
Thread-Index: AQHWWSSlknnHv2ZxzkizTWvPSf2hvakIev+w
Date:   Wed, 15 Jul 2020 10:58:36 +0000
Message-ID: <AM0PR02MB5523A8221809C6D9CD5CFFA0B87E0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
 <20200713155424.24721-3-oded.gabbay@gmail.com>
In-Reply-To: <20200713155424.24721-3-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [5.102.239.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd12ccec-c2d7-49dc-2871-08d828ae0652
x-ms-traffictypediagnostic: AM4PR02MB2978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR02MB29782782F6B422D184B0394EB87E0@AM4PR02MB2978.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8IfWmQSiCfwp/u2rZmWx2hytWVp39RpeKOruWk3mC+cIw09IWkEcESrPAF+bviRERocAtnZxIjeY59N1nhPt/0dtOVwvxVadkL6Vyq2o4+JD7wUGzZ0z2jCCSh47J22pmAy4pPlLoX/vjY1zaggUE2NqzPdlgEHDQE9+2A4ubfqUiMQ2dtBAExp0g0pAkTAUz9vmY0PUlXmUI/DaOwXkLFNCw6h6h1lOFYdcLtXUEK2xqgsDqdhWEYVyAYZYteH3F0qvzyj+IsQEE2ZYuskmjSOapqGWab74Im5DlI4zak6ENDwh7NGHUPWvW0Bmfsdspuck4v+1j3xWvCwYqgDUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(39850400004)(346002)(366004)(55016002)(9686003)(8936002)(2906002)(71200400001)(86362001)(33656002)(6636002)(186003)(8676002)(66446008)(64756008)(66476007)(66946007)(66556008)(76116006)(83380400001)(6506007)(26005)(15650500001)(7696005)(110136005)(558084003)(478600001)(53546011)(316002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ITRM5ZKhuuJ9ABJXML/3ADaAh9MAjH/xzJ7Z/4aoKs3JoU7CtIWqNc6+nHN/ZfFbbfmSHjINH9WNKvmVVvQZ62RVXA8EgvtVVz3N9VQUnxgrDJMZQGt99xbYKU7imohucWxZOk5zxyVlSeqSeH7HszLxjbiC4eiIg8N24+xExnOGOwHNo9+KJqNPL42Wu7kRv8wDT66v6LXqYmnUE/4OvA9I+QmhdHkzTRGlPOf97UZ8zIkN8EUCVyOsWGPJmN+GxGUc7+IQK4hGmS7Pj08u/TnQN10v5G+674SgdYlPMiraxRJYAcm7X4x2QJKFoV8SwKelQCp/hMUsDdsb0q6VafeuOMh4L+KxVbzV43L0bhmtBxM2AaeJ2yiCpYKDlC6nXe1+9QdtMhfoGAEC3xUZ43EhvmfhXIdKsQN1SNLQXLQ8PEkrTU/MeoxBCzwwM2zcm1YIQ56RGQPWmp1wnez6zGIh7dEHQAkx4/IpUUSVFtk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd12ccec-c2d7-49dc-2871-08d828ae0652
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 10:58:36.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImkypoEq6mRF1oMIZkXhyVZK9HfgQFcT09sp1V1Igud+oikreOcd+nSRVmofN8mDkhU4REU9y6okfVG7VycOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB2978
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTMsIDIwMjAgYXQgMDY6NTQgUE0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBVcGRhdGUgdGhlIGJvb3QgaW50ZXJmYWNlIGZpbGUgZnJv
bSB0aGUgbGF0ZXN0IHZlcnNpb24gZnJvbSBmaXJtd2FyZS4NCj4gRGVmaW5lcyBmb3Igc2VjdXJl
IGJvb3Qgd2VyZSBhZGRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVk
LmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGlnZWxtYW4gPG9zaHBp
Z2VsbWFuQGhhYmFuYS5haT4NCg==
