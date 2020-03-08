Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64544C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D912072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="e8/shd3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCHKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:23:54 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:6263
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbgCHKXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhDihijDzLHd6BA+tPE+qwMDX+rUpbXqXgzZSOafN+XCPJgN8kjP+GddrdqrqWxxzZ4Of0mUBKJVj5xh7WTjk8klRNEkElTdMdl70+uKCifLSYTG2CGkWl4ZJNmCAf5OFuOPdRKOzdPIaxJeVBKqPJwRm54H8xTOs9DrxTsuZDPYZ+FTJw+8FjL72DYRpyAsK0josMNl17cW3ey8bizJ3usEln8oj+w8SPdx3fwiEBAWrSli9UbmVBeMB69cTGda5fqHsUDZqEWXER+JmeJbv5LGfGIt7BowQqn+mqQADn+yFbXZEq4xq9arvE3iay3S8iyOkdagvoIc9U1dNxYqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6KhW8NxcPFNDaJgA+0pcsf2tjAX0p8soeb6V4k1Q7U=;
 b=ClPXSY/G0mlEEWHed8BhzkGdPjLC0rufCmN62730NuxkFfreYETkGhwZS2TtD5OJssffTpDnXDfGb/qH5xO6678zVQswcbmZIlwfkN1SXgsG9m8SAhUFUmoBqucAyRR7YqRweL23INkdml25pFAp8pGsRtvNJqNswXtsOt4lyAxUMkKfgQbi1Aev6Gj6P7rWwbsVSgzoqVcssE7LHErvMieqmqVSDJaX0FauwRueZ1GxSUZB+Up07y0XPUHzmLPBPDk1Ess3NIia/CmXJaUtLFpG7j6No4HbGu9xPduMvWHiorRkqLat0QWVtN97dH15E6dsN4c/u+jaJEqRUN6Kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6KhW8NxcPFNDaJgA+0pcsf2tjAX0p8soeb6V4k1Q7U=;
 b=e8/shd3YGzZxTllf6JJxMoFKt3z+u2GX8mfyBOCsT/PS0Aht+8zNRgzdq/39snm4ULsCFY9HrCuPSp2qrlkFGIp+VNzydX9AufORG3gMo56fpFDny8OWxm2uN37l9H+zKLWFMtXhwMspOI8vQZC5F6sGwV7QPdtkAh9A+R4tDus=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2605.namprd11.prod.outlook.com (2603:10b6:805:64::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Sun, 8 Mar
 2020 10:23:50 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2772.019; Sun, 8 Mar 2020
 10:23:50 +0000
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, jolsa@kernel.org,
        meyerk@hpe.com, linux-kernel@vger.kernel.org, acme@kernel.org
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
 <20200305152755.GA6958@redhat.com>
 <20200305183206.GA1454533@tassilo.jf.intel.com>
 <20200305195843.GA7262@redhat.com>
 <f5a7ff48-659a-bce1-2ad0-54f334c27379@windriver.com>
 <20200306083000.GB248782@krava>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <d9e79d87-59de-8139-3b15-089789fb5569@windriver.com>
Date:   Sun, 8 Mar 2020 18:23:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200306083000.GB248782@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Sun, 8 Mar 2020 10:23:47 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e116dd-6011-45f2-041b-08d7c34acb1f
X-MS-TrafficTypeDiagnostic: SN6PR11MB2605:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2605E46FCED61E57B4DF92B58FE10@SN6PR11MB2605.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03361FCC43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(39830400003)(396003)(199004)(189003)(26005)(8676002)(6666004)(86362001)(81166006)(6916009)(186003)(5660300002)(6706004)(8936002)(31696002)(4326008)(81156014)(478600001)(16526019)(6486002)(66556008)(316002)(52116002)(66476007)(53546011)(36756003)(66946007)(31686004)(54906003)(2906002)(2616005)(16576012)(956004)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2605;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7SpHflfEiROu0KTtQpLa1yBVdSHZLw1gSuNXaKHPieJ4rCXnWZX8bVrJ7UdwXbn5Xl/LmIrQw0zYtBaEDhp6O5aAKW6NlwIMnU9C4Y5/snNUeCvpFzT4LMp18n4ErbmGDAnJTvc3hlX7uTwXh3dFwnlPlbH48MMwLjoH2PqIA6IkSmLskXOsJqbaLh1NpYKCu9qpOVh1dhkyl5Xe0kg3Fvj212bG1R9mlTJvRRg63iQ4DSnhwg8DAOhjp2ZlgIBb/V+LQQ33NDsM5GWLl9sRBdFBTHnjQl8eSuRNq911V4+mzrYqxrZ/DphQW6XGAe0YWUsgnfjgddMq1/0utqs/jGVBRlnjQk0H2l5ncRVuwWPq6cxec2gulURwWsayOtGzH4MOFxJr2D7kYZ48/kdObCgNvzw5R4uiDpcj2Ic0rKP6BSBc/1qF34XY/t+MDJd9qPeDmZXX250uJqcG8y4Ke9Ei6j9QW2iwVQQKgtqAs0QNxQ8qBifPK25nPTZoEOEhrHlH/+1O3lT1Iyby3m4ItjdeKWXyhJOJwJTlRhPp58=
X-MS-Exchange-AntiSpam-MessageData: MFaBHIJq8m06oNDN4H0QKQA+gLgYJqP7Z+mGbJhdyOmKbnDNq/ELxuio2JTOj2uouiCdhzqaWfbnt8FV8VS09Sl3fVkb8HDLjOpopY5NB9xuS0KSsq4GGhivbJizsUtPHnv1F8VXwH4uanTB2v4Uxw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e116dd-6011-45f2-041b-08d7c34acb1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2020 10:23:50.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMjW8pZQJzzFkPYwT+X6FgCDFV3BYb+Orc+j8O5RKdefTrFzOJZGF+xDWqzlETosVqnusMEk2gVb12AFqbYoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/20 4:30 PM, Jiri Olsa wrote:
> On Fri, Mar 06, 2020 at 03:20:55PM +0800, He Zhe wrote:
>>
>> On 3/6/20 3:58 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Mar 05, 2020 at 10:32:06AM -0800, Andi Kleen escreveu:
>>>> On Thu, Mar 05, 2020 at 12:27:55PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escreveu:
>>>>>> From: He Zhe <zhe.he@windriver.com>
>>>>>>
>>>>>> NULL pointer may be passed to perf_cpu_map__cpu and then cause the
>>>>>> following crash.
>>>>>>
>>>>>> perf ftrace -G start_kernel ls
>>>>>> failed to set tracing filters
>>>>>> [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
>>>>>>                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
>>>>>> [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
>>>>>>                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
>>>>>>                      4d f4 31 c9 8b 45 08 8b9
>>>>>> Segmentation fault
>>>>> I'm not being able to repro this here, what is the tree you are using?
>>>> I believe that's the same bug that Jann Horn reported recently for perf trace.
>>>> I thought the patch for that went in.
>>> Ok, Zhe, that patch is at the end of this message, and it is in:
>>>
>>> [acme@five perf]$ git tag --contains cb71f7d43ece3d5a4f400f510c61b2ec7c9ce9a1 | grep ^v
>>> v5.6-rc1
>>> v5.6-rc2
>>> v5.6-rc3
>>> v5.6-rc4
>>> [acme@five perf]$
>>>
>>> Can you try with that?
>> Thanks, that does fix the issue I met.
>>
>> BTW, my change in perf_cpu_map__cpu can be used as a preventive check
>> and the "1"  in perf_cpu_map__cpu should be "0", and assigning a NULL in
> I agree, can't see why we had 1 in here.. must be connected to the dummy
> map.. could you please double check with all the perf_cpu_map__nr usages
> that the 0 will work as expected?

I just checked the callers of perf_cpu_map__nr. They really depend on it
returning 1 as the only one cpu at least. And the same trick is played in
perf_thread_map__nr. So perf_cpu_map__nr should remain unchanged.

I'll send v2 for the rest of the hunks.

Thanks,
Zhe

>
>> perf_evlist__exit makes the clearing complete. So are they worth a new patch?
> the rest of the hunks looks good as preventive checks
>
> thanks,
> jirka
>

