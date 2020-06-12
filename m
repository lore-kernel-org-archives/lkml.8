Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45642C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0699A207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="BjEvmKLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFLGTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:19:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:9086 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:19:10 -0400
IronPort-SDR: fxy6SnMeEWwcfBRzn7rZU8GLmtDOuoplWDtko7TIS694SGfZZDpEyqOA6P2CNub+OC4YpYPfXh
 3ZAGcC3fLRnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 23:19:08 -0700
IronPort-SDR: MsRHplg7P0D0ne8Njeqdt2z66KW24y+eLmvriGrn7eOSFEhxL0wlOPwIEpyJJc5LZXl1XsyYM0
 KDDnahvaK+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="260893590"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2020 23:19:08 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 23:19:07 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jun 2020 23:19:07 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jun 2020 23:19:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 11 Jun 2020 23:19:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGVqg1FSTApyi4avcW3ockdKCoWTNivUizz4NnKE7fNGaS2kMuNdNnQ/IhhGzHAG6iYzzoxpigVloXqzgIX/A8BrMVy4+496HvOEFkMAwCGllHyKX4zs58pX68KkA/HLlPetwMMsbxxVEE0fu2WLRKdDeLVGyjJmlLiiu6uaZIHABCkynwqoDh0K/pFxwIPyzdHsfq2xdI6oRU0H2HbZ3jZkGtY+nEcLR6onBXiaH0fnVk2VLtF8cEy/kVtkjchwgqAFnIPy0Qe47i+ovuBJsqbcf5s2qVeB2e2bzGh+Ij5fW5WFQXYcb8D/uVUCfT4e1mN68SjMj5C9RHMU54LLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxlDWIQDg8tpRWphSO0ZgErvB96DSLXLr+gsyyMHYy4=;
 b=fmJNZi8tVxKKkRqyR537oT3bSqpnx/pHXKlhPCYgZScdUzsfCya5mD5z/VJzbo0o6XTGS6hdB2OoeVu2OAHgksuR6ZkgmLKSDUN+c3jD0zVQVWV8EkVUrZrcrBAbjDa34rjcKjfg0yKVUanomPDIsfnbVeLcnSsmvBjy3SVL6m0axg/enKsUWE94ldXu/cw2vlo3LjU3wXnZIQvHxyiqZOU7dUYZp3pKEOVAHUnbuRaVqnTistytcmI6gfZkoSJYObzHIxYDL47xJOPQw5Yr1K8k/llqbDvIC+lHQMGqPBpPuwy1d3EdMncSm9aHaOZpu6zsN2DLrWCPgAE3f/r3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxlDWIQDg8tpRWphSO0ZgErvB96DSLXLr+gsyyMHYy4=;
 b=BjEvmKLP5+BkjxUZJkCSxwQ4vMdn2nGRRNChU4Ui0aOMQnpDMyiNDCE3q64K4Nsg4KNGdNB+tGQS1E8L4BrLD4SVwdqB37ZY1tlblRhfhCfYvadill8OmGxM/Hxuwvw3j0zDfiW9mGc55HFMNVWCucDyXAxJ684BATWvgXbrlbs=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYAPR11MB3607.namprd11.prod.outlook.com (2603:10b6:a03:b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Fri, 12 Jun
 2020 06:19:04 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9%3]) with mapi id 15.20.3088.018; Fri, 12 Jun 2020
 06:19:04 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: RE: [PATCH] nios2: signal: Mark expected switch fall-through
Thread-Topic: [PATCH] nios2: signal: Mark expected switch fall-through
Thread-Index: AQHWPbquJSHIB8ZuY0KIS9gX8zbZuajUhvcA
Date:   Fri, 12 Jun 2020 06:19:04 +0000
Message-ID: <BY5PR11MB38939158FB1087F559A33713CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20200608173632.GA31741@embeddedor>
In-Reply-To: <20200608173632.GA31741@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f14d942f-e5fb-457c-1189-08d80e9881b0
x-ms-traffictypediagnostic: BYAPR11MB3607:
x-microsoft-antispam-prvs: <BYAPR11MB3607C8F7BDF30AC325EDB4CECC810@BYAPR11MB3607.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WZz7k/1Krag1VumIBPO4jgkyi1x74+D+/ysW1v9SLZ9P9vSTjPAEnKowamfChE3uW7HJknFK2yBbpfngRm5ck/kc1f0MQMJJ1X9bNf1sG3MB7Xe/NWwL9RWT759VUuIIlI4AhukjuSipCaI2TyR5FmeK5FDK8yhYfvu9n8fz1pwNWeln9INbuHaBlvw37I57MlXV7eN0BGa/pcD/aJzo88VYMtw8qFMYfdvSFIR4zKdvuiLe1keUEC5MGgHx/cuf5GQ/m+SQCStPSCpx1PKHSSqr7LMPSdJTn7ryNk4vtNlVLGNXiKA6XwymjqArXvfJW6EIcGnqO5Ziy6T5rdv3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(71200400001)(4326008)(5660300002)(55016002)(9686003)(33656002)(26005)(7696005)(6506007)(4744005)(53546011)(8936002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(83380400001)(52536014)(86362001)(110136005)(8676002)(54906003)(316002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Enf7jiaNuNSdrZNaDAPwKZb9R5hAqZevjKRd2394fkernW9VPzjx7/bdo17sCc1lLs4QlyyECW9TQir4B7f7J0HTk8HAuIsuq/I8wCwKU/RtwwfrSYcJ0Kmy/e7cnlLkiQAdBxsLiOYxbh6noo6h+iKV0N1hH2DBPtD7CvzBChm+Ag4MGmpDqcAAc6zlsHMJFVFC+JXo4scoDDPTC9PkjmFf8CnQ2jrjV4FyHa///kzGwzC3gJK++PgqfUFTaEST9KVS0iA0utz0D9tKuDdlMqpIImIAhh7kM5qS2Vpxaptv+PeZouZTqzOQVjGDvj6NmzCvYY8XlZwI3F+7q8sEqdQ5MWgLth8eYettBVK+qXOwtoblA7z88sJot1lSTfxCUbOvLBYq9wK3XQrlRKwKxwsiYzGKBQKhQXwe1F+quP8VsQr9d2rArThjr+aYgn34pnDNXKf5fGvWM2Y+1cd3u1e/tBpFOeJ93D6xXGkQmv94hg4+mhzE7T1hp5mwtLR7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f14d942f-e5fb-457c-1189-08d80e9881b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 06:19:04.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bD+m+vg0tebhoL4SVWFi/KyGMNkv0B0k22cmCdZvBdmUAxq7c7SSoDgmPdIqLGTl7kaGWgERb/ha+jgZyDH2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3607
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Tuesday, June 9, 2020 1:37 AM
> To: Tan, Ley Foon <ley.foon.tan@intel.com>; Christian Brauner
> <christian.brauner@ubuntu.com>
> Cc: linux-kernel@vger.kernel.org; Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> Subject: [PATCH] nios2: signal: Mark expected switch fall-through
>=20
> Mark switch cases where we are expecting to fall through.
>=20
> Fix the following warning through the use of the new the new pseudo-
> keyword fallthrough;
>=20
> arch/nios2/kernel/signal.c:254:12: warning: this statement may fall throu=
gh
> [-Wimplicit-fallthrough=3D]
>   254 |    restart =3D -2;
>       |    ~~~~~~~~^~~~
> arch/nios2/kernel/signal.c:255:3: note: here
>   255 |   case ERESTARTNOHAND:
>       |   ^~~~
>=20
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

Will merge to coming release.
Thanks.

Regards
Ley Foon
