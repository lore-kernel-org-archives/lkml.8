Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F85C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453AF206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O9kWWN13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgC1ShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:37:09 -0400
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:17121
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbgC1ShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:37:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/tELEFHQYCbrYQTb3qGclLjO8WllotaHxa2+iqtqkZsKsCBNaeYTKqbZGAkX63xRl1qfmth0zUsM2MKT3/i8fVPohW+c2rKh34mUvUPUdpRYOqoIjl2MU9uPhsh1RPuSbkHKP4W1s81hVmNm2IUmEv8Zt6JyClDCQaTZ/doJhxwHPdAXjbU9Quf1Tb7yS3iXR4wr4LQ8M+i2PpFP0pFNKMud3A31hIRIAf56l0jXVdM4XDrJZCW+Mx8zDmf7JpynxxJsXOsX5d2KOHxTrj4+6Nb/OPCaBsAB2Vniyrfw4jGlM2QCPA6NAy53mHpVDLCTtmScc6LPr1kPKQ4oR9BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNQA4m/DeOFszZX6hu4Z9niLSnudNQ9GkwoK+sQBwc=;
 b=dVhlF4JlD5g+uaj+bGo7wA6Y+B9k9FnfnR49LSFHgxoQTGdmEli07q/iKzeQcSi/PrxLGjK3T5wo3lqY4TKLoNZd3zbRaHJE3Sp3+hVI3/mY+rTmrKioqFyxowsvBaR1U45DLOjSEkKqdTVI/PdR0PXIh2M1wiARHAK24ES4tYNNe0pZoXb8TMahasufqYRigM5QwseXrHznNA9mcKTOnvGvq1wTdMEue0Hr//wfB/uBI11bGoHWV7Rey463b9N1OQpBXXsySA2brHfi1VlocdSoMKvYIeKjzPfih0zbzT9lRYGc8P/9M2hKx5wCejTgSz9Rk7BHlsxkqcnvikIHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNQA4m/DeOFszZX6hu4Z9niLSnudNQ9GkwoK+sQBwc=;
 b=O9kWWN13Liq8fy9/K8RBPMiamZMA9ixrF3a6wCQzpXeMSpHkVPOLmqv0uSptH7UAooaq5t8J7gJVSg0Cr7Ccuz33FK3/M2b9KSQ3LIm5P7lLdJz3+QPh1p79ALm8CeehfcqLkP5x1lVkYGf+6jaz1D3fb5hH9NWAQYXONPfHRP8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from BYAPR01MB5494.prod.exchangelabs.com (2603:10b6:a03:127::30) by
 BYAPR01MB4423.prod.exchangelabs.com (2603:10b6:a03:97::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Sat, 28 Mar 2020 18:36:27 +0000
Received: from BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb]) by BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb%6]) with mapi id 15.20.2835.026; Sat, 28 Mar 2020
 18:36:25 +0000
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com
References: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200206102340.GA17074@willie-the-truck>
 <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
 <20200311112700.GD3216816@arrakis.emea.arm.com>
From:   Hoan Tran <hoan@os.amperecomputing.com>
Message-ID: <6a01350d-1fde-f8cd-ecac-471b1a4697b3@os.amperecomputing.com>
Date:   Sat, 28 Mar 2020 11:36:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200311112700.GD3216816@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR22CA0073.namprd22.prod.outlook.com
 (2603:10b6:903:ad::11) To BYAPR01MB5494.prod.exchangelabs.com
 (2603:10b6:a03:127::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.138] (67.161.31.237) by CY4PR22CA0073.namprd22.prod.outlook.com (2603:10b6:903:ad::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Sat, 28 Mar 2020 18:36:24 +0000
X-Originating-IP: [67.161.31.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eac1394-ac19-4a00-9167-08d7d346ebb5
X-MS-TrafficTypeDiagnostic: BYAPR01MB4423:
X-Microsoft-Antispam-PRVS: <BYAPR01MB442316F14D2B564805D4733EF1CD0@BYAPR01MB4423.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5494.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(39830400003)(136003)(396003)(26005)(53546011)(66946007)(66476007)(16576012)(66556008)(316002)(52116002)(6916009)(966005)(5660300002)(478600001)(16526019)(2616005)(6486002)(8936002)(31696002)(107886003)(81156014)(86362001)(4326008)(31686004)(956004)(186003)(81166006)(8676002)(2906002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o3L8GvAVJDZ9Znc3ewigiJ15W9NHr26JWkC40n0kFuGGJGGGQ2tA/w/a6l3Bnaps+f1zPZXisNHZYz5SdoUNsJ8qjuSOTKCK+7g2sDuZ3UaH4gNJq/ra+ULrruBHugV9/aiKnL6pvHPKl8/ak/P1RD1/ZqZVShzigLMi2UzHMxJ6Nn58W19zp0iYCQRPHZ8c0hxMPurv2Br3rnPS7B+agd9jfcF1peCtFjA3nlqjCLm7Jp11nOZ04PUn0vlmoQVB92kG1BW6cyKpnBvC+gaIgne8KJfXDligRDkV4gc88+KmPqBW3DNCU+esL7cPzBRw8HCwhQlDNxEeBOowoOUCGbamJS9oMqWQEt6gbSHCYeA5l5i8xZQbTYb+EDFArhm04ZevX3cal0fsYE4fJYf1p36VGrNCDEavIA2xosNZLy/8wBMkC9xhriZOSUggSWTd+BbJRlADm6v6yBW3yokS/QQJ5TcEIOntky/jYQkq9KjXvURFKka1lhDMTbURNMySs2zFMBytrHRLZZZlav2Ig==
X-MS-Exchange-AntiSpam-MessageData: c2VxZX02ewI3CBvQrNERPKX6JkCE3RZ26CnlmbqK85TA9plihFrjdBaIVSeRlhWRQyxVTpuSQ/64DTtRWo/RCXMXqQPp/OY8jiEMRfHJHlPRL+1+G4Ab8Eis5nU/dpamvFfMMiL65qLk3pP0u+KBMA==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac1394-ac19-4a00-9167-08d7d346ebb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2020 18:36:25.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxpvm4EI9+38Nd8yfxhclSccZsSCbD/rmO9uIqtq6vZI7qQBbLkrrqrZ58VN+dUEOsz/KvzoacrWcK7oKb7hMQO0Zx5LNdbpeu7hdOIn0Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 3/11/20 4:27 AM, Catalin Marinas wrote:
> On Thu, Feb 06, 2020 at 12:01:19PM -0800, Hoan Tran wrote:
>> Hi Will,
>>
>> On 2/6/20 2:23 AM, Will Deacon wrote:
>>> On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
>>>> Some NUMA nodes have memory ranges that span other nodes.
>>>> Even though a pfn is valid and between a node's start and end pfns,
>>>> it may not reside on that node.
>>>>
>>>> This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
>>>> this type of NUMA layout.
>>>>
>>>> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/Kconfig | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index e688dfa..939d28f 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>>>    config HOLES_IN_ZONE
>>>>    	def_bool y
>>>> +# Some NUMA nodes have memory ranges that span other nodes.
>>>> +# Even though a pfn is valid and between a node's start and end pfns,
>>>> +# it may not reside on that node.
>>>> +config NODES_SPAN_OTHER_NODES
>>>> +	def_bool y
>>>> +	depends on ACPI_NUMA
>>>> +
>>>
>>> I thought we agreed to do this in the core code?
>>>
>>> https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com
>>
>> Yes, but it looks like Thomas didn't agree to apply this patch into
>> x86.
>>
>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de/
> 
> Was it a clear statement that such change will not make it to x86 or a
> request for improving the patch or the description? I'd suggest you
> update the x86 patch comment to include the rationale as per your reply
> to Thomas and post a new version of the generic series. If Thomas (or
> the mm folk) reject it again, we'll revisit the arm64-specific thread.

Yes, I have just sent out a new patch for mm core.

Regards
Hoan

> 
