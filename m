Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1342068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ivHp03Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBRdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:33:43 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:52704
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbgFBRdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8NVKH8Z3iVOetcPJYKctWnB9O9u7YGqpr5QbSL/lnTGnfakXpdCQ2SkF3MxgK2cFuJVhYpznXoKDnn01SUTlTJN3XdjthOTG+XgRq0hlys2mfiNBWlS8ureYemOnfI1xrMq9imd7YyJT29NzwAFxJTBIpYuyhwP0RykctX6FSrcxZhh40OwxARk2fqXj5I2YcsMbUaJ8pX/Vt0cfkXPN7+SXfjFdkPSyxO1cLcH0zzdynRoJhM6y2TQSoXM4In6kq4vu5f5czUyukYpBETukFOECP0MlrO/FbD0B0ii7DO2YQLFyU5vE2bCygwFfrJmJioJNLbFQTuFLO0zr8JVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3o6W/RXGdEVxDVVY5ljFcDgU7olAWA0QhMQQXa/edc=;
 b=cPJyYBtTwN/6lxP1Y3FyYyFIHxPFWs4/AMV3ZtYHuf/aFfbzhaEQSPEg5U/3+ZPjcdloBWfYHMAtiwD+VrPThAteODrDvcllzOD/vn7bLzbsC9vQ2ynx4vVN+N/kLJ0/uT+HTdLDZjpRjT2AUwUmSzJfaiRWMAdPnrwt193xQQbaR82UIVlrJGFCFEuFjVsF9fU7lOXprpXeO/WAWD/oXf7tPLX/JphzCmmG1L1ISe5nf5t708OpQQ+QaGHRzQbW6AKNdjKktx1ex2U4qZJEPAsIbcL0ulp1Rzu0Xy+lyAKv5KK1uMUXqeuhcM/YZOVRgdawWdMqhTHo/FbbKbH7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3o6W/RXGdEVxDVVY5ljFcDgU7olAWA0QhMQQXa/edc=;
 b=ivHp03SlOGcsI8BPs9mFFbyVrhLLDp5Qn3WelYFLdfXfnrfgfNC6P79TQmwRieOj9U6fmUpU6XFP7wmUgoveUblkMngq64DXv/l6kHo+mmUa7FMBDFSBNlu3JeXO9Uc3QEmgK0oFpyQuDJuxucI184khA1NrniWTZ/rHCyvyhok=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1SPR01MB0002.namprd12.prod.outlook.com (2603:10b6:802:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 17:33:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 17:33:39 +0000
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
 <63f23edd-39d3-0577-6e00-21066ddfe57f@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <05e11ddd-ca0b-e454-0152-6c83e7b7d719@amd.com>
Date:   Tue, 2 Jun 2020 12:33:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <63f23edd-39d3-0577-6e00-21066ddfe57f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by SN4PR0201CA0046.namprd02.prod.outlook.com (2603:10b6:803:2e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 17:33:39 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a2bfed5-d2d6-4bde-e5ed-08d8071b1657
X-MS-TrafficTypeDiagnostic: SN1SPR01MB0002:
X-Microsoft-Antispam-PRVS: <SN1SPR01MB0002CCF5D86DEEF59DB4211F958B0@SN1SPR01MB0002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4Gu3bLHls2QBkLA/lgzDxRTJ4LQn4of+Y2olt0OFEuOuS9v7A3D+G1qS6rABKJZIY5pv+HhD6sNVOpYXnyLkbjF1yF0P0VFvRNECEdh5frEGm4ul0FovnFguBxQfM0IIN+oChANXTfN0b/Y07l00ZKBEMn6rNFI1Z4/B1crw1sqlIUS/QlsZ+mRKf6IaDa+yC8Se3Oug0oBxgEkOUZxIM9olmhH9l/F75Y1SDaZy6cngkYTTvxg1PSpJn0j13TT40D1FeuxVhV3Q54vtMNP+gnljha1aD4XEuYApujaVxDDKGjckhCV2Gdfo3RSgbPoubftIFJKERD1aCRkPygX/HgWsaOdbo6JCOhs71gns02CURLRBBs6TS8f6N/2GZ9x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(2616005)(26005)(31696002)(66946007)(36756003)(66556008)(66476007)(86362001)(956004)(5660300002)(8676002)(8936002)(478600001)(16576012)(53546011)(31686004)(52116002)(316002)(2906002)(6486002)(186003)(44832011)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FcqEBElAl4EmrI49QqPxB3cs+I3Wyo9iooD21jNXWmIgxMqEbh4L3CoYMPVUVQlZEnRq1vh2gzAtbEmmDh/Hv8XCEFMHgmHH1/VYLVn2XOHjfVnnCH/FPTsiOvBk/e1RSAF+csab/pKLEg0RfL33lEJw1NZdh6lITCaPxIcOmkDBZLdU3kwzzk+YoW4Omm64X1g8bqmisP7+njQlcKq4Y5pna1qJANNnMQsB4t4dC2ntBirAsP0AhpsKP09xQqHesR+j/VNRL99jYJBK+F6mfR1TYrPqb4G8Wt3haP/973miY4j+2XGUpWvwLus7qdDtiadzgbWjoco0pv4JGrn8N/eCjjdNCEcH5P1pNmElZLrtL8AZ+E9407br0vzPNhu7QEzBqehKCGpObZuV4LAuD4nEaSG63n7omlWz9sd6CJK8BlkM1I1nBubtnzc/GW4wJ43BAC634oCH5tCwkB/IihmKWh8aWO6jC1vGbFouc3A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2bfed5-d2d6-4bde-e5ed-08d8071b1657
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 17:33:39.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXauxj2838VvkpBbcb4SmsNNRJVbxOQTFCqFUpLIliCteNon9Ncz92QD6ytjCWp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1SPR01MB0002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/20 12:13 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2020 4:00 PM, Babu Moger wrote:
>> Memory bandwidth is calculated reading the monitoring counter
>> at two intervals and calculating the delta. It is the software’s
>> responsibility to read the count often enough to avoid having
>> the count roll over _twice_ between reads.
>>
>> The current code hardcodes the bandwidth monitoring counter's width
>> to 24 bits for AMD. This is due to default base counter width which
>> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
>> to adjust the counter width. But, the AMD hardware supports much
>> wider bandwidth counter with the default width of 44 bits.
>>
>> Kernel reads these monitoring counters every 1 second and adjusts the
>> counter value for overflow. With 24 bits and scale value of 64 for AMD,
>> it can only measure up to 1GB/s without overflowing. For the rates
>> above 1GB/s this will fail to measure the bandwidth.
>>
>> Fix the issue setting the default width to 44 bits by adjusting the
>> offset.
>>
>> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> There is no fixes tag but if I understand correctly this issue has been
> present since AMD support was added to resctrl. This fix builds on top
> of a recent feature addition and would thus not work for earlier
> kernels. Are you planning to create a different fix for earlier kernels?

Yes. This was there from day one. I am going to back port to older kernels
once we arrive on the final patch. Do we need fixes tag here?
