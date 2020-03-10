Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FBC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F3F24677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZiSo9QH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJGWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:22:17 -0400
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:21949
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbgCJGWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nekpuUfqisksp2Vu8x6Erk8IgWIi942plJsIlgtXzIePHMLN+cGg6ti0oROpQI+zOkw3v8jb3CkjRBLoX8Cp/C3Fh8BLPM9dBBRQsxVy23Amtxw56YCAF4/S0J3/Z1nUCS6w3fE1OZanawn25mRs9juv2b+uqgahL9SXDMg24V5l1p9Is61TB6V6tn9Q2dfKI6aBs8N/sirGUZgpyoPJoxQ0GoZNGzKy22xBN+gsoc11BL1PdT6PprTv16k5OQxyPolKhp/SQyj5VDVsV1T7hubPrXP6kmN9cO5tXKx/iNNZASDVqWPQHBqkY9UhAr6jNGDLRyM/1/7f16e/pNy/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT13jeaCEWBW0udbzXSdtBT1dGkZwcuskeb8J3nR3vc=;
 b=GyblzebvPXlGQ7lZa9Vt7e64jZpD+E2oapAuqOrpGNRpajH1JWXSfE7ymigUyJvkSwswmCalewp9C5r7EyjUX9KH0e9FjNaFO53rkdYKttPFi+kovnb/8hyn874Ny2sTmFiaM3BbhXxj7pvsT1u/84wjlCzqMC6VL8NFacKEXwFBcngkIxbN7uoilwytboKwpOWRWYbx9MegUFZ/GEDsJYmP62Fei7q85MpJMMjr1yJimJZ2c6xQMkObueMUwzcnKeEj/aJwqYUFxdfpyhVgyjRnVUPlpXH38yCW6dwpJmsK+7bU51zI3VvGd9nrkzzmfCxGuDal0mDsGnR3D60ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT13jeaCEWBW0udbzXSdtBT1dGkZwcuskeb8J3nR3vc=;
 b=ZiSo9QH6stB8V8hRI+nB34LIj4mGmYWi5x+b9dBLEGHch9/PP1c/O8acqfj3WuzWzx+hGBvt1x5zJP9dKFOp2/MJyaQ8sdGorEw+o24Iv8ruiXv836cQ3Pr68rg7JHjc1Kl4gXF/uNyxjeu5P6EUtBC3Ue/NWtzuZWEYMXASWs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (2603:10b6:903:120::7)
 by CY4PR12MB1590.namprd12.prod.outlook.com (2603:10b6:910:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 06:22:12 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::ccd2:2608:7a9:6ae7]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::ccd2:2608:7a9:6ae7%10]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 06:22:12 +0000
Subject: Re: [PATCH] tee: amdtee: out of bounds read in find_session()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200227161954.fo7pbbgomdjkraxq@kili.mountain>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <0840f77c-6ebd-eafd-6fa5-bc1c2b90f580@amd.com>
Date:   Tue, 10 Mar 2020 11:52:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200227161954.fo7pbbgomdjkraxq@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::30) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.230] (165.204.156.251) by MA1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 06:22:09 +0000
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5eb2f6bd-51ef-4fa7-2e49-08d7c4bb5e6d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1590:|CY4PR12MB1590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1590E43304C77D267FB1C2BECFFF0@CY4PR12MB1590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(110136005)(6486002)(16576012)(8936002)(52116002)(66556008)(66476007)(2906002)(478600001)(66946007)(53546011)(26005)(54906003)(81166006)(5660300002)(186003)(81156014)(8676002)(16526019)(956004)(31686004)(86362001)(31696002)(316002)(2616005)(6666004)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1590;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69D2CV0q7VtxymaDvw9klmSVx9wch+ExAKX1AriXWypI6CTMouKXv0xeOAPc7Sw7yhPswmkYDm2L36FvARRXocODQj8LW487Ogk0moNQE+LSTfghrvX0rOAK/6xyS9ajuyFpNWE/tXjJ5lW3Z0K2/zIRkdTpVtJdZvT98/AocQdVqMmASaXgHI+S+1MewWxf4UazM1ONTsk2/NepNxXQvdlVeplWGKfgRAn1gPBsSRpn+8qWTaHxIA3hTMUiF1lYGFcpeX3BoIjLvZWowXYghsdYbUVXtfBZ9Q0BFdeXEfF8a1Db9MbTFCz3+qkXqqqcCTLX/GdzKA/XrHbI4Zb2qLWxwmb2EvGcClBd1wjw66s/YatJRbM2l3v67iWB3eShEbjl7W4Wva7k+jQV4sHWriDAjTLms8JOY9DNnazxIQAHgjUtHdmbwWsHHZeaD8DH
X-MS-Exchange-AntiSpam-MessageData: FaiqGbCKcqwls5v8GMDdsKeRjo+6Lm6ooNtpA6kquur1vVWTGtEykqCxwG7Jc3gIW3oUj90ohMYWLxpalW+SGzALXVsmjeal31AsSzbsaMeMqz1hQd/eDL7Y07O0Ua8lGXnFx60/MUnlZ6UFkQI3cw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb2f6bd-51ef-4fa7-2e49-08d7c4bb5e6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 06:22:12.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5SpG4YCjx7hPnhjbPFE8pT2Ej70i2I5oPvQUncu9GD4CbMGeymZES0qCAsYswznN0GAsdRNf0CU8U7K/Gieyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/02/20 9:49 pm, Dan Carpenter wrote:
> The "index" is a user provided value from 0-USHRT_MAX.  If it's over
> TEE_NUM_SESSIONS (31) then it results in an out of bounds read when we
> call test_bit(index, sess->sess_mask).
> 
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

> ---
>  drivers/tee/amdtee/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 6370bb55f512..dbc238c7c263 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -139,6 +139,9 @@ static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
>  	u32 index = get_session_index(session);
>  	struct amdtee_session *sess;
>  
> +	if (index >= TEE_NUM_SESSIONS)
> +		return NULL;
> +
>  	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
>  		if (ta_handle == sess->ta_handle &&
>  		    test_bit(index, sess->sess_mask))
> 
