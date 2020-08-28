Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD72C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B49B2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jq7S48P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgH1KJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:09:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:50274 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729079AbgH1KJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1598609341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0y5Y8i2aj+MVbgI+nQbMkokFUpyufW5gJ6he5rj/7eU=;
        b=jq7S48P6mAHLVidwEQvhqpoAfHh8qw2NxpHU1c3LYKCb4UvnxU5kBgyEykAlm20r/Ac3Ck
        3a33Mmet6i50QhQ/stwy06mmy8s5zOQM4bKb6YWJF3dpodPEC5GH7ncm4alUmG5v6/7zW/
        z2GyAVcRCdYY1/VcRd8sX4i7wh8Fr/s=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-weU-VTKFOl6kzDKl2V-2Kg-1; Fri, 28 Aug 2020 12:08:59 +0200
X-MC-Unique: weU-VTKFOl6kzDKl2V-2Kg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Illbl90VBWUX3ZJuBjrvdYTVp9IMuiI5Pb6zsHjD6OZVyiQGkkHLUuzVGW+uPJqRwYQqdYkdSwPARzC6tdmmFUzd9R4aZWHh6k+w3cdZ5kwNMLx5VyBiRypnl5/6mF1+Qk58ZXhkZ5p9nnZyDe84csiLPQrSS9+9IDwSMy30pJhcRpITloVQw/ro3JBrpXz6fwFKpKhOGqX+yC+/Lk6BFVnCUtlsDbeaeJqacCWfg2Mwprrzm3glArQKOmKGOf6Z8kr8Tk3c0Aa0hO3DJAXkXoxJzZsa8Gi6NNpibbQAcw52G9yydPKTo7iymNFGfhThquClTiQFLfGH0h4lnKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y5Y8i2aj+MVbgI+nQbMkokFUpyufW5gJ6he5rj/7eU=;
 b=lUj6o7rNmHCvpgUYU/PiuynQQVwcuNkLZkm+PerdFLEOUP6voI9ICBQnlEk4Wlz3Gwp7dopmvgeLg41lM/poDNofwQYAubDKwQ28ssKktKF/YYTwqkVzEIIgGwSeTijkbH8CNcmS07c90B9JdpKNLvCxMSJjPWDRwfArTKGR2vscjzlJAPKoU/ZEStSVxB5LbNuDOKFFRx5kiSJSFpn0EGKNIHWUocEbdCewxRypweMULrisqZgNKrPZ9Q0tPjEwxlo7bt9hEvbqieP/YmK1eec7wHbHq2nfJGWokdj1N8TAM2tCtvl8xNLctSLyWRfej6pmwe0YWqPHc4L9SadZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB4126.eurprd04.prod.outlook.com (2603:10a6:803:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 10:08:58 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf%5]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 10:08:58 +0000
Date:   Fri, 28 Aug 2020 18:08:39 +0800
From:   joeyli <jlee@suse.com>
To:     Timo Witte <timo.witte@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:ACER WMI LAPTOP EXTRAS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: acer-wmi: add automatic keyboard
 background light toggle key as KEY_LIGHTS_TOGGLE
Message-ID: <20200828100839.GK7501@linux-l9pv.suse>
References: <20200804001423.36778-1-timo.witte@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804001423.36778-1-timo.witte@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 10:08:54 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd232d66-b517-47fa-97bf-08d84b3a60d6
X-MS-TrafficTypeDiagnostic: VI1PR04MB4126:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4126255A514A1BF98E69DFBFA3520@VI1PR04MB4126.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s25LJZZM8TxNtuhG2ENMU0W+fEjsFm2blrGmYZmIbo/lGZthj5HCitsBjRUyT+Fe6gA9MTmmUHzlyL2zAvwzrg+ve6fCePTekESY55hrVdZAB0pU80HpwgWYFhtX6mMHVoXMZ/JGOT6nYOXA24lq7+5R/GvWye6pxQQ1FOp/Oy5N2mHDxHhNXC0MWqYqDKdS0rJFNOUHnxdy1CZ3miBC/VM1RsWnsXnUfLniZRspKs4OrZ/feRq/17KjCW17RHOdeXvZffKPNwtDb2D6Resi/Z0TfHIViUIrD4cr50Zzcg7md6GCmcvvpMEjX4vPYmk9ZXSZb+57MjhRtk3pJrii6bTZW1X/GeX2u42NPO81p3BWVX+nlc6vfp5Mxd5d77l5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(7696005)(8676002)(6506007)(956004)(186003)(52116002)(8936002)(83380400001)(5660300002)(6666004)(26005)(6916009)(16526019)(54906003)(316002)(8886007)(55016002)(4326008)(9686003)(478600001)(33656002)(36756003)(2906002)(66946007)(1076003)(66556008)(86362001)(66476007)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gFIKeEC3EpjdaQ5SD1D/iwmX1PXVM5DmBe4ds3YMGOumHF1TvBVwmydXjqWdCwi951VExB0sGGovwM78VOvCYa2dMuZD8Fj0Jt1AUmsKMD8QUMic9nBpYdlu0rujtx97MAs+yAFL8u8N84SJeS3gl3bQfyzGjDDqeIzToEifKkFwrM/ze/ZBcb5ZRRquJl6CNWgZaldMYp6U6ejJQ9KpYhrppqZZNQBQ7EDFOzmJSgh0QfzcHb58beiSb3x6Qc6ZWpveVEnsDICBClpJEIV6bFquQxc16aBNqTbkEb9dmQCh9AHQACbHcD6ZrDaNFwblseqtcyK5ei3he19SlyBYljSgGC9gz7XirBUx/deqTuyvUseA7Yw15Fk2NvwS3ssl23d29h8O++KhCVFYRqY4WzBkWw0poh69m1MmJDjJAA81OxPUlSmrMt73uMnUEKR0et4g0cnOsdwt3KW/2PGLxKCFhdzM2RwQexHnGUmY6FMnyUP7zolV5/tLcRWIvYLkYMDnWXhXLKRCmo96X55ytk4BB2QoVowKjHxja5B1Lk199aSr4KDo3lGWgEuSGzOb4kBrU4lTb1EvPjSqSLun3f4iGYaJDPCJ3xtFqAugJA6sz5EQteGNdNgrHNSQBtSL4vE8nrZ/ATPO8MUIWieNzg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd232d66-b517-47fa-97bf-08d84b3a60d6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 10:08:58.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh15kyLRawTgleeVD9o/hEGMDvn10XAyHayADxCanXtsnY0r+2sw2avXF+gt/kM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timo,

On Tue, Aug 04, 2020 at 02:14:23AM +0200, Timo Witte wrote:
> Got a dmesg message on my AMD Renoir based Acer laptop:
> "acer_wmi: Unknown key number - 0x84" when toggling keyboard
> background light
> 
> Signed-off-by: Timo Witte <timo.witte@gmail.com>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks for your help!
Joey Lee

> ---
>  drivers/platform/x86/acer-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 60c18f21588d..87797f785d6a 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -111,6 +111,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
>  	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
>  	{KE_IGNORE, 0x81, {KEY_SLEEP} },
>  	{KE_KEY, 0x82, {KEY_TOUCHPAD_TOGGLE} },	/* Touch Pad Toggle */
> +	{KE_IGNORE, 0x84, {KEY_LIGHTS_TOGGLE} }, /* Automatic Keyboard background light toggle */
>  	{KE_KEY, KEY_TOUCHPAD_ON, {KEY_TOUCHPAD_ON} },
>  	{KE_KEY, KEY_TOUCHPAD_OFF, {KEY_TOUCHPAD_OFF} },
>  	{KE_IGNORE, 0x83, {KEY_TOUCHPAD_TOGGLE} },
> -- 
> 2.27.0

