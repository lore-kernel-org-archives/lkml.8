Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C7C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A8820772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="K0uRFHxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCRVT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:19:28 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:56564 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgCRVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:19:28 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IL3qoi008087;
        Wed, 18 Mar 2020 21:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=4f9r9PkNTcv0nmoy8ud0muS6lvAJRtaiv+QarXWwcsI=;
 b=K0uRFHxoQb88Djyvmm0jAb6WYlJUBooKczPpBmfs60Jn796QZDL3UsGADkBOeau3TfhP
 0d/0ALSNP4NBOVMi48vR3DkFbkHqQy4QvwS0ik8xRZjc2YOx2OpwOiMuCKha6ktLz5iV
 Mpg/8n5sTK6jDu+aZGPCwKVyVuaxZ0R6zfivHt6GP5dmYX5GnkmPbn3+NXQUNlC8Ejqh
 ab8W/1YJgIs8CqmC5FcpYiFf8chYhbzIo1MfgAY7mnOJZKekvU3ygAFD6hd5P6h3azyn
 4axm5BVGUFaDjRjD4IgJuwHpnxxQUNT6ZIEPO8OnqMVt7K9JW3PQr1p03bdxxDlhdZ6f pg== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2ys8nhgj9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 21:18:45 +0000
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02ILHbub023256;
        Wed, 18 Mar 2020 17:18:44 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com with ESMTP id 2yrtkvbvp4-1;
        Wed, 18 Mar 2020 17:18:44 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id D052D21B0F;
        Wed, 18 Mar 2020 21:18:43 +0000 (GMT)
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of
 DYNAMIC_DEBUG_CORE
To:     Orson Zhai <orson.unisoc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     orsonzhai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
Date:   Wed, 18 Mar 2020 17:18:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003180091
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 3:03 PM, Orson Zhai wrote:
> There is the requirement from new Android that kernel image (GKI) and
> kernel modules are supposed to be built at differnet places. Some people
> want to enable dynamic debug for kernel modules only but not for kernel
> image itself with the consideration of binary size increased or more
> memory being used.
> 
> By this patch, dynamic debug is divided into core part (the defination of
> functions) and macro replacement part. We can only have the core part to
> be built-in and do not have to activate the debug output from kenrel image.
> 
> Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>

Hi Orson,

I think this is a nice feature. Is the idea then that driver can do
something like:

#if defined(CONFIG_DRIVER_FOO_DEBUG)
#define driver_foo_debug(fmt, ...) \
        dynamic_pr_debug(fmt, ##__VA_ARGS__)
#else
	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#enif

And then the Kconfig:

config DYNAMIC_DRIVER_FOO_DEBUG
	bool "Enable dynamic driver foo printk() support"
	select DYNAMIC_DEBUG_CORE


Or did you have something else in mind? Do you have an example
code for the drivers that you mention?

Thanks,

-Jason


> ---
>  include/linux/dynamic_debug.h |  2 +-
>  lib/Kconfig.debug             | 18 ++++++++++++++++--
>  lib/Makefile                  |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 4cf02ec..abcd5fd 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -48,7 +48,7 @@ struct _ddebug {
>  
>  
>  
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>  				const char *modname);
>  extern int ddebug_remove_module(const char *mod_name);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a..78a7256 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -97,8 +97,7 @@ config BOOT_PRINTK_DELAY
>  config DYNAMIC_DEBUG
>  	bool "Enable dynamic printk() support"
>  	default n
> -	depends on PRINTK
> -	depends on DEBUG_FS
> +	select DYNAMIC_DEBUG_CORE
>  	help
>  
>  	  Compiles debug level messages into the kernel, which would not
> @@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
>  	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>  	  information.
>  
> +config DYNAMIC_DEBUG_CORE
> +	bool "Enable core functions of dynamic debug support"
> +	depends on PRINTK
> +	depends on DEBUG_FS
> +	help
> +	  Enable this option to build ddebug_* and __dynamic_* routines
> +	  into kernel. If you want enable whole dynamic debug features,
> +	  select CONFIG_DYNAMIC_DEBUG directly and this option will be
> +	  automatically selected.
> +
> +	  This option is selected when you want to enable dynamic debug
> +	  for kernel modules only but not for the kernel base. Especailly
> +	  in the case that kernel modules are built out of the place where
> +	  kernel base is built.
> +
>  config SYMBOLIC_ERRNAME
>  	bool "Support symbolic error names in printf"
>  	default y if PRINTK
> diff --git a/lib/Makefile b/lib/Makefile
> index 611872c..2096d83 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
>  
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>  
> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
>  
>  obj-$(CONFIG_NLATTR) += nlattr.o
> 
