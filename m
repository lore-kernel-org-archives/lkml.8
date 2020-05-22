Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47302078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="c/kJgyQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgEVReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:34:11 -0400
Received: from mail-eopbgr60106.outbound.protection.outlook.com ([40.107.6.106]:4865
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730701AbgEVReK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHkfxyCoUzujt8EtuZZo8CHHRQ8EpIh+/lJO7mvDajEmOo06tmJJTjtrRFw52tv6mKxZ6gWp4IlXE9izXwP8oYPeOVXUmwDy1qbVPdYCPU+AebS+4Qb3v75pYJQ8OoysKmNwBkGR4id+xVQtmorG75asixqC4Op0a1AGwVxfB/ERX81n+aiL/A/N62A+3BCSxUKKyZFrGDDaPTHZS17yTs+z+qjleV99wb4weGyGjzFqZ9IcaTFusujwxVpHTOXNJvLzkqJwNJuGByRMuUr5KlRyY9xMwrhNhy00p7ruC6g/J7mnXvUzi2zQQNs3GAXfzq3di7wmb0kDmANDtrg6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5JOskA8chfTEera8VCDqw217kl1iwxES9oPDGkyJe4=;
 b=FWr8IjQ6eJw8hdfFNXYdHvj2PvYIrcvW1T4HluV9xvQSYPIpsUhKa8pYpwhEH1AtqK+Ep66FGPgkH511mF73h1TAQ3kaVz5IT2onrk7WIBThXbUka0O5SbCFHdXKZinQIAAhWX/5Qc9mU1HnuLrrjh9OycE9iExqbdALTFSKc7bi6Qq0jukqRMV394gioBE46ujuR2nd+VvJAjJS2dvtEtO99x8lcpX0xAj04rMznFxCByxSdAnFmXy5rsTuKrr7k/Dbp+QSOPuggyne3QEHzW43wei0qVMLMTNa8H8fPDCnx4yr6JOereArUkQQ2ceyfd8+6XAevUvNBVlAHjM+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5JOskA8chfTEera8VCDqw217kl1iwxES9oPDGkyJe4=;
 b=c/kJgyQQAO1HzwDyvmFs+kuesewc6C69GmvTtKcWWU7m6O8k7d69mf6z4RfrfBEanuFLYQozSqi/oro3o1YhctJSxeL1ANHZCv3FJ9XKS6CtaP8Qa/zcMprxfiE/oTmVJqyekvYsH79mnAkNc735WZs+i6CH2vPffMYDzmwU+MU=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=axentia.se;
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com (2603:10a6:803:115::17)
 by VE1PR02MB5664.eurprd02.prod.outlook.com (2603:10a6:803:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 17:34:07 +0000
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::75e7:46d0:a9b8:a844]) by VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::75e7:46d0:a9b8:a844%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 17:34:07 +0000
Subject: Re: [PATCH v1] mux: adgs1408: Add mod_devicetable.h and remove
 of_match_ptr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
 <20200522125215.GE1634618@smile.fi.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8b742a65-f1fd-3a67-51fe-427553b40548@axentia.se>
Date:   Fri, 22 May 2020 19:34:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200522125215.GE1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0312.eurprd05.prod.outlook.com
 (2603:10a6:7:93::43) To VE1PR02MB5487.eurprd02.prod.outlook.com
 (2603:10a6:803:115::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (213.112.138.116) by HE1PR05CA0312.eurprd05.prod.outlook.com (2603:10a6:7:93::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend Transport; Fri, 22 May 2020 17:34:06 +0000
X-Originating-IP: [213.112.138.116]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e264f04-9aad-4c8c-68b5-08d7fe765428
X-MS-TrafficTypeDiagnostic: VE1PR02MB5664:
X-Microsoft-Antispam-PRVS: <VE1PR02MB56641A4998018BF1F021EADDBCB40@VE1PR02MB5664.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oubcT7FdKymsHmPXtVTuuC35jKM1ui5moVS5u1QKRqQPUMj2ZobnzubetmhCeQbvb/PRfAm+MIxtWvri3tP6EnMCbGX1g+n5athgZE8opWbx/iMH3HxFwR82GU0AWoY/zuhJehqIaCLYRpTG2g9fAPcFM563zXKrAHlARpBNh0tDCe9f2ScWva3ieYP1jTE+DnRXXzf073+oDCz2ZUL+oT5dIfXpWH6br1xFp+xWi11JVGP+oNME9i6oFiydUWH913mV+DIIiEQByIeTb3bDzrPze8vV6s9ba0GMdEKle2SqO+oTwMVDrBMLFYC/cMOAZRRavS4z217C4YUWhCIJQAqbLOzck527e8BJvxsrOWMaal4AhlRXWBJttkm4dFhL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR02MB5487.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(396003)(366004)(136003)(346002)(376002)(8936002)(4326008)(110136005)(54906003)(16526019)(31686004)(16576012)(316002)(36756003)(4744005)(186003)(5660300002)(26005)(6486002)(36916002)(6666004)(66946007)(956004)(8676002)(31696002)(86362001)(2906002)(66476007)(66556008)(53546011)(508600001)(2616005)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cGX3odRvFJzqX39jy7GO6CexHvrYJux0THa/KXEDU16rq6QHxQVFXb/8AMLHJrbEbx8bwZ7S9RcA7RpR246TqIVUm4ASp4zH1rKIoyxrtaan1WSTb8YWI3t3L3RS1WhCjLW6OiAa2f8b8uep6ik+PdGHtIPOE64BmJvs08ZIU/RoTGfUqkbf8pzb7RXOBlJYys7SMNWJFdMvtQ1g580l3L5jXjf/bk7MqXoE8X3v1BhELhtzQl2bivpsOyVf6nw/3a7JvltstOTnDvUCYLNL+vvpl9dFp5FNMxUMEUgXMkYQV3Dzb5GNvfg5UtVAlIdBk3kNQ9zFPX6RMqrjtyvulOn6e8QuT8lTAS7IuaWkQ8gdN5/ng62NXdkZl/sTrE4+0N+Z0IlgBLNIvxQ1DItteI/2cDjr68fyRo86jMAMW0aWO3VN1D1s7uk4qykhofISq7if5Z5rsao2joN3XJhccDID4QJ5EK2dNvR/Ec14ePo=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e264f04-9aad-4c8c-68b5-08d7fe765428
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 17:34:07.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtCp2QfQS18Gk+FmFLEaGfvjQDol7SQ4bPbgjF/NVFMlLo/CcdBvHWdaQg4sqK3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR02MB5664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 14:52, Andy Shevchenko wrote:
> On Wed, May 20, 2020 at 03:01:22PM +0300, Andy Shevchenko wrote:
>> Enables probing via the ACPI PRP0001 route but more is mostly about
>> removing examples of this that might get copied into new drivers.
>>
>> Also fixes
>>   drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
>> as has been reported recently.
> 
> Maybe Mark or Greg can take this?
> 
> I can resend Cc'ing you.

I'll have a look after the (long) weekend.

Cheers,
Peter
