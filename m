Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D10C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA742078B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="hc5N5m8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCZKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:33:30 -0400
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:6484
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgCZKda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNXP+fhSgeNRXdtL17XRrVqp4dn7m9dp/TulRmgBHjeDIs4bWWgkrKhZ184GqMgF/ExIS7+Bojy3moV6ULe+Juq2smARQnqkjUP6zTzvOl0cXbor6PZnFK9Tye1cV1mNGX6PvVSDyjSL7wJdwQ/QLQl3oF8CAA7k4N/377R3K8RccZwr+65wrztElf0/CZeJQwtPX0LGu/Yo6YmKaiS1CqWt38kCewkYSefRxAPAroZDMr65qGa1jjzVL7XZQxMyhOMOW9IsKlwhToLzuW/0dCpPU+k2XYFBCbaosMstGktY3jHVrW24JATAaKhrFcQz5p1Iy8PUwZml5HQc9DqyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irpCIJDIAw/aqkFds6vcP54SukBdeBvwfRHIBpneX0I=;
 b=jzeUthRR1K3RAEa0iH9YWdyiv7SCqmpF1q1xOXNMXNIUGUJxTtpdqMumVi9e5b973qwvYhHsMROvYOSt+eTqQYlQK0dbMDyAqcG5MH/IK2L5yDfb/r0nUrerXfDVnh6FIvBN0msz7RJQP09akv37jJCKIXcHxai08+lk3r1iPtf3l+54ShKOJSxoRAdQfSfYWHfFMd7UkW9r/AMcnSi9eqKEP03i4BtGXL3arti3RvUqqBDnZSWohwnw4RKSwAY02pYpmBLqLqx5Z0RvWvW0lYTAKyLKSvCGrGdhp4v7kOCq3ZqbIb10W76F89VtGgAEQqpX3YPCS9q10VzaxNovhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irpCIJDIAw/aqkFds6vcP54SukBdeBvwfRHIBpneX0I=;
 b=hc5N5m8VY7fAv0JEWXGX54oMwtw4DwRgIIi8O3CpD6KMt112Zc7Y/1WQusZiCyj0g9rj/srMVcGwCrDsfyRv3bvQnX0NJT/ksbBT5oQvK2q7EjgD2DGsPMBWgkATpdO+xfbs+5oA4IZHnYUdMQL6OYHUf28wu30lTSHT6hlDb8w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from DM6PR11MB3355.namprd11.prod.outlook.com (2603:10b6:5:5d::21) by
 DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 26 Mar 2020 10:33:27 +0000
Received: from DM6PR11MB3355.namprd11.prod.outlook.com
 ([fe80::6097:9b3a:d583:1435]) by DM6PR11MB3355.namprd11.prod.outlook.com
 ([fe80::6097:9b3a:d583:1435%7]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 10:33:27 +0000
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
To:     Arnaldo Melo <arnaldo.melo@gmail.com>,
        Sam Lunt <samueljlunt@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava>
 <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
 <20200325133012.GC14102@kernel.org>
 <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com>
 <20200325192640.GI14102@kernel.org>
 <CAGn10uXpBUnSx8fsL79oMzX5bRLyhqckvxXTLg5JxDARsjFpDw@mail.gmail.com>
 <D0DBFE8F-632A-446E-941A-980A511C26FD@gmail.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <c56be2e1-8111-9dfe-8298-f7d0f9ab7431@windriver.com>
Date:   Thu, 26 Mar 2020 18:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <D0DBFE8F-632A-446E-941A-980A511C26FD@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To DM6PR11MB3355.namprd11.prod.outlook.com
 (2603:10b6:5:5d::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0201.apcprd02.prod.outlook.com (2603:1096:201:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 10:33:24 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39dd63d0-6350-47c8-39fb-08d7d1711e64
X-MS-TrafficTypeDiagnostic: DM6PR11MB4530:
X-Microsoft-Antispam-PRVS: <DM6PR11MB45308822402A178B8CE567768FCF0@DM6PR11MB4530.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39850400004)(376002)(346002)(478600001)(31686004)(316002)(16576012)(8936002)(26005)(66946007)(36756003)(66476007)(66556008)(8676002)(52116002)(81166006)(81156014)(4326008)(956004)(2616005)(966005)(31696002)(186003)(110136005)(86362001)(16526019)(2906002)(6666004)(5660300002)(6706004)(53546011)(6486002)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4530;H:DM6PR11MB3355.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYFQshDLceodWRO+w27OPPXIQ1S5NwwCeXgsXBIDNoYpTrQvmd5VErp9AiYyzWgEE4G1b0MTR7E0AFD/wvrh5yUD89CtCQyNuXX9k0LKly3Z+cqGY/BKKHeU+1BpXYXZ3eLGZSOXrJdZyJ8F+8Yfzpwz6ZVnRpSpAE26bCB3aSu22zacunCNPyFrt1bzpjifGqCKn11vSisvS/WlERzEWl49SGzo/xRh/LpIFFvOipP2Ec0D69axc/plVfO1h1441jhNdQ9GvhuFkSIGNx98H5dWnf5Rfp4OzQKIeTIFLiey48zOFgBLyHwr00OqTt8kManC+7Ub6fN0QA4zRRScqfuZeEQb9mzrW1lZPc/NA1N9vHqD8KuBKVOAxazSODF4r+eFPhLhfRvTGK0npDTRDH/3cZ9OWc+Vrea34Ei3iMBkwRam9Oz5+AitdptZ+rYFNeH6KiiPfi2FAGCGofnra8/mFw1Hji1/YmHgJ6CsVCxyuJ+GEAzH0x8xHWL1ib2OO4ONPbMAp4d6xBf55rtBWuQUz3HKOE1JOGjTHUe1OcTjb2lmuUzbjdbn+sJc/T72TAJj2hgkiScuyYBFZvuJUVwZcb9gbCfT6WNRjjDgl+Y=
X-MS-Exchange-AntiSpam-MessageData: 3sIfYZtsLAKjui4lpYpPwK2ywztuoea9xTaut7zEoN7q00jlAL8WwWfpKGcKf3skjLKsu/SnhZRn4StiLaVLxJkOFWAizXD94W52tLoS0A4mnwoEPUiwGnkfQFF5JMUVJ/ZHzWxPVA/0PsahoV4aEw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dd63d0-6350-47c8-39fb-08d7d1711e64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 10:33:26.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYh+N27NhE1NWj2ZvpHbdO4jEdq4t3XRWYCnETO+OEJXq2VUuA0/K2vx9A3Keue0kKztO/YSCz+9srIA1s3CEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/20 9:06 AM, Arnaldo Melo wrote:
>
> On March 25, 2020 5:31:15 PM GMT-03:00, Sam Lunt <samueljlunt@gmail.com> wrote:
>> On Wed, Mar 25, 2020 at 2:26 PM Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>>> Em Wed, Mar 25, 2020 at 09:40:34AM -0500, Sam Lunt escreveu:
>>>> On Wed, Mar 25, 2020 at 8:30 AM Arnaldo Carvalho de Melo
>>>> <arnaldo.melo@gmail.com> wrote:
>>>>> Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
>>>>>>
>>>>>> On 2/17/20 6:22 AM, Jiri Olsa wrote:
>>>>>>> On Fri, Feb 14, 2020 at 02:21:05AM +0800,
>> zhe.he@windriver.com wrote:
>>>>>>>> From: He Zhe <zhe.he@windriver.com>
>>>>>>>>
>>>>>>>> Since Python v3.8.0, with the following commit
>>>>>>>> 0a8e57248b91 ("bpo-36721: Add --embed option to
>> python-config (GH-13500)"),
>>>>>>> we got similar change recently.. might have not been picked
>> up yet
>>>>>>>  
>> https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
>>>>>> Thanks for pointing out.
>>>>> So, just with your patch:
>>>>>
>>>>> [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p
>> /tmp/build/perf
>>>>> [acme@five perf]$ make PYTHON=python3 -C tools/perf
>> O=/tmp/build/perf install-bin |& grep python
>>>>> ...                     libpython: [ OFF ]
>>>>> Makefile.config:750: No 'Python.h' (for Python 2.x support) was
>> found: disables Python support - please install python-devel/python-dev
>>>>>   CC       /tmp/build/perf/tests/python-use.o
>>>>> [acme@five perf]$
>>>>>
>>>>> [acme@five perf]$ rpm -q python2-devel python3-devel python-devel
>>>>> package python2-devel is not installed
>>>>> python3-devel-3.7.6-2.fc31.x86_64
>>>>> package python-devel is not installed
>>>>> [acme@five perf]$
>>>>>
>>>>> [acme@five perf]$ cat
>> /tmp/build/perf/feature/test-libpython.make.output
>>>>> /bin/sh: --configdir: command not found
>>>>> [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
>>>>> test-libpython.make.output         
>> test-libpython-version.make.output
>>>>> [acme@five perf]$ cat
>> /tmp/build/perf/feature/test-libpython-version.make.output
>>>>> /bin/sh: --configdir: command not found
>>>>> [acme@five perf]$
>>>>>
>>>>>
>>>>> Without your patch:
>>>>>
>>>>> [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p
>> /tmp/build/perf
>>>>> [acme@five perf]$ make PYTHON=python3 -C tools/perf
>> O=/tmp/build/perf install-bin |& grep python
>>>>> ...                     libpython: [ on  ]
>>>>>   GEN      /tmp/build/perf/python/perf.so
>>>>>   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
>>>>>   CC      
>> /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
>>>>>   LD      
>> /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
>>>>>   CC       /tmp/build/perf/tests/python-use.o
>>>>>   CC      
>> /tmp/build/perf/util/scripting-engines/trace-event-python.o
>>>>>   INSTALL  python-scripts
>>>>> [acme@five perf]$
>>>>>
>>>>> [acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
>>>>>         libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0
>> (0x00007f11dd1ee000)
>>>>> [acme@five perf]$ perf -vv |& grep -i python
>>>>>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>>>>> [acme@five perf]$
>>>>>
>>>>> What am I missing?
>>>> It looks like you are using python3.7, but the change in behavior
>> for
>>>> python-config happened in version 3.8
>>> Humm, but shouldn't this continue to work with python3.7?
>> Oh, my mistake, I didn't read the output carefully. It should
>> obviously still work with old versions, yes. I actually submitted a
>> similar patch, and it seemed to work when I used python 3.7. I wonder
>> if the issue is the "||" operator in the subshell.
>>
>> https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
>
> I'm aware of your path, even for confused by your comment here, will it try it tomorrow

Sorry for inconvenience.

Yes, it is due to that the command before "||" prints some usage on failure and
thus messes up the whole string.

And I've tested Sam's patch. It works.

BTW, my [2/2] may still make sense.


Thanks,
Zhe

>
>>
>>> - Arnaldo
>>>
>>>>> [acme@five perf]$ cat /etc/redhat-release
>>>>> Fedora release 31 (Thirty One)
>>>>> [acme@five perf]$
>>>>>
>>>>> - Arnaldo
>>> --
>>>
>>> - Arnaldo

