Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0AFC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC63A20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="aDp22+d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCYJTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:19:30 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:36485
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbgCYJT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHQutkmedsDm43JFyDVhlgLMnXrhgFir+Bhd4q21quy8aNMq/OGadwgP6LlGbxLQpbgPgK4BOvlXXJK7MmLOOq/TaONFmaJ5aOD83Pfuudgbc+RP5i71gQfIhNhiTO2uVzznLt1u2/FbTvlGqXif+KcIj0VEzxEEhDOWMNyXpptXVJLpsuVkQtbFidzCBUQjV5MXAxQx4jAq577SHOi1XewxtqwGBtJgcEBwG3Cb81aXPv1w8bmgqS7fws3GETiivbPBeBxPDMXnurc1ulB+JlHRhBg6YVK59Lsuqdgc7RwaiuE9L/1OKWjia6AordFsi+/UqHHe7uie3fPIjjtV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkiqKGtQ4G6bCI09OepV5uXO6ATrWneKK+Ipz3Vx22Y=;
 b=HwOG5rQoTDn0RG2z7l4X1zMci+QQ/YWKwXMXLhGvUjBsC18clY8azxWiqHxBVQFmI635xNvpX5AhpjVmb0CeKzszvVzxai1RpmwMIhEdYfe7tEu94JWIypJKy4ye/RE4wxPP3w3Tn0xINfXkYCcJdI6Zollb7PpJ3+24lVmct9TFnedhutCiT9JZqNgXP+8hZkbQJlBZJLhGuM//iXnmQLVXY/MvhV1UBLzZYeklkfZgEbjwl5bz52zK+i6B8wWVzM1FWhgYS40lavIYDvOEypJl2UszR0gSXxVJWxJRfyEFMquz0gLn3G1B9Fp1MO/yaXKwLWCBg2xOO1OwkEaR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkiqKGtQ4G6bCI09OepV5uXO6ATrWneKK+Ipz3Vx22Y=;
 b=aDp22+d0TmXOEVyNHuzmMcJFB7Ot2l5nAn/CxHlNZ5DIMW7wZBM1Hq0SCKCy159uWbJkd1e6B71qz3UN23soNPznMbrNYkjU5lgYTZoJvJ9lHXeGRxDHE1po+dDnucAqz9tjkhPp+1gXLkBxtOp4hBjzWID9EKhEBjHsH9N35yw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4362.eurprd08.prod.outlook.com (20.179.42.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 09:19:27 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 09:19:26 +0000
Date:   Wed, 25 Mar 2020 09:19:24 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use ARRAY_SIZE instead of hardcoded
 size
Message-ID: <20200325091924.GB15158@jiffies>
References: <20200318174015.7515-1-oscar.carter@gmx.com>
 <20200324095456.GA7693@jiffies>
 <20200324131830.GD4672@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324131830.GD4672@kadam>
X-ClientProxiedBy: CWLP265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5e::13) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (5.151.93.48) by CWLP265CA0361.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Wed, 25 Mar 2020 09:19:26 +0000
X-Originating-IP: [5.151.93.48]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca06baf0-51bc-4692-72fd-08d7d09d9d82
X-MS-TrafficTypeDiagnostic: DBBPR08MB4362:
X-Microsoft-Antispam-PRVS: <DBBPR08MB436240F5EBE715B00D3DFE04B3CE0@DBBPR08MB4362.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39830400003)(346002)(396003)(376002)(366004)(33656002)(186003)(2906002)(508600001)(1076003)(956004)(26005)(9576002)(6916009)(81156014)(16526019)(81166006)(9686003)(55016002)(8676002)(44832011)(316002)(86362001)(66476007)(54906003)(4744005)(6496006)(52116002)(66556008)(53546011)(66946007)(8936002)(4326008)(5660300002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4362;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+smiLD+mH8ggHQ0c8+3wkgs+p9qQa0DGEIEuaMRAo+a5b4JZxoTsj+kg1leVd+vgnOzKrXrc757O5DNNNeEDlgyuKXEYXKE/c68Gqbxb7veJLwpKDnlLeHhmkMThd4GxIE3ucs9PyLNkhvzTLpztPA2BN7xWOtS+VGMgACbEmLZd1Il0rvT3Xg7K/prLA91pUp/Ts8Q79cpG7RZSAC/5uWCmph0vvaZxfX7IqRhtHsoXEmPSnUhDc1J6k4hQ279s3BeLe89BnvH6vfltt/q02bhce+N9SnrE9kbz9EYvIpoyqgH0S/ydMXPpjEz5AWsUGEXaVzOlH6T1Pe3NQX35IWOBq/llUAjYNI4wpmWhau5kILLH1Xh2Fke3eW+4I8Sh8PqLJ36c7ofqF9iSGPRdtAJ1nxcI0c8G9mIfjosL/S9l6agL25/PbHjiZh+Q5KS
X-MS-Exchange-AntiSpam-MessageData: R9hAToOI884s0MOABNE87qEJMvziYB21SnyqkG0bsTlNptwb976gOT6DHH2wdLH69QhSOuk178tDtOWzGrJbQKRs5zYtpZQoUD00QwGHUR+w4SoSJZ0JYcql938L37TwC8yBRuL7Q6N6oZm7zPUGqg==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: ca06baf0-51bc-4692-72fd-08d7d09d9d82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 09:19:26.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ2mypnKSfsyKH+S5DLYvBzUtUx6/rSmIdEVjRwHC8rtiNAnd0AUJkL5bXmxv9QFsS+3/PkLAQZPaU0u/rFmyCkmLnFLG2fs6bP/6eyb3Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4362
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/20 16:18:30, Dan Carpenter wrote:
> That's a bit over engineering something which is pretty trivial.
> Normally, we would just make the size a define instead of a magic number
> 14.

My bad, I meant "define", not "macro".

> If people change the size in the future (unlikely) and it causes a bug
> then they kind of deserve it because they need to ensure all the new
> stuff is initialized, right?  If they change it and it results in a
> buffer overflow then static checkers would complain.  If they changed it
> and it resulted in uninitialized data being used then it would be zero
> so that's okay.

I wasn't sure where I should stand on this, that's clearer now.

Thanks,
Quentin
