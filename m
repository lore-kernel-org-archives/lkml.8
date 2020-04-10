Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A88C20757
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDJGsg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:48:36 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:60442 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgDJGsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:48:36 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Fri, 10 Apr 2020 06:46:42 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 Apr 2020 06:45:04 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 10 Apr 2020 06:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSl6GXSrsTCsVngaG2VmPSS0l2IMYBLzEzMyNBjrja1CUCe0V1+9bq47w0FKBO0/Ol/OXTH/IeFu0Ippql0MBxlst98glRjocTPxM9/mVijy5wnLyu6a/7V7NfTVm28pLKNezJGldBnb28Wg7WMyVhLGoI5hF8EovcYUUlzjHNgEtJ1iBg6gaJwIqZgKyr7ThkinCxzfQmlLlcxOwQmWMGIIIh9MkEkyfAcCUWRAf1wkO+qEkeRamfwoRTZFO1CEvZ68sWdt30phewmy0F4AZKueXKlKhAWL9nklY5vOwtRWSGAWJJvebNTt+VZgBQPPvtE63vf2vL+v0iSVUciOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhY5gIvKZUQZ88DhboJuKbECxX+jRVlfQztPlNYZoHA=;
 b=n4kG3JWFxVWhN+V10SC5zZMTf1X6tpw8cK3LzynboldPjtmhL7EZpUPhTGexdGryGsVtEKik7gm3rAtcBAxqOpsR7yojyzRoG2jzvJYBJnnMNr6M3EtGza2saCEWcdeQpN3l4FrzA7AN8LOdKo/MK5FI4KdAJBPVaFYwBKnVRXNsN/+o8HBJRdclD2IEtnSp6m5IrFiPfHtzCE4FQJf+ebr0A/LrFI3o8wxTGpuzJsMbOSLmpbR0banxgkoMcWxNxm1hne5gbSPhzmirjVVg5gJQB6Wn0/MZD8xzh/wtoNlK7YIWgkccJNQIGzS+RqMSynpwy/VsQyMZr+SgsxtGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3220.namprd18.prod.outlook.com (2603:10b6:a03:1a6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 06:45:01 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::e9e9:86a0:9ca7:2d88]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::e9e9:86a0:9ca7:2d88%6]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 06:45:00 +0000
Subject: Re: [LKP] [btrfs] 8d47a0d8f7: fio.write_bw_MBps -28.6% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
CC:     David Sterba <dsterba@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leonard Lausen <leonard@lausen.nl>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@01.org>
References: <20190513031733.GI31424@shao2-debian>
 <d82835ec-c99c-bb40-be9f-f49f8101e921@linux.intel.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <a52f10f7-cdf6-9b00-9e49-b1344c17a190@suse.com>
Date:   Fri, 10 Apr 2020 14:44:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <d82835ec-c99c-bb40-be9f-f49f8101e921@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Fri, 10 Apr 2020 06:44:58 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce4a2ff-66e7-4c7d-0537-08d7dd1ab090
X-MS-TrafficTypeDiagnostic: BY5PR18MB3220:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR18MB3220EB9FBC1B2BC7B3A987D1D6DE0@BY5PR18MB3220.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(30864003)(53546011)(66946007)(66476007)(16526019)(26005)(6666004)(186003)(2616005)(956004)(31686004)(2906002)(66556008)(110136005)(316002)(86362001)(8936002)(16576012)(6706004)(8676002)(31696002)(966005)(54906003)(5660300002)(81156014)(6486002)(478600001)(19627235002)(52116002)(4326008)(36756003)(78286006)(579004)(559001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H750eRC05qSNAD04xq5F88Nq06AbZCsPw19sfp99WF0/padc3gfjFfxsmzXQPwDpmdV3+KmQgrRqLLdo/Ne7PEBJ/vGdTqbPsI58m3om8OYAaoKvOyxnDcw/TJlTj2Yt9uqrlIphdgyBKUVO7k12AbS7eejYswvIChup9C/P+5oGgrQbi4vZxdx7zRk0QeLyhQB16SZ+2e9MeRfbuibhlw8TWB9P9S3m0T9qbqQpfiUVDNSaYxlh1JQhoEMkx/43Jw6RVQ45CZBM8ZTIX7Go70rXlOtc14BdfJKDAOTd/5Y+3hzaE4nzZdzf4I2qXhdN3KcxYmQjYrKVMU3i7Gv+POtgFShep1epkR9JWcptCmLXef26yQf88LylKWO1CzCuIump3HGmGKbGRtIW17zIciTmfd8VqctczF1H0IFGD9SRddOWbuNR6arx3r+/0rEQY68AhpmwRG/wNL/XZDTNC3hMZTLG7m9rrDQHNLgMO9C5TmMGJh1J80JFMnWGih0onkqGgaM+cWAV12yoVusIUepGtSFOMD02veYC6q8bzFkE59xWbUb1mKdkIMTdE+NDSKafVBibE/ZF2UTICLBr3+FtyNdchzWWJHGc+6CFX3c=
X-MS-Exchange-AntiSpam-MessageData: dOFEY6wmnB/7R99GapPRlbyUEoTu0buajVliDfU0b4T6qSvQYOPMd8UBGvBc7STYPBIhFDcyaASkxabrOEuRfS6mBEd5Px0MR4cjWp5p28Wqwi+Xq7l4hSZ9ACJQJjXUMJfGgWktNzq7dwfOPmluVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dce4a2ff-66e7-4c7d-0537-08d7dd1ab090
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 06:45:00.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoBfaC/LQ603UgqZf+dcKRPibA4hv8wp5rRct3mE5mGaAN5TcJ01NfDOEMPBWr/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3220
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/10 下午2:34, Xing Zhengjun wrote:
> Hi Wenruo,
> 
>    We test it in v5.6, the issue still exist, do you have time to take a
> look at this? Thanks.

This is expected.

The extra check brings new overhead mostly equal to another CRC32 run.

We believe it's worthy, as our read time tree checker has exposed quite
some bit flip corruption.

Thanks,
Qu
> 
> On 5/13/2019 11:17 AM, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -28.6% regression of fio.write_bw_MBps due to commit:
>>
>>
>> commit: 8d47a0d8f7947422dd359ac8e462687f81a7a137 ("btrfs: Do mandatory
>> tree block check before submitting bio")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: fio-basic
>> on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
>> with 256G memory
>> with following parameters:
>>
>>     disk: 2pmem
>>     fs: btrfs
>>     runtime: 200s
>>     nr_task: 50%
>>     time_based: tb
>>     rw: randwrite
>>     bs: 4k
>>     ioengine: libaio
>>     test_size: 100G
>>     cpufreq_governor: performance
>>     ucode: 0x3d
>>
>> test-description: Fio is a tool that will spawn a number of threads or
>> processes doing a particular type of I/O action as specified by the user.
>> test-url: https://github.com/axboe/fio
>>
>>
>>
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
>>
>> =========================================================================================
>>
>> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
>>
>>   
>> 4k/gcc-7/performance/2pmem/btrfs/libaio/x86_64-rhel-7.6/50%/debian-x86_64-2018-04-03.cgz/200s/randwrite/lkp-hsw-ep2/100G/fio-basic/tb/0x3d
>>
>>
>> commit:
>>    ff2ac107fa ("btrfs: tree-checker: Remove comprehensive root owner
>> check")
>>    8d47a0d8f7 ("btrfs: Do mandatory tree block check before submitting
>> bio")
>>
>> ff2ac107fae2440b 8d47a0d8f7947422dd359ac8e46
>> ---------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs
>>             |             |             |
>>             :4           25%           1:4    
>> dmesg.BUG:unable_to_handle_kernel
>>             :4           25%           1:4    
>> dmesg.Kernel_panic-not_syncing:Fatal_exception_in_interrupt
>>             :4           25%           1:4     dmesg.Oops:#[##]
>>             :4           25%           1:4    
>> dmesg.RIP:cpuidle_enter_state
>>             :4           25%           1:4     dmesg.RIP:native_write_msr
>>             :4           25%           1:4    
>> dmesg.RIP:perf_prepare_sample
>>            1:4          -25%            :4    
>> dmesg.WARNING:at#for_ip_interrupt_entry/0x
>>           %stddev     %change         %stddev
>>               \          |                \
>>        0.01 ± 21%      +0.3        0.28 ± 20%  fio.latency_1000ms%
>>        4.14 ± 13%      +1.8        5.95 ±  9%  fio.latency_10ms%
>>        8.73 ± 15%      +3.0       11.68 ±  8%  fio.latency_20ms%
>>        1.91 ±  5%      -0.4        1.52 ±  3%  fio.latency_250ms%
>>       66.81            -5.9       60.90 ±  2%  fio.latency_4ms%
>>        0.18 ± 15%      +0.1        0.29 ± 16%  fio.latency_750us%
>>   1.017e+08           -28.5%   72701525       
>> fio.time.file_system_outputs
>>      109.75           -26.8%      80.33 ±  2% 
>> fio.time.percent_of_cpu_this_job_got
>>      197.97           -26.4%     145.79 ±  2%  fio.time.system_time
>>       38.66 ±  4%     -24.0%      29.39 ±  3%  fio.time.user_time
>>    12388015           -28.5%    8858878       
>> fio.time.voluntary_context_switches
>>    12711059           -28.5%    9083954        fio.workload
>>      247.91           -28.6%     176.96        fio.write_bw_MBps
>>      309248 ±  2%     +71.7%     531114 ±  4%  fio.write_clat_99%_us
>>       17574           +40.0%      24609        fio.write_clat_mean_us
>>       57989 ±  4%     +82.2%     105661        fio.write_clat_stddev
>>       63463           -28.6%      45302        fio.write_iops
>>      564.61           +40.2%     791.54        fio.write_slat_mean_us
>>        9375 ±  7%     +96.3%      18406        fio.write_slat_stddev
>>       21.25            +8.5%      23.06 ±  9%  boot-time.dhcp
>>       93.32            +1.4%      94.58        iostat.cpu.idle
>>        6.43           -18.6%       5.23 ±  2%  iostat.cpu.system
>>        6.48            -1.2        5.27 ±  2%  mpstat.cpu.all.sys%
>>        0.24 ±  5%      -0.1        0.18 ±  2%  mpstat.cpu.all.usr%
>>       93.00            +1.1%      94.00        vmstat.cpu.id
>>      591200           -30.0%     413921        vmstat.io.bo
>>    31653776 ±  2%     -10.9%   28196588 ±  2%  vmstat.memory.cache
>>    11927341 ±  7%     +29.8%   15486805 ±  4%  vmstat.memory.free
>>        5.00           -26.7%       3.67 ± 12%  vmstat.procs.r
>>      635910 ±  2%     -27.6%     460384        vmstat.system.cs
>>     7822384 ±  2%     -25.0%    5870498       
>> numa-numastat.node0.local_node
>>     7839861 ±  2%     -24.8%    5893785       
>> numa-numastat.node0.numa_hit
>>      224988 ± 47%     -93.5%      14675 ± 48% 
>> numa-numastat.node0.numa_miss
>>      242465 ± 44%     -84.3%      37964 ± 18% 
>> numa-numastat.node0.other_node
>>     7762623 ± 12%     -26.8%    5681358 ±  6% 
>> numa-numastat.node1.local_node
>>      224988 ± 47%     -93.5%      14675 ± 48% 
>> numa-numastat.node1.numa_foreign
>>     7768618 ± 12%     -26.9%    5681573 ±  6% 
>> numa-numastat.node1.numa_hit
>>   9.429e+08 ± 10%     -35.4%  6.094e+08        cpuidle.C1.time
>>    53504154 ±  6%     -31.8%   36504731        cpuidle.C1.usage
>>   1.093e+09 ± 22%     -50.3%  5.435e+08 ±  3%  cpuidle.C1E.time
>>    16541925 ± 13%     -45.0%    9103775        cpuidle.C1E.usage
>>   5.366e+09 ± 36%     +71.7%  9.214e+09 ± 18%  cpuidle.C3.time
>>    16163664 ± 33%     +57.0%   25379738 ±  5%  cpuidle.C3.usage
>>     9697055 ± 16%     -35.8%    6225168 ± 19%  cpuidle.C6.usage
>>    19313595 ± 17%     -16.3%   16166123        cpuidle.POLL.time
>>    10291838 ±  9%     -26.8%    7537045 ±  7%  meminfo.Active
>>    10034782 ±  9%     -27.4%    7280710 ±  7%  meminfo.Active(file)
>>    31524905 ±  2%     -10.9%   28082249 ±  2%  meminfo.Cached
>>      115157 ±  4%     +61.1%     185560 ±  3%  meminfo.CmaFree
>>     6430720 ±  8%     +19.1%    7660885 ±  6%  meminfo.DirectMap2M
>>      534230 ±  5%     -12.8%     465932 ±  6%  meminfo.Dirty
>>    11737322 ±  7%     +30.2%   15281189 ±  4%  meminfo.MemFree
>>    37604344 ±  2%      -9.4%   34060483        meminfo.Memused
>>      806.50 ± 37%    +137.4%       1914 ±  8%  meminfo.Writeback
>>      370.50 ± 11%     +36.8%     507.00       
>> slabinfo.bdev_cache.active_objs
>>      370.50 ± 11%     +36.8%     507.00       
>> slabinfo.bdev_cache.num_objs
>>       15147 ±  5%      -8.3%      13897 ±  2% 
>> slabinfo.blkdev_ioc.active_objs
>>       17839 ±  6%     -11.7%      15745 ±  2% 
>> slabinfo.blkdev_ioc.num_objs
>>       12178 ±  4%      -7.4%      11275 ±  2% 
>> slabinfo.kmalloc-512.num_objs
>>        7794 ±  3%     +25.4%       9774       
>> slabinfo.proc_inode_cache.active_objs
>>        8017 ±  2%     +23.4%       9895       
>> slabinfo.proc_inode_cache.num_objs
>>        2366 ± 23%     -32.6%       1595 ±  5% 
>> slabinfo.task_group.active_objs
>>        2366 ± 23%     -32.6%       1595 ±  5% 
>> slabinfo.task_group.num_objs
>>      263.75 ±  2%     -15.1%     224.00 ±  2%  turbostat.Avg_MHz
>>        9.46 ±  2%      -1.4        8.07 ±  2%  turbostat.Busy%
>>    53502248 ±  6%     -31.8%   36503898        turbostat.C1
>>        5.86 ±  8%      -2.0        3.82        turbostat.C1%
>>    16540396 ± 13%     -45.0%    9102733        turbostat.C1E
>>        6.80 ± 22%      -3.4        3.40 ±  4%  turbostat.C1E%
>>    16163332 ± 33%     +57.0%   25379351 ±  5%  turbostat.C3
>>       33.55 ± 36%     +24.1       57.61 ± 18%  turbostat.C3%
>>     9689445 ± 16%     -35.8%    6221033 ± 19%  turbostat.C6
>>       18.04 ± 26%     +49.1%      26.90 ±  9%  turbostat.CPU%c3
>>       53.25 ±  3%     +10.8%      59.00 ±  4%  turbostat.CoreTmp
>>        4.67 ± 14%     +62.7%       7.59 ± 26%  turbostat.Pkg%pc2
>>       56.50            +9.7%      62.00 ±  2%  turbostat.PkgTmp
>>       11.84            -4.8%      11.28        turbostat.RAMWatt
>>     7232478 ± 10%     -37.2%    4543037 ± 22%  numa-meminfo.node0.Active
>>     7072564 ± 10%     -37.6%    4410135 ± 23% 
>> numa-meminfo.node0.Active(file)
>>      308167 ±  6%     -24.7%     232152 ± 10%  numa-meminfo.node0.Dirty
>>     8784028 ± 13%     +21.7%   10686327 ±  2% 
>> numa-meminfo.node0.Inactive
>>     8669548 ± 12%     +20.7%   10465444 ±  2% 
>> numa-meminfo.node0.Inactive(file)
>>      572.50 ± 22%    +115.9%       1236 ± 25% 
>> numa-meminfo.node0.Writeback
>>    15098140 ±  3%     -17.7%   12425670 ±  3% 
>> numa-meminfo.node1.FilePages
>>    11599549 ±  7%     -22.3%    9018051 ±  4% 
>> numa-meminfo.node1.Inactive
>>      105067 ± 92%     -99.3%     725.33 ± 51% 
>> numa-meminfo.node1.Inactive(anon)
>>    11494482 ±  7%     -21.6%    9017325 ±  4% 
>> numa-meminfo.node1.Inactive(file)
>>        5504 ±  9%     -12.5%       4819 ±  2% 
>> numa-meminfo.node1.KernelStack
>>     6709938 ± 11%     +45.8%    9781880 ±  5%  numa-meminfo.node1.MemFree
>>    18029136 ±  4%     -17.0%   14957200 ±  3%  numa-meminfo.node1.MemUsed
>>        4427 ± 69%     -77.5%     996.00 ±  8% 
>> numa-meminfo.node1.PageTables
>>      857660 ± 32%     -37.2%     538646 ±  8% 
>> numa-meminfo.node1.SUnreclaim
>>      109232 ± 88%     -96.1%       4274 ± 10%  numa-meminfo.node1.Shmem
>>      986740 ± 35%     -40.0%     592452 ± 10%  numa-meminfo.node1.Slab
>>      575.21 ± 15%     +30.1%     748.58 ±  2% 
>> sched_debug.cfs_rq:/.runnable_load_avg.max
>>      100.45 ± 15%     +28.6%     129.19 ±  5% 
>> sched_debug.cfs_rq:/.runnable_load_avg.stddev
>>      830.19 ±  9%     +15.7%     960.25 ±  6% 
>> sched_debug.cfs_rq:/.util_avg.max
>>       29.97 ± 16%     -25.2%      22.43 ± 31% 
>> sched_debug.cfs_rq:/.util_est_enqueued.avg
>>      591.17 ± 13%     -22.2%     459.83 ± 18% 
>> sched_debug.cfs_rq:/.util_est_enqueued.max
>>      107.52 ± 13%     -23.0%      82.84 ± 23% 
>> sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>        2.06 ±  5%      -9.3%       1.87       
>> sched_debug.cpu.clock.stddev
>>        2.06 ±  5%      -9.3%       1.87       
>> sched_debug.cpu.clock_task.stddev
>>       24.51 ±  7%     +21.5%      29.77 ±  8% 
>> sched_debug.cpu.cpu_load[0].avg
>>      541.29 ± 15%     +38.3%     748.58 ±  2% 
>> sched_debug.cpu.cpu_load[0].max
>>       93.97 ±  7%     +27.8%     120.09 ±  2% 
>> sched_debug.cpu.cpu_load[0].stddev
>>      519.08 ±  6%     +40.5%     729.42 ±  4% 
>> sched_debug.cpu.cpu_load[1].max
>>       87.45 ±  5%     +28.5%     112.39 ±  4% 
>> sched_debug.cpu.cpu_load[1].stddev
>>      480.83 ±  7%     +39.5%     670.92 ± 13% 
>> sched_debug.cpu.cpu_load[2].max
>>       80.92 ±  5%     +25.7%     101.75 ±  8% 
>> sched_debug.cpu.cpu_load[2].stddev
>>      408.83 ±  4%     +54.0%     629.58 ± 19% 
>> sched_debug.cpu.cpu_load[3].max
>>       71.62 ±  2%     +30.7%      93.61 ± 11% 
>> sched_debug.cpu.cpu_load[3].stddev
>>      381.50 ±  8%     +66.7%     636.00 ± 18% 
>> sched_debug.cpu.cpu_load[4].max
>>       64.40 ±  6%     +39.7%      89.96 ± 12% 
>> sched_debug.cpu.cpu_load[4].stddev
>>      106.75 ± 20%     -88.4%      12.33 ± 10% 
>> proc-vmstat.kswapd_high_wmark_hit_quickly
>>     2508660 ±  9%     -27.5%    1819662 ±  7%  proc-vmstat.nr_active_file
>>    33315360           -30.4%   23192301        proc-vmstat.nr_dirtied
>>      133447 ±  5%     -12.6%     116580 ±  6%  proc-vmstat.nr_dirty
>>     7881043 ±  2%     -10.9%    7019533 ±  2%  proc-vmstat.nr_file_pages
>>       28790 ±  4%     +61.1%      46392 ±  3%  proc-vmstat.nr_free_cma
>>     2934503 ±  7%     +30.2%    3821369 ±  4%  proc-vmstat.nr_free_pages
>>     5044168            -3.4%    4872965       
>> proc-vmstat.nr_inactive_file
>>      430282            -6.0%     404589       
>> proc-vmstat.nr_slab_unreclaimable
>>      197.75 ± 38%    +136.5%     467.67 ± 10%  proc-vmstat.nr_writeback
>>    33243480           -30.4%   23143756        proc-vmstat.nr_written
>>     2508665 ±  9%     -27.5%    1819662 ±  7% 
>> proc-vmstat.nr_zone_active_file
>>     5044399            -3.4%    4873026       
>> proc-vmstat.nr_zone_inactive_file
>>      134972 ±  5%     -12.4%     118262 ±  5% 
>> proc-vmstat.nr_zone_write_pending
>>    15632301 ±  5%     -25.8%   11598535 ±  3%  proc-vmstat.numa_hit
>>    15608826 ±  5%     -25.8%   11575029 ±  3%  proc-vmstat.numa_local
>>     2300530 ± 10%     -31.1%    1585363 ± 10%  proc-vmstat.pgactivate
>>    16955745           -26.3%   12499611 ±  2%  proc-vmstat.pgalloc_normal
>>    17488000           -25.9%   12959812 ±  2%  proc-vmstat.pgfree
>>    1.33e+08           -30.4%   92575440        proc-vmstat.pgpgout
>>     5728177 ±  6%     -78.5%    1232433 ± 25%  proc-vmstat.pgscan_kswapd
>>     5727967 ±  6%     -78.5%    1232244 ± 25%  proc-vmstat.pgsteal_kswapd
>>       32760            -7.6%      30285        proc-vmstat.slabs_scanned
>>     1768211 ± 10%     -37.7%    1102275 ± 23% 
>> numa-vmstat.node0.nr_active_file
>>    10410188 ±  7%     -32.5%    7023939 ±  7% 
>> numa-vmstat.node0.nr_dirtied
>>       76995 ±  6%     -24.6%      58035 ± 10%  numa-vmstat.node0.nr_dirty
>>     2167457 ± 12%     +20.7%    2616147 ±  2% 
>> numa-vmstat.node0.nr_inactive_file
>>      142.00 ± 24%    +120.4%     313.00 ± 24% 
>> numa-vmstat.node0.nr_writeback
>>    10308758 ±  7%     -32.6%    6949497 ±  7% 
>> numa-vmstat.node0.nr_written
>>     1768216 ± 10%     -37.7%    1102275 ± 23% 
>> numa-vmstat.node0.nr_zone_active_file
>>     2167563 ± 12%     +20.7%    2616189 ±  2% 
>> numa-vmstat.node0.nr_zone_inactive_file
>>       77786 ±  7%     -24.3%      58899 ± 10% 
>> numa-vmstat.node0.nr_zone_write_pending
>>     5889240 ±  3%     -14.3%    5046874 ±  3%  numa-vmstat.node0.numa_hit
>>     5837851 ±  4%     -14.0%    5023120 ±  3% 
>> numa-vmstat.node0.numa_local
>>       68376 ± 48%     -96.9%       2149 ± 46% 
>> numa-vmstat.node0.numa_miss
>>      119766 ± 42%     -78.4%      25904 ±  3% 
>> numa-vmstat.node0.numa_other
>>       30.50 ± 38%    -100.0%       0.00       
>> numa-vmstat.node0.workingset_nodes
>>     6829126 ±  6%     -22.8%    5269898 ± 10% 
>> numa-vmstat.node1.nr_dirtied
>>     3774645 ±  3%     -17.7%    3106081 ±  3% 
>> numa-vmstat.node1.nr_file_pages
>>       28796 ±  4%     +61.1%      46405 ±  3% 
>> numa-vmstat.node1.nr_free_cma
>>     1677332 ± 11%     +45.8%    2445778 ±  5% 
>> numa-vmstat.node1.nr_free_pages
>>       26266 ± 92%     -99.3%     180.67 ± 51% 
>> numa-vmstat.node1.nr_inactive_anon
>>     2873702 ±  7%     -21.6%    2254116 ±  4% 
>> numa-vmstat.node1.nr_inactive_file
>>        5506 ±  9%     -12.5%       4820 ±  2% 
>> numa-vmstat.node1.nr_kernel_stack
>>       29031 ± 85%     -88.2%       3436       
>> numa-vmstat.node1.nr_mapped
>>        1106 ± 69%     -77.5%     249.00 ±  8% 
>> numa-vmstat.node1.nr_page_table_pages
>>       27308 ± 88%     -96.1%       1068 ± 10%  numa-vmstat.node1.nr_shmem
>>      214418 ± 32%     -37.2%     134663 ±  8% 
>> numa-vmstat.node1.nr_slab_unreclaimable
>>       75.00 ± 35%    +145.3%     184.00 ± 18% 
>> numa-vmstat.node1.nr_writeback
>>     6761224 ±  6%     -23.1%    5202586 ± 10% 
>> numa-vmstat.node1.nr_written
>>       26266 ± 92%     -99.3%     180.67 ± 51% 
>> numa-vmstat.node1.nr_zone_inactive_anon
>>     2873810 ±  7%     -21.6%    2254135 ±  4% 
>> numa-vmstat.node1.nr_zone_inactive_file
>>       68381 ± 48%     -96.9%       2152 ± 46% 
>> numa-vmstat.node1.numa_foreign
>>     5035283 ± 15%     -26.9%    3679318 ±  7%  numa-vmstat.node1.numa_hit
>>     4905249 ± 15%     -28.2%    3522229 ±  8% 
>> numa-vmstat.node1.numa_local
>>       18.43 ±  6%     -28.3%      13.21 ±  3%  perf-stat.i.MPKI
>>   2.205e+09 ±  3%     +10.5%  2.437e+09       
>> perf-stat.i.branch-instructions
>>        1.83 ±  5%      -0.6        1.24 ±  7% 
>> perf-stat.i.branch-miss-rate%
>>    37019551 ±  3%     -29.4%   26140844 ±  5%  perf-stat.i.branch-misses
>>    28932020 ±  6%     -31.1%   19933819 ±  3%  perf-stat.i.cache-misses
>>    2.03e+08 ±  4%     -24.8%  1.526e+08       
>> perf-stat.i.cache-references
>>      645248 ±  2%     -27.4%     468301       
>> perf-stat.i.context-switches
>>        1.97 ±  7%     -22.1%       1.53 ±  2%  perf-stat.i.cpi
>>   1.983e+10 ±  3%     -15.1%  1.684e+10        perf-stat.i.cpu-cycles
>>        1.03 ±  5%      -0.4        0.64 ± 10% 
>> perf-stat.i.dTLB-load-miss-rate%
>>    31879502 ±  6%     -37.9%   19807598 ±  9% 
>> perf-stat.i.dTLB-load-misses
>>   3.201e+09 ±  3%     +18.8%  3.804e+09        perf-stat.i.dTLB-loads
>>        0.13 ±  7%      -0.0        0.09 ± 10% 
>> perf-stat.i.dTLB-store-miss-rate%
>>     2516181 ± 10%     -28.3%    1805272 ± 10% 
>> perf-stat.i.dTLB-store-misses
>>   2.143e+09 ±  3%     +19.8%  2.568e+09 ±  2%  perf-stat.i.dTLB-stores
>>    13781489 ±  3%     -28.4%    9866239 ±  3%  perf-stat.i.iTLB-loads
>>   1.164e+10 ±  3%     +21.6%  1.415e+10        perf-stat.i.instructions
>>        8435 ± 17%     +42.5%      12023 ± 14% 
>> perf-stat.i.instructions-per-iTLB-miss
>>        0.57 ±  3%     +43.6%       0.82        perf-stat.i.ipc
>>    16050361 ±  9%     -30.7%   11127721 ±  3% 
>> perf-stat.i.node-load-misses
>>     8120610 ±  9%     -31.3%    5580996        perf-stat.i.node-loads
>>     2591649 ± 13%     -31.1%    1785932 ±  6% 
>> perf-stat.i.node-store-misses
>>     1809775 ± 12%     -31.2%    1244360 ±  2%  perf-stat.i.node-stores
>>       17.45 ±  4%     -38.2%      10.79        perf-stat.overall.MPKI
>>        1.68 ±  3%      -0.6        1.07 ±  5% 
>> perf-stat.overall.branch-miss-rate%
>>        1.70 ±  3%     -30.2%       1.19        perf-stat.overall.cpi
>>      689.69 ±  9%     +22.6%     845.48 ±  2% 
>> perf-stat.overall.cycles-between-cache-misses
>>        0.99 ±  5%      -0.5        0.52 ± 10% 
>> perf-stat.overall.dTLB-load-miss-rate%
>>        0.12 ±  8%      -0.0        0.07 ± 10% 
>> perf-stat.overall.dTLB-store-miss-rate%
>>       10.81 ± 14%      +2.3       13.09 ± 10% 
>> perf-stat.overall.iTLB-load-miss-rate%
>>        7119 ± 14%     +35.9%       9679 ± 13% 
>> perf-stat.overall.instructions-per-iTLB-miss
>>        0.59 ±  3%     +43.1%       0.84        perf-stat.overall.ipc
>>      202912 ±  2%     +68.8%     342615 ±  3% 
>> perf-stat.overall.path-length
>>   2.195e+09 ±  3%     +10.5%  2.425e+09       
>> perf-stat.ps.branch-instructions
>>    36847010 ±  3%     -29.4%   26015686 ±  5%  perf-stat.ps.branch-misses
>>    28799092 ±  6%     -31.1%   19837306 ±  3%  perf-stat.ps.cache-misses
>>   2.021e+08 ±  4%     -24.8%  1.519e+08       
>> perf-stat.ps.cache-references
>>      642266 ±  2%     -27.4%     465968       
>> perf-stat.ps.context-switches
>>   1.974e+10 ±  3%     -15.1%  1.676e+10        perf-stat.ps.cpu-cycles
>>    31729472 ±  6%     -37.9%   19715594 ±  9% 
>> perf-stat.ps.dTLB-load-misses
>>   3.186e+09 ±  3%     +18.8%  3.785e+09        perf-stat.ps.dTLB-loads
>>     2504443 ± 10%     -28.2%    1797154 ± 10% 
>> perf-stat.ps.dTLB-store-misses
>>   2.133e+09 ±  3%     +19.8%  2.556e+09 ±  2%  perf-stat.ps.dTLB-stores
>>    13717699 ±  3%     -28.4%    9816979 ±  3%  perf-stat.ps.iTLB-loads
>>   1.159e+10 ±  3%     +21.5%  1.408e+10        perf-stat.ps.instructions
>>    15979371 ±  9%     -30.7%   11073468 ±  3% 
>> perf-stat.ps.node-load-misses
>>     8081205 ±  9%     -31.3%    5554114        perf-stat.ps.node-loads
>>     2580198 ± 13%     -31.1%    1777169 ±  6% 
>> perf-stat.ps.node-store-misses
>>     1801590 ± 12%     -31.3%    1238321 ±  2%  perf-stat.ps.node-stores
>>   2.579e+12           +20.6%  3.111e+12 ±  2% 
>> perf-stat.total.instructions
>>       36149 ±  4%     -26.2%      26686 ±  5%  softirqs.CPU0.RCU
>>       37255 ±  3%     -26.8%      27256 ±  2%  softirqs.CPU1.RCU
>>       37834 ±  5%     -26.5%      27801 ±  9%  softirqs.CPU10.RCU
>>       39075 ±  3%     -24.5%      29494 ±  2%  softirqs.CPU11.RCU
>>       38137 ±  6%     -23.1%      29340 ±  4%  softirqs.CPU12.RCU
>>       37480 ±  3%     -20.5%      29797 ±  2%  softirqs.CPU13.RCU
>>       37690 ±  5%     -28.7%      26861 ±  4%  softirqs.CPU14.RCU
>>       33863 ±  9%     -29.5%      23885 ±  5%  softirqs.CPU15.RCU
>>       34306 ±  9%     -31.1%      23641 ± 12%  softirqs.CPU16.RCU
>>       34374 ±  9%     -29.0%      24402 ±  7%  softirqs.CPU17.RCU
>>       44013 ±  9%     -31.7%      30059        softirqs.CPU18.RCU
>>       43114 ±  8%     -29.9%      30219        softirqs.CPU19.RCU
>>       36276 ±  8%     -23.3%      27825 ±  5%  softirqs.CPU2.RCU
>>       67049 ±  7%     +39.1%      93267 ± 18%  softirqs.CPU2.TIMER
>>       39721 ± 13%     -31.4%      27233 ±  3%  softirqs.CPU20.RCU
>>       42340 ±  5%     -28.6%      30215 ±  6%  softirqs.CPU21.RCU
>>       40896 ±  7%     -30.3%      28506 ±  2%  softirqs.CPU22.RCU
>>       42422 ±  7%     -33.2%      28357 ±  2%  softirqs.CPU23.RCU
>>       42330 ±  9%     -33.5%      28150 ±  5%  softirqs.CPU24.RCU
>>       41406 ±  9%     -31.4%      28398        softirqs.CPU25.RCU
>>       39754 ±  5%     -29.4%      28063        softirqs.CPU26.RCU
>>       40207 ±  6%     -27.9%      28995 ± 12%  softirqs.CPU27.RCU
>>       40351 ±  9%     -29.4%      28487 ±  3%  softirqs.CPU28.RCU
>>       41880 ±  5%     -29.6%      29472        softirqs.CPU29.RCU
>>       36293 ±  4%     -17.7%      29864 ±  7%  softirqs.CPU3.RCU
>>       39341 ±  9%     -34.3%      25847        softirqs.CPU30.RCU
>>       39687 ±  9%     -33.5%      26400 ±  2%  softirqs.CPU31.RCU
>>       38062 ± 14%     -39.9%      22878 ± 10%  softirqs.CPU32.RCU
>>       39769 ± 13%     -33.8%      26314 ±  5%  softirqs.CPU33.RCU
>>       39504 ± 10%     -37.2%      24824 ±  6%  softirqs.CPU34.RCU
>>       39591 ± 11%     -38.6%      24300 ±  5%  softirqs.CPU35.RCU
>>       40398 ±  8%     -27.0%      29488 ± 12%  softirqs.CPU36.RCU
>>       39464 ± 12%     -25.3%      29478 ± 10%  softirqs.CPU37.RCU
>>       41177 ±  9%     -34.0%      27190 ± 19%  softirqs.CPU38.RCU
>>       38734 ± 13%     -24.8%      29145 ±  5%  softirqs.CPU39.RCU
>>       36804 ±  5%     -23.0%      28354        softirqs.CPU4.RCU
>>       40421 ± 12%     -28.8%      28776 ±  6%  softirqs.CPU40.RCU
>>       40371 ± 11%     -31.1%      27834 ±  8%  softirqs.CPU41.RCU
>>       40633 ± 10%     -29.9%      28469 ± 10%  softirqs.CPU42.RCU
>>       41018 ±  9%     -33.6%      27252 ±  6%  softirqs.CPU43.RCU
>>       38181 ± 12%     -27.0%      27856 ± 10%  softirqs.CPU44.RCU
>>       39605 ± 12%     -32.3%      26803 ± 12%  softirqs.CPU45.RCU
>>       42686 ± 11%     -29.7%      30016 ±  9%  softirqs.CPU47.RCU
>>       40433 ±  9%     -31.8%      27586 ± 11%  softirqs.CPU48.RCU
>>       38371 ± 12%     -23.0%      29528 ±  7%  softirqs.CPU49.RCU
>>       37172 ±  2%     -25.9%      27562 ±  3%  softirqs.CPU5.RCU
>>       39660 ± 12%     -27.5%      28752 ± 11%  softirqs.CPU50.RCU
>>       40375 ± 10%     -26.7%      29582 ±  3%  softirqs.CPU51.RCU
>>       40568 ±  9%     -28.8%      28886 ±  6%  softirqs.CPU52.RCU
>>       39967 ± 10%     -27.3%      29073 ± 11%  softirqs.CPU53.RCU
>>       40874 ± 11%     -37.1%      25725 ±  6%  softirqs.CPU54.RCU
>>       41227 ± 14%     -37.9%      25606 ±  6%  softirqs.CPU55.RCU
>>       38856 ± 13%     -34.7%      25380 ±  8%  softirqs.CPU56.RCU
>>       39618 ± 13%     -39.1%      24119 ±  4%  softirqs.CPU57.RCU
>>       39412 ± 12%     -36.6%      24970 ±  3%  softirqs.CPU58.RCU
>>       41572 ± 14%     -41.3%      24399 ± 10%  softirqs.CPU59.RCU
>>       36927 ±  3%     -24.4%      27923 ± 22%  softirqs.CPU6.RCU
>>       37057 ± 10%     -31.8%      25261 ±  2%  softirqs.CPU60.RCU
>>       36584 ±  8%     -27.8%      26419 ±  2%  softirqs.CPU61.RCU
>>       35859 ±  4%     -28.2%      25729 ±  5%  softirqs.CPU62.RCU
>>       35849 ±  7%     -33.2%      23933 ±  5%  softirqs.CPU63.RCU
>>       35379 ±  6%     -26.4%      26041 ±  4%  softirqs.CPU64.RCU
>>       36908 ±  6%     -26.5%      27110 ±  2%  softirqs.CPU65.RCU
>>       37595 ±  3%     -26.1%      27783 ±  4%  softirqs.CPU66.RCU
>>       36327 ±  2%     -27.0%      26533 ±  2%  softirqs.CPU67.RCU
>>       35136 ±  7%     -31.7%      23998 ±  9%  softirqs.CPU68.RCU
>>       35638 ±  4%     -28.6%      25435 ±  4%  softirqs.CPU69.RCU
>>       37268 ±  6%     -25.4%      27786 ±  4%  softirqs.CPU7.RCU
>>       36693 ±  4%     -29.2%      25986 ±  5%  softirqs.CPU70.RCU
>>       36859 ±  3%     -28.8%      26260 ±  4%  softirqs.CPU71.RCU
>>       37539 ±  7%     -27.7%      27144 ±  4%  softirqs.CPU8.RCU
>>       37584 ±  4%     -26.0%      27802 ± 15%  softirqs.CPU9.RCU
>>     2795313 ±  7%     -29.7%    1964363 ±  4%  softirqs.RCU
>>      249.50 ± 76%     -50.4%     123.67 ±  2% 
>> interrupts.41:PCI-MSI.1572870-edge.eth0-TxRx-6
>>      154.50 ± 13%     -10.9%     137.67 ± 10% 
>> interrupts.42:PCI-MSI.1572871-edge.eth0-TxRx-7
>>      150.50 ± 43%     -28.0%     108.33       
>> interrupts.84:PCI-MSI.1572913-edge.eth0-TxRx-49
>>       10393 ± 10%     -26.4%       7653 ± 10% 
>> interrupts.CPU1.RES:Rescheduling_interrupts
>>       12518 ± 15%     -31.0%       8642 ± 21% 
>> interrupts.CPU10.RES:Rescheduling_interrupts
>>      945.25 ± 79%     -75.4%     232.67 ±141% 
>> interrupts.CPU11.NMI:Non-maskable_interrupts
>>      945.25 ± 79%     -75.4%     232.67 ±141% 
>> interrupts.CPU11.PMI:Performance_monitoring_interrupts
>>       13068 ± 18%     -30.6%       9075 ± 23% 
>> interrupts.CPU11.RES:Rescheduling_interrupts
>>       11949 ± 11%     -49.8%       6001 ± 29% 
>> interrupts.CPU12.RES:Rescheduling_interrupts
>>       13711 ±  8%     -19.4%      11052 ± 24% 
>> interrupts.CPU13.RES:Rescheduling_interrupts
>>       13361 ±  6%     -38.8%       8170 ± 25% 
>> interrupts.CPU14.RES:Rescheduling_interrupts
>>        7628 ± 12%     -29.2%       5401 ±  7% 
>> interrupts.CPU18.RES:Rescheduling_interrupts
>>        7909 ± 25%     -30.4%       5501 ± 37% 
>> interrupts.CPU19.RES:Rescheduling_interrupts
>>        1482 ± 39%    -100.0%       0.00       
>> interrupts.CPU2.NMI:Non-maskable_interrupts
>>        1482 ± 39%    -100.0%       0.00       
>> interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>        2116           +23.2%       2606 ± 10% 
>> interrupts.CPU20.CAL:Function_call_interrupts
>>      194.75 ±173%    +380.1%     935.00 ± 30% 
>> interrupts.CPU20.NMI:Non-maskable_interrupts
>>      194.75 ±173%    +380.1%     935.00 ± 30% 
>> interrupts.CPU20.PMI:Performance_monitoring_interrupts
>>        2096 ±  4%     +18.0%       2474 ±  9% 
>> interrupts.CPU21.CAL:Function_call_interrupts
>>       11313 ± 20%     -56.4%       4935 ± 23% 
>> interrupts.CPU21.RES:Rescheduling_interrupts
>>        2111 ±  3%     +20.1%       2534 ± 11% 
>> interrupts.CPU22.CAL:Function_call_interrupts
>>        2109 ±  4%     +22.6%       2585 ± 10% 
>> interrupts.CPU23.CAL:Function_call_interrupts
>>       10305 ± 16%     -40.7%       6115 ± 17% 
>> interrupts.CPU23.RES:Rescheduling_interrupts
>>        2128 ±  2%     +17.8%       2507 ± 10% 
>> interrupts.CPU24.CAL:Function_call_interrupts
>>       12271 ± 20%     -39.0%       7488 ± 29% 
>> interrupts.CPU24.RES:Rescheduling_interrupts
>>        2123           +19.7%       2541 ±  7% 
>> interrupts.CPU25.CAL:Function_call_interrupts
>>        9780 ± 21%     -32.9%       6563 ± 25% 
>> interrupts.CPU25.RES:Rescheduling_interrupts
>>      980.75 ± 89%     -88.9%     109.00 ±141% 
>> interrupts.CPU26.NMI:Non-maskable_interrupts
>>      980.75 ± 89%     -88.9%     109.00 ±141% 
>> interrupts.CPU26.PMI:Performance_monitoring_interrupts
>>       11163 ± 28%     -49.8%       5605 ± 13% 
>> interrupts.CPU27.RES:Rescheduling_interrupts
>>       11071 ± 12%     -56.3%       4835 ± 26% 
>> interrupts.CPU29.RES:Rescheduling_interrupts
>>      728.50 ± 66%    -100.0%       0.00       
>> interrupts.CPU3.NMI:Non-maskable_interrupts
>>      728.50 ± 66%    -100.0%       0.00       
>> interrupts.CPU3.PMI:Performance_monitoring_interrupts
>>       10599 ± 10%     -38.7%       6501 ± 16% 
>> interrupts.CPU31.RES:Rescheduling_interrupts
>>        2213 ±  4%     +14.2%       2527 ±  7% 
>> interrupts.CPU32.CAL:Function_call_interrupts
>>        8862 ± 16%     -39.6%       5354 ± 28% 
>> interrupts.CPU32.RES:Rescheduling_interrupts
>>        2156 ±  6%     +20.5%       2599 ±  9% 
>> interrupts.CPU33.CAL:Function_call_interrupts
>>        2169 ±  5%     +19.9%       2601 ±  9% 
>> interrupts.CPU34.CAL:Function_call_interrupts
>>       10483 ± 18%     -48.8%       5371 ± 33% 
>> interrupts.CPU34.RES:Rescheduling_interrupts
>>        2049           +24.4%       2549 ±  8% 
>> interrupts.CPU35.CAL:Function_call_interrupts
>>       10929 ± 15%     -49.0%       5578 ± 14% 
>> interrupts.CPU35.RES:Rescheduling_interrupts
>>        1993 ±  4%     +28.5%       2561 ± 12% 
>> interrupts.CPU36.CAL:Function_call_interrupts
>>      161.75 ±161%    +717.9%       1323 ± 43% 
>> interrupts.CPU36.NMI:Non-maskable_interrupts
>>      161.75 ±161%    +717.9%       1323 ± 43% 
>> interrupts.CPU36.PMI:Performance_monitoring_interrupts
>>        1987 ±  4%     +30.5%       2594 ± 13% 
>> interrupts.CPU37.CAL:Function_call_interrupts
>>        1863 ± 10%     +35.7%       2529 ± 14% 
>> interrupts.CPU38.CAL:Function_call_interrupts
>>        1984 ±  6%     +26.5%       2509 ± 12% 
>> interrupts.CPU41.CAL:Function_call_interrupts
>>       12830 ± 30%     -26.4%       9445 ±  9% 
>> interrupts.CPU43.RES:Rescheduling_interrupts
>>        2067 ±  2%     +27.4%       2632 ±  9% 
>> interrupts.CPU44.CAL:Function_call_interrupts
>>        2066 ±  3%     +27.2%       2629 ±  9% 
>> interrupts.CPU45.CAL:Function_call_interrupts
>>        2158 ±  3%     +19.6%       2582 ±  9% 
>> interrupts.CPU46.CAL:Function_call_interrupts
>>        2036 ±  6%     +30.3%       2652 ± 10% 
>> interrupts.CPU47.CAL:Function_call_interrupts
>>      150.50 ± 43%     -28.0%     108.33       
>> interrupts.CPU49.84:PCI-MSI.1572913-edge.eth0-TxRx-49
>>       11823 ± 12%     -36.9%       7460 ± 18% 
>> interrupts.CPU49.RES:Rescheduling_interrupts
>>        1139 ± 58%     -75.5%     278.67 ±141% 
>> interrupts.CPU5.NMI:Non-maskable_interrupts
>>        1139 ± 58%     -75.5%     278.67 ±141% 
>> interrupts.CPU5.PMI:Performance_monitoring_interrupts
>>       11748 ± 22%     -40.0%       7048 ± 27% 
>> interrupts.CPU5.RES:Rescheduling_interrupts
>>        2102 ±  5%     +19.6%       2515 ±  7% 
>> interrupts.CPU52.CAL:Function_call_interrupts
>>        2115 ±  6%     +19.5%       2527 ±  7% 
>> interrupts.CPU53.CAL:Function_call_interrupts
>>       11318 ± 17%     -20.4%       9004 ± 26% 
>> interrupts.CPU53.RES:Rescheduling_interrupts
>>        2177 ±  5%     +17.4%       2556 ±  9% 
>> interrupts.CPU54.CAL:Function_call_interrupts
>>       10968 ± 23%     -62.3%       4134 ± 21% 
>> interrupts.CPU54.RES:Rescheduling_interrupts
>>        2161 ±  5%     +20.2%       2598 ±  9% 
>> interrupts.CPU55.CAL:Function_call_interrupts
>>        9334 ± 19%     -55.4%       4158 ± 34% 
>> interrupts.CPU55.RES:Rescheduling_interrupts
>>        1443 ± 22%    -100.0%       0.00       
>> interrupts.CPU56.NMI:Non-maskable_interrupts
>>        1443 ± 22%    -100.0%       0.00       
>> interrupts.CPU56.PMI:Performance_monitoring_interrupts
>>       11377 ± 31%     -56.9%       4907 ± 43% 
>> interrupts.CPU56.RES:Rescheduling_interrupts
>>      601.00 ± 99%     -79.6%     122.67 ±141% 
>> interrupts.CPU57.NMI:Non-maskable_interrupts
>>      601.00 ± 99%     -79.6%     122.67 ±141% 
>> interrupts.CPU57.PMI:Performance_monitoring_interrupts
>>        8295 ± 31%     -47.7%       4340 ± 24% 
>> interrupts.CPU57.RES:Rescheduling_interrupts
>>        9182 ± 37%     -59.7%       3701 ± 46% 
>> interrupts.CPU58.RES:Rescheduling_interrupts
>>      249.50 ± 76%     -50.4%     123.67 ±  2% 
>> interrupts.CPU6.41:PCI-MSI.1572870-edge.eth0-TxRx-6
>>       12473 ± 27%     -44.4%       6940 ± 13% 
>> interrupts.CPU6.RES:Rescheduling_interrupts
>>        7886 ± 12%     -42.2%       4555 ± 31% 
>> interrupts.CPU60.RES:Rescheduling_interrupts
>>      971.50 ± 47%     -86.8%     128.33 ±141% 
>> interrupts.CPU61.NMI:Non-maskable_interrupts
>>      971.50 ± 47%     -86.8%     128.33 ±141% 
>> interrupts.CPU61.PMI:Performance_monitoring_interrupts
>>        9253 ± 26%     -56.4%       4033 ± 16% 
>> interrupts.CPU61.RES:Rescheduling_interrupts
>>        2103 ±  5%     +19.1%       2505 ± 11% 
>> interrupts.CPU63.CAL:Function_call_interrupts
>>        2059 ±  2%     +20.6%       2483 ± 10% 
>> interrupts.CPU64.CAL:Function_call_interrupts
>>        8545 ± 17%     -41.2%       5025 ±  8% 
>> interrupts.CPU65.RES:Rescheduling_interrupts
>>        7378 ± 23%     -51.0%       3614 ± 30% 
>> interrupts.CPU68.RES:Rescheduling_interrupts
>>        8573 ± 28%     -50.1%       4277 ±  6% 
>> interrupts.CPU69.RES:Rescheduling_interrupts
>>      154.50 ± 13%     -10.9%     137.67 ± 10% 
>> interrupts.CPU7.42:PCI-MSI.1572871-edge.eth0-TxRx-7
>>        9910 ± 28%     -51.2%       4839 ± 40% 
>> interrupts.CPU70.RES:Rescheduling_interrupts
>>        8836 ± 26%     -52.7%       4180 ±  6% 
>> interrupts.CPU71.RES:Rescheduling_interrupts
>>      911.50 ± 37%     -93.2%      61.67 ±141% 
>> interrupts.CPU8.NMI:Non-maskable_interrupts
>>      911.50 ± 37%     -93.2%      61.67 ±141% 
>> interrupts.CPU8.PMI:Performance_monitoring_interrupts
>>       12326 ± 15%     -32.3%       8350 ± 10% 
>> interrupts.CPU8.RES:Rescheduling_interrupts
>>        1392 ± 58%    -100.0%       0.00       
>> interrupts.CPU9.NMI:Non-maskable_interrupts
>>        1392 ± 58%    -100.0%       0.00       
>> interrupts.CPU9.PMI:Performance_monitoring_interrupts
>>       60185 ± 19%     -30.5%      41822 ± 11% 
>> interrupts.NMI:Non-maskable_interrupts
>>       60185 ± 19%     -30.5%      41822 ± 11% 
>> interrupts.PMI:Performance_monitoring_interrupts
>>      749419           -31.9%     510225 ±  3% 
>> interrupts.RES:Rescheduling_interrupts
>>       15.05 ±  6%      -4.1       10.97 ± 20% 
>> perf-profile.calltrace.cycles-pp.normal_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
>>
>>       12.66 ±  5%      -4.0        8.68 ± 20% 
>> perf-profile.calltrace.cycles-pp.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread.kthread
>>
>>        5.99 ±  8%      -1.6        4.37 ±  6% 
>> perf-profile.calltrace.cycles-pp.io_submit
>>        5.83 ±  8%      -1.6        4.25 ±  6% 
>> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.io_submit
>>        5.82 ±  8%      -1.6        4.24 ±  6% 
>> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.io_submit
>>
>>        5.81 ±  8%      -1.6        4.23 ±  6% 
>> perf-profile.calltrace.cycles-pp.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe.io_submit
>>
>>        5.76 ±  8%      -1.6        4.19 ±  6% 
>> perf-profile.calltrace.cycles-pp.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe.io_submit
>>
>>        5.65 ±  6%      -1.6        4.08 ± 20% 
>> perf-profile.calltrace.cycles-pp.btrfs_mark_extent_written.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread
>>
>>        4.52 ±  3%      -1.5        2.99 ± 19% 
>> perf-profile.calltrace.cycles-pp.add_pending_csums.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread
>>
>>        6.90 ±  8%      -1.5        5.38 ± 10% 
>> perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback
>>
>>        6.90 ±  8%      -1.5        5.38 ± 10% 
>> perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
>>
>>        5.58 ±  8%      -1.5        4.07 ±  6% 
>> perf-profile.calltrace.cycles-pp.aio_write.io_submit_one.__x64_sys_io_submit.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>
>>        4.50 ±  3%      -1.5        2.99 ± 19% 
>> perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.add_pending_csums.btrfs_finish_ordered_io.normal_work_helper.process_one_work
>>
>>        5.44 ±  8%      -1.5        3.96 ±  7% 
>> perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.aio_write.io_submit_one.__x64_sys_io_submit.do_syscall_64
>>
>>        6.63 ±  8%      -1.5        5.17 ± 10% 
>> perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.__writeback_single_inode
>>
>>        5.34 ±  9%      -1.4        3.90 ±  6% 
>> perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.aio_write.io_submit_one.__x64_sys_io_submit
>>
>>        5.55 ±  8%      -1.2        4.32 ± 10% 
>> perf-profile.calltrace.cycles-pp.writepage_delalloc.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
>>
>>        4.98 ±  8%      -1.1        3.86 ± 10% 
>> perf-profile.calltrace.cycles-pp.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage.extent_write_cache_pages
>>
>>        5.00 ±  8%      -1.1        3.88 ± 10% 
>> perf-profile.calltrace.cycles-pp.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage.extent_write_cache_pages.extent_writepages
>>
>>        2.80 ±  4%      -1.0        1.78 ± 22% 
>> perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_mark_extent_written.btrfs_finish_ordered_io.normal_work_helper.process_one_work
>>
>>        1.45 ±  3%      -0.7        0.79 ± 18% 
>> perf-profile.calltrace.cycles-pp.__btrfs_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_mark_extent_written.btrfs_finish_ordered_io
>>
>>        1.45 ±  3%      -0.7        0.79 ± 18% 
>> perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_mark_extent_written.btrfs_finish_ordered_io.normal_work_helper
>>
>>        2.32 ±  3%      -0.6        1.72 ± 18% 
>> perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_csum_file_blocks.add_pending_csums.btrfs_finish_ordered_io.normal_work_helper
>>
>>        0.91 ±  8%      -0.5        0.42 ± 73% 
>> perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_csum_file_blocks.add_pending_csums.btrfs_finish_ordered_io.normal_work_helper
>>
>>        0.88 ±  8%      -0.5        0.41 ± 74% 
>> perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.add_pending_csums.btrfs_finish_ordered_io
>>
>>        0.83 ±  5%      -0.4        0.41 ± 71% 
>> perf-profile.calltrace.cycles-pp.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.btrfs_csum_file_blocks.add_pending_csums
>>
>>        1.90 ± 20%      -0.4        1.48 ± 29% 
>> perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
>>
>>        1.89 ± 20%      -0.4        1.48 ± 29% 
>> perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>>
>>        0.82 ±  4%      -0.4        0.42 ± 71% 
>> perf-profile.calltrace.cycles-pp.run_one_async_done.normal_work_helper.process_one_work.worker_thread.kthread
>>
>>        0.81 ±  4%      -0.4        0.41 ± 71% 
>> perf-profile.calltrace.cycles-pp.btrfs_map_bio.run_one_async_done.normal_work_helper.process_one_work.worker_thread
>>
>>        0.74 ±  6%      -0.4        0.36 ± 70% 
>> perf-profile.calltrace.cycles-pp.push_leaf_right.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.btrfs_csum_file_blocks
>>
>>        1.19 ±  3%      -0.4        0.83 ± 16% 
>> perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_csum_file_blocks.add_pending_csums.btrfs_finish_ordered_io
>>
>>        1.00 ±  6%      -0.4        0.65 ±  7% 
>> perf-profile.calltrace.cycles-pp.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter.aio_write.io_submit_one
>>
>>        1.27 ±  5%      -0.4        0.92 ±  7% 
>> perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.aio_write.io_submit_one
>>
>>        1.25 ±  6%      -0.3        0.90 ±  7% 
>> perf-profile.calltrace.cycles-pp.create_io_em.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage
>>
>>        0.93 ±  8%      -0.3        0.59 ±  7% 
>> perf-profile.calltrace.cycles-pp.__set_extent_bit.lock_extent_bits.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter
>>
>>        0.94 ±  7%      -0.3        0.60 ±  6% 
>> perf-profile.calltrace.cycles-pp.lock_extent_bits.lock_and_cleanup_extent_if_need.btrfs_buffered_write.btrfs_file_write_iter.aio_write
>>
>>        0.70 ±  8%      -0.3        0.37 ± 70% 
>> perf-profile.calltrace.cycles-pp.__lookup_extent_mapping.btrfs_get_extent.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
>>
>>        0.79 ±  6%      -0.3        0.47 ± 71% 
>> perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_duplicate_item.btrfs_mark_extent_written.btrfs_finish_ordered_io.normal_work_helper
>>
>>        0.71 ± 21%      -0.3        0.43 ± 74% 
>> perf-profile.calltrace.cycles-pp.__btrfs_free_extent.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space
>>
>>        1.15 ± 11%      -0.3        0.88 ±  9% 
>> perf-profile.calltrace.cycles-pp.btrfs_lookup_csums_range.csum_exist_in_range.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc
>>
>>        1.15 ± 11%      -0.3        0.88 ±  8% 
>> perf-profile.calltrace.cycles-pp.csum_exist_in_range.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage
>>
>>        1.43 ± 13%      -0.3        1.17 ±  5% 
>> perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.aio_write.io_submit_one
>>
>>        1.06 ±  5%      -0.3        0.81 ±  7% 
>> perf-profile.calltrace.cycles-pp.btrfs_drop_extent_cache.create_io_em.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc
>>
>>        1.30 ± 15%      -0.2        1.06 ±  4% 
>> perf-profile.calltrace.cycles-pp.reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.aio_write
>>
>>        1.03 ± 13%      -0.2        0.79 ±  9% 
>> perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csums_range.csum_exist_in_range.run_delalloc_nocow.btrfs_run_delalloc_range
>>
>>        1.20 ±  4%      -0.2        0.96 ± 15% 
>> perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>>
>>        1.24 ±  3%      -0.2        1.01 ± 15% 
>> perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>
>>        1.05 ±  8%      -0.2        0.82 ± 12% 
>> perf-profile.calltrace.cycles-pp.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
>>
>>        0.88 ± 13%      -0.2        0.71 ±  2% 
>> perf-profile.calltrace.cycles-pp.wait_reserve_ticket.reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
>>
>>        1.01 ±  9%      -0.2        0.84 ±  9% 
>> perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc
>>
>>        1.01 ± 10%      -0.2        0.85 ±  9% 
>> perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage
>>
>>        0.72 ±  7%      -0.2        0.56 ±  6% 
>> perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.aio_write
>>
>>        0.75 ±  8%      -0.1        0.60 ± 10% 
>> perf-profile.calltrace.cycles-pp.submit_extent_page.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages
>>
>>        0.92 ± 15%      +0.2        1.14 ±  3% 
>> perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>>
>>        1.01 ± 15%      +0.2        1.25 ±  4% 
>> perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
>>
>>        1.15 ± 15%      +0.3        1.44 ±  6% 
>> perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>>
>>        0.27 ±100%      +0.4        0.63 ±  4% 
>> perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
>>
>>        1.74 ±  9%      +0.4        2.11 ±  2% 
>> perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
>>
>>        2.63 ± 10%      +0.6        3.26       
>> perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
>>
>>        0.00            +0.8        0.75 ± 18% 
>> perf-profile.calltrace.cycles-pp.map_private_extent_buffer.btrfs_get_token_64.check_leaf.btree_csum_one_bio.btree_submit_bio_hook
>>
>>        2.37 ± 19%      +0.8        3.19 ±  5% 
>> perf-profile.calltrace.cycles-pp.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
>>
>>        2.33 ± 19%      +0.8        3.17 ±  5% 
>> perf-profile.calltrace.cycles-pp.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread
>>
>>        0.00            +0.9        0.90 ± 18% 
>> perf-profile.calltrace.cycles-pp.map_private_extent_buffer.btrfs_get_token_32.check_leaf.btree_csum_one_bio.btree_submit_bio_hook
>>
>>        4.71 ± 11%      +1.0        5.74       
>> perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry
>>
>>        5.04 ± 10%      +1.2        6.19       
>> perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
>>
>>        0.00            +1.3        1.30 ± 19% 
>> perf-profile.calltrace.cycles-pp.submit_extent_page.write_one_eb.btree_write_cache_pages.do_writepages.__filemap_fdatawrite_range
>>
>>        0.00            +1.4        1.36 ± 19% 
>> perf-profile.calltrace.cycles-pp.write_one_eb.btree_write_cache_pages.do_writepages.__filemap_fdatawrite_range.btrfs_write_marked_extents
>>
>>        0.29 ±101%      +1.4        1.67 ± 18% 
>> perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
>>
>>        0.00            +1.4        1.39 ± 19% 
>> perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
>>
>>        0.00            +1.4        1.39 ± 19% 
>> perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
>>
>>        0.00            +1.4        1.39 ± 19% 
>> perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space
>>
>>        0.00            +1.4        1.39 ± 19% 
>> perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
>>
>>        0.00            +1.4        1.39 ± 19% 
>> perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_async_reclaim_metadata_space
>>
>>        0.00            +1.5        1.52 ± 18% 
>> perf-profile.calltrace.cycles-pp.btrfs_get_token_64.check_leaf.btree_csum_one_bio.btree_submit_bio_hook.submit_one_bio
>>
>>        0.00            +2.2        2.20 ± 14% 
>> perf-profile.calltrace.cycles-pp.btrfs_get_token_32.check_leaf.btree_csum_one_bio.btree_submit_bio_hook.submit_one_bio
>>
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
>>
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
>>
>>        7.97 ±  7%      +3.5       11.44 ± 15% 
>> perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn
>>
>>        7.97 ±  7%      +3.5       11.44 ± 15% 
>> perf-profile.calltrace.cycles-pp.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work.worker_thread
>>
>>        7.97 ±  7%      +3.5       11.44 ± 15% 
>> perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work
>>
>>       49.45 ±  2%      +4.3       53.79 ±  4% 
>> perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
>>
>>       61.98 ±  2%      +4.4       66.38 ±  3% 
>> perf-profile.calltrace.cycles-pp.secondary_startup_64
>>        1.07 ± 18%      +5.0        6.06 ± 20% 
>> perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback
>>
>>        0.93 ± 18%      +5.0        5.95 ± 20% 
>> perf-profile.calltrace.cycles-pp.write_one_eb.btree_write_cache_pages.do_writepages.__writeback_single_inode.writeback_sb_inodes
>>
>>       61.26 ±  2%      +5.1       66.36 ±  3% 
>> perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>>
>>       61.27 ±  2%      +5.1       66.37 ±  3% 
>> perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>>       61.21 ±  2%      +5.1       66.32 ±  3% 
>> perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>
>>        0.33 ±100%      +5.3        5.68 ± 20% 
>> perf-profile.calltrace.cycles-pp.submit_extent_page.write_one_eb.btree_write_cache_pages.do_writepages.__writeback_single_inode
>>
>>       55.45 ±  2%      +5.4       60.88 ±  3% 
>> perf-profile.calltrace.cycles-pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>
>>        0.00            +6.4        6.39 ± 13% 
>> perf-profile.calltrace.cycles-pp.check_leaf.btree_csum_one_bio.btree_submit_bio_hook.submit_one_bio.submit_extent_page
>>
>>        0.00            +6.5        6.50 ± 13% 
>> perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btree_submit_bio_hook.submit_one_bio.submit_extent_page.write_one_eb
>>
>>        0.29 ±100%      +6.6        6.92 ± 13% 
>> perf-profile.calltrace.cycles-pp.submit_one_bio.submit_extent_page.write_one_eb.btree_write_cache_pages.do_writepages
>>
>>        0.29 ±100%      +6.6        6.92 ± 13% 
>> perf-profile.calltrace.cycles-pp.btree_submit_bio_hook.submit_one_bio.submit_extent_page.write_one_eb.btree_write_cache_pages
>>
>>       15.05 ±  6%      -4.1       10.97 ± 20% 
>> perf-profile.children.cycles-pp.normal_work_helper
>>       12.66 ±  5%      -4.0        8.68 ± 20% 
>> perf-profile.children.cycles-pp.btrfs_finish_ordered_io
>>        7.84 ±  5%      -2.4        5.39 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_search_slot
>>        7.30 ±  7%      -1.7        5.59 ± 11% 
>> perf-profile.children.cycles-pp.extent_writepages
>>        7.30 ±  7%      -1.7        5.59 ± 11% 
>> perf-profile.children.cycles-pp.extent_write_cache_pages
>>        7.03 ±  7%      -1.6        5.38 ± 12% 
>> perf-profile.children.cycles-pp.__extent_writepage
>>        6.19 ±  8%      -1.6        4.56 ±  7% 
>> perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>        6.17 ±  8%      -1.6        4.55 ±  7% 
>> perf-profile.children.cycles-pp.do_syscall_64
>>        6.01 ±  8%      -1.6        4.39 ±  7% 
>> perf-profile.children.cycles-pp.io_submit
>>        5.81 ±  8%      -1.6        4.23 ±  6% 
>> perf-profile.children.cycles-pp.__x64_sys_io_submit
>>        5.76 ±  8%      -1.6        4.19 ±  6% 
>> perf-profile.children.cycles-pp.io_submit_one
>>        5.66 ±  5%      -1.6        4.09 ± 20% 
>> perf-profile.children.cycles-pp.btrfs_mark_extent_written
>>        4.52 ±  3%      -1.5        2.99 ± 19% 
>> perf-profile.children.cycles-pp.add_pending_csums
>>        5.59 ±  8%      -1.5        4.07 ±  6% 
>> perf-profile.children.cycles-pp.aio_write
>>        4.51 ±  3%      -1.5        2.99 ± 19% 
>> perf-profile.children.cycles-pp.btrfs_csum_file_blocks
>>        5.44 ±  8%      -1.5        3.96 ±  7% 
>> perf-profile.children.cycles-pp.btrfs_file_write_iter
>>        5.34 ±  9%      -1.4        3.90 ±  6% 
>> perf-profile.children.cycles-pp.btrfs_buffered_write
>>        5.88 ±  7%      -1.4        4.47 ± 11% 
>> perf-profile.children.cycles-pp.writepage_delalloc
>>        5.30 ±  8%      -1.3        4.01 ± 11% 
>> perf-profile.children.cycles-pp.btrfs_run_delalloc_range
>>        5.28 ±  8%      -1.3        3.99 ± 11% 
>> perf-profile.children.cycles-pp.run_delalloc_nocow
>>        2.55 ±  2%      -0.9        1.67 ± 16% 
>> perf-profile.children.cycles-pp.btrfs_cow_block
>>        2.54 ±  2%      -0.9        1.66 ± 16% 
>> perf-profile.children.cycles-pp.__btrfs_cow_block
>>        2.15 ± 13%      -0.8        1.31 ±  8% 
>> perf-profile.children.cycles-pp.__lookup_extent_mapping
>>        1.87 ± 12%      -0.8        1.04 ± 12% 
>> perf-profile.children.cycles-pp.__etree_search
>>        0.94 ± 51%      -0.7        0.22 ± 34% 
>> perf-profile.children.cycles-pp.printk
>>        0.94 ± 51%      -0.7        0.22 ± 34% 
>> perf-profile.children.cycles-pp.vprintk_emit
>>        2.60 ±  2%      -0.7        1.92 ± 14% 
>> perf-profile.children.cycles-pp.btrfs_insert_empty_items
>>        3.00 ±  5%      -0.7        2.33 ±  6% 
>> perf-profile.children.cycles-pp._raw_spin_lock
>>        1.89 ±  2%      -0.7        1.23 ±  7% 
>> perf-profile.children.cycles-pp.__set_extent_bit
>>        2.78 ±  4%      -0.6        2.14 ± 14% 
>> perf-profile.children.cycles-pp.__schedule
>>        1.57 ±  2%      -0.5        1.02 ±  9% 
>> perf-profile.children.cycles-pp.lock_extent_bits
>>        1.19 ± 14%      -0.5        0.70 ± 11% 
>> perf-profile.children.cycles-pp.__clear_extent_bit
>>        1.51 ±  7%      -0.5        1.04 ±  9% 
>> perf-profile.children.cycles-pp.read_block_for_search
>>        2.08 ±  5%      -0.5        1.62 ± 18% 
>> perf-profile.children.cycles-pp.setup_items_for_insert
>>        2.08 ± 17%      -0.4        1.67 ± 24% 
>> perf-profile.children.cycles-pp.btrfs_run_delayed_refs
>>        2.08 ± 17%      -0.4        1.67 ± 24% 
>> perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
>>        1.60 ±  6%      -0.4        1.20 ± 12% 
>> perf-profile.children.cycles-pp.schedule
>>        1.95 ± 11%      -0.4        1.58 ± 12% 
>> perf-profile.children.cycles-pp.try_to_wake_up
>>        1.31 ±  6%      -0.4        0.94 ±  9% 
>> perf-profile.children.cycles-pp.create_io_em
>>        0.99 ±  4%      -0.4        0.63 ± 13% 
>> perf-profile.children.cycles-pp.alloc_tree_block_no_bg_flush
>>        1.00 ±  6%      -0.4        0.65 ±  7% 
>> perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
>>        1.27 ±  9%      -0.4        0.92 ± 11% 
>> perf-profile.children.cycles-pp.__wake_up_common_lock
>>        0.98 ±  3%      -0.4        0.63 ± 13% 
>> perf-profile.children.cycles-pp.btrfs_alloc_tree_block
>>        1.27 ±  5%      -0.4        0.92 ±  7% 
>> perf-profile.children.cycles-pp.btrfs_dirty_pages
>>        1.34 ±  7%      -0.3        0.99 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_map_bio
>>        1.11 ±  9%      -0.3        0.77 ± 11% 
>> perf-profile.children.cycles-pp.generic_bin_search
>>        1.16 ±  6%      -0.3        0.82 ±  9% 
>> perf-profile.children.cycles-pp.find_extent_buffer
>>        0.91 ±  7%      -0.3        0.57 ± 21% 
>> perf-profile.children.cycles-pp.btrfs_lookup_csum
>>        1.21 ± 11%      -0.3        0.90 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_lookup_csums_range
>>        1.21 ± 11%      -0.3        0.91 ±  9% 
>> perf-profile.children.cycles-pp.csum_exist_in_range
>>        1.10 ± 10%      -0.3        0.80 ±  9% 
>> perf-profile.children.cycles-pp.__wake_up_common
>>        0.37 ± 70%      -0.3        0.07 ± 18% 
>> perf-profile.children.cycles-pp.test_range_bit
>>        1.61 ±  4%      -0.3        1.32 ± 15% 
>> perf-profile.children.cycles-pp.push_leaf_right
>>        0.60 ±  4%      -0.3        0.31 ± 25% 
>> perf-profile.children.cycles-pp.btrfs_extend_item
>>        1.02 ±  9%      -0.3        0.73 ± 10% 
>> perf-profile.children.cycles-pp.autoremove_wake_function
>>        1.12 ±  4%      -0.3        0.84 ±  9% 
>> perf-profile.children.cycles-pp.btrfs_drop_extent_cache
>>        0.82 ±  6%      -0.3        0.55 ±  4% 
>> perf-profile.children.cycles-pp.btrfs_release_path
>>        0.85 ±  8%      -0.3        0.59 ± 17% 
>> perf-profile.children.cycles-pp.copy_extent_buffer_full
>>        0.99 ±  4%      -0.3        0.73 ± 13% 
>> perf-profile.children.cycles-pp.btrfs_set_token_32
>>        1.44 ± 13%      -0.3        1.18 ±  5% 
>> perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
>>        0.84 ±  8%      -0.3        0.59 ± 17% 
>> perf-profile.children.cycles-pp.copy_page
>>        0.87 ± 11%      -0.3        0.62 ± 11% 
>> perf-profile.children.cycles-pp.pagecache_get_page
>>        0.84 ±  7%      -0.2        0.60 ± 11% 
>> perf-profile.children.cycles-pp.kmem_cache_alloc
>>        1.12 ±  7%      -0.2        0.88 ± 17% 
>> perf-profile.children.cycles-pp.__extent_writepage_io
>>        1.30 ± 15%      -0.2        1.06 ±  5% 
>> perf-profile.children.cycles-pp.reserve_metadata_bytes
>>        0.82 ±  4%      -0.2        0.58 ± 13% 
>> perf-profile.children.cycles-pp.run_one_async_done
>>        1.25 ±  3%      -0.2        1.01 ± 15% 
>> perf-profile.children.cycles-pp.schedule_idle
>>        0.34 ± 53%      -0.2        0.10 ± 28% 
>> perf-profile.children.cycles-pp.delay_tsc
>>        0.70 ± 13%      -0.2        0.47 ± 11% 
>> perf-profile.children.cycles-pp.prepare_pages
>>        0.50 ± 22%      -0.2        0.28 ± 13% 
>> perf-profile.children.cycles-pp.clear_state_bit
>>        0.84 ±  5%      -0.2        0.63 ±  6% 
>> perf-profile.children.cycles-pp.btrfs_get_extent
>>        0.54 ± 11%      -0.2        0.34 ±  4% 
>> perf-profile.children.cycles-pp.btrfs_free_path
>>        1.16 ± 11%      -0.2        0.96 ± 19% 
>> perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>        0.53 ±  9%      -0.2        0.33 ± 18% 
>> perf-profile.children.cycles-pp.unpin_extent_cache
>>        1.07 ± 10%      -0.2        0.88 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_lookup_file_extent
>>        0.50 ±  4%      -0.2        0.31 ± 15% 
>> perf-profile.children.cycles-pp.clear_extent_bit
>>        0.45 ± 13%      -0.2        0.26 ± 11% 
>> perf-profile.children.cycles-pp.kmem_cache_free
>>        0.40 ± 14%      -0.2        0.21 ± 50% 
>> perf-profile.children.cycles-pp.__writeback_inodes_wb
>>        0.64 ±  7%      -0.2        0.45 ± 10% 
>> perf-profile.children.cycles-pp.dequeue_task_fair
>>        0.50 ±  8%      -0.2        0.33 ± 23% 
>> perf-profile.children.cycles-pp.btrfs_add_delayed_tree_ref
>>        0.88 ± 13%      -0.2        0.71 ±  2% 
>> perf-profile.children.cycles-pp.wait_reserve_ticket
>>        0.52 ±  9%      -0.2        0.35 ±  7% 
>> perf-profile.children.cycles-pp.__radix_tree_lookup
>>        0.52 ±  8%      -0.2        0.36 ±  8% 
>> perf-profile.children.cycles-pp.xas_load
>>        0.78 ± 19%      -0.2        0.62 ± 23% 
>> perf-profile.children.cycles-pp.__btrfs_free_extent
>>        0.56 ± 17%      -0.1        0.42 ± 15% 
>> perf-profile.children.cycles-pp.btrfs_del_items
>>        0.51 ±  5%      -0.1        0.36 ±  9% 
>> perf-profile.children.cycles-pp.dequeue_entity
>>        0.39 ±  7%      -0.1        0.24 ±  6% 
>> perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
>>        0.82 ± 14%      -0.1        0.68 ± 18% 
>> perf-profile.children.cycles-pp.ttwu_do_activate
>>        0.55 ±  8%      -0.1        0.41 ±  8% 
>> perf-profile.children.cycles-pp.btrfs_submit_bio_hook
>>        0.53 ±  5%      -0.1        0.40 ± 13% 
>> perf-profile.children.cycles-pp.update_load_avg
>>        0.40 ±  8%      -0.1        0.27 ± 27% 
>> perf-profile.children.cycles-pp.add_delayed_ref_head
>>        0.35 ± 13%      -0.1        0.22 ±  3% 
>> perf-profile.children.cycles-pp.set_extent_bit
>>        0.52 ±  9%      -0.1        0.39 ±  7% 
>> perf-profile.children.cycles-pp.btrfs_wq_submit_bio
>>        0.35 ±  3%      -0.1        0.23 ± 32% 
>> perf-profile.children.cycles-pp.queued_write_lock_slowpath
>>        0.33 ±  6%      -0.1        0.21 ± 15% 
>> perf-profile.children.cycles-pp.__slab_alloc
>>        0.63 ± 19%      -0.1        0.51 ± 13% 
>> perf-profile.children.cycles-pp.sched_ttwu_pending
>>        0.31 ± 11%      -0.1        0.19 ± 28% 
>> perf-profile.children.cycles-pp.btrfs_update_inode
>>        0.31 ± 11%      -0.1        0.19 ± 28% 
>> perf-profile.children.cycles-pp.btrfs_update_inode_fallback
>>        0.57 ±  5%      -0.1        0.46 ± 10% 
>> perf-profile.children.cycles-pp.find_lock_delalloc_range
>>        0.45 ±  5%      -0.1        0.34 ±  9% 
>> perf-profile.children.cycles-pp.btrfs_cross_ref_exist
>>        0.29 ±  3%      -0.1        0.18 ±  7% 
>> perf-profile.children.cycles-pp.free_extent_buffer
>>        0.38 ±  3%      -0.1        0.26 ±  8% 
>> perf-profile.children.cycles-pp.btrfs_mark_buffer_dirty
>>        0.46 ±  5%      -0.1        0.35 ± 13% 
>> perf-profile.children.cycles-pp.find_delalloc_range
>>        0.41 ±  9%      -0.1        0.30 ±  2% 
>> perf-profile.children.cycles-pp.btrfs_copy_from_user
>>        0.40 ±  9%      -0.1        0.29 ±  2% 
>> perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
>>        0.38 ± 10%      -0.1        0.27       
>> perf-profile.children.cycles-pp.find_get_entry
>>        0.31 ± 12%      -0.1        0.20 ± 31% 
>> perf-profile.children.cycles-pp.btrfs_remove_ordered_extent
>>        0.30 ±  6%      -0.1        0.20 ± 14% 
>> perf-profile.children.cycles-pp.___slab_alloc
>>        0.26 ±  8%      -0.1        0.16 ±  7% 
>> perf-profile.children.cycles-pp.merge_state
>>        0.38 ±  7%      -0.1        0.28 ±  3% 
>> perf-profile.children.cycles-pp.copyin
>>        0.26 ± 17%      -0.1        0.15 ± 26% 
>> perf-profile.children.cycles-pp.btrfs_delayed_update_inode
>>        0.25 ±  4%      -0.1        0.15 ±  5% 
>> perf-profile.children.cycles-pp.insert_state
>>        0.40 ± 13%      -0.1        0.30 ± 13% 
>> perf-profile.children.cycles-pp.extent_clear_unlock_delalloc
>>        0.36 ±  9%      -0.1        0.26 ±  3% 
>> perf-profile.children.cycles-pp.alloc_extent_state
>>        0.38 ±  7%      -0.1        0.29 ±  3% 
>> perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>>        0.39 ±  3%      -0.1        0.29 ± 14% 
>> perf-profile.children.cycles-pp.alloc_extent_buffer
>>        0.31 ±  4%      -0.1        0.22 ± 11% 
>> perf-profile.children.cycles-pp.set_extent_buffer_dirty
>>        0.26 ± 11%      -0.1        0.17 ± 23% 
>> perf-profile.children.cycles-pp.unlock_up
>>        0.32 ±  3%      -0.1        0.24 ± 13% 
>> perf-profile.children.cycles-pp.__btrfs_map_block
>>        0.23 ± 13%      -0.1        0.15 ± 28% 
>> perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
>>        0.25 ± 12%      -0.1        0.17 ±  2% 
>> perf-profile.children.cycles-pp.__slab_free
>>        0.47 ±  6%      -0.1        0.39 ± 15% 
>> perf-profile.children.cycles-pp.__push_leaf_right
>>        0.26 ±  9%      -0.1        0.18 ± 19% 
>> perf-profile.children.cycles-pp.__test_set_page_writeback
>>        0.32 ± 11%      -0.1        0.24 ± 27% 
>> perf-profile.children.cycles-pp.btrfs_add_ordered_extent
>>        0.15 ±  8%      -0.1        0.07 ±  6% 
>> perf-profile.children.cycles-pp.__xa_set_mark
>>        0.23 ±  7%      -0.1        0.15 ±  3% 
>> perf-profile.children.cycles-pp.release_extent_buffer
>>        0.18 ±  8%      -0.1        0.11 ± 26% 
>> perf-profile.children.cycles-pp.alloc_extent_map
>>        0.32 ± 10%      -0.1        0.24 ± 27% 
>> perf-profile.children.cycles-pp.__btrfs_add_ordered_extent
>>        0.32 ± 17%      -0.1        0.24 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_tree_read_lock_atomic
>>        0.20 ± 13%      -0.1        0.13 ± 27% 
>> perf-profile.children.cycles-pp.btrfs_inc_extent_ref
>>        0.14 ± 21%      -0.1        0.06 ± 19% 
>> perf-profile.children.cycles-pp.find_ref_head
>>        0.13 ± 32%      -0.1        0.06 ± 19% 
>> perf-profile.children.cycles-pp.rb_erase_cached
>>        0.21 ±  7%      -0.1        0.14 ± 15% 
>> perf-profile.children.cycles-pp.btrfs_submit_bio_start
>>        0.53 ± 12%      -0.1        0.46 ± 16% 
>> perf-profile.children.cycles-pp.btrfs_tree_read_lock
>>        0.21 ±  7%      -0.1        0.14 ± 15% 
>> perf-profile.children.cycles-pp.btrfs_csum_one_bio
>>        0.17 ± 16%      -0.1        0.10 ±  8% 
>> perf-profile.children.cycles-pp.rb_erase
>>        0.21 ±  7%      -0.1        0.14 ± 16% 
>> perf-profile.children.cycles-pp.run_one_async_start
>>        0.22 ±  3%      -0.1        0.15 ± 22% 
>> perf-profile.children.cycles-pp.btrfs_try_tree_write_lock
>>        0.21 ±  9%      -0.1        0.15 ± 21% 
>> perf-profile.children.cycles-pp.btrfs_leaf_free_space
>>        0.15 ± 23%      -0.1        0.09 ± 35% 
>> perf-profile.children.cycles-pp.free_extent_map
>>        0.20 ±  9%      -0.1        0.14 ± 20% 
>> perf-profile.children.cycles-pp.leaf_space_used
>>        0.19 ±  8%      -0.1        0.13 ± 13% 
>> perf-profile.children.cycles-pp.check_delayed_ref
>>        0.17 ± 13%      -0.1        0.12 ± 31% 
>> perf-profile.children.cycles-pp.get_page_from_freelist
>>        0.13 ±  8%      -0.1        0.08 ± 26% 
>> perf-profile.children.cycles-pp.__update_load_avg_se
>>        0.17 ±  2%      -0.1        0.12 ± 18% 
>> perf-profile.children.cycles-pp.btrfs_set_range_writeback
>>        0.15 ±  8%      -0.1        0.09 ± 20% 
>> perf-profile.children.cycles-pp.xas_set_mark
>>        0.18 ±  6%      -0.1        0.13 ± 16% 
>> perf-profile.children.cycles-pp.___might_sleep
>>        0.20 ± 11%      -0.1        0.15 ± 35% 
>> perf-profile.children.cycles-pp.__alloc_pages_nodemask
>>        0.10 ±  9%      -0.1        0.04 ± 71% 
>> perf-profile.children.cycles-pp.btrfs_tree_unlock
>>        0.14 ± 11%      -0.1        0.09 ± 28% 
>> perf-profile.children.cycles-pp.btrfs_reserve_extent
>>        0.10 ± 33%      -0.1        0.05 ± 72% 
>> perf-profile.children.cycles-pp.__btrfs_release_delayed_node
>>        0.22 ±  9%      -0.0        0.17 ± 25% 
>> perf-profile.children.cycles-pp.mark_extent_buffer_accessed
>>        0.09 ± 13%      -0.0        0.04 ± 71% 
>> perf-profile.children.cycles-pp.btrfs_tree_read_unlock_blocking
>>        0.18 ±  8%      -0.0        0.14 ± 24% 
>> perf-profile.children.cycles-pp.__list_del_entry_valid
>>        0.09 ± 13%      -0.0        0.04 ± 73% 
>> perf-profile.children.cycles-pp.verify_parent_transid
>>        0.11 ± 19%      -0.0        0.07 ± 11% 
>> perf-profile.children.cycles-pp.entry_SYSCALL_64
>>        0.22 ±  5%      -0.0        0.18 ± 12% 
>> perf-profile.children.cycles-pp.check_committed_ref
>>        0.11 ± 19%      -0.0        0.07 ± 23% 
>> perf-profile.children.cycles-pp.select_idle_sibling
>>        0.14 ± 11%      -0.0        0.09 ±  5% 
>> perf-profile.children.cycles-pp.do_io_getevents
>>        0.15 ±  7%      -0.0        0.11 ±  4% 
>> perf-profile.children.cycles-pp.__x64_sys_io_getevents
>>        0.08 ± 10%      -0.0        0.04 ± 71% 
>> perf-profile.children.cycles-pp.btrfs_release_extent_buffer_pages
>>        0.17 ± 18%      -0.0        0.13 ±  9% 
>> perf-profile.children.cycles-pp.clear_page_dirty_for_io
>>        0.14 ±  5%      -0.0        0.10 �� 25% 
>> perf-profile.children.cycles-pp.block_group_cache_tree_search
>>        0.18 ±  4%      -0.0        0.14 ± 11% 
>> perf-profile.children.cycles-pp.btrfs_get_chunk_map
>>        0.11 ± 13%      -0.0        0.08 ± 12% 
>> perf-profile.children.cycles-pp.btrfs_buffer_uptodate
>>        0.15 ± 15%      -0.0        0.11 ± 19% 
>> perf-profile.children.cycles-pp.xas_find_marked
>>        0.12 ± 15%      -0.0        0.08 ± 20% 
>> perf-profile.children.cycles-pp.btrfs_unlock_up_safe
>>        0.12 ± 14%      -0.0        0.08 ± 14% 
>> perf-profile.children.cycles-pp.btrfs_set_path_blocking
>>        0.11 ± 11%      -0.0        0.07 ± 28% 
>> perf-profile.children.cycles-pp.find_free_extent
>>        0.24 ±  5%      -0.0        0.20 ±  6% 
>> perf-profile.children.cycles-pp.btrfs_root_node
>>        0.07 ±  6%      -0.0        0.03 ± 70% 
>> perf-profile.children.cycles-pp.extent_mergeable
>>        0.13 ± 12%      -0.0        0.10 ±  9% 
>> perf-profile.children.cycles-pp.__switch_to
>>        0.10 ± 18%      -0.0        0.07 ±  7% 
>> perf-profile.children.cycles-pp.rb_insert_color_cached
>>        0.07 ± 14%      -0.0        0.04 ± 71% 
>> perf-profile.children.cycles-pp.rb_prev
>>        0.11 ± 11%      -0.0        0.08 ± 12% 
>> perf-profile.children.cycles-pp.get_io_u
>>        0.10 ± 14%      -0.0        0.07 ± 23% 
>> perf-profile.children.cycles-pp.available_idle_cpu
>>        0.17 ± 10%      -0.0        0.13 ±  3% 
>> perf-profile.children.cycles-pp._raw_write_lock
>>        0.10 ± 11%      -0.0        0.06 ±  7% 
>> perf-profile.children.cycles-pp.__might_sleep
>>        0.17 ±  7%      -0.0        0.14 ± 12% 
>> perf-profile.children.cycles-pp._raw_read_lock
>>        0.17 ± 10%      -0.0        0.14 ± 12% 
>> perf-profile.children.cycles-pp.can_overcommit
>>        0.10 ± 11%      -0.0        0.07       
>> perf-profile.children.cycles-pp.__list_add_valid
>>        0.09 ±  7%      -0.0        0.06 ±  7% 
>> perf-profile.children.cycles-pp.aio_read_events
>>        0.11 ± 10%      -0.0        0.08 ± 10% 
>> perf-profile.children.cycles-pp.___perf_sw_event
>>        0.11 ±  9%      -0.0        0.09 ± 18% 
>> perf-profile.children.cycles-pp.get_alloc_profile
>>        0.11 ± 12%      -0.0        0.08 ± 14% 
>> perf-profile.children.cycles-pp.pick_next_task_idle
>>        0.10 ± 13%      -0.0        0.07 ±  6% 
>> perf-profile.children.cycles-pp.read_events
>>        0.08 ±  6%      -0.0        0.06 ± 13% 
>> perf-profile.children.cycles-pp.replace_extent_mapping
>>        0.10 ±  5%      -0.0        0.08 ± 10% 
>> perf-profile.children.cycles-pp.menu_reflect
>>        0.07 ± 17%      +0.0        0.09 ±  5% 
>> perf-profile.children.cycles-pp.run_posix_cpu_timers
>>        0.05 ± 58%      +0.0        0.08 ±  6% 
>> perf-profile.children.cycles-pp.rcu_irq_enter
>>        0.19 ± 11%      +0.1        0.26 ± 17% 
>> perf-profile.children.cycles-pp.native_irq_return_iret
>>        0.20 ± 14%      +0.1        0.27 ±  8% 
>> perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
>>        0.38 ±  9%      +0.1        0.46       
>> perf-profile.children.cycles-pp.load_balance
>>        0.30 ±  8%      +0.1        0.38 ± 15% 
>> perf-profile.children.cycles-pp.irq_enter
>>        0.21 ± 24%      +0.1        0.30 ±  9% 
>> perf-profile.children.cycles-pp.rcu_sched_clock_irq
>>        0.22 ±  3%      +0.1        0.32 ±  9% 
>> perf-profile.children.cycles-pp.lapic_next_deadline
>>        0.52 ± 12%      +0.1        0.63 ±  3% 
>> perf-profile.children.cycles-pp.rebalance_domains
>>        1.90 ± 10%      +0.3        2.23 ±  2% 
>> perf-profile.children.cycles-pp.__hrtimer_run_queues
>>        0.23 ± 12%      +0.4        0.67 ± 15% 
>> perf-profile.children.cycles-pp.read_extent_buffer
>>        2.88 ± 11%      +0.5        3.41       
>> perf-profile.children.cycles-pp.hrtimer_interrupt
>>        0.09 ± 12%      +0.7        0.83 ± 15% 
>> perf-profile.children.cycles-pp.btrfs_get_token_8
>>        2.37 ± 19%      +0.8        3.19 ±  5% 
>> perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
>>        2.33 ± 19%      +0.8        3.17 ±  5% 
>> perf-profile.children.cycles-pp.flush_space
>>        0.14 ± 34%      +1.3        1.39 ± 19% 
>> perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
>>        0.14 ± 34%      +1.3        1.39 ± 19% 
>> perf-profile.children.cycles-pp.btrfs_write_marked_extents
>>        0.14 ± 34%      +1.3        1.39 ± 19% 
>> perf-profile.children.cycles-pp.__filemap_fdatawrite_range
>>        0.42 ± 43%      +1.3        1.67 ± 18% 
>> perf-profile.children.cycles-pp.btrfs_commit_transaction
>>        0.25 ±  5%      +1.9        2.17 ± 10% 
>> perf-profile.children.cycles-pp.btrfs_get_token_64
>>        1.71 ±  5%      +2.1        3.79 ±  5% 
>> perf-profile.children.cycles-pp.btrfs_get_token_32
>>        0.43 ±  8%      +2.4        2.84 ± 10% 
>> perf-profile.children.cycles-pp.map_private_extent_buffer
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.children.cycles-pp.wb_writeback
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.children.cycles-pp.writeback_sb_inodes
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.children.cycles-pp.__writeback_single_inode
>>        8.37 ±  7%      +3.3       11.65 ± 16% 
>> perf-profile.children.cycles-pp.wb_workfn
>>       50.06 ±  2%      +3.8       53.82 ±  4% 
>> perf-profile.children.cycles-pp.intel_idle
>>       61.99 ±  2%      +4.4       66.39 ±  3% 
>> perf-profile.children.cycles-pp.do_idle
>>       61.98 ±  2%      +4.4       66.38 ±  3% 
>> perf-profile.children.cycles-pp.secondary_startup_64
>>       61.98 ±  2%      +4.4       66.38 ±  3% 
>> perf-profile.children.cycles-pp.cpu_startup_entry
>>        8.51 ±  7%      +4.5       13.04 ± 12% 
>> perf-profile.children.cycles-pp.do_writepages
>>       56.43 ±  3%      +4.9       61.30 ±  3% 
>> perf-profile.children.cycles-pp.cpuidle_enter_state
>>       61.27 ±  2%      +5.1       66.37 ±  3% 
>> perf-profile.children.cycles-pp.start_secondary
>>        1.43 ±  7%      +6.2        7.64 ± 13% 
>> perf-profile.children.cycles-pp.submit_extent_page
>>        1.20 ± 17%      +6.2        7.45 ± 13% 
>> perf-profile.children.cycles-pp.btree_write_cache_pages
>>        1.05 ± 17%      +6.3        7.31 ± 13% 
>> perf-profile.children.cycles-pp.write_one_eb
>>        1.11 ±  7%      +6.3        7.37 ± 13% 
>> perf-profile.children.cycles-pp.submit_one_bio
>>        0.55 ± 16%      +6.4        6.95 ± 13% 
>> perf-profile.children.cycles-pp.btree_submit_bio_hook
>>        0.00            +6.5        6.48 ± 13% 
>> perf-profile.children.cycles-pp.check_leaf
>>        0.00            +6.5        6.53 ± 13% 
>> perf-profile.children.cycles-pp.btree_csum_one_bio
>>        2.12 ± 11%      -0.8        1.29 ±  7% 
>> perf-profile.self.cycles-pp.__lookup_extent_mapping
>>        1.83 ± 12%      -0.8        1.03 ± 13% 
>> perf-profile.self.cycles-pp.__etree_search
>>        2.06 ±  5%      -0.5        1.59 ±  5% 
>> perf-profile.self.cycles-pp._raw_spin_lock
>>        0.81 ±  9%      -0.3        0.52 ± 10% 
>> perf-profile.self.cycles-pp.generic_bin_search
>>        0.84 ±  7%      -0.3        0.58 ± 17% 
>> perf-profile.self.cycles-pp.copy_page
>>        0.33 ± 54%      -0.2        0.10 ± 28% 
>> perf-profile.self.cycles-pp.delay_tsc
>>        0.89 ±  9%      -0.2        0.69 ± 14% 
>> perf-profile.self.cycles-pp.btrfs_set_token_32
>>        0.81 ±  4%      -0.2        0.63 ± 14% 
>> perf-profile.self.cycles-pp.__schedule
>>        0.51 ±  9%      -0.2        0.35 ±  6% 
>> perf-profile.self.cycles-pp.__radix_tree_lookup
>>        0.45 ±  8%      -0.1        0.32 ± 10% 
>> perf-profile.self.cycles-pp.xas_load
>>        0.43 ±  4%      -0.1        0.31 ±  6% 
>> perf-profile.self.cycles-pp.find_extent_buffer
>>        0.77 ±  5%      -0.1        0.66 ± 11% 
>> perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>        0.31 ± 10%      -0.1        0.20 ± 28% 
>> perf-profile.self.cycles-pp.add_delayed_ref_head
>>        0.39 ± 16%      -0.1        0.29 ± 16% 
>> perf-profile.self.cycles-pp.try_to_wake_up
>>        0.31 ±  4%      -0.1        0.20 ± 26% 
>> perf-profile.self.cycles-pp.queued_write_lock_slowpath
>>        0.38 ±  7%      -0.1        0.29 ±  3% 
>> perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>>        0.20 ± 17%      -0.1        0.11 ± 14% 
>> perf-profile.self.cycles-pp.kmem_cache_free
>>        0.25 ± 11%      -0.1        0.17 ±  2% 
>> perf-profile.self.cycles-pp.__slab_free
>>        0.16 ±  9%      -0.1        0.08 ±  5% 
>> perf-profile.self.cycles-pp.free_extent_buffer
>>        0.28 ± 17%      -0.1        0.20 ± 11% 
>> perf-profile.self.cycles-pp.btrfs_search_slot
>>        0.31 ±  4%      -0.1        0.24 ± 20% 
>> perf-profile.self.cycles-pp.kmem_cache_alloc
>>        0.14 ± 21%      -0.1        0.06 ± 19% 
>> perf-profile.self.cycles-pp.find_ref_head
>>        0.16 ± 10%      -0.1        0.09 ±  5% 
>> perf-profile.self.cycles-pp.insert_state
>>        0.12 ±  8%      -0.1        0.06 ± 72% 
>> perf-profile.self.cycles-pp.__update_load_avg_se
>>        0.16 ± 15%      -0.1        0.10 ±  8% 
>> perf-profile.self.cycles-pp.rb_erase
>>        0.10 ±  9%      -0.1        0.04 ± 71% 
>> perf-profile.self.cycles-pp.btrfs_tree_unlock
>>        0.15 ± 13%      -0.1        0.10 ± 12% 
>> perf-profile.self.cycles-pp.___slab_alloc
>>        0.28 ± 13%      -0.1        0.22 ±  5% 
>> perf-profile.self.cycles-pp.queued_read_lock_slowpath
>>        0.15 ± 21%      -0.1        0.09 ± 35% 
>> perf-profile.self.cycles-pp.free_extent_map
>>        0.18 ±  6%      -0.1        0.12 ± 11% 
>> perf-profile.self.cycles-pp.update_load_avg
>>        0.10 ± 11%      -0.1        0.04 ± 70% 
>> perf-profile.self.cycles-pp.btrfs_extend_item
>>        0.15 ± 23%      -0.1        0.09 ±  9% 
>> perf-profile.self.cycles-pp.add_extent_mapping
>>        0.15 ±  8%      -0.1        0.09 ± 20% 
>> perf-profile.self.cycles-pp.xas_set_mark
>>        0.18 ±  6%      -0.1        0.13 ± 16% 
>> perf-profile.self.cycles-pp.___might_sleep
>>        0.18 ±  6%      -0.0        0.13 ± 22% 
>> perf-profile.self.cycles-pp.__list_del_entry_valid
>>        0.18 ±  4%      -0.0        0.14 ± 22% 
>> perf-profile.self.cycles-pp.pick_next_task_fair
>>        0.09 ± 13%      -0.0        0.04 ± 73% 
>> perf-profile.self.cycles-pp.verify_parent_transid
>>        0.09 ± 12%      -0.0        0.04 ± 71% 
>> perf-profile.self.cycles-pp.btrfs_tree_read_unlock_blocking
>>        0.16 ± 13%      -0.0        0.12 ± 24% 
>> perf-profile.self.cycles-pp.mark_page_accessed
>>        0.12 ± 14%      -0.0        0.08 ± 20% 
>> perf-profile.self.cycles-pp.dequeue_task_fair
>>        0.10 ± 19%      -0.0        0.07 ± 18% 
>> perf-profile.self.cycles-pp.entry_SYSCALL_64
>>        0.08 ± 14%      -0.0        0.04 ± 73% 
>> perf-profile.self.cycles-pp.unlock_up
>>        0.15 ± 15%      -0.0        0.11 ± 19% 
>> perf-profile.self.cycles-pp.xas_find_marked
>>        0.24 ±  6%      -0.0        0.20 ±  8% 
>> perf-profile.self.cycles-pp.btrfs_root_node
>>        0.17 ±  6%      -0.0        0.13 ± 10% 
>> perf-profile.self.cycles-pp._raw_read_lock
>>        0.10 ± 13%      -0.0        0.06 ± 14% 
>> perf-profile.self.cycles-pp.btrfs_csum_one_bio
>>        0.16 ±  7%      -0.0        0.13 ±  9% 
>> perf-profile.self.cycles-pp.dequeue_entity
>>        0.07            -0.0        0.04 ± 71% 
>> perf-profile.self.cycles-pp.io_u_queued_complete
>>        0.08            -0.0        0.05 ± 70% 
>> perf-profile.self.cycles-pp.mutex_lock
>>        0.11 ± 11%      -0.0        0.08 ± 12% 
>> perf-profile.self.cycles-pp.get_io_u
>>        0.16 ±  9%      -0.0        0.13       
>> perf-profile.self.cycles-pp._raw_write_lock
>>        0.07 ± 17%      -0.0        0.04 ± 73% 
>> perf-profile.self.cycles-pp.btrfs_tree_read_lock
>>        0.12 ±  8%      -0.0        0.09 ± 13% 
>> perf-profile.self.cycles-pp.__switch_to
>>        0.10 ± 11%      -0.0        0.06 ± 14% 
>> perf-profile.self.cycles-pp.__clear_extent_bit
>>        0.07 ± 12%      -0.0        0.04 ± 71% 
>> perf-profile.self.cycles-pp.rb_prev
>>        0.10 ± 15%      -0.0        0.07 ± 23% 
>> perf-profile.self.cycles-pp.find_get_pages_range_tag
>>        0.10 ± 12%      -0.0        0.07 ± 23% 
>> perf-profile.self.cycles-pp.available_idle_cpu
>>        0.10 ± 11%      -0.0        0.07 ±  7% 
>> perf-profile.self.cycles-pp.__list_add_valid
>>        0.08 ± 13%      -0.0        0.06 ±  8% 
>> perf-profile.self.cycles-pp.__might_sleep
>>        0.12 ± 17%      -0.0        0.09 ± 15% 
>> perf-profile.self.cycles-pp.release_extent_buffer
>>        0.09 ± 17%      -0.0        0.07 ± 14% 
>> perf-profile.self.cycles-pp.___perf_sw_event
>>        0.08 ±  5%      -0.0        0.06 ± 13% 
>> perf-profile.self.cycles-pp.__push_leaf_right
>>        0.11 ±  7%      -0.0        0.09 ±  9% 
>> perf-profile.self.cycles-pp.set_extent_buffer_dirty
>>        0.11 ±  4%      -0.0        0.08 ± 11% 
>> perf-profile.self.cycles-pp.__set_extent_bit
>>        0.09 ±  7%      +0.0        0.11 ±  4% 
>> perf-profile.self.cycles-pp.hrtimer_interrupt
>>        0.07 ± 17%      +0.0        0.09 ±  5% 
>> perf-profile.self.cycles-pp.run_posix_cpu_timers
>>        0.07 ±  7%      +0.0        0.09 ±  5% 
>> perf-profile.self.cycles-pp.load_balance
>>        0.01 ±173%      +0.1        0.07 ± 17% 
>> perf-profile.self.cycles-pp.lapic_next_deadline
>>        0.00            +0.1        0.06 ± 23% 
>> perf-profile.self.cycles-pp.find_next_and_bit
>>        0.19 ± 11%      +0.1        0.26 ± 17% 
>> perf-profile.self.cycles-pp.native_irq_return_iret
>>        0.19 ± 24%      +0.1        0.28 ±  7% 
>> perf-profile.self.cycles-pp.rcu_sched_clock_irq
>>        0.50 ±  8%      +0.2        0.69 ± 17% 
>> perf-profile.self.cycles-pp.cpuidle_enter_state
>>        0.07 ± 11%      +0.4        0.46 ± 17% 
>> perf-profile.self.cycles-pp.btrfs_get_token_8
>>        0.22 ± 13%      +0.4        0.66 ± 16% 
>> perf-profile.self.cycles-pp.read_extent_buffer
>>        0.00            +0.6        0.65 ± 14% 
>> perf-profile.self.cycles-pp.check_leaf
>>        0.15 ± 11%      +1.0        1.13 ± 11% 
>> perf-profile.self.cycles-pp.btrfs_get_token_64
>>        1.48 ±  7%      +1.0        2.51 ±  5% 
>> perf-profile.self.cycles-pp.btrfs_get_token_32
>>        0.41 ±  8%      +2.2        2.61 ±  9% 
>> perf-profile.self.cycles-pp.map_private_extent_buffer
>>       49.99 ±  2%      +3.7       53.74 ±  4% 
>> perf-profile.self.cycles-pp.intel_idle
>>
>>
>>                                                                                 
>>                                   fio.write_bw_MBps
>>                                                                                 
>>    300
>> +-+-------------------------------------------------------------------+
>>       
>> |                                                                     |
>>    250 +-++.+     +.  .+..    .+..+..+.+..               .+..+..
>> .+          |
>>        |    :     : +.    +..+            +    +..+    +.      
>> +            |
>>        |     :    :                       :    :  :   
>> :                     |
>>    200 +-+   :   :                         :   :   :   :  O 
>> O               |
>>        O  O O: O :O O  O  O  O O  O  O O  O: O:O  O: O:         O
>> O     O O  O
>>    150 +-+   :   :                         :  :    : 
>> :                      |
>>        |      :  :                         :  :    : 
>> :                      |
>>    100 +-+    : :                           : :     :
>> :                      |
>>        |      : :                           : :     :
>> :                      |
>>        |      : :                           : :     :
>> :                      |
>>     50 +-+     ::                           ::     
>> ::                       |
>>        |       :                             :      
>> :                       |
>>      0
>> +-+---------------------------------------------O-------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                     fio.write_iops
>>                                                                                 
>>    70000
>> +-+-----------------------------------------------------------------+
>>          |..+.+    +..+..+.+..  .+.+..+.+..+    +..    
>> +..+.+..+..+         |
>>    60000 +-+  :    :          +.           :    :  +   
>> :                    |
>>          |    :    :                       :    :  :   
>> :                    |
>>    50000 +-+   :   :                        :   :  :  
>> :                     |
>>          O  O O:  :O  O  O O  O  O O  O O  O: O:O  O:O :   O O  O 
>> O    O O  O
>>    40000 +-+   : O:                         :  :    : 
>> :                     |
>>          |     :  :                         :  :    : 
>> :                     |
>>    30000 +-+    : :                          : :    :
>> :                      |
>>          |      : :                          : :    :
>> :                      |
>>    20000 +-+    : :                          : :    :
>> :                      |
>>          |      ::                           ::     
>> ::                      |
>>    10000 +-+     :                            :     
>> :                       |
>>          |       :                            :     
>> :                       |
>>        0
>> +-+--------------------------------------------O------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                 fio.write_clat_mean_us
>>                                                                                 
>>    30000
>> +-+-----------------------------------------------------------------+
>>         
>> |                                                                   |
>>    25000 O-+O O  O O  O  O O  O  O O  O O  O  O O  O O            
>> O      O  |
>>          |                                                 O O 
>> O       O    O
>>         
>> |                                                                   |
>>    20000
>> +-+                                                                 |
>>          |..+.+    +..+..+.+..+..+.+..+.+..+    +..+   
>> +..+.+..+..+         |
>>    15000 +-+  :    :                       :    :  :   
>> :                    |
>>          |     :   :                        :   :   : 
>> :                     |
>>    10000 +-+   :  :                         :  :    : 
>> :                     |
>>          |      : :                          : :    : 
>> :                     |
>>          |      : :                          : :    :
>> :                      |
>>     5000 +-+    : :                          : :    
>> ::                      |
>>          |       :                            :     
>> :                       |
>>        0
>> +-+--------------------------------------------O------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                  fio.write_clat_stddev
>>                                                                                 
>>    160000
>> +-+----------------------------------------------------------------+
>>          
>> |                                                                  |
>>    140000 O-+O O  O O  O O  O  O O    O     O O  O
>> O                         |
>>    120000 +-+                       O   
>> O                                   |
>>          
>> |                                                                  |
>>    100000 +-+                                         O    O  O O 
>> O    O O  O
>>          
>> |                                                                  |
>>     80000
>> +-+                                                                |
>>           |               
>> .+..                                              |
>>     60000 +-++.+    +..+.+.    +.+..+.+..+..+    +.+   
>> +..+..+.+..+         |
>>     40000 +-+   :   :                       :   :   :  
>> :                    |
>>           |     :  :                         :  :   : 
>> :                     |
>>     20000 +-+    : :                         : :     :
>> :                     |
>>           |      ::                           ::    
>> ::                      |
>>         0
>> +-+-------------------------------------------O------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                fio.write_slat_mean_us
>>                                                                                 
>>    900
>> +-+-------------------------------------------------------------------+
>>        O    O  O  O O  O  O  O O  O  O O  O  O O  O              
>> O       O  |
>>    800 +-+O                                          O    O  O 
>> O       O    O
>>    700
>> +-+                                                                   |
>>       
>> |                                                                     |
>>    600 +-++.+     +.+..+..+..+.+..+..+.+..+    +..+   
>> +..+..+..+.+          |
>>    500 +-+  :     :                       :    :  :   
>> :                     |
>>        |     :   :                         :   :   :  
>> :                     |
>>    400 +-+   :   :                         :  :    : 
>> :                      |
>>    300 +-+   :   :                         :  :    : 
>> :                      |
>>        |      : :                           : :     :
>> :                      |
>>    200 +-+    : :                           : :     :
>> :                      |
>>    100 +-+    : :                           ::     
>> ::                       |
>>        |       :                             :      
>> :                       |
>>      0
>> +-+---------------------------------------------O-------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                  fio.write_slat_stddev
>>                                                                                 
>>    25000
>> +-+-----O---------O-------------------------------------------------+
>>          O  O O    O  O  O    O  O O  O O  O  O O 
>> O                         |
>>         
>> |                                                                   |
>>    20000
>> +-+                                                                 |
>>          |                                           O     O O  O 
>> O    O O  O
>>         
>> |                                                                   |
>>    15000
>> +-+                                                                 |
>>         
>> |                                                                   |
>>    10000 +-++.            .+..    .+.. .+..+      .+          
>> .+..+         |
>>          |.   +    +..+..+    +..+    +     :   +. :   
>> +..+.+.              |
>>          |     :   :                        :   :   : 
>> :                     |
>>     5000 +-+   :  :                          : :    : 
>> :                     |
>>          |      : :                          : :    :
>> :                      |
>>          |      ::                            :     
>> ::                      |
>>        0
>> +-+--------------------------------------------O------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                  fio.latency_1000ms_
>>                                                                                 
>>     0.4
>> +-+------------------------------------------------------------------+
>>        
>> |                                                                    |
>>    0.35
>> +-+                                                               O  |
>>     0.3
>> +-+                                                                  |
>>         |                                            O           
>> O          |
>>    0.25 +-+                                              
>> O             O    |
>>         |                            O                         
>> O            O
>>     0.2 O-+  O  O  O       O O     O    O    O    O         
>> O               |
>>         |                                  O   
>> O                            |
>>    0.15 +-+O         O  O      
>> O                                            |
>>     0.1
>> +-+                                                                  |
>>        
>> |                                                                    |
>>    0.05
>> +-+                                                                  |
>>         | .+.               .+..+..+.+..+..    .+.    
>> .+.+..+..             |
>>       0
>> +-+---------------------------------------------O------------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                                       fio.workload
>>                                                                                 
>>    1.4e+07
>> +-+---------------------------------------------------------------+
>>            |..+.+    +..+.+..+.+..+.+..+.+..+    +..    
>> +.+..+.+..+         |
>>    1.2e+07 +-+  :    :                      :    :  +   
>> :                   |
>>            |    :    :                      :    :  :   
>> :                   |
>>      1e+07 +-+   :   :                       :   :  :  
>> :                    |
>>            O  O O:  :O  O O  O O  O O  O O  O: O:O  O:O :  O  O O 
>> O    O O  O
>>      8e+06 +-+   : O:                        :  :    : 
>> :                    |
>>            |     :  :                        :  :    : 
>> :                    |
>>      6e+06 +-+    : :                         : :    :
>> :                     |
>>            |      : :                         : :    :
>> :                     |
>>      4e+06 +-+    : :                         : :    :
>> :                     |
>>            |      ::                          ::     
>> ::                     |
>>      2e+06 +-+     :                           :     
>> :                      |
>>            |       :                           :     
>> :                      |
>>          0
>> +-+-------------------------------------------O-----------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                            fio.time.voluntary_context_switches
>>                                                                                 
>>    1.4e+07
>> +-+---------------------------------------------------------------+
>>           
>> |                                                                 |
>>    1.2e+07 +-++.+    +..+.+..+.+..+.+..+.+..+    +..+   
>> +.+..+.+..+         |
>>            |    :    :                      :    :  :   
>> :                   |
>>      1e+07 +-+   :   :                       :   :  :   
>> :                   |
>>            |  O O:   :  O           O    O   :   :   :O :  O  O O 
>> O    O O  O
>>      8e+06 O-+   : O:O    O  O O  O    O    O: O:O  O: 
>> :                    |
>>            |     :  :                        :  :    : 
>> :                    |
>>      6e+06 +-+    : :                         : :    : 
>> :                    |
>>            |      : :                         : :    :
>> :                     |
>>      4e+06 +-+    : :                         : :    :
>> :                     |
>>            |      : :                         : :    
>> ::                     |
>>      2e+06 +-+     :                           :     
>> ::                     |
>>            |       :                           :     
>> :                      |
>>          0
>> +-+-------------------------------------------O-----------O-------+
>>                                                                                 
>>                                                                                                                                                                 
>>                               fio.time.file_system_outputs
>>                                                                                 
>>    1.2e+08
>> +-+---------------------------------------------------------------+
>>           
>> |                                                                 |
>>      1e+08 +-++.+    +..+.+..+.+..+.+..+.+..+    +..+   
>> +.+..+.+..+         |
>>            |    :    :                      :    :  :   
>> :                   |
>>            |     :   :                       :   :  :   
>> :                   |
>>      8e+07 +-+   :   :                       :   :   :  :  O  O
>> O       O    O
>>            O  O O: O:O  O O  O O  O O  O O  O: O:O  O:O :         
>> O      O  |
>>      6e+07 +-+   :  :                        :  :    : 
>> :                    |
>>            |      : :                         : :    : 
>> :                    |
>>      4e+07 +-+    : :                         : :    :
>> :                     |
>>            |      : :                         : :    :
>> :                     |
>>            |      : :                         : :    
>> ::                     |
>>      2e+07 +-+     :                           :     
>> ::                     |
>>            |       :                           :     
>> :                      |
>>          0
>> +-+-------------------------------------------O-----------O-------+
>>                                                                                 
>>                                                                                 
>> [*] bisect-good sample
>> [O] bisect-bad  sample
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are
>> provided
>> for informational purposes only. Any difference in system hardware or
>> software
>> design or configuration may affect actual performance.
>>
>>
>> Thanks,
>> Rong Chen
>>
>>
>> _______________________________________________
>> LKP mailing list
>> LKP@lists.01.org
>> https://lists.01.org/mailman/listinfo/lkp
>>
> 
