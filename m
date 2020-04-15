Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D761A206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YL3uRS+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbgDOTWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404530AbgDOTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:22:13 -0400
X-Greylist: delayed 1982 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 12:22:13 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F2C061A0C;
        Wed, 15 Apr 2020 12:22:13 -0700 (PDT)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FIjCqU031913;
        Wed, 15 Apr 2020 19:48:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=tfyP2ECHbQ/s8AdsIIJTVPSDSgqkPyqgIBBNn+vOaxw=;
 b=YL3uRS+Q2qBGD5xObjq88ehkxHFw9cD4U8USFQelymXpj5jQ5Dh7orOz0LwGPm/fBrSz
 PU6Mg+wdaP7dNu+Bc1rl1MbpddEMRQLich7K2vDVJztHYiHPJm8Uja2SLeQQ5IlcSZTH
 myvyRgq4VIqYLQSJXFAu0e5+xJcyqKWu1FYBrwBN/ID3PSWtgcMSlBNnmVO7eov6kAB7
 WkSadNfgQ2t/r7u/2TsPGVUsCnpJT7h9NclU3c8ruTvihZyXEKoAYj4ZovOOj73U7BHx
 uocbp5e3AEYFUrHNCbVhnlovCkynzn24BrBIaQGKiETZGYEBsnS2S221CZ4RjTVgRMnl IA== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 30bphp4e54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 19:48:18 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 03FIm6vw018854;
        Wed, 15 Apr 2020 11:48:17 -0700
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint5.akamai.com with ESMTP id 30bbv92brf-1;
        Wed, 15 Apr 2020 11:48:16 -0700
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 7866C39375;
        Wed, 15 Apr 2020 18:48:16 +0000 (GMT)
Subject: Re: [PATCH] dynamic_debug: Add an option to enable dynamic debug for
 modules only
To:     Orson Zhai <orsonzhai@gmail.com>,
        Orson Zhai <orson.unisoc@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Orson Zhai <orson.zhai@unisoc.com>
References: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
 <CA+H2tpH4+cLN0z7v50UdKCXOqZDt2rSYF5Lvm9-WBYJ3YWtJVg@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <c50deb5a-e3c1-a3c7-1467-fb78b13ceea8@akamai.com>
Date:   Wed, 15 Apr 2020 14:48:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CA+H2tpH4+cLN0z7v50UdKCXOqZDt2rSYF5Lvm9-WBYJ3YWtJVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_06:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2004150136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_06:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/20 12:31 PM, Orson Zhai wrote:
> Hi Jason,
> 
> On Fri, Apr 10, 2020 at 8:33 PM Orson Zhai <orson.unisoc@gmail.com> wrote:
>>
>> From: Orson Zhai <orson.zhai@unisoc.com>
>>
>> Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
>> CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
>> debug. With the DEBUG_MODULE defined for any modules, dynamic debug
>> will be tied to them.
>>
>> This is useful for people who only want to enable dynamic debug for
>> kernel modules without worrying about kernel image size and memory
>> consumption is increasing too much.
>>
> 
> Do you have any comments for this patch?
> 

So I like that you added the 'DEBUG_MODULE', but I'm wondering if the
naming is too generic? Maybe DYNAMIC_DEBUG_MODULE?

There may also be other places where you want to have the per-module
dependency, for example netdev_dbg()? But perhaps further expansion
could wait for a user...

Thanks,

-Jason


> Best Regards,
> Orson
> 
>> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
>> ---
>>  Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
>>  include/linux/dev_printk.h                        |  6 ++++--
>>  include/linux/dynamic_debug.h                     |  2 +-
>>  include/linux/printk.h                            | 14 +++++++++-----
>>  lib/Kconfig.debug                                 | 12 ++++++++++++
>>  lib/Makefile                                      |  2 +-
>>  lib/dynamic_debug.c                               |  9 +++++++--
>>  7 files changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
>> index 0dc2eb8..fa5b8d4 100644
>> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
>> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
>> @@ -13,8 +13,11 @@ kernel code to obtain additional kernel information.  Currently, if
>>  ``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
>>  enabled per-callsite.
>>
>> -If ``CONFIG_DYNAMIC_DEBUG`` is not set, ``print_hex_dump_debug()`` is just
>> -shortcut for ``print_hex_dump(KERN_DEBUG)``.
>> +If ``CONFIG_DYNAMIC_DEBUG_CORE`` is set, only the modules with ``DEBUG_MODULE``
>> +defined will be tied into dynamic debug.
>> +
>> +If ``CONFIG_DYNAMIC_DEBUG`` or ``CONFIG_DYNAMIC_DEBUG_CORE`` is not set,
>> +``print_hex_dump_debug()`` is just shortcut for ``print_hex_dump(KERN_DEBUG)``.
>>
>>  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
>>  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
>> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
>> index 5aad06b..2fb0671 100644
>> --- a/include/linux/dev_printk.h
>> +++ b/include/linux/dev_printk.h
>> @@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
>>  #define dev_info(dev, fmt, ...)                                                \
>>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>>  #define dev_dbg(dev, fmt, ...)                                         \
>>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>  #elif defined(DEBUG)
>> @@ -181,7 +182,8 @@ do {                                                                        \
>>         dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
>>  #define dev_info_ratelimited(dev, fmt, ...)                            \
>>         dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
>>  #define dev_dbg_ratelimited(dev, fmt, ...)                             \
>>  do {                                                                   \
>> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
>> index 4cf02ec..abcd5fd 100644
>> --- a/include/linux/dynamic_debug.h
>> +++ b/include/linux/dynamic_debug.h
>> @@ -48,7 +48,7 @@ struct _ddebug {
>>
>>
>>
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>>  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>>                                 const char *modname);
>>  extern int ddebug_remove_module(const char *mod_name);
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index 1e6108b..77fab5b 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -291,8 +291,9 @@ extern int kptr_restrict;
>>  /*
>>   * These can be used to print at the various log levels.
>>   * All of these will print unconditionally, although note that pr_debug()
>> - * and other debug macros are compiled out unless either DEBUG is defined
>> - * or CONFIG_DYNAMIC_DEBUG is set.
>> + * and other debug macros are compiled out unless either DEBUG is defined,
>> + * CONFIG_DYNAMIC_DEBUG is set, or CONFIG_DYNAMIC_DEBUG_CORE is set when
>> + * DEBUG_MODULE being defined for any modules.
>>   */
>>  #define pr_emerg(fmt, ...) \
>>         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>> @@ -327,7 +328,8 @@ extern int kptr_restrict;
>>
>>
>>  /* If you are writing a driver, please use dev_dbg instead */
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>>  #include <linux/dynamic_debug.h>
>>
>>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
>> @@ -453,7 +455,8 @@ extern int kptr_restrict;
>>  #endif
>>
>>  /* If you are writing a driver, please use dev_dbg instead */
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
>>  #define pr_debug_ratelimited(fmt, ...)                                 \
>>  do {                                                                   \
>> @@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
>>
>>  #endif
>>
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>>  #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
>>                              groupsize, buf, len, ascii)        \
>>         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 50c1f5f..25a1b9de 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
>>         default n
>>         depends on PRINTK
>>         depends on (DEBUG_FS || PROC_FS)
>> +       select DYNAMIC_DEBUG_CORE
>>         help
>>
>>           Compiles debug level messages into the kernel, which would not
>> @@ -165,6 +166,17 @@ config DYNAMIC_DEBUG
>>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>>           information.
>>
>> +config DYNAMIC_DEBUG_CORE
>> +       bool "Enable core function of dynamic debug support"
>> +       depends on PRINTK
>> +       depends on (DEBUG_FS || PROC_FS)
>> +       help
>> +         Enable core functional support of dynamic debug. It is useful
>> +         when you want to tie dynamic debug to your kernel modules with
>> +         DEBUG_MODULE defined for each of them, especially for the case
>> +         of embedded system where the kernel image size is sensitive for
>> +         people.
>> +
>>  config SYMBOLIC_ERRNAME
>>         bool "Support symbolic error names in printf"
>>         default y if PRINTK
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 685aee6..8952772 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -186,7 +186,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
>>
>>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>>
>> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
>> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
>>
>>  obj-$(CONFIG_NLATTR) += nlattr.o
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index 8f199f4..321437b 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
>> @@ -1032,8 +1032,13 @@ static int __init dynamic_debug_init(void)
>>         int verbose_bytes = 0;
>>
>>         if (&__start___verbose == &__stop___verbose) {
>> -               pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>> -               return 1;
>> +               if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
>> +                       pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>> +                       return 1;
>> +               }
>> +               pr_info("Ignore empty _ddebug table in a CONFIG_DYNAMIC_DEBUG_CORE build\n");
>> +               ddebug_init_success = 1;
>> +               return 0;
>>         }
>>         iter = __start___verbose;
>>         modname = iter->modname;
>> --
>> 2.7.4
>>
