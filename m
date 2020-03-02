Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF434C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87507217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="VnouQkg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCBPnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:43:15 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:39555
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbgCBPnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:43:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZt3FGTPMZIchL9gBaXP5ty+ldlfk2r/dPBvDpst/z95VraV8GhJey5TUZql/5wJba2FfN77m9Q9vL5+voGpkiFaHQuuyDesrGWG6B7nNt9msY5/WWV3YWd36azQy0mg4DxrrUJj2wiOR8zL1SR/zmcN+aGYYYxm0uXuTYi9snnS4HhZ9s3Ug9T9dUszOl8qzRwTLG+jsLZ/e2bevJSXYDlEvCup+NcIsIKuwVYw1+xAQnWyc/V4FR1uigMKYCHNpKOSfXXxnOf9C5BzGmbTpqhsGHR/nUpAamUV9vqX4LQ0F0eTxSqtLpfKyB1Kg77lpa5g41zzRzPN6cb3+FbK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94AIEAfmbc8N0LDV8hG4602iETHCoKTrTeicQgDo1xI=;
 b=AAT2QSeXx3aKZnt4DRdA32YfWeOPrJ9X3KkvwKUEKoJXvO1SvB9p0d+PRuA4YfF3SsWPxKAsNPqEGoymdCEiCLrh5CJvAk3oviTKRY6TJkYWFahZ72oDOCy4r2/tWi/cFtB2zAXDfNSaeoWaRtb93kNJeQCv4ckdWW5QR11y26OUsj+bn+OuzJR6bl3nfGH3cwm0wUvLuQwsXF11tKo8NXNGDxr5BE7qn2PvQsirytORWJjuxj+6wsTndfYmUgXBqtVq2MpR6sJjMmXWEu19JHo1qgXprXl8XsXC/tGcy2FTM9AalO7mlkGyTH+ZyBOvvCPVvoAt4thO++Sq3bu4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94AIEAfmbc8N0LDV8hG4602iETHCoKTrTeicQgDo1xI=;
 b=VnouQkg4nF5oRv5+vnT4KM5MzUa/cq39ie4tpLFPDP0DPwyBXLZKirN7EhkqKOQfO8yZ3kbyvNiwOOPREM6syAITTaLwyqkeul+CXJqR5KMQsUnEvACL6B5+lj2U9RK1R35tZi08AbkViWgWgT2489j6GczhKeKLSDUdiWAhNww=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4824.eurprd08.prod.outlook.com (20.179.46.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 2 Mar 2020 15:43:11 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::5084:aeb:3ba5:c5c1]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::5084:aeb:3ba5:c5c1%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:43:10 +0000
Date:   Mon, 2 Mar 2020 15:43:09 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200302154309.GA11315@qd-ubuntu>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301112620.7892-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P123CA0032.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::20)
 To DBBPR08MB4491.eurprd08.prod.outlook.com (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from qd-ubuntu (89.21.227.133) by LO2P123CA0032.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 15:43:10 +0000
X-Originating-IP: [89.21.227.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59454e13-e044-4842-dd42-08d7bec06950
X-MS-TrafficTypeDiagnostic: DBBPR08MB4824:
X-Microsoft-Antispam-PRVS: <DBBPR08MB48247F2ECD6956AF2A876331B3E70@DBBPR08MB4824.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39830400003)(396003)(199004)(189003)(66946007)(66476007)(81166006)(16526019)(81156014)(8676002)(33656002)(66556008)(4326008)(86362001)(316002)(33716001)(8936002)(6916009)(1076003)(2906002)(6496006)(508600001)(186003)(44832011)(52116002)(5660300002)(26005)(54906003)(55016002)(9686003)(956004)(518174003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4824;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7Hjc8/PrE6OVS4uxO573uJuIzhqc5C+FpewrJAGQC3kr7Nl95zQYLvfySCIDIQGl18/BXV9inGl9hy4NnKnGXKxfQE7G2FfCTo471kK4aYPyaj/Au1nBFRIWfbDnCXHmqRNLqqYRSSkxnoijnqwFb0hfbCbOSiOMwqdN5LLiufpMP+BlVDf+mBk9EuI2xM7OQY6Wz1jK8HMy9FUJr81UtLsMQzfRtSeR4DPpoC1AX+Rv7KHH/a+SWodkTii22kb1slPega7NqOK1XxtraT/XH2HcFjACye28xRVVVeMKQYPkEK+fTEJ6VXYpaDphBXwtoKioE/JThhDByfVNgyDTUsMc0niIsuHspu9hU+K8NVITAmnxakCiGM44jZ9D37BAPDFUZbvz++XXVserM8bLOZHYt7LD84kd/nc23ivx5dSSaAUj0tyyUVvPyEjVwobRK0e86WF/HH1lcQpizoXbbG/ZVtXkUtkj/OcMaUTRvM5X4J66KYyQwIu5YkFdMYi
X-MS-Exchange-AntiSpam-MessageData: 5B1n5TLyIj7Wmwpy8KTBqLMEVj9FksUZI1ft3SfIWQEmW/KTI10c63A5JPVDFebGlCrChOoW22FT4IZ9PC1oYz56UOn1wkZ1YhxeKRxAx63XVBSWAr37p1a2yvGnneTfuL/X4/HFOv5/NZ2mQuBTrA==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 59454e13-e044-4842-dd42-08d7bec06950
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 15:43:10.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsYUTE65jOj+7sZky6LRvdtl/fJSYrIrelevBhrhyN/Izvqz3zbyvAF8+h7J7yx3qi4HYdl7R+CBuZSeL6mZl/p1AGHTiNmjV9WuA56frDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 12:26:20PM +0100, Oscar Carter wrote:
> These include module parameters.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/main_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5e48b3ddb94c..701300202b21 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);
> 
>  #define RX_DESC_DEF0 64
> -static int vnt_rx_buffers = RX_DESC_DEF0;
> +static int __read_mostly vnt_rx_buffers = RX_DESC_DEF0;
>  module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
>  MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");
> 
>  #define TX_DESC_DEF0 64
> -static int vnt_tx_buffers = TX_DESC_DEF0;
> +static int __read_mostly vnt_tx_buffers = TX_DESC_DEF0;
>  module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
>  MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
> 
> --
> 2.20.1
> 

Looks good to me.

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

