Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D38C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8DC2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IeScTLYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgAJVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:42:18 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:13113
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbgAJVmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:42:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfvPwYJPeN4CHjq4vE7fflOgW1gTcdeOjx36TJ8Ki5ekQwMfbFQx6hKVQnXyl2NBfwEIrG1AEAsFzieBXXvGTNFYEti56/Iy0YmbT9p39emS8SCbmvcVInB8EomMCvuuzjC4Nko/6AzTWiiGaB9fnF8qsneCUo98N2lYXULPqH4+kinvV+j9hju7sc30FTtwy+klQ1UrhiBrxPV3+L3Earc50DYib7c+rtbyDBJb/j2Brgje5SkwRpZq/QnXJNZmOOkaaUy7WhzfzItz6PxxuCKMGimUnmgrsOZQ9LwH2zPxJsicqeyxZdxY0n1zGj5XDqq24Rk0MdUtxsiSYB0dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQPz4nMZ+hG38N14yjcv4UShGRen7Z8oHBrifsRwttk=;
 b=hG6sSh84OD7eZcuyEeVc/tt3Xtqm92ma6Nx1SB1Zy5sV0GUtb0DbvCS1dwceI7I8edi4e3+KMO0FEEb79WmE3qdNwIwQncL86+WJgyVGJOawOFIXkYwtfJTtFPW0JHne0PUct5Fx5LI/bpiGKZRKulhpfcVLyNxAN/9LdeMoFtyvTGz1xZpgur1+3fjRDozhAsgjLBZUK5mQa3fu0OxNucq7STrrdXIsCqh3jGPp5bpT/uEU1IyCgjjj2UIJijRqtRIrf7xQ0xIx1SBZYecSIkUeVISh9LVTmBSmj8IHbGDqUxR66u4mIQbUFEJZJH8+IfTtt9PY1pHYPcvla4juYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQPz4nMZ+hG38N14yjcv4UShGRen7Z8oHBrifsRwttk=;
 b=IeScTLYy7MSlgEwCXpq6jRN5cbeNdCBDi3F848+iyB7BqrThN445lDZ+4U9g+VHus5O53rNFmKwwK0Eh6tJESLzDDyo8GWWiicOsgokMWpNRDwHZfowbN1lLDDxWZzFB0DSOFeeLUYkcT+puN6nYWx4DqB+aVmgHOE805Nt+vg0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0053.namprd12.prod.outlook.com (10.174.53.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 10 Jan 2020 21:41:34 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Fri, 10 Jan 2020
 21:41:34 +0000
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conversion to bool
To:     Chen Zhou <chenzhou10@huawei.com>, alexander.deucher@amd.com,
        sunpeng.li@amd.com
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20200110071616.84891-1-chenzhou10@huawei.com>
From:   Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <b86d050a-634e-c99d-1302-29fd6257df1c@amd.com>
Date:   Fri, 10 Jan 2020 16:41:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200110071616.84891-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 21:41:33 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d23f74fb-3496-45e3-7860-08d79615dcc1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0053:|CY4PR1201MB0053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005323DCC364FBA1910C626A8C380@CY4PR1201MB0053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2906002)(16526019)(2616005)(6666004)(956004)(16576012)(316002)(26005)(66556008)(6636002)(478600001)(8676002)(66476007)(52116002)(66946007)(81156014)(81166006)(6486002)(53546011)(36756003)(31686004)(186003)(31696002)(4326008)(8936002)(4744005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0053;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8i+of+K3LYqddKm3tSby5qA89lyp+rHWPkgM4Jdy4aEF4vuDVI8MW23UWOyulGfC4QUa9b5Lh0nczt4T8rJiJsz16BuO/tCa5MjCiBi5nHz4Ms8QS3D5UQCWlRy9oeuMXZhMnC8GjebuB8JssVahIGKbZsYCQjoelDYKYfDPeiCU4ic9g0GWcXJCb1WnmA/UUfnTWVswzDiv/C6qTPZgJEEQuY9WZTOQ0bf4nW0IMZn8J5UgUpYGUqjw5uaPEnNJu/qQkALm+6SjO+Alw+e9m8CuOSSMxsBfJQkGrOLTrZ8fP4aVfE1MrOGou1H48I9Tj280v7ngkyTeAssEx9+m5z7iFrjK4xz68Y3ZETH8pJ8nVVEQEcrW33EljlP/Ij1PWe8O3QNbM2fkchdtZkPBfrEg/mDJ7W7u79cwpvEeSdeGZO9eU+QW10x2jvw7Bsrn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23f74fb-3496-45e3-7860-08d79615dcc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 21:41:34.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qbnPjbZ+R7Kawq8vSOD+hiX5r0WgJPNlmEFRoX+EpDAMXxqdPI/TPwtRCIqrpRLgpPL4ERpPaERlRBtAh0S0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-10 2:16 a.m., Chen Zhou wrote:
> The conversion to bool is not needed, remove it.
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 504055f..a004e8e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2792,7 +2792,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>  			dpcd_data[DP_TRAINING_AUX_RD_INTERVAL];
>  
>  		link->dpcd_caps.ext_receiver_cap_field_present =
> -				aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1 ? true:false;
> +				aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1;
>  
>  		if (aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1) {
>  			uint8_t ext_cap_data[16];
> 
