Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F5D2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OugtcNL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgE2Vo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:44:59 -0400
Received: from mail-bn7nam10on2126.outbound.protection.outlook.com ([40.107.92.126]:20256
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbgE2Vo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaHjNZjhET10BvPMNCtwBEsC25t45h2OfnnjLwULYNoc6k8Z7cQz8vW9TbggRGwX69nZ7X8AHHDZDsP1GAgPKa9frE2+yoehF6drRIH4yqegkoWkVYVem4zgEWYsTKJw4Q7HPmTJHAU+LqhaE3UKPaAlVx42a3Btvtl/0awrcwOKv/cPOKRL0EeT29GdOact5xWX04DGJGf75acOdSq1Ig2IOiYVhYRFudNv/WukAkzZL2HCVtY2Dq6lMSjCyT6rA3d+4VH8pg6E4I3W9/NG38QBkXExxAgV+Uz9ySMuNgnEnNVcpsNTOuvSCPEFYZ1T4qD8H8xo1S3QJMu9cq9iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/1vzNoAbAXUQ1cVnAXoWpjdXiQ5kfDZVKyhq6QPvPE=;
 b=AnQuk3dspkXIUAL1/EFl8MwjC42MwbckqBrDcSMb5AF2U5zqIoB6qRsb5H6Bg+MPFn0HR3zvtgz3TrJStAgYxccVro1kJvLbFItw30xW5UhpcMqPkxuhcNRdjhpNYUxwmX++3rWqnmF2mo0MzMyCI3yP9hZTnoHnWa/UPo20i91XKLMO6FRVG5utrpClfK2HAPjX9XZUrjc7RdIeJM7F86bMZnPRtIjecTv1IXtE4ccD+kzXjJJA0hn4nZ8/Ia/tYYH/0n0XNq6Wc31H+2VT7px6udOnmkar6oviPf4NUa3kPH3BtHeqvvvynR/1uF+vDrlCho4DT+f7MLTIk+LF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/1vzNoAbAXUQ1cVnAXoWpjdXiQ5kfDZVKyhq6QPvPE=;
 b=OugtcNL2UwPjIIfnoeXuapRmGuxk8zjmzhkgB7WSEtR5vDtPuyKMIKinG6svu23tyIf+YHaguU8kRcjmKKnll2qMKTmGQ2QnXZeYRAHhb/LoZXosONEq01aK+htvAiJvggaivHsaxQiFKxqISQXZBvUpzlPFLRE1/Lxps1mnRK0=
Received: from MN2PR21MB1518.namprd21.prod.outlook.com (2603:10b6:208:20e::24)
 by MN2PR21MB1406.namprd21.prod.outlook.com (2603:10b6:208:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 21:44:55 +0000
Received: from MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88]) by MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88%8]) with mapi id 15.20.3066.007; Fri, 29 May 2020
 21:44:55 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Ian Rogers <irogers@google.com>
CC:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Topic: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Index: AQHWM8mKGkvgLkOO8Em0Algb20rYzKi8SrMAgAACEUCAAB83gIAA0mCAgAIkP9CAADlDAA==
Date:   Fri, 29 May 2020 21:44:55 +0000
Message-ID: <MN2PR21MB1518440CF0E4C5A335EBD8E3F78F0@MN2PR21MB1518.namprd21.prod.outlook.com>
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
 <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
 <MN2PR21MB1518D07AD29D0E744E2D4EA2F78F0@MN2PR21MB1518.namprd21.prod.outlook.com>
In-Reply-To: <MN2PR21MB1518D07AD29D0E744E2D4EA2F78F0@MN2PR21MB1518.namprd21.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-29T18:48:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50f66f58-96bb-42b9-8031-830503629b8a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [75.182.186.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fda2ca13-5620-4e23-45e1-08d8041986e4
x-ms-traffictypediagnostic: MN2PR21MB1406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB14069F91C9624665F884F46FF78F0@MN2PR21MB1406.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NndPtZCYWS4IgvPNQBcs/Cs0QiWgeERc1/UFB22xEPC5DQ/C/tzmN6KaQ35dIqiT0tn28gvlr6pHZA88QgTiW/3ZmfEU6ukXjYfyXDb3M3GdEEA5t78VddigXKAnbjtP7ffPvOifQJ0G51h6sjvNbMMyZJpsjhKQ+pvvbpR9dENJu+IgK8x2JRD8QQyxZz0NsdYRtuPqJbJi/iDn02wwYNZd/F5dywFv9QKzUytAivKY8k20n1L+46I7sQp65tJVEtiYydMAiD6lTH++oj90B9sTzHjNgqDYGMcqNz5x0I7y/kxdosasWIZMkgvbIQMfWj3meDgTQlN/cy85zotsqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1518.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(7696005)(316002)(2940100002)(9686003)(82960400001)(86362001)(8936002)(110136005)(33656002)(6506007)(82950400001)(54906003)(71200400001)(2906002)(7416002)(66556008)(66476007)(76116006)(66946007)(10290500003)(26005)(5660300002)(186003)(64756008)(4326008)(478600001)(4744005)(55016002)(8676002)(52536014)(66446008)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i0TumGHV9LUr7EbPlev1MdvQ1HgA1ABxLJorN3JaLPsMlQpmkZ/tPmFcglG19e26fpGLgo7QHuBf9+L+2wGj2J4We1wK513ZEZ/J0BILR8EwnZKT1quYxYJCxaq+7tnpgH74DBeMmBl7LIbEpo9qUyqxCtemYnmcYnshWFIpQZmLcz2y73EkVaNeByeujc2HwTBL+0wdnWZkrQa9iLIrphLCTe9DRqRojO5zLKwJ/X3A3hHATEKFRBb//fpH5DJnT8ZbMiPkQ3wakAQ2I3yPhAcfrUr88dIJ9Zk6nve2cRhQGuWASt1acbpuj7ODr+6RNWLFd9SBNaicsMqTt2XyhZUtnwAF3hctXF3vzJ+z9OH5vre3OxeLk0QQsqfj9pyEhmfhH5838JnHcE0TmxPjQFLLbEnFUmiMhhpNoXopG2NqFo9awAGATpXCNr7uHDpL6WtCb6wdNVDT/XbhDEIXxRVfwFs+UqfuslFQnJQJ0d4bLNMkKxvFo/AH9bTTB9+i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda2ca13-5620-4e23-45e1-08d8041986e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 21:44:55.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5YYi9RaZ5rDzrPSSEwVPwUVdDP13gbHZVeifYUfvSK5VgQlO7osn3J65Q1YbetBaIdsLif2IgrbW4Z8H+bEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi90bXAvcGVyZi9wZXJmIHJlY29yZCAtayAxIC1lIGN5Y2xlczp1IC1vIC90bXAvcGVyZi5kYXRh
IGphdmEgDQo+LWFnZW50cGF0aDovdG1wL3BlcmYvbGlicGVyZi1qdm10aS5zbyAtWFg6K1ByZXNl
cnZlRnJhbWVQb2ludGVyIA0KPi1YWDpJbml0aWFsQ29kZUNhY2hlU2l6ZT0yME0gLVhYOlJlc2Vy
dmVkQ29kZUNhY2hlU2l6ZT0xRyAtamFyIA0KPmRhY2Fwby05LjEyLWJhY2guamFyIGp5dGhvbiAN
Cg0KSXRzIGFsc28gcG9zc2libGUgdGhlIGBJbml0aWFsQ29kZUNhY2hlU2l6ZT0yME1gIGFyZ3Vt
ZW50IGlzIG1hc2tpbmcgdGhlIHByb2JsZW0uICBTb21ldGhpbmcgbGlrZSA0SyB3b3VsZCBtYWtl
IHRoZSBwcm9ibGVtIG11Y2ggZWFzaWVyIHRvIHNlZS4NCg0KSSBzZWUgdGhlIHByb2JsZW0gZXZl
cnkgdGltZSAuTkVUIGdyb3dzIHRoZSBjYWNoZSBhY3Jvc3MgYSA2NEsgcGFnZSBib3VuZGFyeS4g
IDIwTSBtYXkgbWVhbiB5b3UgYXJlIGFsbG9jYXRpbmcgaHVnZSBwYWdlcyBvciBzb21ldGhpbmcg
d2hpY2ggbWlnaHQgbWFzayB0aGUgcHJvYmxlbS4gV2UgbWF5IGJlIGFsbG9jYXRpbmcgY29kZSBw
YWdlcyA2NEsgYXQgYSB0aW1lLg0KDQo=
