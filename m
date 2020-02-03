Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DFC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB82080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgBCFdP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:33:15 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:54082 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgBCFdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:33:15 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Mon,  3 Feb 2020 05:31:46 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 05:32:31 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 05:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWxxuN8mUcI11Nt/WuKKNEQKuEcdAGh+Je+FiveiD9vg95CzHlyFpMR6FJHI2tSPxeGBwZrrdhc1y0nC1xT8I49Gha+WjcjxYfWySvyJWmIvptBum3/e3QFyIaiZohNXVS2z9ZCRDdPRn8azXaYl9Z0kr5/UG7OMVPVr4D0eigA+AIaAh95mfRLrtL06W16nTaZneN8lwcSwBYEO7e/l5t0LshIBefMSuNkuL3WLmfFnroWnXzu7CyQQvlr6Dr7NCTL2D4JEG5EItYjtohBUDYXzGbQzRx+BuGtUgn0WWRWReKLJLO2sgF5PBw/zNw6eK53NbTx9VDXWxw3nzoJ50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQbtFPVmX6aih0baSkoK/XN9nQXmOmjWqmOvTE024zc=;
 b=cvjzuwZYFBo8ZFZ8yLatcJdyNPTLMUpg07DeyMIqRoRLhvdczK2o5jzTSQav6xqzQSKYv7/sk40jdYYrdnAZbyaubXpt9XM0bxAR9UJn7ok7Wkx5uIA/9BK1Fcf0ydkFvewIL9Vei3W7GJaY0r2bS37t09WYthixJSjin3N+eMg2JV1o6MnuuUj1keefI/J1gh1FI4d1Bv3cg3Fii5HYlf4In5nYyvCmIxRvjonZ2C7thM9dmG6q/OiCZR4XDaJi757JojLlQGMcXt+UZZw9jiYOCUvtY6+DNkO3dYy270EBBmURhcjSgkfVmTAemAY/YxmYYH2Jo0APWDfuyBH9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3334.namprd18.prod.outlook.com (52.132.247.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 05:32:29 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77%3]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 05:32:28 +0000
From:   Gang He <GHe@suse.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "gechangwei@live.cn" <gechangwei@live.cn>,
        Shuning Zhang <sunny.s.zhang@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Topic: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Index: AQHV0Bf49UeZZZUyKki8pGxA20UtZKgIy58+gAA2GACAAAMu6A==
Date:   Mon, 3 Feb 2020 05:32:28 +0000
Message-ID: <CH2PR18MB3206844EE94EC90A2CBFF85CCF000@CH2PR18MB3206.namprd18.prod.outlook.com>
References: <20200121050153.13290-1-ghe@suse.com>
 <CH2PR18MB3206F418382332EB25130477CF000@CH2PR18MB3206.namprd18.prod.outlook.com>,<de23176f-5b84-a785-80a2-0bdc8e3a0fab@linux.alibaba.com>
In-Reply-To: <de23176f-5b84-a785-80a2-0bdc8e3a0fab@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-originating-ip: [124.205.104.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8275a9a7-bcb0-4ab5-acd2-08d7a86a759a
x-ms-traffictypediagnostic: CH2PR18MB3334:
x-microsoft-antispam-prvs: <CH2PR18MB3334FB897EBC655625DC972ECF000@CH2PR18MB3334.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(478600001)(86362001)(7696005)(33656002)(5660300002)(52536014)(66556008)(66476007)(76116006)(81156014)(71200400001)(66946007)(91956017)(316002)(110136005)(8936002)(6506007)(8676002)(54906003)(81166006)(66446008)(64756008)(53546011)(9686003)(2906002)(186003)(55016002)(26005)(4326008)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3334;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIqJt9Z5HIum0FUV5G05PEtJYCmZxwHgv6rInT5gR4f7N2lGEfBjCjDs7ScliPcc2qvGiiSvPx7GF9uUfLran2qvp/aya0KIcVCmbp1cA5uF1lmb+m0N2C2WtqfWnZI7QaJMQioWKstn+IjVAYw5d2zcS7+Z1sVTbZAbLLBjWhxl7LEhrkfa+tT5p9r5XyeGbk4WI/Bvl3Sj9riSZOqadtpnqkjPKHmEF2BR2+yjNiRIUcYBp8AI06ya7mUxxfOmHk+B/LkjjESMJud3PQQS00L2y7QqMapA9GbA+5nQb8Oy2B7866MLxC4g7rhZeT0IwLFKCcqT9gp/Pn0/0G2gKEYc3EAUev/svpg1Xo/zgg/GyicEq9iByF8dkb7r/4orDCJtroEU39exN5cQE2vXVOiMdfmR/1Uh1I6i/kGF0wX+2ME6ePYjSsY2JDTWYzK9
x-ms-exchange-antispam-messagedata: M74xk+XaFWJAv17HUcfSZYhHz+O+cqWruNCrqnbflcXRw9fQzOPZqcsprtL0u1iGkhji61mBCe9OxKGQ7NB8wAOT4A8pITJ6qq9qBjm7L3X0yrz51L76eeCWwnn0DN24wJLwZa9zp3CSg9t8nHLYJw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8275a9a7-bcb0-4ab5-acd2-08d7a86a759a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 05:32:28.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byIQQNPEGqVUuIla7nG6lVacie1nvQ3h3pVnQFBXhT/TvsmEyc2yyNE5lUuk7BvR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3334
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

before calling ocfs2_refcount_cow() in the function ocfs2_prepare_inode_for_write(), we do not use inode buffer_head.
So, we can let buffer_head is NULL.
But, when we invoke ocfs2_refcount_cow() function, we have to pass inode buffer_head without NULL pointer.
That is why writing clone file will cause oops and kill the user-space process.

Thanks
Gang

________________________________________
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Sent: Monday, February 3, 2020 1:15 PM
To: Gang He; mark@fasheh.com; jlbec@evilplan.org; gechangwei@live.cn; Shuning Zhang
Cc: linux-kernel@vger.kernel.org; ocfs2-devel@oss.oracle.com; akpm@linux-foundation.org
Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file



On 20/2/3 10:17, Gang He wrote:
> Hello Joseph, Changwei, Sunny and all,
>
> Could you help to review this patch?
> This patch will fix the oops problem caused by write ocfs2 clone files.
> The root cause is inode buffer head is NULL when calling ocfs2_refcount_cow.
> Secondly, we should use EX meta lock when calling ocfs2_refcount_cow.
>
Before commit e74540b28556, we may also use NULL buffer head in case of
overwrite, so why there is no such issue before?

Thanks,
Joseph
