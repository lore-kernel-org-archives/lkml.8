Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC88C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AUmAtgKj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AUmAtgKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFD7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:59:52 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:58386
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgCFD7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWUokUwjqrgIc12HCCYZCDxxVoYvJDsuBF5du0XyGwM=;
 b=AUmAtgKjqfuA4hhiLQIsoCnkc9u0iUNJLeboWAzRyq6I/Z8NcNR0I/3Q4jhabFCMXmHR4Vn71Uq5ynbqBJOeTiPf2F3s9hSOhafkYTNwQrPrMUHc9V8TRxoXpOW6dTSj4UaNsiuIP6C0G2xL+t7+aNhVd5I+anepfWga/8lidsY=
Received: from AM5PR0701CA0058.eurprd07.prod.outlook.com (2603:10a6:203:2::20)
 by AM0PR08MB3938.eurprd08.prod.outlook.com (2603:10a6:208:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Fri, 6 Mar
 2020 03:59:46 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::5) by AM5PR0701CA0058.outlook.office365.com
 (2603:10a6:203:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.5 via Frontend
 Transport; Fri, 6 Mar 2020 03:59:45 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Fri, 6 Mar 2020 03:59:44 +0000
Received: ("Tessian outbound efdea641ed36:v42"); Fri, 06 Mar 2020 03:59:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 16cc82a51e8e0f6a
X-CR-MTA-TID: 64aa7808
Received: from fa7379677cbc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 35F4A7E6-64CC-416C-BBDA-DB50885BAA64.1;
        Fri, 06 Mar 2020 03:59:39 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fa7379677cbc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 06 Mar 2020 03:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr3ZeqQl4A0Lys+v2yHprhZPqzSCZ3T/3Icy8JoI2m5kH4/l+C+MmgAvZIDlwCBKOCqwn3/VsYVGRf9oobwWtQYkV+2VDUCpAtD//YrVnkuA7RjxfcgUMmWAKhagbNwsPnU74vmNTCEfMKCyGt/4aTDT84VULajDrfdjMBdODzQPmEZuw2ktzFFpnnVlSX1a0N6VSZZ36ws9ohQz7F5tz4abkmA1icNM0Y3x0hq/Ic+fEM+Y7vN2gXGSblaUo44Bz/Evip9SbsaC8Y3Qw5M622VWGutnYzUBfD/DwjQe2HjBLbMJyJFr4Mwa9t99aSHZikUSlep2MTXpgKZSf+LE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWUokUwjqrgIc12HCCYZCDxxVoYvJDsuBF5du0XyGwM=;
 b=SWsJiWbthcpOSPTkAsextNolOhbmtCVnSjz/ep28dzMP5ShFALUo22iNjemATlUFEvZVRPs4y/J0ZS1wZUFXFxS03aelBj8zVKXId/ddJPAeGS1HYfzLK1cE6SqcxgioOH25sQjL2DL/7NTiJJvy/sSd/UT16OP6R0Xa9ap/NCJntL4zlHknaIgfnCpDgWyULuAdgH24yvB95wAvUmQDMPpzvGruyHpSlBfppDjO8CbcZNDmNAMD2rESFxX15Bxl+t/qm96gNAoLUGC7Dro4ZKeWTXFUfo6qUrYpoQvtr3u6K6FtioOxubqzIyD3uwm5W13LMUCiiGqKJcFPW+1rAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWUokUwjqrgIc12HCCYZCDxxVoYvJDsuBF5du0XyGwM=;
 b=AUmAtgKjqfuA4hhiLQIsoCnkc9u0iUNJLeboWAzRyq6I/Z8NcNR0I/3Q4jhabFCMXmHR4Vn71Uq5ynbqBJOeTiPf2F3s9hSOhafkYTNwQrPrMUHc9V8TRxoXpOW6dTSj4UaNsiuIP6C0G2xL+t7+aNhVd5I+anepfWga/8lidsY=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4814.eurprd08.prod.outlook.com (10.255.115.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Fri, 6 Mar 2020 03:59:36 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::101d:3c1a:50cd:520]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::101d:3c1a:50cd:520%7]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 03:59:36 +0000
Date:   Fri, 6 Mar 2020 11:59:30 +0800
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: drm/komeda: mark PM functions as __maybe_unused
Message-ID: <20200306035930.GA26600@jamwan02-TSP300>
References: <20200107215327.1579195-1-arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107215327.1579195-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (113.29.88.7) by HK2PR02CA0165.apcprd02.prod.outlook.com (2603:1096:201:1f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 03:59:35 +0000
X-Originating-IP: [113.29.88.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42861930-36c8-48d1-57fe-08d7c182ce6d
X-MS-TrafficTypeDiagnostic: VE1PR08MB4814:|VE1PR08MB4814:|AM0PR08MB3938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3938B6BE27E7534DFEF9DD6FB3E30@AM0PR08MB3938.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;OLM:3383;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(5660300002)(81166006)(81156014)(55236004)(26005)(9686003)(8676002)(6666004)(956004)(1076003)(54906003)(6916009)(66556008)(316002)(16526019)(66946007)(66476007)(186003)(86362001)(33716001)(52116002)(2906002)(6496006)(6486002)(33656002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4814;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +dnSL4REssuZvLx1smuXN8Sk197dY/x/2DtHoVWjNbDtOrJc1yO9778sIOCTtCe4b0ufeAgp1YcF4TbqKZDi6WM0JgHuUPAH3rY3BEPiiQI3gzG5n6j/z1WI8xuVL1EMgIJvmqsufzL75BPM5q6Zrk6KoOrR/H8Xn1gr23hhnn/wLfoZH7rNGLW6GdF/Yv4kdrFCWkoWou4/18MaAnBYWCtEMzu3sW1ve35894a5/OPd2dUCQG14AuPzap5ZwgGQZP/aUv3YU8tF+lPIvznxVPgoJ2K99tPXzCtmlmEp5SwZqspWyjvWaBklc8AKBoK35Oz2cU8fAwXpJT5HdFNAVZrQBJ9cAq8pn90xddgocHOz5XSGr6Uuc9T27Ylpa7YgjxoQpzpOI6Qj+UasfR2y47/30/cnf9PNrmooYXoLALo0itWCAqF4v8xmramuqYyd
X-MS-Exchange-AntiSpam-MessageData: w1rYufDA6N5evi6VgGfQA05+pl9VSNxbvRhI/sonSfM9gxlvqoZInvVJ+N0I7dVqzxEDtbkAi1gxQG9tc5fqa/2dG96AwnfBiVjpqcn2V5691VUQsB1xyrRJIA+5pfYHkXVmAoOgKFGZ9XWYyDnmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4814
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(5660300002)(36906005)(6862004)(81156014)(2906002)(33656002)(8676002)(4326008)(26826003)(81166006)(478600001)(54906003)(316002)(8936002)(6666004)(70206006)(70586007)(356004)(186003)(16526019)(86362001)(6496006)(6486002)(26005)(1076003)(956004)(9686003)(336012)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3938;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bbf58db3-1066-4c9c-f440-08d7c182c94b
X-Forefront-PRVS: 0334223192
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOnObzkAzVaBJMCMPLGB/g1ftBZ+XH7cm1alT3wV8O3V0eIeSVvFeOZ0mRYhMxQYSEv+iLDt2lPh1G/AQ/YuSYxpuGO/UqmPx4+wDUx5MzZFYuCqdVQd2AIfVguH1z+0aEHOgq0AXCn/I2/IGOLm6v1t4HXRSph+w0q7rl5XFBdSk9a11b5ro5dEYJY+igUYqIjumusgHXF8hV3pM9dSUGXa9vprEqEfPOWLxuK1TBhVuaFrAIBxSKvSne+WVsyBZQKCpZ+Tk415UGfRi1AKhJLu7Z7ptlNOfXiWSFKgDrOVZWaEJyqX1mdXIWSaiOoc8SqRFKzfLa4swOXLUXvZ83X/rw9BKfo87AYfAhGHA1k4RshRBiqnFsBrF9nhbHLSNDbiDOWT4QHlrhDv3PY2ekv4+zIxXJXQm+eTKPEsFvxXFJELo0jOOyCzUOGLMJ5B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 03:59:44.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42861930-36c8-48d1-57fe-08d7c182ce6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:53:19PM +0100, Arnd Bergmann wrote:
> Without this, we get a couple of warnings when CONFIG_PM
> is disabled:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12: error: 'komeda_rt_pm_resume' defined but not used [-Werror=unused-function]
>  static int komeda_rt_pm_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12: error: 'komeda_rt_pm_suspend' defined but not used [-Werror=unused-function]
>  static int komeda_rt_pm_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~
> 
> Fixes: efb465088518 ("drm/komeda: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index ea5cd1e17304..e7933930a657 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -146,14 +146,14 @@ static const struct of_device_id komeda_of_match[] = {
>  
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
>  
> -static int komeda_rt_pm_suspend(struct device *dev)
> +static int __maybe_unused komeda_rt_pm_suspend(struct device *dev)
>  {
>  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
>  
>  	return komeda_dev_suspend(mdrv->mdev);
>  }
>  
> -static int komeda_rt_pm_resume(struct device *dev)
> +static int __maybe_unused komeda_rt_pm_resume(struct device *dev)
>  {
>  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
>

Applied to drm-misc-fixes 9803aac7b5508718989e4cde11b854fc01037b01
