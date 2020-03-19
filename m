Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5805C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDD1206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="N8bRM5WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCSUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:20:18 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:64520 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCSUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:20:18 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JJvWmY005413;
        Thu, 19 Mar 2020 20:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=vcoVV5JZDKmvqtdXib7x9PtKyr3DrqbfvkgBQl4CUmM=;
 b=N8bRM5WVj3wEi/idtGhawGcIzsKoCggIf1yI2kHnqho19Ml7q/9yskTrm/jY3Ew3obQd
 UEcWStfXcnxnaxAoCLpWkD8VSJBjU7SAvz1ok1y0cGCEqZqMcy+4wqyUNc8e2DC2OFzq
 H2pGl5v2lar5RRwETgYt8ZPyaDWLYA6I5lMtzxe8E6LGPNw4JZDr/DHCvh6PN6iSn5iI
 dV4K817QtQ6jSrpBh8Oce/JINbqMFZwOghYlkkL4WZ99BBbveK3sgK47XZae6owKOab9
 jNzLENfQQVAl5A8S+jC0wMrz3dyDcAXQEBxeNs2dRLwx5/w34HPyU7IrtjbWYxInQOtk NA== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2yum0s660m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 20:19:52 +0000
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02JKII94030105;
        Thu, 19 Mar 2020 16:19:51 -0400
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2yrtkwmhha-1;
        Thu, 19 Mar 2020 16:19:51 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id F240122020;
        Thu, 19 Mar 2020 20:19:49 +0000 (GMT)
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of
 DYNAMIC_DEBUG_CORE
To:     Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
 <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
 <20200319152820.GA2793@lenovo>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <d8474138-6f8f-8a99-351d-5e5b37999373@akamai.com>
Date:   Thu, 19 Mar 2020 16:19:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200319152820.GA2793@lenovo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_08:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003190084
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_08:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 11:28 AM, Orson Zhai wrote:
> Hi Jason,
> 
> On Wed, Mar 18, 2020 at 05:18:43PM -0400, Jason Baron wrote:
>>
>>
>> On 3/18/20 3:03 PM, Orson Zhai wrote:
>>> There is the requirement from new Android that kernel image (GKI) and
>>> kernel modules are supposed to be built at differnet places. Some people
>>> want to enable dynamic debug for kernel modules only but not for kernel
>>> image itself with the consideration of binary size increased or more
>>> memory being used.
>>>
>>> By this patch, dynamic debug is divided into core part (the defination of
>>> functions) and macro replacement part. We can only have the core part to
>>> be built-in and do not have to activate the debug output from kenrel image.
>>>
>>> Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
>>
>> Hi Orson,
>>
>> I think this is a nice feature. Is the idea then that driver can do
>> something like:
>>
>> #if defined(CONFIG_DRIVER_FOO_DEBUG)
>> #define driver_foo_debug(fmt, ...) \
>>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>> #else
>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>> #enif
>>
>> And then the Kconfig:
>>
>> config DYNAMIC_DRIVER_FOO_DEBUG
>> 	bool "Enable dynamic driver foo printk() support"
>> 	select DYNAMIC_DEBUG_CORE
>>
> I highly appreciate you for giving this good example to us.
> To be honest I did not really think of this kind of usage. :)
> But it makes much sense. I think dynamic debug might be a little
> bit high for requirement of memory. Every line of pr_debug will be
> added with a static data structure and malloc with an item in link table.
> It might be sensitive especially in embeded system.
> So this example shows how to avoid to turn on dynamci debug for whole
> system but part of it when being needed.
> 
>>
>> Or did you have something else in mind? Do you have an example
>> code for the drivers that you mention?
> 
> My motivation comes from new Andorid GKI release flow. Android kernel team will
> be in charge of GKI release. And SoC vendors will build their device driver as
> kernel modules which are diffrent from each vendor. End-users will get their phones
> installed with GKI plus some modules all together.
> 
> So at Google side, they can only set DYNAMIC_DEBUG_CORE in their defconfig to build
> out GKI without worrying about the kernel image size increased too much. Actually
> GKI is relatively stable as a common binary and there is no strong reason to do 
> dynamic debugging to it.
> 
> And at vendor side, they will use a local defconfig which is same with Google one but add 
> CONFIG_DYNAMIC_DEBUG to build their kenrel modules. As DYNAMIC_DEBUG enables only a
> set of macro expansion, so it has no impact to kernel ABI or the modversion.
> All modules will be compatible with GKI and with dynamic debug enabled.
> 
> Then the result will be that Google has his clean GKI and vendors have their dynamic-debug-powered modules.
>


static int __init dynamic_debug_init(void)
{
        struct _ddebug *iter, *iter_start;
        const char *modname = NULL;
        char *cmdline;
        int ret = 0;
        int n = 0, entries = 0, modct = 0;
        int verbose_bytes = 0;

        if (__start___verbose == __stop___verbose) {
                pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
                return 1;
        }

...

I wonder if we should just remove it now.

Thanks,

-Jason

