Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7183020855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="BJuakB1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHHGSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 02:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgHHGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 02:18:55 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75EC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 23:18:55 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x6so1790086qvr.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=Cdwt0X1NGLhpgGzhM07Oprp4GqxL9RFoUr5InBDnvbM=;
        b=BJuakB1BR7XDLOhZj0kFalzG6BjQSqsxnQCIxNmyNyYv4dHl0QJlb5jrOadO8JocLy
         csyhIi8pimxOR1YMJCDEQpElsnh9aP/BxJXwTtaqPIRxIe7GbaezoZzaJvsT/y45wylX
         WMnWoDWpggagtj61+GQZjP04EyXwwOCWgnQW4i4DBpYkj+kGy1mefH1l2IPvGo3HlPHy
         5jpIK+OJTvaKmQhn4RD5KA8Wz9A2kgOseLjVAT0ZTpMb0eYGQJp9Ms29k4AyPgniaol+
         8i6Qf2umrysRbR8g+KXOIyVoKOFyJNjqFxBgCIazA14IhzWGZJ7NltChYu8EB5inGA6H
         zzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=Cdwt0X1NGLhpgGzhM07Oprp4GqxL9RFoUr5InBDnvbM=;
        b=nMs9v7oz/0NPrId8cLVKN1hB1jqpkQYQGLtgJ9Gfv8aT3uze4GonKGkvLXU6IY73JK
         1ZHyeEvn2wm8bj6jTj9ooq3vdHKLYe/nS8cUvuKyI+IElmeexmrAlL+kg8xNShxuUlJO
         wD/zvf8dLIo+Do5TUQaS/Ec/amAfFniHGtcQgPDUADLbMAFZoLtg01ohLC9nCzqE8obV
         tBzZlDbbEYcKhis1NFLB9zoSQNDp724JeQb2pEm4NT2aqWsEiE8KdQO9It0SaVXLspFI
         97+MW6kNAcMrKwIygxBWdQYu8AxlFhvcGR+HKY8mc5WhTlN6nJcpMoE6SCNZlUXlq0nH
         jBlQ==
X-Gm-Message-State: AOAM531C3lh+fOxGKObtfODrrs1cEXKMa4flIOnuR6MqH7qMvHzqyWMn
        /m/5lBK2iR8ahaC0U/P/KrveTQ==
X-Google-Smtp-Source: ABdhPJxlOF8TJJanLWYFQadBHwaCKdcqXFHVV2w+JKvSQOlu8UF5BlOSzx71wEYpWkM9z4EfkVYgHg==
X-Received: by 2002:a0c:f849:: with SMTP id g9mr18617852qvo.80.1596867534215;
        Fri, 07 Aug 2020 23:18:54 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
        by smtp.gmail.com with ESMTPSA id a3sm9156453qtj.21.2020.08.07.23.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 23:18:52 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra (Intel) <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: next-20200807 - arm allmodconfig dies in asm-offsets.s
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1596867531_38093P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 08 Aug 2020 02:18:51 -0400
Message-ID: <52753.1596867531@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1596867531_38093P
Content-Type: text/plain; charset=us-ascii

commit 859247d39fb008ea812e8f0c398a58a20c12899e
Author: Ahmed S. Darwish <a.darwish@linutronix.de>
Date:   Mon Jul 20 17:55:14 2020 +0200

    seqlock: lockdep assert non-preemptibility on seqcount_t write

breaks an arm allmodconfig build.  'git revert -n' and the build continues on.

  CC      arch/arm/kernel/asm-offsets.s
In file included from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from arch/arm/kernel/asm-offsets.c:11:
./include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
./include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id' [-Werror=implicit-function-declaration]
 #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
                                        ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:145:27: note: in definition of macro 'WARN_ON_ONCE'
  int __ret_warn_once = !!(condition);   \
                           ^~~~~~~~~
././include/linux/compiler_types.h:307:2: note: in expansion of macro '__compiletime_assert'
  __compiletime_assert(condition, msg, prefix, suffix)
  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:319:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
  ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
                     ^~~~~~~~~~~~~
./include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
  compiletime_assert_rwonce_type(x);    \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:10: note: in expansion of macro 'READ_ONCE'
  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
          ^~~~~~~~~
./include/linux/percpu-defs.h:231:2: note: in expansion of macro 'RELOC_HIDE'
  RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
  ^~~~~~~~~~
./include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
 #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                               ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
 #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
                         ^~~~~~~~~~~~~~
./include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
 #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                     ^~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
  arch_raw_cpu_ptr(ptr);      \
  ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:21: note: in expansion of macro 'raw_cpu_ptr'
  __ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:138:11: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   __ret = __this_cpu_generic_read_nopreempt(pcp);  \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:320:31: note: in expansion of macro 'this_cpu_generic_read'
 #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:321:23: note: in expansion of macro 'this_cpu_read_1'
  case 1: pscr_ret__ = stem##1(variable); break;   \
                       ^~~~
./include/linux/percpu-defs.h:507:29: note: in expansion of macro '__pcpu_size_call_return'
 #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                             ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lockdep.h:565:9: note: in expansion of macro 'this_cpu_read'
         this_cpu_read(hardirqs_enabled)));  \
         ^~~~~~~~~~~~~
./include/linux/seqlock.h:285:2: note: in expansion of macro 'lockdep_assert_preemption_disabled'
  lockdep_assert_preemption_disabled();
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1203: prepare0] Error 2


--==_Exmh_1596867531_38093P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXy5DygdmEQWDXROgAQJ5WxAAi83o5j7NFvv0XK+Q/a333EIAcme7nSEE
OjTF0XKBDuTpDhR5h6A34Nu9dPraENZidVD2tXIHA9weE3WQp5yxAwH8nm7RTt9f
pYSt1TthYRzGvgdPsSY5w551i0e2GmYmTNxy7L1mTE/8Kt7lbsJ6iXQW2F4t25RE
V/aqSJ9c/Yx571NuFCG1gf9E3gsH+s7/cc2n0UlNCKln16Dsf+K21uwuG5I8j2NM
Y2os+6cfyL95UPQzDlnIjC/vEjtc9mtajdMWUjoS5+6XiYz6aovsMBa6LNipKzTX
HAaL6pEqvpLKz76CzHBtiFvg9967pv0CrDuKVDNZL7p65/jlx3CN9G2957KEgQxy
GbvkqAtbuvYleyCWUAgNL1n40A9QFerP08S9Fkbs1SM8BqucU3Bwi1JPiUttd2/9
WiJiP+7V6ahf0DdR9JoS4QbpRnb9BcFO/C3FbLCBdgnm2pGD3pWAHxE1hBbbfTp6
Wa9qP4OpEyYs/ZNxyJOi/leqqgrmhJvIAKgis3KrymMhr//fk465eeXnAIaaeU1Q
YLs2Jlfd/plpwzHgwCxREjlzRlekosGk5DCCRaGG8Y7sn2JoYKqDlf6gLA4TRCVa
Pog8KopyZHuM54SzTPHl6BttM+QvLwmnLvn2sYyLt++yF3gHBlV2kS1nI9LRs2Au
MNjm3KAkoTw=
=amCA
-----END PGP SIGNATURE-----

--==_Exmh_1596867531_38093P--
