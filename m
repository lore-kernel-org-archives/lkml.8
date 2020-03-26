Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C04C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770E20658
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VekhExwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgCZTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:04:38 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:23069
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgCZTEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjlcS2EzzYjPtbI2hg0BWZNzdsb9PLd49GBc29+2/ZIDiTiZrHAcMbz+x7wMtgYDC40A4iQxZEBnk8VYMHIzCzNGBK+aYLAow0wsvdPQG2XdYJJ20BUQz/3yYUJOAasMXqosAIhrCKkFFhV+jSvlRyystui9ZCDgw85vw+GUv6oIC5kZmVxSSM3gNWpuwjLW2o2SPpkAF2zu5xAD93g2ywzUWmFP+MIHjO3bpLxoUIvdE6kJqg+iXXVpzdDzcfrp+VcL7WIfl6r6Pne5pGJaTxJkO6DQh273wcsUinqIwGrLnu3uAc4fDO/HgBqGxsxAQZfZfgPaUI+MA52cstXSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUpAv5P5yNcgovAa+1hKp9pfypfULpomYaiK5MOZRNc=;
 b=PxVYubq+jJcMtRlJQ8x12vj2wvUBJwQEFZ5WG+tiMd4TsNislsBpNXFbido185wBdLR810ccCRaL/38C1IJtZR0Hu8dz/dz9AkZGv0RJc8tJuCMQHFWR2HXdxOx+R/J0W5zPiHf47qgBkkUJDT+59yzhACTRx/+J5xOZ8oWtEtpFc1Lw1cIbDOtT8t/jAyxbbCPhPlwYXc6QShD7H/cqxR1kbr0T/Eg0phVZab7BG3xd3Lq7SCbPa17tZZogd7r1pAHftpamIKTDQUz60a5dkJ5GMHfgSEZVGVv5qheWuM+lAQeVE4nh4N6OLrQ2BF9l2xjr7MF168Sic/uK18sLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUpAv5P5yNcgovAa+1hKp9pfypfULpomYaiK5MOZRNc=;
 b=VekhExwxUYmFYvIdvFREROZtWo076QBU5+EcC1GRMltquXcJZAB/EPrylhHiveCO7g2AX2A7ubBbhHe6TsFqm49LKOi3yvnlB8qUsh+G/SAUGe+tVR8PDATgHCQNLI8psdGePPj8a8ZqaWbg3f5KlXJLT1HfhLNZwGHoiofgBLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 19:04:33 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 19:04:33 +0000
From:   Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
To:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        linux-perf-users@vger.kernel.org
Cc:     Martin Spier <mspier@netflix.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
 <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Message-ID: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Date:   Thu, 26 Mar 2020 14:04:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:408:4c::20) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.194] (165.204.84.11) by BN8PR16CA0007.namprd16.prod.outlook.com (2603:10b6:408:4c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 19:04:31 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84eca86b-563a-4dd8-66b8-08d7d1b88515
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685DB9F312FE307343B768087CF0@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6486002)(2616005)(81156014)(956004)(26005)(186003)(66556008)(36756003)(53546011)(16526019)(66946007)(8676002)(81166006)(52116002)(66476007)(8936002)(966005)(31686004)(44832011)(16576012)(86362001)(4326008)(478600001)(31696002)(316002)(5660300002)(7416002)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ef2/eYHZG1ulmO3Ch9uTWn6GtdaeO15lOzM8unKVyzWA3xSia5efq00qTxBusVv9LalpiL9szUuHRVybDIwCVLYT3+saXgpl5mhn9OLyAgLL46V+SwzQ3POQSnmFZq6fEW9i6KWRIRouWAvR4+Ogl0GZBsweQiW0PnPGoB1NgNBbJbjq1wZJ6gTqeaCIGqh1bet7RbRrtRwwwD7fjVd7y0U4Qcuuf+4AH9pte7VCppmUt4/125tvsq+x/G3hPIaz5huWuCUxoU0eKhmRVUIXgoCNFi+NeyU7AVwFxIotVKD+9HWOl2uifgyawJweNdhVJ2Z1MfTRMZIIOjnAhM87SNCzgZ1fo8WyFWB7b8szgskMCyruyVvhEWoMorHuDRQt12TKVL2hv/W/b5eXXqhb+W/MlwTC/raZnM9PzzyKnhRbklK/KrSZiskccSm7lDH/d6M89+nlyJgUBvPqKom5HJqVGlVYBn/IsYPVOmIGxQeVmvNS/zE008i+zs6Z78apK0zc94+OIZZmZQoxKcTioQ==
X-MS-Exchange-AntiSpam-MessageData: AYjDArO/D9y4i4+ULDKZo9gADBy6/8yhWJM6o2VGY4kog+IYXjaNvRUywBQo8ADuLIvdmwcQmXDGQLsbxquS1G7cbGCvRUHQ68EF0J9sUkuSS9citYTTw0cenFWV9LFdiNz/8u7xMS74x7/7vDfUpQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84eca86b-563a-4dd8-66b8-08d7d1b88515
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 19:04:33.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eyNXyxgeNXVqRRUMx0flSl2L3UdYb7IC84piwPdm1w5H0H+1VZRYikDwk+NOgB124x4j2mzp7P9y5MSbHyMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 2:05 PM, Andreas Gerstmayr wrote:
> On 24.03.20 17:16, Kim Phillips wrote:
>> On Ubuntu 19.10, where python 2.7 is still the default, I get:
>>
>> $ perf script report flamegraph
>>    File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
>>      print(f"Flame Graph template {self.args.template} does not " +
>>                                                                 ^
>> SyntaxError: invalid syntax
>> Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py
>>
>> Installing libpython3-dev doesn't help.
> 
> Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's officially EOL since Jan 1, 2020)
> 
> The Ubuntu 18.04 release notes mention that "Python 2 is no longer installed by default. Python 3 has been updated to 3.6. This is the last LTS release to include Python 2 in main." (https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes) - so imho it should be fine to drop Python 2 support.
> 
> I tested it with a Ubuntu VM, and by default the Python bindings aren't enabled in perf (see https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707875).
> 
> But you can compile perf and select Python 3:
> 
> $ make -j2 PYTHON=python3
> 
> in the perf source directory (libpython3-dev must be installed).
> 
> 
> Does this work for you?

Not on Ubuntu 18.04.4 LTS, but it does on 19.10.

On 19.10 however, when specifying dwarf on the record, e.g.:

sudo perf record -a -g -C2,4 --call-graph=dwarf -- sleep 10

I now get a SIGSEGV when executing perf script report flamegraph.

Here's a trace:

#0  0x000055555590a9b2 in regs_map (regs=0x7fffffffbfc8, mask=16715775, 
    bf=0x7fffffffba60 "", size=512) at util/scripting-engines/trace-event-python.c:696
#1  0x000055555590ab03 in set_regs_in_dict (dict=0x7ffff61dd500, sample=0x7fffffffbf20, 
    evsel=0x555555d7a700) at util/scripting-engines/trace-event-python.c:718
#2  0x000055555590af1f in get_perf_sample_dict (sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, al=0x7fffffffbdd0, callchain=0x7ffff625b780)
    at util/scripting-engines/trace-event-python.c:787
#3  0x000055555590ce3e in python_process_general_event (sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, al=0x7fffffffbdd0)
    at util/scripting-engines/trace-event-python.c:1301
#4  0x000055555590cf94 in python_process_event (event=0x7ffff60b0a48, 
    sample=0x7fffffffbf20, evsel=0x555555d7a700, al=0x7fffffffbdd0)
    at util/scripting-engines/trace-event-python.c:1328
#5  0x000055555577375c in process_sample_event (tool=0x7fffffffcf30, 
    event=0x7ffff60b0a48, sample=0x7fffffffbf20, evsel=0x555555d7a700, 
    machine=0x555555d73168) at builtin-script.c:2072
#6  0x000055555585f3d9 in perf_evlist__deliver_sample (evlist=0x555555d79c60, 
    tool=0x7fffffffcf30, event=0x7ffff60b0a48, sample=0x7fffffffbf20, 
    evsel=0x555555d7a700, machine=0x555555d73168) at util/session.c:1389
#7  0x000055555585f588 in machines__deliver_event (machines=0x555555d73168, 
    evlist=0x555555d79c60, event=0x7ffff60b0a48, sample=0x7fffffffbf20, 
    tool=0x7fffffffcf30, file_offset=3037768) at util/session.c:1426
#8  0x000055555585fa32 in perf_session__deliver_event (session=0x555555d72fe0, 
    event=0x7ffff60b0a48, tool=0x7fffffffcf30, file_offset=3037768)
    at util/session.c:1499
#9  0x000055555585bf5e in ordered_events__deliver_event (oe=0x555555d79b20, 
    event=0x555556446588) at util/session.c:183
#10 0x0000555555864010 in do_flush (oe=0x555555d79b20, show_progress=false)
    at util/ordered-events.c:244
#11 0x000055555586435f in __ordered_events__flush (oe=0x555555d79b20, 
    how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:323
#12 0x0000555555864447 in ordered_events__flush (oe=0x555555d79b20, how=OE_FLUSH__ROUND)
    at util/ordered-events.c:341
#13 0x000055555585e2b1 in process_finished_round (tool=0x7fffffffcf30, 
    event=0x7ffff60ec040, oe=0x555555d79b20) at util/session.c:997
#14 0x000055555585fcea in perf_session__process_user_event (session=0x555555d72fe0, 
    event=0x7ffff60ec040, file_offset=3280960) at util/session.c:1546
#15 0x000055555586055d in perf_session__process_event (session=0x555555d72fe0, 
    event=0x7ffff60ec040, file_offset=3280960) at util/session.c:1706
#16 0x0000555555861973 in process_simple (session=0x555555d72fe0, event=0x7ffff60ec040, 
    file_offset=3280960) at util/session.c:2202
#17 0x0000555555861792 in reader__process_events (rd=0x7fffffffcd70, 
    session=0x555555d72fe0, prog=0x7fffffffcd90) at util/session.c:2168
#18 0x0000555555861a68 in __perf_session__process_events (session=0x555555d72fe0)
    at util/session.c:2225
#19 0x0000555555861b9d in perf_session__process_events (session=0x555555d72fe0)
    at util/session.c:2258
#20 0x0000555555774d02 in __cmd_script (script=0x7fffffffcf30) at builtin-script.c:2557
#21 0x0000555555779988 in cmd_script (argc=0, argv=0x7fffffffebd0)
    at builtin-script.c:3926
#22 0x00005555557f2a93 in run_builtin (p=0x555555bb44d8 <commands+408>, argc=4, 
    argv=0x7fffffffebd0) at perf.c:312
#23 0x00005555557f2d18 in handle_internal_command (argc=4, argv=0x7fffffffebd0)
    at perf.c:364
#24 0x00005555557f2e6b in run_argv (argcp=0x7fffffffea2c, argv=0x7fffffffea20)
    at perf.c:408
#25 0x00005555557f326e in main (argc=4, argv=0x7fffffffebd0) at perf.c:538

This is on today's acme's perf/urgent branch.

Thanks,

Kim
