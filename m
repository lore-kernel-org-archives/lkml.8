Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E94C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48282087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LoNReGzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgAJLHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:07:30 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:45027 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgAJLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578654449;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oGXGay7cCpzVzXtI7lKewXBfa/hl7JcDGI+Xi/x2vl8=;
  b=LoNReGzVZY+bjvBTgb3DiskWXP9TdKMdJMF2uPbPVqB5/oJcS/r3iaO0
   ob2sMKvWQWY9L43Jg0Sg67WLOM+gmrWP2zleuImPJpYskphr7HJt/pqHZ
   EiIQPUltP9kAO+IkAMvw5Qh6/aiky2rXym4Jz0Fyn5WcF/kc6kPBHsTaF
   g=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: twpcSmXpC1qCNCFAijV/X2KEvYkOgAGoh1Cqqhl5VEHfHZ3/f6lq8R2JA7J7utgKQoUnpZXwbN
 rQCOKXw2lHYzt6NEBUHJWRHyGPKhCZgoK5+eIprHYSQ2XuY9bZutptCiYzSpcSYx9nheSDYoZK
 KxGfjTMT0gZ7uhrfyIrY5Z86NKvvtTH2xJ5B0LrQOtHfKiJIKnVWxgbGEN6FwKIPqQ/inn3SMA
 TH9pHg4lXICcighXX2GlFnG1lCyg6Y6jrFV+9mlGG+0xW5k5MsHQbL8jSvqCZsco3BuFq1wthr
 Bzs=
X-SBRS: 2.7
X-MesageID: 11108479
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,416,1571716800"; 
   d="scan'208";a="11108479"
Subject: Re: [PATCH v1 2/4] x86/xen: add basic KASAN support for PV kernel
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "sergey.dyasli@citrix.com >> Sergey Dyasli" 
        <sergey.dyasli@citrix.com>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
 <20200108152100.7630-3-sergey.dyasli@citrix.com>
 <0c968669-2b21-b772-dba8-f674057bd6e7@suse.com>
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
Autocrypt: addr=sergey.dyasli@citrix.com; keydata=
 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
Message-ID: <e5853285-8c18-8c9d-2d40-7e7115c8d3cf@citrix.com>
Date:   Fri, 10 Jan 2020 11:07:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0c968669-2b21-b772-dba8-f674057bd6e7@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 09:15, Jürgen Groß wrote:
> On 08.01.20 16:20, Sergey Dyasli wrote:
>> This enables to use Outline instrumentation for Xen PV kernels.
>>
>> KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
>> and hence disabled.
>>
>> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
>> ---
>> RFC --> v1:
>> - New functions with declarations in xen/xen-ops.h
>> - Fixed the issue with free_kernel_image_pages() with the help of
>>    xen_pv_kasan_unpin_pgd()
>> ---
>>   arch/x86/mm/kasan_init_64.c | 12 ++++++++++++
>>   arch/x86/xen/Makefile       |  7 +++++++
>>   arch/x86/xen/enlighten_pv.c |  3 +++
>>   arch/x86/xen/mmu_pv.c       | 39 +++++++++++++++++++++++++++++++++++++
>>   drivers/xen/Makefile        |  2 ++
>>   include/xen/xen-ops.h       |  4 ++++
>>   kernel/Makefile             |  2 ++
>>   lib/Kconfig.kasan           |  3 ++-
>>   8 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
>> index cf5bc37c90ac..902a6a152d33 100644
>> --- a/arch/x86/mm/kasan_init_64.c
>> +++ b/arch/x86/mm/kasan_init_64.c
>> @@ -13,6 +13,9 @@
>>   #include <linux/sched/task.h>
>>   #include <linux/vmalloc.h>
>>   +#include <xen/xen.h>
>> +#include <xen/xen-ops.h>
>> +
>>   #include <asm/e820/types.h>
>>   #include <asm/pgalloc.h>
>>   #include <asm/tlbflush.h>
>> @@ -332,6 +335,11 @@ void __init kasan_early_init(void)
>>       for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
>>           kasan_early_shadow_p4d[i] = __p4d(p4d_val);
>>   +    if (xen_pv_domain()) {
>> +        pgd_t *pv_top_pgt = xen_pv_kasan_early_init();
>
> You are breaking the build with CONFIG_XEN_PV undefined here.

Right, the following is needed:

diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 91d66520f0a3..3d20f000af12 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -241,8 +241,14 @@ static inline void xen_preemptible_hcall_end(void)

 #endif /* CONFIG_PREEMPT */

+#if defined(CONFIG_XEN_PV)
 pgd_t *xen_pv_kasan_early_init(void);
 void xen_pv_kasan_pin_pgd(pgd_t *pgd);
 void xen_pv_kasan_unpin_pgd(pgd_t *pgd);
+#else
+static inline pgd_t *xen_pv_kasan_early_init(void) { return NULL; }
+static inline void xen_pv_kasan_pin_pgd(pgd_t *pgd) { }
+static inline void xen_pv_kasan_unpin_pgd(pgd_t *pgd) { }
+#endif /* defined(CONFIG_XEN_PV) */

 #endif /* INCLUDE_XEN_OPS_H */

--
Thanks,
Sergey
