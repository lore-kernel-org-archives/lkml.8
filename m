Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82396206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ddPA5QZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgGFQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:35:58 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:58244
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729293AbgGFQf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixbxe/52pbjQwApK55xhfqG4wrLApCKe75BsI3krf0VPxEp121rG+K7oLS3Al6bgbCsFR+X9QknwAA8aNQX8rsGFfu6SCJIaJknzSiBbQad6VOEechdCRRivuW/tb+Fs4Y9Dl43E6GSB86wjIvHFWATlnURSCElFy5vOIOcyocx7bDhd8Z1pCpGDF2NslDuuEKwH23AKAtuYRSioCTit9KDhTcALXU3wvZQZZLoS0VsZ4NuZhOT6w2syFVydkNbuREO6PP/kkBymm4Su2imxuZMxP6CZYMnMwpGaBjAaXwHyv2Dn0dewvfBGFqtbv7jBgxcir+vCTn0IlglTHe2ymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CMhoE64ZV8sQSny7l+acGPWm6eE2EN2oAf+8CWKMyI=;
 b=PM061uMYLaAbhZIq4AgzxHNXQdIr7PDBU4kGjMhtLUL/kC+Kbreu32T8MjbW+dxrpWR2m6Yt5pQ6phgblTXwJO/GL99H0+mX6KF9Qkzgmirw4AVc0A1Gz8O8z/6KeoARB6DHOhLvhTLEg7h2c8DZ4xbb8c4eE57y1E37/bvY+yBNSWOn8KdIFeZNiQQNIeZ38sUK3KaPmHSG9EEREQv9XR3By4LXxc+1YuPhtZDaJQSVWTyEgT1l/vFvCA++Z1NbG3u8KOyE583JCOyo/Vh01DSKgEjnkiEyVdsXd/183A3CqLwYuP5pYlvRLVgUSvlIW6n0r7HvhrVURVGvPVDfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CMhoE64ZV8sQSny7l+acGPWm6eE2EN2oAf+8CWKMyI=;
 b=ddPA5QZAqiji6aJE6Ulmw5U3rXxViMscXK6Z1GjxiCmkg2ndrFocZiUfFXOU7yOR9DhZwcVSGnMcyFsF36hO23Aw/dl28LFQ4+Ytu07/qoTOiZgtlOulfRtugRP6uNUqv0LV5S7KMXLOyuve8E/ifBB8UBghB1SFAj18hVZpVKw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR04MB6989.eurprd04.prod.outlook.com
 (2603:10a6:803:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 16:35:54 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:35:54 +0000
Subject: Re: [PATCH v3 03/13] bus/fsl-mc: add support for 'driver_override' in
 the mc-bus
To:     Andrew Lunn <andrew@lunn.ch>, Diana Craciun <diana.craciun@nxp.com>
Cc:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org, stuyoder@gmail.com, leoyang.li@nxp.com,
        bharatb.linux@gmail.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200706124243.10697-1-diana.craciun@nxp.com>
 <20200706124243.10697-4-diana.craciun@nxp.com>
 <20200706135717.GB919533@lunn.ch>
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <2267de0c-0ee8-b277-4de8-0cc48fff14f5@oss.nxp.com>
Date:   Mon, 6 Jul 2020 19:35:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200706135717.GB919533@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::29) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.122] (86.120.234.4) by AM4P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 16:35:52 +0000
X-Originating-IP: [86.120.234.4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eda86bf-61b5-479d-66d7-08d821caa6d6
X-MS-TrafficTypeDiagnostic: VI1PR04MB6989:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6989EB1EEAE24906CABD458EBE690@VI1PR04MB6989.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdwbmJm4kpVRxuSyPoKz9LBuziMbUdztNtoWxdqLZ0wv6TNHyBWnaL9epbtcM7UigUmkcz49bfgX4MTxwCKUt73auPMRr82LQ7B3ETxOLBH2KoIBP85IaLb+bvyiLgAxxR5NvZBaieBoB/KhwElA1gCCFHikEdZtkXPqVH1AKUjcmrpZUbtjnQTMdtASQueK7aDrnJv7YS9Vo1g7pimk/hPbPOIAnVFRfPx8HlvIYTMwDld/cYQYtsQh8urwqgnix2Slb0miO/emqEAAm4M6QKSOsymdTvoo+4zjrij0gKQ4Rpd/WumBSz+PNcifnfU/BP9DakVCUlcnYkU+OIV6LO15G0/0FHPoP+aQgNeHcl9KafsHx0z9/JFph3ycSTLH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(53546011)(52116002)(31686004)(186003)(16526019)(8936002)(26005)(6486002)(316002)(86362001)(4326008)(31696002)(16576012)(8676002)(110136005)(478600001)(66556008)(66476007)(66946007)(956004)(5660300002)(2906002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +M1T+dARclEh0NYNpsbTVaNKw0R4d98RFZD2lRu3nkOCKp4JP2+MCf/Kt/tdcy0cYG1u2QyClJVfBntNC9ooHyyEOcvWdIcfdPBHjlS2HZUKboRXuIpVT7BG2hs1o1AIVMuKwugSuzsxDRCdr3QlP0RQjQiI+ftUtzxWUFHC6QlUUDjz3Tm/8mh6DyNvbUXsjN/o/08uTmfXJc6/KVlKh+k91nUhWI3I6h6G/KEaoqwZ9O8dlnoeAWRStLgeTKZ+E2EXPjKgz+NRw4RpzhoNdWATq/BXNm1MA5HhNmX4AMpZFLSpe7W0sjOdlDNJEh3S3Wxqdixne+cm0JdwuukTbZDcqvQDyEab9kp+4NzQF6f3qnwT06AuUSRMar97EGR0D/3mzLfXZ0y5d1l77SVR/rrH2uabLuJ2Z4obiRCAciYBp0ME0m2e8l6vLzpxi/PS83XBtGGdYXMePfFnDGxPOOG7agDpZiqjzyEvf+TS/80=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda86bf-61b5-479d-66d7-08d821caa6d6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2815.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:35:54.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBeURK+yACJyx+I6SruWtZvoCK265OKTxXOqEHFN5jA8LPJLVuZMLrc+Q/o2WqbzUehmfHj1FYSW3nZLbkVbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I apologize, I somehow missed you previous comment.

OK, I see that there are a number of drivers using the same code. In 
case we share the code, probably we need to store the driver_override 
value in the struct device (not in the particular driver device 
structure as it is done now).

Diana


On 7/6/2020 4:57 PM, Andrew Lunn wrote:
> Hi Diana
>
> On Mon, Jul 06, 2020 at 03:42:33PM +0300, Diana Craciun wrote:
>> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>>
>> This patch is required for vfio-fsl-mc meta driver to successfully bind
>> layerscape container devices for device passthrough. This patch adds
>> a mechanism to allow a layerscape device to specify a driver rather than
>> a layerscape driver provide a device match.
>>
>> Example to allow a device (dprc.1) to specifically bind
>> with driver (vfio-fsl-mc):-
>>   - echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.1/driver_override
>>   - echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
>>   - echo dprc.1 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind
> Something i asked before, why is this buried in a driver, when it
> could be put in the driver core. This is not the only driver doing
> this, so it does make sense to share the code and bugs.
>
>        Andrew

