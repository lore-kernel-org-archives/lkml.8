Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65791C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26645206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="ZfYz2O39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgEPTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 15:24:34 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:50400
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgEPTYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 15:24:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM/zrXnIt0vohgGR9eKQw1YCYU6aoVeTSus9LzbCAzZr15ot8qmYyv/3OrbrEMHDN6w9crwWiMN7zN7nYsK/pC6gxoOhABpcPnz4bpXZswWsemZlDTQ3ANxvDkRFqZs8PJmyucVWh/9EFtxexlwh7wwxK3bfksPUhjDfUHJHtHbVbG1z0JdASM+xW6AwCIJvxCfSFqt1xrMNvWXECsQ7mXVcgfhM3AiTZ2zYmpTW1iTHB0DWncWnKxq2DQ97aTtz4coi+v9JZUySOm5nU1ejfRnkOZZUb2wEGC5wz1tLn7hDtlCrdhTjTxJAZIKLKpRWpAO0Gv/Xm0F3/Lj8MMWWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D2ggoSqjtsWx+YLOxSg+Rp2JayxG48GOUFWTuM8UD8=;
 b=ceSTO3KiRahwstvU25GSncGW4JQucLxLhkWYQYGnXHtrh3T/SuXVG3nuYLEniP9QUArjUHDuSBJJDMfrre69wMqgfuUE6aljpIHJmZPhr1HgagweYIg9/63K5mz3npdQGjSw23kSdG2KGraAE/rrzHagnPRo3dDA8lekB7VLh/elDx9BAs4hX7MzF1W27da5SLF9+pO80fMmyxJiWLjIAEEAilBVhcQ+0MGrIppIhPwl3GWB/m+JeD2dqXW2jXO0VXeGmRYLVysznH93h90hsW2QYE35gR5nSlzzZLdf6r78lUF+yZRsBxns6vUs7hj5aIAiS0fQY30NW2kWKX7a7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D2ggoSqjtsWx+YLOxSg+Rp2JayxG48GOUFWTuM8UD8=;
 b=ZfYz2O39dwfyd1divXUmPBMdCuTBrqsefLmVqFEiyWVLnxKm2WDbuEc4XFvU6Vka+b+Zn7QVDVCgNWdMeGaHF77PHvocn8ybQmh8WwphrMSPVejJ9dTWEegLXqLkhJGXsub/AID3tNw3Lp9+OtlDirAG3+aSbff7ytBCSMJ/dF8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=silabs.com;
Received: from MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14)
 by MWHPR11MB1280.namprd11.prod.outlook.com (2603:10b6:300:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 19:24:31 +0000
Received: from MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da]) by MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da%5]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 19:24:30 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Mohamed Dawod <mhm.dawod@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: typo fix
Date:   Sat, 16 May 2020 21:24:26 +0200
Message-ID: <3228807.hdANLyfC2B@pc-42>
Organization: Silicon Labs
In-Reply-To: <20200516124359.GA11592@dinux>
References: <20200516124359.GA11592@dinux>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: DM5PR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:4:ae::31) To MWHPR11MB1775.namprd11.prod.outlook.com
 (2603:10b6:300:10e::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (82.67.86.106) by DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Sat, 16 May 2020 19:24:29 +0000
X-Originating-IP: [82.67.86.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15345b2e-26cd-4d3d-b622-08d7f9cec16a
X-MS-TrafficTypeDiagnostic: MWHPR11MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR11MB1280F2BB9DA46B9A71B771BE93BA0@MWHPR11MB1280.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOMa/yBw48Z04SPwq+3RiV+B8xUMrQP4S18zpdF2IoOXz0agbkWEL2uJqgpZU5c3xqWMKFiXxymqOOnqEWetnjiV2RG0b8m/UT9xZwPjwVmhHoIci8dlvYFGWjhAZ/kI3OU3G7GNs7Bwm71Sc2vDEj/NK4PTICk+MguRWnEDjIXhD/BRjNXo/1lCfojeKrO4NJ+Y6nWfdE86JMhewEKa94iwTiykEO5F+MMXM0eDeb+fYAgTaW5TvUiBKt5Nm19hjNsFU/xtrFU2emShBRkFGLzE8rGo4SVOx5ODQBWboV4jAp8ykqo+cHSnX3OSYQeOF33xPz67OFRg7dVNnI9/60bWS/2BzcKQGz9CZ6UQcp3wKzcSfuoi5RqwlSWB/wRfEHnoIK9VMrMzGvtz7vnFtDHHOoIm/M93ad6DgqZmOEOrkCNxhNOCMLVr4ROqcnnTdjHc9D6eNlCErl72PgA8PhI0LjAbMHA0n3dYOzpaWfg3bgfOiAfzghVw9KxFYWAfrTVGora2+8Cw8WpOehWbsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(26005)(5660300002)(8936002)(16526019)(6486002)(316002)(66946007)(86362001)(66476007)(66556008)(186003)(478600001)(4326008)(6506007)(956004)(8676002)(6666004)(33716001)(6916009)(2906002)(6512007)(36916002)(9686003)(52116002)(39026012)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wnQNCyUHBFA3d2MLjAWq0I6hbqvp1cE4Wvnit0kW85Bq+By2PzQ6weK3YiXtZ8VhkB4OlOSdq05EGGhyjUgxAsLxNOiLcstaMqDdp1QGeF5qdshPwpufpKR4M3mbz4KDj9pkEdGZ01CLDB30eggQo235gakdDeb6U9ZfCLyNaaIMLtNKRxyuVevLKQ08dHYBkIX1DP3WOva44Cmrz5oSEQftiOd8v7339imC4ZvZxbYvkzjR4oLDJw6Hj5dGU5U4rISJIQc9EDZ2ffQjQfP9ugVhiTyAsKLtDB8T5hKl+zyVSMQ9w2BJqHmTrf6FV187B8mfEaOony4id7ajp11fAPiJLCOZnffeZHaKC7GIiKUCFHZK80YQNlhIWAEOK9H0ugzwi1L7s5fElcLCjcdNgcNRDofI/xTt3Yo4HQhNQ8DgUKb9HkrwaS5CK5fyWY8Ga1TCm3HsAWerR8UTK17+SgfmMVbr5OGocrovHYXIx7E=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15345b2e-26cd-4d3d-b622-08d7f9cec16a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 19:24:30.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twFzLSu2aGIz7knIUJtuA25p8RC+OW9olp+yAk0kJ4UAClS6xG7AvzbzuE1WciB97XASrxsXC9wzKo/c3/zgFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 May 2020 14:43:59 CEST Mohamed Dawod wrote:
> Fixing some typo errors in traces.h file
>=20
> Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
> ---
>  drivers/staging/wfx/traces.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
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
>   *

The subject of the mail should have been "[PATCH v2]" (it is automatic if
use the -v option of "git send-email").

Apart from that:

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>


--=20
J=E9r=F4me Pouiller


