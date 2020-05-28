Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B4420721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uy8iAaoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgE1FQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:16:19 -0400
Received: from mail-eopbgr750045.outbound.protection.outlook.com ([40.107.75.45]:23020
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbgE1FNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra0aqFewEH2yloT3xbq6tzuwtEgqIV38D+FBJVg2zgpIs99BriSaygjTonQU0JbmTCpzoBwudT2frhwMFrlmWvdWzFiCKUZLLWCZMEsAzw+d/SJc0u0/rBJKJGLylGdrXOkrTe89/ELUi3ihRPtnEEi67sz9rtNeNmQepFCoJSUzGTEKXQcGbREoB/UdB4/aPu+vgkK33WtdEmOz9SmY31/ehNdBq/jbwFNSA8RWYm+M2xVY5Kr8WxrPPkjQ5Cg+JgcoiegvYZSXDspjNKd6fTq3ljG7fcjquFGvKk+byHJWAv/dpAMMP5L3WGu1Am7QPzVQF6G6LsGMP56+LT2nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyZyvLGxmUexrAGRZG+pWuMycvgxrij/r9Y946voejw=;
 b=TT/2jPGzcMcfyMnJDe+nLNmKOGrCCOjxdaK5OefQx3pJlsUYYIYWcBJX3Vp8KIBUl0VNSzUnhT56ynGza0ZjO84pnenW4GvldRcPYck/nApf9PISmk2RhkKMSXZMakIQ3Cc3hInTBm2b9ODaEsDtZRDuYSScUbwj0eT4D9V4/aCtwjSQcJzRU8r8UvoR6dTbMjQOjW79uO+rooBSPZgbXF3dz1hEm7Kk/gU7SQkwcYK7F2cvhaMcnB2aSdFi9LU1TDN0Oy2VZMIaR+g3ocdcZmaavh1DricJzJFHifBA/eMTfMFUHnbkicfjcx6VYsSfuqNG0jdUqrOtv/IjwO4ucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyZyvLGxmUexrAGRZG+pWuMycvgxrij/r9Y946voejw=;
 b=Uy8iAaoUD0PT1g7j+U9HrC+95A2wtYe0QEp7ITjuLOvjyaRFUtnFAIJhtx9WNoet+pF00VuI7oeylk2Bl2gdUQCsg5VvrryKjaO6biWPCVGrBFYXQ25NQdDeAk4gqRTzaMomCvis9HbGYDoDsMmWZKVHdXi2xzegrt9B0huT0fo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 by MWHPR12MB1838.namprd12.prod.outlook.com (2603:10b6:300:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 28 May
 2020 05:13:38 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::25ab:aac8:ecf3:59a0]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::25ab:aac8:ecf3:59a0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 05:13:38 +0000
Subject: Re: [PATCH] ASoC: AMD: Use mixer control to switch between DMICs
To:     Mark Brown <broonie@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     yuhsuan@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200527014023.2781-1-akshu.agrawal@amd.com>
 <20200527112758.GE5308@sirena.org.uk>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <f0087d94-c81d-3dc0-9b6d-473795a89918@amd.com>
Date:   Thu, 28 May 2020 10:43:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200527112758.GE5308@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::18) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.107] (122.171.58.15) by MAXPR0101CA0032.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 05:13:35 +0000
X-Originating-IP: [122.171.58.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 029d2749-bc0b-4013-5291-08d802c5e0d7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB18381FF98A36C515A297B39EF88E0@MWHPR12MB1838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7et0J+8cDeLjk+XOpcmK1TyljnkmfoT+/NoWWnKp/dJImX+0q8xAUjsHMpKzGoXeLvDk25HR1z4cXmW2zV+RR3FA0kzppGynPAxm8zk5LdnJ15s/r/MloEl/vg88cWCdHpYxvvTVARrcxtHzoGolPRXynAOlVIUFn4HaWoqi9q4pPSnD9zlVjRnC41qjhMM+kZKX4TM/xIE1krzwm6rFcLcqH1pf1Pb1WPrmmXm6xU/u5omHIJHXYba/wm/eVg+lO/r8HNiuoiQVK/NWHbgcZRa65chKbznG6xE2xLKeSc++qXy120XzXJmyOFobSbcFKCEgp20CGP3KFMHpqJElaGU+krUSidIwEUR2GYSYGgPlx3ZKn8fZyPIYsN2qvV/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(4744005)(2616005)(66556008)(2906002)(956004)(31696002)(53546011)(4326008)(8936002)(66476007)(54906003)(478600001)(110136005)(6636002)(31686004)(16526019)(16576012)(186003)(36756003)(26005)(5660300002)(8676002)(6666004)(316002)(52116002)(66946007)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GkFMvTLT7VbgjDG+/mByRCvCreSusPytJZyuyJwVfMP4aFL3UBDlmCJVEOQJSGQJkGqJWmhOn+riRhGGoOjjVO0eA3zYwF0wZ87PCS82Bl5cYfpSPo1282KtpvlfIJiozbncEUICYWw3X4vO8a4hft32Re7LEZoOCo0IDST4yOa+ZgDj0EHvylSDD5/iDC+zsZmMd0Ivfvk6yTcRd6uzHwuB7mY/uMep66Jj2YOMiQIPjygt9o3lqlxmhnqSn4xYh7gMVQ3osurNO2u3qISJM2R+//X46HljH2ml//OHYd27wAnzdzGSAlHevUyJMYaWfdgcmhOicu5dJhsEiyh5eP9JpfZ5SRTe7R624uZpTIIPx1yJQTUc7OA4pzI13che6K/bmOtZsQoPseDyIXnhZhD0srgD3pOgsWfSIB7ny5Yh1PKNOSjZ/lPW4cMVxElEm27P68v4AeB0aZhm80NL6vaBgCQMMMb8KcuHPRy7chk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029d2749-bc0b-4013-5291-08d802c5e0d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 05:13:38.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9BvGvO2wgu9jJSenPHRC8x8hFLt1xswi8DGNGIq+kceuf29Upfv1pFYIcDHm/y6DLLBJf6UiyWtG07N/VTMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/2020 4:57 PM, Mark Brown wrote:
> On Wed, May 27, 2020 at 07:10:16AM +0530, Akshu Agrawal wrote:
>
>> +	SOC_SINGLE_BOOL_EXT("Front Mic", 0, front_mic_get, front_mic_set),
> This should probably be a mux with two labelled options, or if it's a
> boolean control it should end in Switch.  A mux definitely seems like a
> better option though.

Actually it's a dmic switch, so will change it to boolean control named 
"DMIC switch". Front or rear mic might change with variants.

Thanks,

Akshu

