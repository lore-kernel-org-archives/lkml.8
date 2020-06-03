Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FED2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9TNV/yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFCLPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:15:35 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:63810
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgFCLPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/XLgP31pnrvpAd8Po12qSWID69ffOYFCJ2bv+/7DT3pAeTAJZAV5v8/3DvuILIr26cab4XjTuHt7jJEpgXMKeod9fSauFG+oBSsfd3XHZRFgpjlgzA77Z30/Zv5BSIm9NLyV3GIHbji+yoYQUeEb4kIQRyCL7OfW+nX9gARUqihhPLUfCqRVF4FXZAYPIIjk4A2W8z7oiSgtzivpls+TeGiDd32WiJYU3I2T0L/mQ3Fg9jS52wKergA5f7uV2aq5q7aonr9jaErRGxMHHeUWDOtrmEu+1mLy+8W7daXzzCYuYUI/7KSdDkijGGZ3YtWOPhOG+RYuohitAcA6iuifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM/Gu350wgEhoNLHKmui6Q4BZQxWYP6WlwAu+lbgEDM=;
 b=VhvYi5D3n/9g9xTPT6/id0SD1K5aFtEykGrx+j63VoefiDTOi5VfLcl9xshy+a+4jhogJ9w0kHBAmQgG4HM/Q5FZFFzycRjJGVBrwuu1j1FfDz2ENxCvasrSsTTUiraNMfvxUDTGwesK2odsVvzlNpjJJy3Zj0XOzOdF6mKQXsM8xbDCx2lWT+eZci+IK8kmkhE44zDDYJ4Yjl70eAMmoaisdHoLFoyAmzjSk+yaaa2MskBdmhbfqApfLtNvuQBu3eHIAXqY5dBnwoncogNDK+v466PctdA9koFqx5DLMqiGndG7MdiVAeNtrEXqziZztxr60nE0Aj4XktTSCUCLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM/Gu350wgEhoNLHKmui6Q4BZQxWYP6WlwAu+lbgEDM=;
 b=f9TNV/yDlOG7RElJyiH87gONSuFpgio2Bj0dzhY6ZsSf2dlU5tcVgALQOF4eGHV+6hd9U8b4tC33e25UHFUp6c1zlI9UjN4hcOnedgazAY5UNL/2buaSPYlwlWN7XQOMSc6RLnlUH42LB+gKCW4X621+X2Yq9i7PpB7M7hzVkHE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2576.eurprd04.prod.outlook.com
 (2603:10a6:800:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 11:15:30 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 11:15:30 +0000
Subject: Re: [PATCH] soc: imx: scu: use devm_kasprintf
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
References: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <306868c5-1491-7a18-5ba6-3b8afceaffd0@nxp.com>
Date:   Wed, 3 Jun 2020 14:15:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To VI1PR0401MB2287.eurprd04.prod.outlook.com (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:2f08:5708:3700:99bd:f81e:e380:8429] (2a02:2f08:5708:3700:99bd:f81e:e380:8429) by AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 11:15:29 +0000
X-Originating-IP: [2a02:2f08:5708:3700:99bd:f81e:e380:8429]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4855347-99d5-4bfd-9df6-08d807af6d19
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB257661E250572861D1D19578F9880@VI1PR0401MB2576.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRJa3CvCp/kCyQ8kBvDw3gszGwiakutchwx+pRZ5AtuIE332YD3rwdsT1nXIX0UZilDKQbIGqu2fbG8Bk/28SfUNYM1a7/lkN0lC07J/K6CdHKYi2e9OEElQFrQlGVdQndiHoKkU7mM49S2QZ1t8ccABWxviyB7EOLOdHFsL8eBK1cK/TM3T/zWAOPSVFvLiM5B9JEas2K+ZtMkVbCML4h/gj9OVKtL0+FWXJfcgUQ5nWGbPxyC0qt/NbbJlMbLX0E/Hyc4+eMSkY4tjcCWuud6nXqcxO0oLkcQODvj+UX9LVWV9Ew4p0E5ini6WQRFeau2YeYE9jmsVHUy4dBb0/58+C2XJAMLFBcw75Ys7xbMz5B796dxVj7T8rxXAQwul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(53546011)(6636002)(558084003)(52116002)(478600001)(6486002)(4326008)(86362001)(8676002)(186003)(31686004)(16526019)(66946007)(316002)(66476007)(2906002)(66556008)(8936002)(36756003)(5660300002)(44832011)(31696002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FN517/CqisqzAw7DFwE1alnYTRASbapx5BKIFChureNv/hTFybP59ERrikdHCVrt+FZJ8VKOnt86mMSJWRP7HW3ilNFZGYKlZyowmAujRkKfETDI2gTC45D4ETf9RSuVeWQ1/P7b252TUun3UgzY6Lxe1p0Px69nznW7hLw235hKhVVJSJKYspbi/6WPob+QSa99nJ7yUb+7u6ZdG7tiR8ViYaNFJNnumb40RBo93uokMVW/W5Qw9hhVO9FbY/+O2kGkcPlztvFzPDRC9HlzLWcAH/9nKv0Fsaejc0S3DePb91Ix+9m4Qq9BaTW7jhz67mb8ygFWkmu5WBZNapxQ3Jj3aHoAcrLuskMXHVb+xSL48my+9+d5QHwWB3DPRyPsbcZXN7nsvIVUrBRttaREzZib6r/8+4LPUahgRFZP68p3ALVTbEbt0FfIcITV0Yf0LsXfXW2L9yJ4fa8MqGiizYW5Uwnqsy/IvEXw9oepmQEBkSV9KUk6b7yyoPeThPyRqogm3a0/JGW84EybF1Oixkc649Fho99aaWPuodkWUsDDQto2QwRj/tiQPknTs8CF
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4855347-99d5-4bfd-9df6-08d807af6d19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 11:15:30.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dZ6jobdDaKjIQAnilLK5MeT8NXGEk48KE0ZAdD47rX11RQQLTKoG9BEJbrpp1XJueYL11IOiv34fylC1vTPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.06.2020 12:29, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Use devm_kasprintf to simplify code
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


