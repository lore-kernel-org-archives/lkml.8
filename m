Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F770C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD2120732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bdWLZm1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgC3PUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:20:49 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:53890 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbgC3PUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:20:48 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 02UFJJaF026370;
        Mon, 30 Mar 2020 16:19:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=BADA7hXiwwQhGmesvE/ksgEol5zYpBhJ9Pw5PLC9eqE=;
 b=bdWLZm1sU18QY3kiv7azd4s6vyzRnspMzLeZKs54p2rNGxaHRDXE7L6oqZJ89OSPKB1u
 Bu/SIN5AxPujVhDri2V3H/+X2GyAKkAkptTG2Ba77/iQzQRWrdb4+o/qeab0jdjTpMMJ
 QDAPhD3WBvlnsFHRmZoGmf77wjF2PbrQ1+wJ8PdaQKuPSJ0QOtzJ4spkMRVfe2lGo3LW
 joYUJixeurfpELmskiqCaa5x6O8Pg/gwGgImbU+jLtM+G4bof1Ws1icz0qzRiS8lgXm8
 Sq79mAmDOO6Ecj5JHdXugdavK4/nMQFjXs+uXL3gOjPNhpemGoCk0VablsrQGfMlmcjo 3A== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 301xqu9h2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 16:19:20 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02UFHgZE018020;
        Mon, 30 Mar 2020 11:19:19 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com with ESMTP id 3028dghqcw-1;
        Mon, 30 Mar 2020 11:19:19 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 9D0C221B24;
        Mon, 30 Mar 2020 15:19:18 +0000 (GMT)
Subject: Re: [RFC PATCH V2] dynamic_debug: Add config option of
 DYNAMIC_DEBUG_CORE
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>, joe@perches.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Orson Zhai <orson.unisoc@gmail.com>
References: <1585156347-8365-1-git-send-email-orson.unisoc@gmail.com>
 <CA+H2tpE5Fe5zJKEUM7H9xT10+ZGKVmZ2Aa5D7j_eq7dvZyX5wA@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <b8119cba-e660-d831-1f09-f99641e3d938@akamai.com>
Date:   Mon, 30 Mar 2020 11:19:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+H2tpE5Fe5zJKEUM7H9xT10+ZGKVmZ2Aa5D7j_eq7dvZyX5wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003300143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/20 2:17 AM, Orson Zhai wrote:
> Hi Jason,
> 
> On Thu, Mar 26, 2020 at 1:13 AM Orson Zhai <orson.unisoc@gmail.com> wrote:
>>
>> Instead of enabling whole kernel with CONFIG_DYNAMIC_DEBUG, CONFIG_
>> DYNAMIC_DEBUG_CORE will only make the basic function definition and
>> exported symbols to be built without replacing pr_debug or dev_dbg
>> to dynamic version unless DEBUG is defined for any desired modules
> 
> How do you think about this idea?
> Optionally enable dynamic debug of modules by the DEBUG macro.
> 

Hi Orson,

So I like the idea of being able to use pr_debug() as a way for modules to
tie into dynamic_debug() without having to enable everything via
CONFIG_DYNAMIC_DEBUG. However the 'DEBUG' already has a specific meaning
which is to enable the printing or enable by default (can be turned off
at run-time if CONFIG_DYNAMIC_DEBUG is set).

So I think generally modules want the printing off by default. So maybe
what we want is instead of:

>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))

is:

>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG_MODULE))


That is introduce a new per-module definition I've called it
'DEBUG_MODULE' (perhaps we can name it better), that enables
dynamic debugging without having to turn it on globally. Then,
modules can in addition enabled 'DEBUG' if they want all the printing
on by default.

Thanks,

-Jason


> Best Regards,
> -Orson
> 
>> together by users.
>>
>> This is useful for people who only want to enable dynamic debug for some
>> specific kernel modules without worrying about whole kernel image size will
>> be significantly increased and more memory consumption caused by CONFIG_
>> DYNAMIC_DEBUG.
>>
>> Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
>> ---
>> Changes from V1:
>> - Rewrite commit message for more generic usage.
>> - Add combination use of CONFIG_DYNAMIC_DEBUG_CORE and DEBUG to enable
>>   dynamic debug seperately.
>> - Ignore empty _ddtable and return success when only the core is enabled.
>> - Fix all typoes.
>>
>>  include/linux/dev_printk.h    |  6 ++++--
>>  include/linux/dynamic_debug.h |  2 +-
>>  include/linux/printk.h        | 12 ++++++++----
>>  lib/Kconfig.debug             | 18 ++++++++++++++++++
>>  lib/Makefile                  |  2 +-
>>  lib/dynamic_debug.c           |  9 +++++++--
>>  6 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
>> index 5aad06b..ed40030 100644
>> --- a/include/linux/dev_printk.h
>> +++ b/include/linux/dev_printk.h
>> @@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
>>  #define dev_info(dev, fmt, ...)                                                \
>>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
>>  #define dev_dbg(dev, fmt, ...)                                         \
>>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>  #elif defined(DEBUG)
>> @@ -181,7 +182,8 @@ do {                                                                        \
>>         dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
>>  #define dev_info_ratelimited(dev, fmt, ...)                            \
>>         dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
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
>> index 1e6108b..44d5378 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -292,7 +292,8 @@ extern int kptr_restrict;
>>   * These can be used to print at the various log levels.
>>   * All of these will print unconditionally, although note that pr_debug()
>>   * and other debug macros are compiled out unless either DEBUG is defined
>> - * or CONFIG_DYNAMIC_DEBUG is set.
>> + * or CONFIG_DYNAMIC_DEBUG is set, or both CONFIG_DYNAMIC_DEBUG_CORE and
>> + * DEBUG is defined.
>>   */
>>  #define pr_emerg(fmt, ...) \
>>         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>> @@ -327,7 +328,8 @@ extern int kptr_restrict;
>>
>>
>>  /* If you are writing a driver, please use dev_dbg instead */
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
>>  #include <linux/dynamic_debug.h>
>>
>>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
>> @@ -453,7 +455,8 @@ extern int kptr_restrict;
>>  #endif
>>
>>  /* If you are writing a driver, please use dev_dbg instead */
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
>>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
>>  #define pr_debug_ratelimited(fmt, ...)                                 \
>>  do {                                                                   \
>> @@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
>>
>>  #endif
>>
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
>>  #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
>>                              groupsize, buf, len, ascii)        \
>>         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 69def4a..8381b19 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
>>         default n
>>         depends on PRINTK
>>         depends on DEBUG_FS
>> +       select DYNAMIC_DEBUG_CORE
>>         help
>>
>>           Compiles debug level messages into the kernel, which would not
>> @@ -164,6 +165,23 @@ config DYNAMIC_DEBUG
>>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>>           information.
>>
>> +config DYNAMIC_DEBUG_CORE
>> +       bool "Enable core functions of dynamic debug support"
>> +       depends on PRINTK
>> +       depends on DEBUG_FS
>> +       help
>> +         Enable this option to build ddebug_* and __dynamic_* routines
>> +         into kernel. If you want enable whole dynamic debug features,
>> +         select CONFIG_DYNAMIC_DEBUG directly and this option will be
>> +         automatically selected as well.
>> +
>> +         This option can be selected with DEBUG together which could be
>> +         defined for desired kernel modules to enable dynamic debug
>> +         features instead for whole kernel. Especially being used in
>> +         the case that kernel modules are built out of kernel tree to
>> +         have dynamic debug capabilities without affecting the kernel
>> +         base.
>> +
>>  config SYMBOLIC_ERRNAME
>>         bool "Support symbolic error names in printf"
>>         default y if PRINTK
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 611872c..2096d83 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
>>
>>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>>
>> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
>> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
>>
>>  obj-$(CONFIG_NLATTR) += nlattr.o
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index c604091..34f303a 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
>> @@ -1014,8 +1014,13 @@ static int __init dynamic_debug_init(void)
>>         int verbose_bytes = 0;
>>
>>         if (__start___verbose == __stop___verbose) {
>> -               pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>> -               return 1;
>> +               if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
>> +                       pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>> +                       return 1;
>> +               }
>> +               pr_info("Ignore empty _ddebug table in a core only build\n");
>> +               ddebug_init_success = 1;
>> +               return 0;
>>         }
>>         iter = __start___verbose;
>>         modname = iter->modname;
>> --
>> 2.7.4
>>
