Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15888C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926CA20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="M6IU+a4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbgEMSCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:02:43 -0400
Received: from mail-eopbgr690072.outbound.protection.outlook.com ([40.107.69.72]:51425
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390049AbgEMSCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L38nZifO2JRwOg1T2KYImiZxgpBlD96lfWPQzGidI1NChAVOjfYtOGgcMVGxMJdeKe2bYjTe6A8XcGHpSQUH3/SJkTFYjl5ZzhB8ZLGdoXa6XpBLefRZs28pGSVCHfOOlUJmurfea+ILE6GAriiMOnURxpUD6GU9d+71fHRtRehmGuxHESshV7sgTD21FkevCOuiw/NGcyH2vpSeIMTTuZQdFFuxbyhr0butPU341hc54+/t8Yc0kqZjKosBDZYTffRz+22iFzYbtgOxc59OJhTZnlw5Ax6eaShzEBeDU7HgXxVAYqX5dboVQniIzzJMv//z2xrnANThijgiwtZMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ+PCNXiaBLRVrDVQ7vaKGvTHKGUUYfHkHgnxFuo7Xs=;
 b=lj+rQLNV1b4rbT55Moio32gbqsOLS5UQswPSHVRKlND9o9G8NkI3IdG/RmElNHSGDRew7If+AY1LQnF5qYQMBQmTZawGh1NNd05hWbD/NCKTLNgETYlbcv+d8kh4DmYS3/cunuUCbyPV73T6nLJrFC9Ux2KUthbB+f0Z0rQCYK8NRzqrAqatBUVtOQmQL0pPkiiIefNiCgzxtv1ueZO/HxlHCLaLHETNmbT1g8Mg3BO5ODFJKP7tuQa81134WfEKu5oxNaLAIeEGfNuoinqHpJ1OE7QGPH0MIbzGgUeJO8mU7bAsCeAeUby1wqmgoK8sWq1yXrPgf4isk5DYiEc0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ+PCNXiaBLRVrDVQ7vaKGvTHKGUUYfHkHgnxFuo7Xs=;
 b=M6IU+a4vZNoN0fA4M4j1wOyt89GafOKOIMVLZNw63cyUxk2a+HTrKMP0Db2o3KVuh6bUzlG8edpK3KA5e5yL2eW5mjRc/yIRjJkJqnq/Ypj88uR90wJMyhKWj2fRM90Rb0cYhMqhHLJgUQABqbx4G0cNEcYBZ7Xi05YBGHsKNP4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=silabs.com;
Received: from MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14)
 by MWHPR11MB1440.namprd11.prod.outlook.com (2603:10b6:301:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Wed, 13 May
 2020 18:02:40 +0000
Received: from MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da]) by MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 18:02:40 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Mohamed Dawod <mhm.dawod@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wfx: typo fix
Date:   Wed, 13 May 2020 20:02:34 +0200
Message-ID: <3242246.g26XRxWjXc@pc-42>
Organization: Silicon Labs
In-Reply-To: <20200513072433.GA11560@dinux>
References: <20200513072433.GA11560@dinux>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN4PR0601CA0005.namprd06.prod.outlook.com
 (2603:10b6:803:2f::15) To MWHPR11MB1775.namprd11.prod.outlook.com
 (2603:10b6:300:10e::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (82.67.86.106) by SN4PR0601CA0005.namprd06.prod.outlook.com (2603:10b6:803:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 18:02:38 +0000
X-Originating-IP: [82.67.86.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e735501-7e67-4a34-3fff-08d7f767d38f
X-MS-TrafficTypeDiagnostic: MWHPR11MB1440:
X-Microsoft-Antispam-PRVS: <MWHPR11MB144086DC445F226083F79A8993BF0@MWHPR11MB1440.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L711W+IdF99lERDOnWMZ5nSwzD16raY2PF7tY3iLWEiWJQ5cK3OkGxiW6F7ejFZuw5aYjQwbLhEYB3/DVrxx8ChdzpusL00MLVfxuv1DpckZvFdPWovmB4vifMhCeMUqApXTm0KrYRx9/imk7SEHuPFV6KBuL3vWJgSJJa9c+C2hQzuuitr2ZT0EAbD7a/+E9phMDTwowXd9rYKpouOyECMTj868b6Xaowr+iui1crJ1w6fAZcrl9SvjAlARf+fYEMVeRC5jJDuuZk76ycFK07sTHcwYuDmTqYvm8XowmUjIyDL9cxLXntiJn6KI7f0D4hGjJ9zsNkFZD1Z6+wlfuEQSmUEsy/CUZLLU3SkTEiGg1X7eok2ZV5lCbiTMPSKDooDB0KomqQGdRy5eceDxzvzvj+RX1xKn2550h0L0MwmDCypn7rNrqJAmRSKXRjrf2ge5lwXKWxT98xM6DtZMRvVtZkfb7VWYVHa/2vLoPYrwJKmvlQTFI/5FxMI1zhZ3D3XnVo5mHYqnQuc8Fe6MtwWK7IFz5xNCOctMOfN9llSCImS3p0JXmra+rfPs7b19pvPaaiiUYg49k/HiW2exDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39850400004)(33430700001)(6506007)(2906002)(316002)(33440700001)(6666004)(9686003)(33716001)(8936002)(4326008)(6512007)(478600001)(26005)(52116002)(5660300002)(6486002)(186003)(16526019)(66556008)(36916002)(86362001)(956004)(6916009)(66946007)(66476007)(8676002)(39026012)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NhlWss0z/O0ZON1E87ZjN0h5zxSo2seRgflWGHNf6l4IJn5qmv84sNhBiDd/nXD5E+YJF2HqLYwyD83Tqz4OJ79ughp7LN/q4OAEtmuuIh/sBxVDVEA3uCVzwMREZ4VSDae6c7edi4e9m++mvzSVTlbbyDV7Nj/uuNRKkpNezUO4at98zy8eA1GoxELmtTfP3xIkUDxlPuLycksRyucvVEYATOgW+LHMA9lU8iKKr1ZsOzd8B+9ajSMOjcjpoXdoW7Z5fhIfNzbwHLS7JhGoTnZR/3Bjl+C97aj9xugVWNTZeJ7Q3xEzCcBMM/vWJTQIGDZgnJot9LbzOjOMyx4WcthPFWp/ak8MPLyV8XY5YNztWJa8IlQIL4hi7jjcW3Xeqzz2VPlML9cSZl4mN+RpstYQ8R/r8KTBvpLiPdziQ+lg1yfh7kZ37hsUtMWwrotdZeWZDV/HMyKTg5c+27HZ4CLzyTW4Zo05D8RHteJQZjo=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e735501-7e67-4a34-3fff-08d7f767d38f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:02:40.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKOYsQuDNADPrzdXJeeiQcoZJpW8kRo1gl3RCDEDcLg9dU75qJWBbyGTkHUCJPaQ06XiJDHOtNKFNQVEBOJJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday 13 May 2020 09:24:33 CEST Mohamed Dawod wrote:
>=20
> fixing some typo errors in traces.h file
>=20
> Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
> ---
>  drivers/staging/wfx/traces.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

It would be great if the subject started with "staging: wfx: " (as
the other patches of this directory).

Else, I like when commit messages start with a capital letter, but it is no=
t big
deal.


> diff --git a/drivers/staging/wfx/traces.h b/drivers/staging/wfx/traces.h
> index bb9f7e9..80e131c 100644
> --- a/drivers/staging/wfx/traces.h
> +++ b/drivers/staging/wfx/traces.h
> @@ -32,16 +32,16 @@
>   *             xxx_name(XXX)       \
>   *             ...
>   *
> - *   3. Instanciate that list_names:
> + *   3. Instantiate that list_names:
>   *
>   *          list_names
>   *
> - *   4. Redefine xxx_name() as a entry of array for __print_symbolic()
> + *   4. Redefine xxx_name() as an entry of array for __print_symbolic()
>   *
>   *          #undef xxx_name
>   *          #define xxx_name(msg) { msg, #msg },
>   *
> - *   5. list_name can now nearlu be used with __print_symbolic() but,
> + *   5. list_name can now nearly be used with __print_symbolic() but,
>   *      __print_symbolic() dislike last comma of list. So we define a ne=
w list
>   *      with a dummy element:

Ok.


Thank you for your contribution.

--=20
J=E9r=F4me Pouiller


