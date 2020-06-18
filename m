Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E98C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F750206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="uodTxTJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgFRHjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:39:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:36025 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgFRHjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:39:40 -0400
IronPort-SDR: tbJyrsBoJ6zNq1MIF6GSafk0WrkujB8cpxDse7DEw8IXwalltcGTkSUnjJsLcc13wHO1PoBsh3
 7iU33Ph7+1xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="142421400"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="142421400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:39:38 -0700
IronPort-SDR: EEk656pFV1uNDBCGprNQhPevw6EfpvA1RDD63LTK2PuJZ3ETOlVEEMnL/EiVDG6szj7HENFzjC
 aEcjIo2Osqsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="450548456"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 00:39:35 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 00:39:33 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 00:39:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 00:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqkfKiaY6bjTNNYV+b3+V1j5cgBs6vKx59UMn9gzhP1GNDxaKCHoYhJDeQM0+jcoa2iPQGJZK5GgbzNClLQu7LWh/sC2aQ+ngIPS1F6CK25STh9Ba8WQSPEn4AS4oI2CUL/WzMAxSOlk2TwtAHzLXE7pu7Exp14+fNAGMzh6GF8mlXm9DbMFOIGJLLhwbrepMG7RB7kdrHyofZlgnK1da1FliHlOsVK74M2N1rGsOQigyp5ljIunu04rkkH8U/zgoj/Aq/m8xLBk1JtOlvdSiPQ0mmPk/fg66tPlZSnmcpDp1O7mss7cgP8vmo/bMDkayy3dSFTrOKTHf22vP8SWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT1byb2YKQ9IAmkpmfvOtcfqURbx7mTT+yWHYJOfcJs=;
 b=hRkjmcswNMs1LLbodeXAuA3NwhJ1bclcmXLHBMS+MMSPlvffS06LQluVXjK7xM0WkMI7snDiL1UxLrSGeFPX8aDer8KoOy5CwgNm7q7pDwMWsDnuDJycTS34p0RtjyiYIfsv+YmCMTeaJF5SGxAJCcuHLTR8tU9oHzGndN9Mq+wCEWU9pmTRPEWIDrjr4TVxYr3XqOlJWadtLOMDRgUiKOP+GgnwzozOXsG2/CDr4KoPJPwwjECBtPvfXVBH6VWiYh8jLu7sASYjNpCCsTvuPbbHiNDlHNSBwpP/kOSehAGEpK8d9RqmTK2vvkKF3mghld2hyenQWP29jO1Ia3vL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT1byb2YKQ9IAmkpmfvOtcfqURbx7mTT+yWHYJOfcJs=;
 b=uodTxTJFpsfGouxWn0YvMvqNhi+HyPWHzlY6Rmt1pYjqVSmLqPSDh0iS81QSjJ1MyeS+HbQGigXaLPZbuo6E+rCeVS3ti080V2p3u/pPT8DkEXaiyarr0NyMJ4eU2NFvNKHNiEeBfkInpWscZ8tDEwGk6ch5WrUwmzUycoDWMO8=
Received: from CY4PR1101MB2326.namprd11.prod.outlook.com
 (2603:10b6:903:b3::23) by CY4PR11MB1287.namprd11.prod.outlook.com
 (2603:10b6:903:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 07:39:31 +0000
Received: from CY4PR1101MB2326.namprd11.prod.outlook.com
 ([fe80::20ad:67f:8bea:34a0]) by CY4PR1101MB2326.namprd11.prod.outlook.com
 ([fe80::20ad:67f:8bea:34a0%8]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:39:31 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "alex.huangjianhui@huawei.com" <alex.huangjianhui@huawei.com>,
        "dylix.dailei@huawei.com" <dylix.dailei@huawei.com>,
        "chenzefeng2@huawei.com" <chenzefeng2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Thread-Topic: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Thread-Index: AQHWQOg7pvDM2vjI7kmUTaz/F8Qw8ajY8l4AgAAdh4CAABsdYIAA0yOAgAQFDHA=
Date:   Thu, 18 Jun 2020 07:39:31 +0000
Message-ID: <CY4PR1101MB23267DC8D2B1232744A5D6DCE79B0@CY4PR1101MB2326.namprd11.prod.outlook.com>
References: <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <202006142054.C00B3E9C9@keescook>
 <CY4PR1101MB23261B27ACF9D7FBC3969318E79C0@CY4PR1101MB2326.namprd11.prod.outlook.com>
 <202006151108.5B25D5A31@keescook>
In-Reply-To: <202006151108.5B25D5A31@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7ba76e3-73b0-4448-49fe-08d8135abcfb
x-ms-traffictypediagnostic: CY4PR11MB1287:
x-microsoft-antispam-prvs: <CY4PR11MB1287C08FA26347D44ACB010AE79B0@CY4PR11MB1287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PpaBKFQp3vQhrSgS4gGHiGt331T7XYFv1obXfa++Og9orGn/OxyCuIZcGhz0Oj8KLKnIZn5wFOQhRfpVVlwWwQG69Eqbt1PsKQIyR2k8bnvhi0pdnf4XsXW4clOcLGtQQwo9MKF2bIevp75IR6Cd6qkcTTyBu62qzvV1sK/IJrYF5GQvb8qniaFiZQ6XVbb6IeeURaWBA7A+nzjIzoMpwAB1ec4MYZd1cygyfxI1CyAlpZs/5QPYjHGnvxB8PsqG0RX4aO9l0Cyn7EulzgYQVVjapYaHxSCMzEIj8ouO/N3fvEZASotQD2qM3bCJuQbBGqF+cwZZq3LQ797fz34oUsOcWU27L+ctqChQRFS7cQ92r1qMcLDjMrx8wiw6iRM6TFDCneApgIljF0ODJqYdKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(26005)(186003)(6916009)(8676002)(316002)(6506007)(33656002)(2906002)(54906003)(478600001)(5660300002)(52536014)(71200400001)(7696005)(83380400001)(966005)(66446008)(4326008)(66946007)(76116006)(66476007)(66556008)(64756008)(55016002)(8936002)(7416002)(9686003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SE8IJBFLwrrNbq+JLNrjz9g4MThnioxpjPudB7CM3oacqAHloysJOu4CfR6qypEWyfKrfBULeTB1RUiFsKdbDFbN5AupJP8sVnmJXJd3dY25YuJhTpRj8gCMPWsymQK4tYMvuFjDtLbV8UeUORY8vdXmZiaDSzDaqzZUqjrvUK7jH4ISQ1GIyUElfWsF1/j3Hjgb84X33Y/5huAlRi2cucs9e2NfLdvbJ5s2fBakYb/E2lqpo9cXj5LMQxm4XjeEJgybMSbG9dCygkcB2Dt8Vu0NKqDZZy9UaevYjHfSCGC25B9Rjd1VbtX+zUUsMvuuwlU8ucpS+SaQAHbHnfFq7FF7qcHcs6akZdUkyuZzG2j+GDmBG83z0SYlYxpTHgiYumbI/s1123l9IPef1LNB+nrvvMorbCE0ggQwcTQYowPzhE720EItE4Cvr6R0ppJZsIx73ILScidZOwpPyuzgtxpYtZfb3s4cozRmU0hA4PQ+KlqdJ4xkyOenuJS5GTVC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba76e3-73b0-4448-49fe-08d8135abcfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 07:39:31.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u5j23VXjsL6uce9Rh+2Arn7OWMXjyjuf2aodCNKL0oq9rC/0eRYbTIAaRGOUazylCtFgpWm6evxzb+EcJGFuQxWY4iDjiDimaNOnzndHOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1287
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have these ones also here in case anyone is interested:
> > https://github.com/ereshetova/linux-stable/commits/refcount_t_fs
> > https://github.com/ereshetova/linux-stable/commits/refcount_t_block
> >
> > They haven't been rebased for a while, but if there is an interest,
> > I can certainly do it.
>=20
> That would be great; yes!

Here are leftover pieces now rebased on top of next/stable:

https://github.com/ereshetova/linux-stable/commits/refcount_t_fs
https://github.com/ereshetova/linux-stable/commits/refcount_t_block

Haven't tested them beyond allyesconfig compile through...

There are also mm pieces (ignore bdi_writeback_congested.refcnt as it is al=
ready done)
 that were sent originally here:
https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-elena.reshet=
ova@intel.com/
But especially mm_struct pieces would need a new look and proper=20
checks.=20
Again, happy to do them also on a separate branch, if there is an interest =
to merge
them (I expect mm_struct to be much more sensitive structure for such chang=
es).

Best Regards,
Elena
