Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71DFC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DA020663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="D+LOFm4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgCPQPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:15:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:56870 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731713AbgCPQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:15:15 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GGEH2C025508;
        Mon, 16 Mar 2020 09:14:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=+Bn+U0PCbImATFMD5vyESfUnbSOAEV/572EFr2CtsZk=;
 b=D+LOFm4KCvYF32+/m3vKB5LD2+nqMG109iHaROJ5V2o/HfIlmnTsSKZqbooWwiUohERU
 z8trMcdsjL5YLqxWjgoyiMaDWdqWpz27ohNsJJ3m5F0mlGjibv/SIxMojlxKbvJy8Ja0
 KvlMkTIgnKRJAM8aKT8H0UPdt3IwCQCdW69pozvpR7HMVRdRBOt3gkRnM1Qh6gEVrAIy
 NLcvek+ifWbn4CKQoPmMA2HqnoSNd8MPcQa/PTuuv81zLS2EaRXIJ3shmhUBbqX676TS
 lP/+eIJU3Z7EJXqTvZyKr52FMrzLEn7aeyXHeoSQJD2CbBJ4YF+JPnzSU49imqNMP1LZ eA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2ys4h5udks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 09:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+5rsuLlKRA982EtKKGSKrdcKYJZSmc9LSPTyCg4C1ZhysT7+37xuG23QaDmkSjdkHnc/C6/t5TgoWEF4eeA7WY0assk0V7k4XDh+wvNJYxswBeLNCUUBv/LA+bH7D7HSxrW5GInKiIhVRGVUf0sZkJF3ZxyJIpXWru/OI4mbxavWRf1cBjOj9iM2F+7L+QjobFn5/JAzzstxw2Te+53fa2EHAx1kfQ+YdKqxMxnYfXIZAIW29tuEkgyRd/w8+TUN3sO0nz4CcuIv5xM6rKUszgGtK9tOt6yZ5YkjvqCvtTlhKsvfbwqAwR0eeiyPh8D0A2Lk+HUmwY3RuRY6fIAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bn+U0PCbImATFMD5vyESfUnbSOAEV/572EFr2CtsZk=;
 b=QbXafKTPhjvfuEu7BUG5MQhAB8cTcbqKQxgZhMi4t4BhXDmDrL0Q4h4ztxCnynRVy4Qpbq1HYGVVsSASCIIP6r8K5ZnCM/ZdhcBctCq0SmgZ5hBiZE4XiOipvdmhmhIx6o/Vj+Ztdl6LMETnpS8Flx+NXOH/yu93sNghBZ5br7WRD/2QkOu/L7fgZ4o7QMCbzC8ziazUOLUn6ak0g1c2BE79Z+RdE0utwEUMXoxQ6zENaAO5ALAxW7m/5FXtgtGhHEB5BHZcbVsUyU2mMEca8qCCBM7+ke/qGFpvaF2cOsj/++gS9ybN0dkJEUuK5/qjnR9dRp22YJizqEFKE6TqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB4673.namprd02.prod.outlook.com (2603:10b6:208:55::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Mon, 16 Mar
 2020 16:14:48 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 16:14:48 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDgAg7liAAAcXdAAAAVTlAADMMSCAAAKFFGA=
Date:   Mon, 16 Mar 2020 16:14:48 +0000
Message-ID: <BL0PR02MB560169A483F201F1855C41A3E9F90@BL0PR02MB5601.namprd02.prod.outlook.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
 <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312132642.GW23944@dhcp22.suse.cz>
 <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
In-Reply-To: <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a502c10f-ca01-4598-6946-08d7c9c52671
x-ms-traffictypediagnostic: BL0PR02MB4673:
x-microsoft-antispam-prvs: <BL0PR02MB4673520EF1E0BA836812B6AEE9F90@BL0PR02MB4673.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(6506007)(4326008)(7696005)(71200400001)(9686003)(66476007)(55016002)(66556008)(66446008)(64756008)(66946007)(76116006)(81166006)(44832011)(4744005)(33656002)(478600001)(110136005)(54906003)(86362001)(2906002)(186003)(7416002)(81156014)(8936002)(52536014)(8676002)(5660300002)(26005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4673;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeimoY8b7DXMYRWZFGVc3Vz9UugLLPShV7CjTkOOX4KSUjv6q3qQkh2QFYNISmk+rVS37gqDeWSPd0WpB43ccAFn/LrLCAbck5y/y7VLSij/AVY9DJEyzo/OuJu7xC9PoPtU3MYfCcXi2SBXDYwi4GfH+2knq8yKMfCZ7JXfp12ZqfKSbrNJIxN50WZSlAHb5qhuVRjcdvtTsofAoCWp++cTax97nXJgmMbiJFaq+uwlgVKaTp+4g7lpyO8K8IuoU9xr+ema16yuS28QywmNnSZK5c7W8BIvHSFBaDcqy6Z6gDFUBUIeSFpWoXeciOVTzyeyVc3HUHpt3M2bbDA6HuRMluQt5Hra45sCcC7U79GjP1r1gEdGZ4S3k9TKsBas+oPjBKZ1Wij94+1blup0MbIFvoJIx/qROSfmqvGE3scy6hBUZBKr0gcEniLJrXTx
x-ms-exchange-antispam-messagedata: n7Gnu9wI804jJznWuh3Gt1g/Ni5iQWAdcnwTfsKnMwMkx/5w6cZi/78k+pQSeDPTu/qcHg44g0Av+cQ5rOQrM2dBd8bKpT6uulJ4Yx0xGPH4fWFTqVwLhyHviVE1ybUWLg+ELtJjGeShlHoOM9ea2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a502c10f-ca01-4598-6946-08d7c9c52671
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 16:14:48.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdogLw7jvp+ninJo7bRx0mXC1TVIgNUBXYRrmcAwiMwbNCBBVE8K9EqaB0eI07R/Xw7pXWybLUuCyJRuLuJXNK3OKskJL6W2APAQTZngR3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4673
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-16_07:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAxNiBNYXIgMjAyMCwgVmxhc3RpbWlsIEJhYmthIHdyb3RlOg0KPiANCj4gU2V0dGlu
ZyB0aGUgdm1fc3dhcHBpbmVzcyBzcGVjaWZpYyBjYXNlIGFzaWRlLCBJIHdvbmRlciBpZiBpZiB3
b3VsZCBiZQ0KPiB1c2VmdWwgdG8gYmUgYWJsZSB0byBlbXVsYXRlIGFueSBzeXNjdGwgd2l0aCBh
IGtlcm5lbCBwYXJhbWV0ZXIsDQo+IGkuZS4gYm9vdCB0aGUga2VybmVsIHdpdGggc3lzY3RsLnZt
LnN3YXBwaW5lc3M9WA0KPiBUaGVyZSBhcmUgYWxyZWFkeSBzb21lIG9wdGlvbnMgdGhhdCBwcm92
aWRlIGtlcm5lbCBwYXJhbWV0ZXIgYXMgd2VsbA0KPiBhcyBzeXNjdGwsIHdoeSBub3QganVzdCBz
dXBwb3J0IGFsbC4NCj4NCkl0IGxvb2tzIGxpa2UgYSBtaXNzaW5nIGZlYXR1cmUgdG8gbWUgYnV0
IEkndmUgYWx3YXlzIGFzc3VtZWQgdGhhdA0KdGhlcmUgaXMgc29tZSB1bm9idmlvdXMgcGhpbG9z
b3BoaWNhbCByZWFzb25pbmcgYmVoaW5kIG5vdCBoYXZpbmcNCnN1Y2ggaW50ZXJmYWNlcyBpbiB0
aGUga2VybmVsLiBUaGUgZmVhdHVyZS13aXNlIEknZCBiZSBvbmUgb2YgdGhlDQpmaXJzdCB1c2Vy
cyBvZiB0aGUgc3lzY3RsIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXJzLg0KDQo=
