Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686CC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF212074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="nVJOvT5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgD0VL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:11:29 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:56224 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgD0VL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:11:28 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RL7rsK008252;
        Mon, 27 Apr 2020 22:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=glXRrzgKjAA690iUFHISrp+8fpIWzrITGXY9K/qA7Zk=;
 b=nVJOvT5fW10rHtROjulKkuoLqFesIkvhZbAV8NlXTo/6E/62DaIXBF+udwyLvgfUVZ+Y
 i+s5kxxuzf7T4cgXWBxIdSHLc/w7yq9Mvm8fErA/phO3x857Fmq12D9magj+O8FcCPss
 spXR+RHmVdkXXAl7vArO/BiJCKU7TbvBBRkiy3TlOeMgZrJx57E107JGQ2A4/8AZ6God
 0+/FmkDYmNjX+j0XL+3qG8YMhSFEO52OwHua5ktJeyIbwigBu64vmoAYFoNkS6LtJGZI
 dDz+bRDwbfOksAfZyMCbma1gMez/Hak03EHjnScKXNOacgPQtP7WFaMp0KxIx/3d9C68 aQ== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 30md8j9puj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 22:10:21 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 03RL2v2g030460;
        Mon, 27 Apr 2020 17:10:20 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com with ESMTP id 30mghv967e-1;
        Mon, 27 Apr 2020 17:10:20 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id F1E0F21B53;
        Mon, 27 Apr 2020 21:10:19 +0000 (GMT)
Subject: Re: [PATCH] md/raid0: add config parameters to specify zone layout
To:     Coly Li <colyli@suse.de>, songliubraving@fb.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
References: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
 <0b7aad8b-f0b7-24c6-ad19-99c6202a3036@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <8feb2018-7f99-6e02-c704-9d7fed40bba2@akamai.com>
Date:   Mon, 27 Apr 2020 17:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b7aad8b-f0b7-24c6-ad19-99c6202a3036@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_16:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2004270172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_16:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/20 12:31 AM, Coly Li wrote:
> On 2020/3/26 23:28, Jason Baron wrote:
>> Let's add some CONFIG_* options to directly configure the raid0 layout
>> if you know in advance how your raid0 array was created. This can be
>> simpler than having to manage module or kernel command-line parameters.
>>
> 
> Hi Jason,
> 
> If the people who compiling the kernel is not the end users, the
> communication gap has potential risk to make users to use a different
> layout for existing raid0 array after a kernel upgrade.
> 
> If this patch goes into upstream, it is very probably such risky
> situation may happen.
> 
> The purpose of adding default_layout is to let *end user* to be aware of
> they layout when they use difference sizes component disks to assemble
> the raid0 array, and make decision which layout algorithm should be
> used. Such situation cannot be decided in kernel compiling time.

I agree that in general it may not be known at compile time. Thus,
I've left the default as RAID0_LAYOUT_NONE. However, there are
use-cases where it is known at compile-time which layout is needed.
In our use-case, we knew that we didn't have any pre-3.14 raid0
arrays. Thus, we can safely set RAID0_ALT_MULTIZONE_LAYOUT. So
this is a simpler configuration for us than setting module or command
line parameters.

Thanks,

-Jason

> 
>> If the raid0 array was created by a pre-3.14 kernel, use
>> RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
>> kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
>> setting is RAID0_LAYOUT_NONE, in which case the current behavior of
>> needing to specify a module parameter raid0.default_layout=1|2 is
>> preserved.
>>
> 
> The difficulty is for a given md raid0 array, there is no clue whether
> it is built on pre-3.14 kernel or not. If the kernel is not configured
> and built by end user, we have risk that wrong algorithm will be applied
> to unmatched layout.
>> Thanks.
> 
> Coly Li
> 
> 
>> Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> ---
>>  drivers/md/Kconfig | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/md/raid0.c |  7 +++++++
>>  2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index d6d5ab2..c0c6d82 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -79,6 +79,61 @@ config MD_RAID0
>>  
>>  	  If unsure, say Y.
>>  
>> +choice
>> +	prompt "RAID0 Layout"
>> +	default RAID0_LAYOUT_NONE
>> +	depends on MD_RAID0
>> +	help
>> +	  A change was made in Linux 3.14 that unintentinally changed the
>> +	  the layout for RAID0. This can result in data corruption if a pre-3.14
>> +	  and a 3.14 or later kernel both wrote to the array. However, if the
>> +	  devices in the array are all of the same size then the layout would
>> +	  have been unaffected by this change, and there is no risk of data
>> +	  corruption from this issue.
>> +
>> +	  Unfortunately, the layout can not be determined by the kernel. If the
>> +	  array has only been written to by a 3.14 or later kernel its safe to
>> +	  set RAID0_ALT_MULTIZONE_LAYOUT. If its only been written to by a
>> +	  pre-3.14 kernel its safe to select RAID0_ORIG_LAYOUT. If its been
>> +	  written by both then select RAID0_LAYOUT_NONE, which will not
>> +	  configure the array. The array can then be examined for corruption.
>> +
>> +	  For new arrays you may choose either layout version. Neither version
>> +	  is inherently better than the other.
>> +
>> +	  Alternatively, these parameters can also be specified via the module
>> +	  parameter raid0.default_layout=<N>. N=2 selects the 'new' or multizone
>> +	  layout, while N=1 selects the 'old' layout or original layout. If
>> +	  unset the array will not be configured.
>> +
>> +	  The layout can also be written directly to the raid0 array via the
>> +	  mdadm command, which can be auto-detected by the kernel. See:
>> +	  <https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration>
>> +
>> +config RAID0_ORIG_LAYOUT
>> +	bool "raid0 layout for arrays only written to by a pre-3.14 kernel"
>> +	help
>> +	  If the raid0 array was only created and written to by a pre-3.14 kernel.
>> +
>> +config RAID0_ALT_MULTIZONE_LAYOUT
>> +	bool "raid0 layout for arrays only written to be a 3.14 or newer kernel"
>> +	help
>> +	  If the raid0 array was only created and written to by a 3.14 or later
>> +	  kernel.
>> +
>> +config RAID0_LAYOUT_NONE
>> +	bool "raid0 layout must be specified via a module parameter"
>> +	help
>> +	  If a raid0 array was written to by both a pre-3.14 and a 3.14 or
>> +	  later kernel, you may have data corruption. This option will not
>> +	  auto configure the array and thus you can examine the array offline
>> +	  to determine the best way to proceed. With RAID0_LAYOUT_NONE
>> +	  set, the choice for raid0 layout can be set via a module parameter
>> +	  raid0.default_layout=<N>. Or the layout can be written directly
>> +	  to the raid0 array via the mdadm command.
>> +
>> +endchoice
>> +
>>  config MD_RAID1
>>  	tristate "RAID-1 (mirroring) mode"
>>  	depends on BLK_DEV_MD
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index 322386f..576eaa6 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -19,7 +19,14 @@
>>  #include "raid0.h"
>>  #include "raid5.h"
>>  
>> +#if defined(CONFIG_RAID0_ORIG_LAYOUT)
>> +static int default_layout = RAID0_ORIG_LAYOUT;
>> +#elif defined(CONFIG_RAID0_ALT_MULTIZONE_LAYOUT)
>> +static int default_layout = RAID0_ALT_MULTIZONE_LAYOUT;
>> +#else
>>  static int default_layout = 0;
>> +#endif
>> +
>>  module_param(default_layout, int, 0644);
>>  
>>  #define UNSUPPORTED_MDDEV_FLAGS		\
>>
> 
