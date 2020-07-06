Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9189C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8A206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="Y6YbTeVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgGFN32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:29:28 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:6148
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728961AbgGFN31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDQsKRbGvLl+LlmKHq7+pn5wR/wqB46eO03G/ijSCYOhQdNAKoYW9getpvpjnE2QwE0ab8zXWtrbQib/ayT7wHwBLPN4aAuoBps5ykoDol1DuTwGWJSBaul5c2ALB4R1SYIdOftv/FVoMjA112DHkF6Rnfyg5LC6rSzGCPxP3z3uI2/xUEDXNswc9eMu+Kd3HCBbCqlIjmw9yjbXIAqgSc337eTIhWJFg5iS1J5fLcFRWvBmnrhdqDUoD1V9Lll8lGCqMl0VyI+qi9v+vwTw32Ju1Fiu78IYUrmDYcaypOuKWXv2ipuZ02EI8wAYQR3TjxltBvkEhXOlfzc3lPJ47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzlwAheT/cgHgQE7DzkfaziqnNXXOUv7EK9tpasX1FE=;
 b=NEhph80gMtDaezJHrMA6KO9kUyQXyx4P1nnsRaV9kL1n6mHDqc6NsPXXe+bUPWLQRlf9WkLI1RcfqEYwf7wKGMU2avTdYZP+Ne4OafdXo4RQFguT0cdWxIlX0p8JwiYP6u4KPuJ3gdptOtxK3kZzRppq5JuFHnncAlfeAh23wyyeHTjDEH/3/Qsf2bHqbQJLiQqY/YyyZi8TjX1W51cvLOI4BEWnA8eao3JhzZrXfyZgOWRDVm+NSebSkYwIe1FpvjFbpXWI3lU4HPcTp2kgXll4IXIlXwUtTFu2Vl+/4+e647p7Nzru68M6OwQmDNYh90/PKTXSNWrJqU5wnzHHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzlwAheT/cgHgQE7DzkfaziqnNXXOUv7EK9tpasX1FE=;
 b=Y6YbTeVjiuj0+oy5UdoK4rpS5lCeyG+QmrsF9PRaJaR2voW8wOCGTSoKB+C7Uu7hUqDwrnJJqrEsiGo/2jA2itlymXAolTYDqy4NeEK9WjNjw55v+eGiXKe+3DaVKX+lVcsCTw7eUqgFQ+ouJ9TbVE4iMvXvrmMxPBkfBIr5GGM=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3455.namprd11.prod.outlook.com (2603:10b6:805:bb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 13:29:25 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::b412:798b:f6bd:3e6d]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::b412:798b:f6bd:3e6d%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:29:25 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] staging: wfx: fix uninitialized variable bytes_done
Date:   Mon, 06 Jul 2020 15:29:19 +0200
Message-ID: <6155735.5LkVgl88Ba@pc-42>
Organization: Silicon Labs
In-Reply-To: <20200706132017.487627-1-colin.king@canonical.com>
References: <20200706132017.487627-1-colin.king@canonical.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::26) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (37.71.187.125) by PR0P264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 13:29:23 +0000
X-Originating-IP: [37.71.187.125]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84abe317-9c1d-48a4-3a52-08d821b09986
X-MS-TrafficTypeDiagnostic: SN6PR11MB3455:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3455DBC8BA58324B3ADD5A4893690@SN6PR11MB3455.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9RCFB7Uv9ommQUtWLR6ul//wlGSvGA1fn/Qtn9ZrmyjCfTMDUNDOJknIQ/rlJhzbEa0JLFh0w482dpKdjotd8OnwPh53oS+R3UN2lEPBIiriO5VzYP282pUVgErt2Bmgdf7RvPgMGcP3r9GaToPIq2vQYQ4i46d9UXskjk95bZ9vMpVSs7F+xftNu43XYg7bD2uqERDMuFZ/uKAxn4j5Anxh45a6PQLSXVaotVtEONJh2kIlqpiO9tLv4wmZ9jpo4SDOMlWF3wNQv3wuEjovACi/Eg7ph4jNg3zZ9zrc6Z+HaZULvgEgtqn4IPIIIX+ctF7oCOhtlDZNllIaCp9wCE3JmefIPaoLSanmq4fn2Us/Eu0VhPULokWq/5RU4Kf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39850400004)(376002)(136003)(396003)(346002)(52116002)(316002)(66574015)(86362001)(110136005)(2906002)(8676002)(4326008)(6486002)(6666004)(83380400001)(186003)(16526019)(5660300002)(33716001)(478600001)(36916002)(8936002)(9686003)(6512007)(66476007)(66556008)(26005)(66946007)(956004)(6506007)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kGUSuGxs7WdiDg5bWE2Mb7mIfME1e8hECRUgXstYxEC/29SOj3XkSeyLOg3gxwNbui5ie+XBvNV2knM2e9nBy4Ya4taBlK6omZKx6CfQ/BfAiPEGxdvqklV2lpSJ2dONl5fTaM2Bq/LZDulR8rkkXWUMW5aRsTiO/mLCvjbCHz1luOydyjG3U23w/42RJc1usWoF3cGv7S8SkryZpT0cifWqXtfQFBLwTZJaXAVpWdxvoCsLyLVveIPmYIjxbq2RkF7XNr02+xIP+GK6bGodw5oNSWRXTT8aK4/OPof7Y2HM7bFA+u91PRrcKWNSPmtESbDzeQw8rpWgRKkDIXl1e6sAToSEGwn2F1sLuhXf7ikjyNJ+Yc3O4Gzc91u/4ub4uPg7iiloecODyxd4X8uBpNefnY/AzVexOXjWCR1Ni1lAjBWLNq8lAMZ1DPNtJRkOM4LIcVtCD7xy4ew+A3/rCxYq82U/2J84nMPAUgRo8ps=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84abe317-9c1d-48a4-3a52-08d821b09986
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 13:29:24.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KfekXgUaiL+1hSkqnQS0+wA693xKJibTFtUqlAz0PMpPP0/f8kMI4pjRXuwWAz1w96La3lhLthdGRxwyJkgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 6 July 2020 15:20:17 CEST Colin King wrote:
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable bytes_done is not initialized and hence the first
> FIFO size check on bytes_done may be breaking prematurely from
> the loop if bytes_done contains a large bogus uninitialized value.
> Fix this by initializing bytes_done to zero.
>=20
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a9408ad79ff3 ("staging: wfx: load the firmware faster")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch!

I am surprised that my gcc hasn't caught that.

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>


> ---
>  drivers/staging/wfx/fwio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/fwio.c b/drivers/staging/wfx/fwio.c
> index d9a886f3e64b..206c6cf6511c 100644
> --- a/drivers/staging/wfx/fwio.c
> +++ b/drivers/staging/wfx/fwio.c
> @@ -177,7 +177,7 @@ static int wait_ncp_status(struct wfx_dev *wdev, u32 =
status)
>  static int upload_firmware(struct wfx_dev *wdev, const u8 *data, size_t =
len)
>  {
>         int ret;
> -       u32 offs, bytes_done;
> +       u32 offs, bytes_done =3D 0;
>         ktime_t now, start;
>=20
>         if (len % DNLD_BLOCK_SIZE) {
> --
> 2.27.0
>=20
>=20


--=20
J=E9r=F4me Pouiller


