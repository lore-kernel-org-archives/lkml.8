Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A292075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="OvWqzx4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHTJSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:18:41 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:34145
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgHTJRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:17:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOgSfZKsbgLpK+nnCkIDXUZ7nwhAr/tANR23BjLMKNF1tn1T3nJ/7+YEJiXWYrDgZF0LotKJ8ZQzhU5ei4xPH5fhnVBGYiDGHkP+6erpLW5wnP6mJUHIvhiYTQ5trcOYBeeC6QdkeARr+ZwKTMuofO6tfqeztSuX02z/TeBhwnElsDJm6/1dJIdcXHxPewZxLGXvSQ+u9MKf4VDfiicFng3Fotq3amUy8JphWL0LRUz31CDfHfjP6epaZzEcd9okSryH3moSkI6qF8vBWsb7O2uiA6AtAmrdnnVDoIDJt3JtAUXWsh09yhUPR4cMBd8W9+DWoaTMMW14WkPJWF+WJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re0Q6oQsSZB03X+6ebzlSnGVNLjltNFLyhToBTxliO8=;
 b=bmV5sxsvSveaYWsbCRcU7chxJGfFHX+O/+sCGM9PsShaLC3LEK+0RgiiVVkwqTeF/CNhTjMYi5hOUtPyNj0tVlWmTd0ahF9lPqTFagaSMSJnJ0txhUq95eN0WYXEF70+w09SEpVlisO6Kt8khy+kyAvmUOUsOGdW5x1DDFuVJfh83MN3xJJv465UtDSnDkejLw407ihGFBGhwdIggpSt2u7OXLsc35uySTZ5KRYzgvWG+p4BWPB2xRXbxIP61I7pxXL3Lk0J6HduC5xKbGaUAxFcgrTde0a9CGdweyuHDyV2JVP39ZNBiTQp7cljyLrsgRzi7SPll9LPxZIAD4rC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re0Q6oQsSZB03X+6ebzlSnGVNLjltNFLyhToBTxliO8=;
 b=OvWqzx4qq0A7LmWhv9W/9E8ChZOFygduArxYuzYFwN3AlVccSJSfVzaTOB5b0lDZqJHZ5sZNMw57jv82RpITxAh2BEd3BYfUOPeBr0jUBrWGyIthLEtq1Y1FgxkVZktT540vVzWij/lgcal8sUP/HXVgKHe+CrqFGVtwVXyNAYI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2560.namprd11.prod.outlook.com (2603:10b6:805:55::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 20 Aug
 2020 09:17:42 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::85c9:1aa9:aeab:3fa6]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::85c9:1aa9:aeab:3fa6%4]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 09:17:42 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, Suraj Upadhyay <usuraj35@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: wfx/main.h: fix a spelling and grammar mistake
Date:   Thu, 20 Aug 2020 11:17:35 +0200
Message-ID: <20227794.A6qR83TFM7@pc-42>
Organization: Silicon Labs
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::12) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by PR3P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 09:17:40 +0000
X-Originating-IP: [37.71.187.125]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af98263b-4cc7-4357-145f-08d844e9e414
X-MS-TrafficTypeDiagnostic: SN6PR11MB2560:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2560787D3E93FA54BF239B68935A0@SN6PR11MB2560.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+pMOwp2Cx39c+1H+ZX5SZgc4ND/cKnCJwOyyNfZuDfAkgyA+Pf6pUnDriO/S5JSpF6eJDkDjvlPnf344Gwf1OwruOKzAnzf3noYRd/OFJv1JHYbBd7Xi2utIAcDu0Ho/U0OIYH+NQlFfQ8cie0Oa16PC3rRD3TSKOIWwPpKgVqDJztjtEo1c9p12ZhOFuVVACnXFAcUOC2CBNAh/4fitpgg5Ekjo1jbmqWTBVU8y4AtlS6UsdlqXHAn52AzsfgUH1MJwXAj+OOiSCGGj/Q6+1j1r7YxpPWC+eNXikQ0P0fUla7JeycD59oAAjSEk89h79OaH/39JdmiIGo8Q7bUpT6PMh9x0LDnS1Ovs+wXZ2YG/KjCZ8BpcuMzgH5MZaH3y3HzUsdl8G67boTkuQnPtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(366004)(396003)(136003)(346002)(39850400004)(478600001)(6916009)(4326008)(5660300002)(26005)(186003)(8676002)(16576012)(4744005)(8936002)(9686003)(110011004)(52116002)(956004)(36916002)(316002)(66574015)(83380400001)(2906002)(66946007)(66476007)(6486002)(66556008)(33716001)(86362001)(6666004)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ES5ux+U5TOWCTO3+zC5YmhIRhRJgsMbnd8o/pEq2YbgTGvn8bH/N2O+3qzVXk7nPUc14jnYXjijpbRM5YRmCv8vi8jKIzGf+CTc9s7Ixv+9tUXPbsNG1pS+hhAI6W5ZBPOK6pQV0bC94wzLRtT3PtYVr7hBV1MONVFhDbzqxaQjz1bIVvZT+sbyPHs9ekRWd2JM4ohiTnC4RZWZefgOe6O1H9FsjX2kXbpr5MdKNqIOWlVHM++6otJKApCjMdTR6HpH6r2VXdWJAWAopHHMUs8rZKa5C6YjGsS3qk9XHl7qrmAmCdkH+6U+15BoFCeBMVak4DmBqcCbETzgzu5VGtZan8g/ETHNMWU7WXDb855FO/4GGHHADgy478pVCpCs53UxToUUmdUGOL+V/oSGNyDMto5GEWrWqWwJpkx2UaifM+q6pmJ/8BtyCu5HPKP7M0Ah6Qr/Kiuq/Xkx1/oQo3BsRRyUuk/+AS2WZCnVuvQmP8siV5WAO78O8qsC1/fCTkoMUEwpWwdZdSs5qojeaHav+9hHEpwE03dr3UWkP/uMJRE2vJA2C43pBi94aqTck/AlTqZ5Z+T/Pwvif8ibr0+NKTJvfcWbJLBcFrDCuK+r3nkze+dl1k9uBa4DETI/uA46JJ27KCBPwsR+OdhLnfA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af98263b-4cc7-4357-145f-08d844e9e414
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:17:41.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O53/rT1js2N1mOCseGZnbviAnOpRthsuIN2Px2TU8Qhqg0/zayfcDrFI5Osdj7f5qjD8FiDIxDYiMS09DDPf5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 August 2020 10:49:33 CEST Suraj Upadhyay wrote:
>=20
> Fix spelling mistake "extention" =3D> "extension".
> And correct the statement in passive-voice by adding "be".
>=20
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/staging/wfx/main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/main.h b/drivers/staging/wfx/main.h
> index c59d375dd3ad..2457cb595b0f 100644
> --- a/drivers/staging/wfx/main.h
> +++ b/drivers/staging/wfx/main.h
> @@ -19,7 +19,7 @@ struct wfx_dev;
>  struct hwbus_ops;
>=20
>  struct wfx_platform_data {
> -       /* Keyset and ".sec" extention will appended to this string */
> +       /* Keyset and ".sec" extension will be appended to this string */

Already fixed by commit c9638363f02d ("staging: wfx: fix a handful of
spelling mistakes"). But, I am sure there still are spell mistakes in code
of wfx driver :)


--=20
J=E9r=F4me Pouiller


