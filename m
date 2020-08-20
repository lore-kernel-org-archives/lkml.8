Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9836C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5682078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="ho72egb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHTJLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:11:25 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:35904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTJLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvqg8p7IDl28T2MjwqrrhwStZeQEPTfsXWBlsX7b0ey9vBeOGxSNzniNGiHFKOfih7NZGwvqK0wGLnlYWQL0ro51nRKjrqKL9J5av4pNgxv8IEiLzh1gRfstCAEMIw0vcisoB0NCMRyTH4KX56ye0TLuQstDqYmoM0+cc+mGYrUcGmynwvnGm19Mn43lnZDPjYmK1BeeYwEy5ac3Q1drx/AkC5WXmHdKvhcGoJtHWJJILoiCesIxJ2gzQH8kd8n6DaF3pIVt4PxuR2MVSqgrT24LX+bUXJxrhRhgso9m3py06CdldPKpe0NPQOGl8UycqrlT7SLHc/kh4814X6qQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBvTnQ/oki3O+HDORedm9zXMjPJjx1JFDiBlSqL0tUs=;
 b=AcE1FlDklqlFfET8rFPCEFv8Va0hEDSBp9p2iHP86xTiyA6a/LC0JKX5lRjGQW+/2yc6Iwldon0Iw0lia8oFaIRjM6zcioo86hxumr0bH63apjDYfZnC8FaptIneH/meAwQQeysSHgps9ZvCmRpkcJRHRQddqiRT8AyM5wZRJtpNLWIFWqGfi5uSf+1TwpXSmShPUgjjMm11CMi9f8a6l2FB4FCUHJ2Kehdz3tZxvYdWj2QARYGCRiA7T5uiTLuDeOEYRknJERFroq/RsMbuwVAPwqwVb562kKIy1IMbq+YKDkBAJs1193/bRvp8VwXN+rInT0Qq0lZXkMQnce7Ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBvTnQ/oki3O+HDORedm9zXMjPJjx1JFDiBlSqL0tUs=;
 b=ho72egb5pwAosxObu81Jd1iIQKicPhFLhmuPxfEnIHjFz+hRZJnaXWwE4VlAh/huohTM8yrK7WFtvHbIaZUcdHNfH7VjryxyI6PBQz8kXv17kcIhSeLT2LjmNIUPiwvIZZD8jhutqbU6IoOSdaaf+LcwFgYdb0yXzqd6HKesabE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 09:11:21 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::85c9:1aa9:aeab:3fa6]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::85c9:1aa9:aeab:3fa6%4]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 09:11:20 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, Suraj Upadhyay <usuraj35@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: wfx/hif_rx.c: Fix spelling mistake "negociation" => "negotiation"
Date:   Thu, 20 Aug 2020 11:11:16 +0200
Message-ID: <2117465.u6biEVJElo@pc-42>
Organization: Silicon Labs
In-Reply-To: <eab6bcb570dcd1407efc8163ff8ff976f623ae9c.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com> <eab6bcb570dcd1407efc8163ff8ff976f623ae9c.1597913333.git.usuraj35@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0093.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::33) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by PR0P264CA0093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 09:11:19 +0000
X-Originating-IP: [37.71.187.125]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61c4be1-6ed0-45ed-2d9d-08d844e900e0
X-MS-TrafficTypeDiagnostic: SA0PR11MB4544:
X-Microsoft-Antispam-PRVS: <SA0PR11MB454417E341798B77EF1C3653935A0@SA0PR11MB4544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFjfj1fMiNbgus8/dS4wWjaLQ6oAvZK8dNepBo3P1jCUf82Ytj+AkGGIwqaLIJksCt5JDP9aZ2cbCQ5S4iPHWYNIuMppfWaG/edUE4hu8kJqRcCmlY7kGZwLrJWmUZ67tb2Wn9/EHMFsi0O9ZgHXUeOFyiXWRAkzguYqMSFAxfPtwFzk8/SGyq2LB1OXnvKAbESGReCOIB/zrvv5Cg2oMkjxvuZjzPw2zEY//iXbyVogeVtR04MYp2TWbL18We23qlYeK74W796uN+CchHfn5USPoQeozchRgzu0yLLoZxJ9KR6kPnDaffLSGCPj671UZhCY4NN/vvmUq3GNxvQpIKEuSRH3UDnWr4E81nsleotljj3uGw5q5FzQKf7sjtqjP2RVVyQDYxutfdQKZanYJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(39850400004)(376002)(366004)(346002)(396003)(186003)(6916009)(8936002)(8676002)(956004)(9686003)(478600001)(86362001)(2906002)(5660300002)(66556008)(4326008)(33716001)(66946007)(66476007)(16576012)(6666004)(6486002)(110011004)(83380400001)(316002)(52116002)(36916002)(66574015)(26005)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1MdqK417BXA37J6p0BIWxddU3usp514uLeQKEXHFPUL9MmkpIEE8bIk0B/VpKmsVMGjP4rObUUPPTyC5Aj89dos+svfqhxmNFgafdFwoAFYZza1xn49cNU0MkfMT0YD3+FGgySEwizMWATFUnHDbt/GqrZCWxKMHuHN/oelslIiIlWNuNTP+l9f34ODeke0YrK0NRID6ccnJN0O+1ZxKG1hw0S2KFCunkJF9UgnO+skiLvAdNGvWSgc5qEyXiZFNrY0RyhyWwZOrKpFhlKzm7KfN7eBnWVW+NRPIFQo9eLJ7y2Ep1+G3SLaW/mYxVLtVxrVgkWupbDQ2AexrWl/MBPSJlfJlNn4fGRuvNiPRf/FMoFWW/1mBc4cWO9XWGlrvw37WR//SJi4I95cwLWn12F61/SqVn6ODh4QS/uEXeiJVjh9nVyU2pn8ol2c0FoJzOm+xZYfg+OpvXLCxqRJ13Qwy3jvHL5yDYLfQqxHQq/WEpm3Umagr4+IQTLq/COUSXYMXtZIe1BTGiUCFckBK9r4E3ZhKD8CtIh//2eYVwNpeC7O0cYkUmDHFD8q5nyfzJf4ZgrUFvS2kqjopG0Bw8tpOnjtDg1Tl0TqNJJmNCwaH1ZGWUpJAOqfwQJxzaxNj92y6Zr6/kafL5kG5s0TVqw==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61c4be1-6ed0-45ed-2d9d-08d844e900e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:11:20.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDSb6/JCBUiCMSakR7V3BLn8U43kdXQBbIRJ6jBGGldstdtkjs9wcYLVzn1UX3Mij5nhT/pBEkjOtnwpUau5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Suraj,

Thank you for your contribution.

On Thursday 20 August 2020 10:51:27 CEST Suraj Upadhyay wrote:
>=20
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Even for a small change, you have to fill the commit log body.

> ---
>  drivers/staging/wfx/hif_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
> index cc7c0cf226ba..1d32973d8ec1 100644
> --- a/drivers/staging/wfx/hif_rx.c
> +++ b/drivers/staging/wfx/hif_rx.c
> @@ -118,7 +118,7 @@ static int hif_keys_indication(struct wfx_dev *wdev,
>=20
>         // SL_PUB_KEY_EXCHANGE_STATUS_SUCCESS is used by legacy secure li=
nk
>         if (body->status && body->status !=3D HIF_STATUS_SLK_NEGO_SUCCESS=
)
> -               dev_warn(wdev->dev, "secure link negociation error\n");
> +               dev_warn(wdev->dev, "secure link negotiation error\n");

This change is already in the staging tree. See commit c9638363f02d
("staging: wfx: fix a handful of spelling mistakes").

Globally, if you post changes for drivers/staging you should rebase your
work on the staging tree before to send it. You can use the script
get_maintainer.pl to get this information:

    $ ./scripts/get_maintainer.pl --scm drivers/staging/wfx
    [...]
    git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

--=20
J=E9r=F4me Pouiller


