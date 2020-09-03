Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1062C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C75F2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CkKsyr5s";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="niNk61my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgICHcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:32:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:34082 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgICHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:32:44 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0837SqOC011329;
        Thu, 3 Sep 2020 00:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=QiU/FsNlbgwHQ+0mjOzySNDola4fK4n50EavepDlWoM=;
 b=CkKsyr5sixm9INIdlBLEbUVRTpbFyUCiz0CbjOayytPkfqEfz5GFhDjeRh+hZjZNQvw4
 /czvakGrJXGkbnx7rAskpo0slVKkxzQSNmLTSHlaRqQgA8Xv4ElTnBc9hpWXzDq3bsBY
 RrD0jR3GSqO5MEb377PN5uG7kwGiPAG8Te2bcC5kDDhXbmdHtqrIUIN6qD+uNm8HCvLQ
 VdpRz432wBbSc79lvhKNTaLX4Ti4RxftfzqNi3qZWrKtiev4DofNyRyJJXjHUfa2dOCx
 t+qI9gtwohKec7PylU4gnm97xEUFA33gWooAm2g0bWMsqIbHejCDUfqfv30GDnDrDK5E Qw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 337jkwksnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 00:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef4ELJXVLcWFD3zsneUv7nlJFBRH1LbfSHHWJB9lYgO2y7FvuCsP7heVSw4J266abPI1pYxd8YgOfCzmVL8AIXuW30GYvfNXuwy6UjQ2vM4TJphNo2Sg6s9V3kuib6ar4ew4EGzVCYnzTdLclYHtb2mp3X5ZQHYpZX4G4M3z6GcFGKkUn3rzEXnnB1lJb8BqpA0aASmiL2y75tU9IgkoF8HSjI6KkiAEftaAQlXInm24yFpOImcBEtJafxPjOI/e8LhUBrRZyz8+lI6PnBC6Ce2qLZxoHectkSUQga4mf20SHxOAfwwCSLAykW7vfFLwo1/zqGJG9/u7FSh0rKyyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiU/FsNlbgwHQ+0mjOzySNDola4fK4n50EavepDlWoM=;
 b=bZHiyb6cUb3d5NjDeG9fmz9owVQ656ZXB2xDYv5Z6M1Wj2ym8VIdVkNyneQmmRaGEvWSdLzgrdH301kEzY5o5/Rw0SMHSQOjQNJvcfriXN45PcoOXTuqGDp2vQ7z9MVOwQIbFyWZt72SJhTsMsu7981mhxbrBNJHuGGdJYKi5uanHkAvdEaK0x60RIiWO5KijIumlbO5iTy9jnJbg9VHHl6LrKjBb8mzYQYRVaVd4ONOFwacW0N4e0kjzUDaMss3YvbReVe3EZgrrkwFDMOpWnU2ZbMwWHV1iG4fiTvhnoNwR5ldTQ5HONeYYALhx3wso3xCiaeUs7XQo/mc/FHgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiU/FsNlbgwHQ+0mjOzySNDola4fK4n50EavepDlWoM=;
 b=niNk61my/wahH37pyqZeqZlCyCy7xntVYBchySO8wlAadDtFiZk5XOTJal+af7n8HIRTVUn+n5OWROQuGBg1CIMlHQCRFJ+yBnN23H8gieaQfts7BaTpmpcgsn9pmZjtykJOwUpelev+m7QKnJ5tNwhZ/xgT38JcwqA4iYV7Srw=
Received: from DM6PR07MB5531.namprd07.prod.outlook.com (2603:10b6:5:76::15) by
 DM6PR07MB6363.namprd07.prod.outlook.com (2603:10b6:5:155::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 3 Sep 2020 07:32:13 +0000
Received: from DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2]) by DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 07:32:13 +0000
From:   Milind Parab <mparab@cadence.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>
Subject: RE: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
Thread-Topic: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
Thread-Index: AQHWf3AYzpzGkoZ9706j21VgVUJ0X6lTdp2AgALthcCAACNHgIAAAR/A
Date:   Thu, 3 Sep 2020 07:32:13 +0000
Message-ID: <DM6PR07MB55310053A35DC754C5B27FA9D32C0@DM6PR07MB5531.namprd07.prod.outlook.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
 <e53e87b0-7e0a-763f-8b8b-0dc278e1f225@ti.com>
 <DM6PR07MB5531DF749C993423B0A3E746D32C0@DM6PR07MB5531.namprd07.prod.outlook.com>
 <4a0d1e85-0db6-af62-a1ea-e8f0c684b4a6@ti.com>
In-Reply-To: <4a0d1e85-0db6-af62-a1ea-e8f0c684b4a6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1ae9ae-4b0c-48cb-4a7e-08d84fdb79d5
x-ms-traffictypediagnostic: DM6PR07MB6363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB63638E1178DE40A9B1BDBA36D32C0@DM6PR07MB6363.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9/B6u73gN42vQQroC+2xEMyz0GQ2fUxiQN9lZ7P3iuNVpGxFeMPYXMK+jPQ3XY2NeBvfTbjbc8AP0Uf2ml0bdUw7TmeHEusjIeGUXxDYxQ/7wCbU/0qrWZ2bGwQXbNcBrjn/YAlNu4+jcqaOY/EepTcjpIZ6ReM6gkLyzLrxBilhAWkg45/4dFhXefZCALlSqFXOgdw8kM24vWwBjFSesaVTe10RkwPJdDetFrFW+dpriS+rO8FYx4nfAns4Wr/8tzfUO3X9TRhk8ZkdZM0DvaBsooUmH7vXxitCXA9/vLhW3C3xvcaGYzkrQbT9pk+qAOJNDBz+N4TB9m2cYOyLj0OCCU+RVWvegcFidVlQmCz1sjY5YJ6K9rZG1EmYliwCzq815rKKYc5hCJNI8c6ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5531.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(36092001)(71200400001)(2906002)(76116006)(86362001)(8936002)(66556008)(4326008)(478600001)(64756008)(186003)(66446008)(66946007)(66476007)(52536014)(110136005)(8676002)(7416002)(26005)(316002)(6506007)(54906003)(33656002)(5660300002)(7696005)(9686003)(83380400001)(55016002)(55236004)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: B4q5X7vDRK05uWNMnTI5xqxQkMBtgQh/YJy+B5xdy/ViymNkLv7PTNXV8bdXhUoFd221Ulir/TUrtn5fdQUJWG6baEN88cnkHOO66wxcMeD01HFPZMXxLGh/LwnmGB875Kv0H0UvtTADM4yJhfcw3dKskuwDm1iySNEud7e8je6iOp0IFKawkWOhTTcO/A9oOn87IGxR16mfvuzgvI5NcIEFQv0IUsKJ80Vx9+l8C/D/9pWqvR+RKXLomh8Z+Qdkllaa+sVQBDCxV6Cw9gLsbBe8cub3t10hgN/B1u/Yv8W/JEqufbZJg6clA6uh/V6RkeBcfgMvPCdj68YrhBrJHLvTm9IUDg1jgSDhipBb42lN8oqD3/jxIGcW6/io2WR6zFVbLDTSIiuWqgsFIoOHn7KlTj1pL0lZmZWX8SeFUfvajvVbEaxKppagVa2j8EPbW4yb3QSee79MtR+6cW4KpA2/CWjzbwDeN6Q8wjH91t6unF7QkzRTM/5CbsLh4rf8Sft6QOBLEdLzey2msHJrBWZMInJM4vPUUQzRyviK372EK9mNhlUUMl52j4F148Hymjr9fxc/aQGyYalQZ6mlZ8Ka9T+Rs8LUxNWObaJqABTDE9nD0cl5qNn865dR4vU6efTF4kywVzmr6bjIJ9LYZg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5531.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ae9ae-4b0c-48cb-4a7e-08d84fdb79d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 07:32:13.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvlcpjfPFH8YBtmedT8vKMms7Y9+zUSZD+MFAfjbKVeBeIeTBN5wuz7O1J+DIIrGB2eSKEoh3iXbVrwY7B+mtq4NW8ZG9MRGH5pFKhbCsHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6363
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_04:2020-09-02,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009030067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVG9taSwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVG9taSBWYWxr
ZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDMsIDIwMjAgMTI6NTQgUE0NCj5UbzogTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+
OyBTd2FwbmlsIEthc2hpbmF0aCBKYWtoYWRlDQo+PHNqYWtoYWRlQGNhZGVuY2UuY29tPjsgYWly
bGllZEBsaW51eC5pZTsgZGFuaWVsQGZmd2xsLmNoOw0KPkxhdXJlbnQucGluY2hhcnRAaWRlYXNv
bmJvYXJkLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPmEuaGFqZGFAc2Ftc3VuZy5jb207IG5h
cm1zdHJvbmdAYmF5bGlicmUuY29tOyBqb25hc0Brd2lib28uc2U7DQo+amVybmVqLnNrcmFiZWNA
c2lvbC5uZXQ7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+ZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5DYzogWXV0aSBT
dXJlc2ggQW1vbmthciA8eWFtb25rYXJAY2FkZW5jZS5jb20+OyBqc2FyaGFAdGkuY29tOw0KPm5z
ZWtoYXJAdGkuY29tOyBwcmFuZWV0aEB0aS5jb207IG5pa2hpbC5uZEB0aS5jb20NCj5TdWJqZWN0
OiBSZTogW1BBVENIIHY5IDIvM10gZHJtOiBicmlkZ2U6IEFkZCBzdXBwb3J0IGZvciBDYWRlbmNl
IE1IRFA4NTQ2DQo+RFBJL0RQIGJyaWRnZQ0KPg0KPkVYVEVSTkFMIE1BSUwNCj4NCj4NCj5IaSBN
aWxpbmQsDQo+DQo+T24gMDMvMDkvMjAyMCAwOToyMiwgTWlsaW5kIFBhcmFiIHdyb3RlOg0KPg0K
Pj4gQWxzbywgbm90ZSB0aGF0IENETlMgTUhEUCBpbXBsZW1lbnRzIERQX0ZSQU1FUl9UVV9wIHdo
ZXJlIGJpdHMgNTowDQo+aXMgdHVfdmFsaWRfc3ltYm9scy4gU28gbWF4IHByb2dyYW1tYWJsZSB2
YWx1ZSBpcyA2My4NCj4+IFJlZ2lzdGVyIGRvY3VtZW50IGdpdmVzIGZvbGxvd2luZyBleHBsYW5h
dGlvbiAiTnVtYmVyIG9mIHZhbGlkIHN5bWJvbHMNCj4+IHBlciBUcmFuc2ZlciBVbml0IChUVSku
IFJvdW5kZWQgZG93biB0byBsb3dlciBpbnRlZ2VyIHZhbHVlIChBbGxvd2VkDQo+dmFsdWVzIGFy
ZSAxIHRvIChUVV9zaXplLTEpIg0KPj4NCj4+IFNvLCBpdCBzYXlzIGluIGNhc2UgdnMgY2FsY3Vs
YXRlcyB0byA2NCAod2hlcmUgQXZhaWwgQlcgYW5kIFJlcSBCVyBhcmUNCj4+IHNhbWUpIHdlIHBy
b2dyYW0gdHVfdmFsaWRfc3ltYm9scyA9IDYzDQo+DQo+SG1tLCBzbyAiUm91bmRlZCBkb3duIHRv
IGxvd2VyIGludGVnZXIgdmFsdWUiIG1lYW5zDQo+DQo+Zmxvb3IoeCkgLSAxID8NCj4NCj5JZiB0
aGF0J3MgdGhlIGNhc2UsIHdlIG5lZWQgdG8gc3VidHJhY3QgMSBpbiBhbGwgY2FzZXMsIG5vdCBv
bmx5IHdoZW4gcmVxIGJ3ID09DQo+YXZhaWwgYncuDQo+DQpFeHBsaWNpdCBzdWJ0cmFjdGlvbiBi
eSAxIGlzIG5vdCBtZW50aW9uZWQgYW55d2hlcmUNClRoZXJlIGlzIGEgaGludCBvZiBzdWItb3B0
aW1hbCBwZXJmb3JtYW5jZSB3aGVuIHZzIGVxdWFscyA2NC4gSG93ZXZlciBuZWVkIHRvIGNvbmZp
cm0gZnJvbSBzaW11bGF0aW9ucy4NCg0KPj4gVGhpcmQsIGlzIGFib3V0IHRoZSBsaW5lX3RocmVz
aG9sZCBjYWxjdWxhdGlvbiBVbmxpa2UgVFVfU0laRSBhbmQNCj4+IFZhbGlkX1N5bWJvbHMsIGxp
bmVfdGhyZXNob2xkIGlzIGltcGxlbWVudGF0aW9uIGRlcGVuZGVudA0KPj4NCj4+IENETlMgTUhE
UCByZWdpc3RlciBzcGVjcyBnaXZlcyB0aGUgZGVmaW5pdGlvbiBhcyAiIFZpZGVvIEZJRk8gbGF0
ZW5jeQ0KPnRocmVzaG9sZCINCj4+IEJpdHMgNTowLCBOYW1lICJjZmdfYWN0aXZlX2xpbmVfdHJl
c2giLCBEZXNjcmlwdGlvbiAiVmlkZW8gRmlmbyBMYXRlbmN5DQo+dGhyZXNob2xkLiBEZWZpbmVz
IHRoZSBudW1iZXIgb2YgRklGTyByb3dzIGJlZm9yZSByZWFkaW5nIHN0YXJ0cy4gVGhpcyBzZXR0
aW5nDQo+ZGVwZW5kcyBvbiB0aGUgdHJhbnNtaXR0ZWQgdmlkZW8gZm9ybWF0IGFuZCBsaW5rIHJh
dGUuIg0KPj4NCj4+IFRoaXMgcGFyYW1ldGVyIGlzIHRoZSBUaHJlc2hvbGQgb2YgdGhlIEZJRk8u
IEZvciBvcHRpbWFsIHBlcmZvcm1hbmNlDQo+KGNvbnNpZGVyaW5nIGVxdWFsIHdyaXRlIGFuZCBy
ZWFkIGNsb2NrKSB3ZSBub3JtYWxseSBwdXQgdGhlIHRocmVzaG9sZCBpbiB0aGUNCj5taWQgb2Yg
dGhlIEZJRk8uDQo+PiBIZW5jZSB0aGUgcmVzZXQgdmFsdWUgaXMgZml4ZWQgYXMgMzIuDQo+PiBT
aW5jZSBzeW1ib2wgRklGTyBpcyBhY2Nlc3NlZCBieSBQeGwgY2xvY2sgYW5kIFN5bWJvbCBMaW5r
IENsb2NrIHRoZQ0KPj4gVGhyZXNob2xkIGlzIHNldCB0byBhIHZhbHVlIHdoaWNoIGlzIGRlcGVu
ZGVudCBvbiB0aGUgcmF0aW8gb2YgdGhlc2UNCj4+IGNsb2Nrcw0KPj4NCj4+IGxpbmVfdGhyZXNo
b2xkID0gZnVsbF9maWZvIC0gZmlmb19yYXRpb19kdWVfdG9fY2xvY2tfZGlmZiArIDIgd2hlcmUs
DQo+PiBmdWxsX2ZpZm8gPSAodnMrMSkgKiAoOC9icHApIGZpZm9fcmF0aW9fZHVlX3RvX2Nsb2Nr
X2RpZmYgPSAoKHZzKzEpICoNCj4+IHB4bGNsb2NrL21oZHAtPmxpbmsucmF0ZSAtIDEpIC8gbWhk
cC0+bGluay5udW1fbGFuZXMNCj4+DQo+PiBOb3RlIHRoYXQgbGluZV90aHJlc2hvbGQgY2FuIHRh
a2UgYSBtYXggdmFsdWUgb2YgNjMNCj4NCj5UaGF0IGRvZXNuJ3QgcmVzdWx0IGluIGFueXRoaW5n
IHNlbnNpYmxlLiA4L2JwcCBpcyBhbHdheXMgMC4NCg0KQ29uc2lkZXIgYWJvdmUgc3RhdGVtZW50
cyBhcyBwc2V1ZG9jb2RlLiBGb3IgaW50ZWdlciBkaXZpc2lvbiB3ZSBuZWVkIHNjYWxlIHVwIGxp
a2UgaXQgd2FzIHNjYWxlZCBieSA1IGJpdHMgaW4gdGhlIG9yaWdpbmFsIGNvZGUNCkFuZCBoZXJl
IDgvYnBwID0gMQ0KPg0KPiBUb21pDQo+DQo+LS0NCj5UZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5k
IE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4NCj5ZLXR1bm51cy9CdXNpbmVz
cyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQ0K
