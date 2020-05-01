Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB50C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23CF21775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O+NqE5y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEAXuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:50:44 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:54881
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgEAXum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJWGAU2voGvQIPpOYhtpgavc/7/5TtU+45ikSE/x46ib2gY2TuWjskAEdp0urgaFozy0xcWp1DAnXMx5Fk2x1jvR0rRgkMHLLdrvC5VLo7PMxaQBhmzGKRgTgKNuxbcr+EvypR4DPOMY/SRqy8ZeaxSQ13UDxQXZj3cBnIF9U52Y6Q/QlDTXCkvhkhevIKPBsc91dsg5tR1AjX9egrOQ/zMEe7AQr3Fty6VS2XbXjyYaW0lduF9JzfwqjbWbbFDqztbv1TwQubrmdZsUmWZdqiTWeMSy/cBpqekts70jKbkEenQWfmGe0zwSgIFV7+30kLT0bz/8DhTsOtnUH9Ix6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbJ4qK27uhND1oU9/fRFifd03ygQULiJawNe9Z+Ae5Y=;
 b=RnRALClocXLSlsBpXWwE8X22yG4iCoxNPhU1XDKnnp3QBpB7Wk+iuHSk5cSNSHmhdedrF2Sf6mY7Mcw+yYeK0/SgbgeP7ZdSzmmR77Y6Eq782OQDWR98orcvxGnyjNukuP4J6iuru1nvqnEcQSoAux76iq9LKUn766OrXDG5bD70hlC9caakKGbDKDGWXNfG1ski35x0M0usqjrWsGbzkCNnhMf0K2n5VF04wA0gEz/ZmLwjTlocQQ04LHPnXgeP8WPNSc9FGksokfo8iJG51CS2vwcJvkfEYWeSTXQ8ZW/D9dMgjmS3RfgSr+Scmyb9i2mr6CSwaPisGLBPqUkkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbJ4qK27uhND1oU9/fRFifd03ygQULiJawNe9Z+Ae5Y=;
 b=O+NqE5y6UyCG16TkCaIob/0uzkcTsiTrMNwL6b/XXZSkNxIFUEqk7je3e4PtINSBw5zXWavoN9AMEIkrIzvnHdbBmm3/cmAF0PYs4bqpOynEKC0UeUjx1/p8Hqzni0DvJXa7uJKX7tpQouQu8eLvwIoW1VOs8+4QeREqhCuJegA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1801.namprd12.prod.outlook.com (2603:10b6:3:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Fri, 1 May 2020 23:50:40 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.2937.034; Fri, 1 May 2020
 23:50:39 +0000
Subject: Re: AMD / Memory Protection Keys
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        jon.grimm@amd.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
 <b63e2111-b0c6-a716-3d99-88f91ad64e1d@intel.com>
 <68bdd6f0-a229-433a-9234-303a3b02b092@amd.com>
 <4b20cff5-6e16-3599-4fc1-4f51d7c18d1d@intel.com>
 <178377ad-efd6-d473-e10d-2928c171437e@intel.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <01f3cf52-bb1e-f6a0-5810-c5e62ce5f302@amd.com>
Date:   Sat, 2 May 2020 06:50:25 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
In-Reply-To: <178377ad-efd6-d473-e10d-2928c171437e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (2403:6200:8862:99e1:2c36:925:db67:65ba) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:50:35 +0000
X-Originating-IP: [2403:6200:8862:99e1:2c36:925:db67:65ba]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5237802-a3f6-48c4-552e-08d7ee2a735d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1801:|DM5PR12MB1801:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1801897521309D166E7F3F2BF3AB0@DM5PR12MB1801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0390DB4BDA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(52116002)(31696002)(86362001)(6486002)(2616005)(186003)(6512007)(54906003)(6506007)(53546011)(2906002)(36756003)(4326008)(66556008)(316002)(6666004)(8936002)(8676002)(66946007)(66476007)(44832011)(31686004)(16526019)(478600001)(45080400002)(966005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6viCYpv/eI8EeDcXyH4NAgfZ/VJipmevMACPqN9EAI2w8TDnw6p384tV8szwVa6J6b/3LTwXohFT0s+m2I+ugT5neTzbpI3h5/y7U1Tvl+zYC4cUArWwDDK+61n5FQuZqwmy3TjoHgIaKbwCFPYhLMmg5fz6vqePSJQb0DsXkdRbAQCswja6yvZwpSRZyNNiFFTLKKbKWLkGqOA0SNYlsyAuNV8FOVni8AcPqrBCZ8RtLM9LXDZOpc4L/k2Xr2zIttSfBoX/fQ2aN59DmF2hLhPXu0M8q/322CAN4I7oAQy6LJrtUTcGoYTX/I+Ic14u8N9R1urOx0MToaVV/oBZgVEEpzic4iKdsQEcKI8wBkx0wTwY5P00WVtXdgldtgn22V8B9+7VvDiw5FrG/XjQASzVQVdZf1ZP032PBk+hTS6YwrV9cmHeAk7/nTXDvySMze7QJcwtsJHTvlP9eyGFWqr1X2hEcSTAOfoyqpm4xzwsyU//BeanwBvNGruVj4VFT0X5Oybvx0kE0/yR4texpQ==
X-MS-Exchange-AntiSpam-MessageData: 8/1sSo54dqNMtYu5ceCegw3FsS3gn+irKtPe8kcjcopYrgnKKO0lHlrsj8awflqqnuZ6oNr0+EqPuHCQWHXbVSDxIVln6BDAIeTpDhEg9L8g2dVm+R1ekTP9LulkNspkzIXc6K7eN1QpDWnDGw4lNgb2a7QeRo0dFzYfdNd1CGem6O2VajZGOAlxQTQjwqJ/y2yrfz7iqfNKZ2OmHSqqSCjRWsjcMP9Nl/DRr8SjGOXpsrmM/pZXhxZmbF9drwCPS7UplCnxf7rPamVSS/AfaDnOmAykiNlwADum+7irr31KlWjCEPY6/GJzleAhsTZ8gsfIgcN1wv6XNmcKySIh1i/CjLO0moldAVyB3DTAvKONOtMHPjhDVkyvKmM15YnCzCJqPh6tKdPRz1yDkQZ7oiOpdFbqdQUq79ki0DSOFZrJoqInyTpju+7L9MuYvCAsny+3laEMgwVJOHdd7lZtCKOnYmdMMkje+ZLHyG+ZBZG9Yf+rOgLjbktkFNHMW6AUGFVkYbrvjDWT20BkfB1i32g8LYPDTiFueT9g4TUD6ichR0IhTzr9jPL5+eUbn2+7c0j70I2WV+hwR3DFS6LgT8vWIKImhASSno8MEySL6XJqXWRPLn/GsuPR77mnIDL3FIqfPN9ntexThRC6XOo9Vzd6hX99xcp5UE552FabRzEJJ2TZrMJYwX1LFwpKTLOUNGS20CEVC5Ad1nUn2xEj4ZvAd2O0bOKI+5ux5J8r6OHdGqVj7L9I8tk+4PB76bU9ew0uXui5hAyT1R/nmdPPLmDh+zEK6c/cX3U3uZuXSILV9VArkFbip6Nv37EcEzfTAQJlw8+7HzmAwerQ/IqqVFHHLXPFQXXDZxHxmjD7o1w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5237802-a3f6-48c4-552e-08d7ee2a735d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:50:39.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gdkTAFKenM9+O9b/p1sz/+tmIdQEsST2HNP7z04IYZL8pWKvB3SrjdOpaW2cektcqDVvYiDmy90o6Zsg13zoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On 4/30/20 2:18 AM, Dave Hansen wrote:
> The docs for AMD's implementation of protection keys showed up[1].
> Welcome to the party!
> 
> It all looks fine, except for this nugget:
> 
> 	The MPK mechanism is ignored in the following cases:
> 	... for pages marked in the paging structures as read-only
> 	(R/W=0) or as supervisor addresses (U/S=0)
> 
> That R/W=0 would mean that you can't access-disable read-only pages,
> which seems a bit goofy.  It's certainly a feature that I could imagine
> folks wanting to have.  Read-only pages might happen in unexpected
> places for things like mmap(PROT_WRITE)'d files or even CoW pages after
> fork().
> 
> Is this an error in the docs?
> 
> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24593.pdf&amp;data=02%7C01%7Csuravee.suthikulpanit%40amd.com%7C9ea21438bce6488589a308d7ec720d0d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637237847630823928&amp;sdata=LZLQjvlVT5xSnjyRt0alN0lHleh8VD7Sxx53RL1UrX0%3D&amp;reserved=0
> 

Yes, we have checked with the hardware team and this is a mistake in the documentation.
The access disable bit (ADi) bit does apply to read-only pages. We will be correcting
the documentation. Thanks for pointing it out :)

Suravee
