Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6861C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FFE207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s9Xn5Ztu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG1GgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:36:00 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:27617
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbgG1GgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RotAQcr9a9o347f8/E4dQjdfsxwzbOoRxkZMOV5bm8TmLOzTpMDZ+KRxOIl/8P/p8MfkvTgA5onLUypktDJ6rkHfyPpGyu7r5Sx5qwivjpHx4CxFaVWZMVZGOIhIYcdDMWeBKpdK4hW5GdWzVu7vWVzyTHtWqWBoZEBVfKx/uk3FmOoaNz84SPgsIwZnAMO8O5VBzITSUfUi104Gf++Lf7mNGYco/siSYwulPC/2dgsqiXyxPpGLA9fRWuEgT4XIo2bPYwMZcfLD7NL6NrpZn6Z2VO8o72NGGoXb3Wz2vRAQ7il1HJjVxUDDq0KoQdVR31zVfx/6+Ud6RRcQP0Rb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXzm7ERdmfu74MiKrHQ2foV63YBSbfY5lAbSki7QTco=;
 b=noa/r+6O62YuOWTR1Qhl/ocpXMA4jicm/ur5UpcmQv8jqRK6QaI2L/l+1hXDKhgmeat+nzAOdGUSSmFiMJcc9jhXrGAnfFQ3/okRKXIbOkOfsgq3d81OVEROBmimTu/ER4u7PtFWdltMn5glMvKBqxRG8aUTLM03PIbwrLIau+C12uyqyfgH5axR8L4Rh2MY7KqnULFvlJzhrkzDlM27X4yrQ/1wwUOg1hGVQ7O2eDZf3YL2rJOO8jV2y02h2oMH0+d+zrp1YlhSzGjGVgbqmwwQMW2PlTqeNJmd8Wrci2fE15nPbVBlS2ESX1JFTyq1FtOgPtdYKqraooB0V7nxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXzm7ERdmfu74MiKrHQ2foV63YBSbfY5lAbSki7QTco=;
 b=s9Xn5ZtunXsIwtsa00ZMZWteZWbYQuf0r7BzvweOEhxwJdocY5FEScq+JpvivrDUDeetXuMQjfdZELMA9xzvzgF7oA1PJ2KGQ1pmtPgB22x4F4Dyp/PYn0togYSSuw0m2bhjt+Upi2TBnoS3vpUX9+vknPvHKMtCb2UvKgGZieM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 06:35:57 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 06:35:57 +0000
Subject: Re: [PATCH 2/4] clk: x86: Change name from ST to FCH
To:     Stephen Boyd <sboyd@kernel.org>, akshu.agrawal@amd.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
 <20200720050500.23357-3-akshu.agrawal@amd.com>
 <159531878155.3847286.4182941234530539520@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <fe1842c6-47f0-1eb2-9973-628f34d02e54@amd.com>
Date:   Tue, 28 Jul 2020 12:05:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159531878155.3847286.4182941234530539520@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::33)
 To DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.179.172) by MA1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 06:35:54 +0000
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b7c762e-9484-4f31-08f0-08d832c07bd2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17226506CB23146F9DC62C09F8730@DM5PR12MB1722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjKc1wLoisrTtCgiCy1jSLOwwAPr3DQxUYJjM7bnxMhfibiW6OOpF6Hm/xyTVXceePQTmTPc7DEvdbYoSLbQ59XIP/4AHly6wyGIep04Yva8mjqD5haf+CUA698pX7swJeGLRMx3trG5Z56aCcQHgszS94KfISiTIPtROUbZXq7SUQyAWwMMcJ3sqKeBp2QUpKC3aAkfQZRmOAyxfEtk3Qv5xpESZ2U4kdc+359ioo8VLght3ntHvpYwKD4r0U/uRCJ3Fsp/Yxn26vUtrviaW4wZKSZezoUZItPMBEmwuyVA2L0Aye6vENWW7Gj/gkVIVNTJRDsRVVfImhBcKLS9fX3hfjURVTn7IlPZxB2SMz50y5ffyy4jyro+B1l5w9Bu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(31696002)(36756003)(26005)(5660300002)(4326008)(31686004)(4744005)(8676002)(52116002)(53546011)(54906003)(6636002)(8936002)(6486002)(2906002)(186003)(316002)(66476007)(66556008)(6666004)(66946007)(16526019)(2616005)(16576012)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aiXQNVRlTmKk0FnBC96ELEhxoN99LwOABo0x0Qe/6rGrpjxoPtYaA/t6cByoKtncao9EEEbgLpnIeQl1UbSgqFgMwu5ei6uxGakv6gQ/oISe7R1alxxIs97gpS7qyXlCHNnLNhcoHriL/0369Tifh6o49z02oVcvq2xUjyTfEGenRT3DcwlmU6yTQ8f7fbLzUllyV1G4rYQTAUdp+Elgs+8igD+qIoEgUayIDtS4f7ME/573iY6v7wVFUVyrV4o8a7vAiSpjRcaMMFk8PCTTNoOUMMhcJTzvA4BU+5nybIljIrSsEjkLtHv415Zj+BXGo+TZXlsBEAcyFgfOIl7hT2dsL2R9RykjmT5MoSIXWdH7nGCjd0qs6HtU0W9rIPoOy+5pl2RIHC+7mMcasOaYHILv5KGFQcDt1LLX68l0WJeejVLtVwdb4zlm5RAoVFu7nEEEq0Z9m3An6/zhXQv/haW4mkPuSI7cdjS24f0+GEI5Fh/j/+9UuQGytInmzCS+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c762e-9484-4f31-08f0-08d832c07bd2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:35:56.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHqkrur8QvaCEZzlcY9uVVHrOtWYwKPvKJVj1ElGn6kYJalkfcalEAu1ulBnNz/KHp7gnQI765Nlw2zTOs2OeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/21/2020 1:36 PM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2020-07-19 22:04:57)
>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
>> similarity index 73%
>> rename from drivers/clk/x86/clk-st.c
>> rename to drivers/clk/x86/clk-fch.c
>> index 25d4b97aff9b..b252f0cf0628 100644
>> --- a/drivers/clk/x86/clk-st.c
>> +++ b/drivers/clk/x86/clk-fch.c
>> @@ -8,7 +8,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/clkdev.h>
>>   #include <linux/clk-provider.h>
>> -#include <linux/platform_data/clk-st.h>
>> +#include <linux/platform_data/clk-fch.h>
> As stated before, this should go with the patch that moves the file.

+Rafael

Sorry for late reply, somehow I missed these mails. Will move it to 
acpi: apd change

Thanks,

Akshu

