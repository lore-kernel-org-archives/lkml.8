Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC802C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481B207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s5SzNWR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHEAbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:31:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEAbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:31:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0750M93U066420;
        Wed, 5 Aug 2020 00:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9AdcsLD0nSJADXeg1XTW4GS8eL5KgzIeRdCrCpLs5/E=;
 b=s5SzNWR8g0cy+yImOmARgFEXfcV/n4rhE8DFpc3q67ew+vrqSlCj8olDYDX1xzLLd3+p
 7aZiCKQS6EJ0wj3S7v1AbFrgZ4orHzU1UT5YNw3dIlEdyDa3ZFbSXscuKteSAyNvBwE3
 ILCW1G/xRwSktNH9QASVnoyFeCuu50iQvHTtpF/FgU78s7Ccx55euX/E//xufgiJWSvs
 njmHjTwNRELBPrZ/Gl3o2nUYAE9wSRFv40JngteB4k9sh5+IchgnF7MuUlN4caADQRD8
 f6Pxodj31f7C7jS1LkB5t1FiEHoHuL02XLPu/5d/sov9DbRT57nJ5oE4NYhCm5mDcTCr 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32n11n77ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 00:31:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0750SrKt043949;
        Wed, 5 Aug 2020 00:31:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnrqtm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 00:31:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0750VBg0026676;
        Wed, 5 Aug 2020 00:31:11 GMT
Received: from dhcp-10-159-241-148.vpn.oracle.com (/10.159.241.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 17:31:10 -0700
Subject: Re: [md] e1a86dbbbd:
 mdadm-selftests.enchmarks/mdadm-selftests/tests/07layouts.fail
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        kernel test robot <rong.a.chen@intel.com>
References: <20200729090451.GK23458@shao2-debian>
 <C6E82A56-754C-4FA3-A15B-6A6F80A9457D@fb.com>
 <05662f78-f442-5f1d-4423-bd206a2e8fd8@oracle.com>
Message-ID: <c83149ba-eb06-d24c-95c3-e7bbd3328156@oracle.com>
Date:   Tue, 4 Aug 2020 17:30:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <05662f78-f442-5f1d-4423-bd206a2e8fd8@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=4 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue had been fixed. I send the following patch in another thread. 
Please take a look. Thank you.

[PATCH] md: get sysfs entry after redundancy attr group create

Thanks,

Junxiao.

On 8/3/20 9:00 AM, Junxiao Bi wrote:
> Hi Song,
>
> I am working on setup an env to reproduce, will update soon.
>
> Thanks,
>
> Junxiao.
>
> On 8/2/20 10:52 PM, Song Liu wrote:
>>
>>> On Jul 29, 2020, at 2:04 AM, kernel test robot 
>>> <rong.a.chen@intel.com> wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: e1a86dbbbd6a77f73c3d099030495fa31f181e2f ("md: fix deadlock 
>>> causing by sysfs_notify")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>>
>>> in testcase: mdadm-selftests
>>> with following parameters:
>>>
>>>     disk: 1HDD
>>>     test_prefix: 07layout
>>>     ucode: 0x21
>>>
>>>
>>>
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz 
>>> with 4G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire 
>>> log/backtrace):
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>
>>>
>>>
>>> 2020-07-29 01:06:34 mkdir -p /var/tmp
>>> 2020-07-29 01:06:34 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sda3
>>> 2020-07-29 01:07:36 mount -t ext3 /dev/sda3 /var/tmp
>>> sed -e 's/{DEFAULT_METADATA}/1.2/g' \
>>> -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
>>> /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
>>> /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
>>> /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
>>> /usr/bin/install -D -m 644 mdadm.conf.5 
>>> /usr/share/man/man5/mdadm.conf.5
>>> /usr/bin/install -D -m 644 udev-md-raid-creating.rules 
>>> /lib/udev/rules.d/01-md-raid-creating.rules
>>> /usr/bin/install -D -m 644 udev-md-raid-arrays.rules 
>>> /lib/udev/rules.d/63-md-raid-arrays.rules
>>> /usr/bin/install -D -m 644 udev-md-raid-assembly.rules 
>>> /lib/udev/rules.d/64-md-raid-assembly.rules
>>> /usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules 
>>> /lib/udev/rules.d/69-md-clustered-confirm-device.rules
>>> /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
>>> /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
>>> Testing on linux-5.8.0-rc4-00129-ge1a86dbbbd6a7 kernel
>>> /lkp/benchmarks/mdadm-selftests/tests/07layouts... FAILED - see 
>>> /var/tmp/07layouts.log and /var/tmp/fail07layouts.log for details
>>> 07layouts TIMEOUT
>>>
>>>
>>>
>>> To reproduce:
>>>
>>>         git clone https://github.com/intel/lkp-tests.git
>>>         cd lkp-tests
>>>         bin/lkp install job.yaml  # job file is attached in this email
>>>         bin/lkp run     job.yaml
>>>
>>>
>>>
>>> Thanks,
>>> Rong Chen
>>>
>>> <config-5.8.0-rc4-00129-ge1a86dbbbd6a7><job-script.txt><kmsg.xz><mdadm-selftests.txt><job.yaml><reproduce.txt><07layouts.log> 
>>>
>> Hi Junxiao,
>>
>> Could you please look into this issue?
>>
>> Thanks,
>> Song
>>
