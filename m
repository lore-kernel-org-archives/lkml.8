Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC1FC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AA221473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEILKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgEILJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:09:59 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FCC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 04:09:59 -0700 (PDT)
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 049B9uMd032166
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 07:09:56 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 049B9pLV018886
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 07:09:56 -0400
Received: by mail-qk1-f198.google.com with SMTP id b7so2072303qkk.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 04:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=vIjUaVr8lXgICZvNCCHOLX8uh9Z0/aUAOCq842hnMgE=;
        b=Nv7oe+tup8mIjfT2Z2P1bdOqmqkEYuc6af0KLHKrca6s1Nd0dnGL9CfEah1LenzFtQ
         c8CO4hc5XcoIv0DbkMfsn8TnJxKxdktqAII/Iqu5SSJ59N+Li82o+imJKC5uh9KVdljC
         bMDUnwEX3VwV1+a+bJ7XS5c/3KEhfn3Woli80tgqKfFtHJGLx8+WNVHl8g0A0h6TGu3i
         Al5uhfrh0FvNUjTPSWKXjj4qjQgwrTBBX7b3gJVAWVgbGV5DDn/hFJqiXY/xFCAVtMPU
         Ej3DiZ1vMiNF/3UPS707iLcFjsVu9WRIzhjSP8Z2o88VFr/1c+RkDtfMJEhBKnj5ruu2
         +KZg==
X-Gm-Message-State: AGi0PubE9ZS3kU3mUlPYQgG9U2oQAUUZA6nBQMSBHF4t9BN1yCbwX1ix
        zOSj7WiKSYroDRO6E6qzLDjDwC6lbTe46busdH99dhoyozxWxPgsmqUwM3NawtGdPknrsWciahp
        Lwm0H0GkT44S8WqdF7itQ+Xthe2bC06sidhk=
X-Received: by 2002:a37:7786:: with SMTP id s128mr7164213qkc.497.1589022590815;
        Sat, 09 May 2020 04:09:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypLc8IvWBaSGDhyMTl5B9gxpmnXDY7zrvRffUZM1qewb4/r7Sxa5/smmEBjIDGRf7TUUf6kwyw==
X-Received: by 2002:a37:7786:: with SMTP id s128mr7164185qkc.497.1589022590368;
        Sat, 09 May 2020 04:09:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 10sm4316594qtp.4.2020.05.09.04.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 04:09:49 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: linux-next 20200508 - build failure in kernel/resource.c w/ SPARSEMEM=n
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1589022587_4501P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 May 2020 07:09:48 -0400
Message-ID: <17362.1589022588@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1589022587_4501P
Content-Type: text/plain; charset=us-ascii

So I did a 'make allmodconfig' and then a 'make' on an RPi4 ARM box, and it
decided that CONFIG_SPARSEMEM=n was OK (so an include of linux/mmzone.h doesn't
define some needed values).

The offending code in resource.c is wrapped in a #ifdef CONFIG_DEVICE_PRIVATE,
which throws a whinge during 'make menuconfig' or 'make allmodconfig':

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && DRM_NOUVEAU [=m] && MMU [=y] && STAGING [=y]

after which I end up with CONFIG_DEVICE_PRIVATE=y in the .config file.

make menuconfig tells me:
Symbol: ZONE_DEVICE [=n]
   Type  : bool
   Defined at mm/Kconfig:779
     Prompt: Device memory (pmem, HMM, etc...) hotplug support
     Depends on: MEMORY_HOTPLUG [=n] && MEMORY_HOTREMOVE [=n] && SPARSEMEM_VMEMMAP [=n] && ARCH_HAS_PTE_DEVMAP [=n]
     Location:
   (1) -> Memory Management options
   Selects: XARRAY_MULTI [=n]

Pretty obviously a Kconfig whoops, but I have no idea what the proper Kconfig
fix is for this..

May be related to:

commit 0092908d16c604b8207c2141ec64b0fa4473bb03
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jun 26 14:27:06 2019 +0200

    mm: factor out a devm_request_free_mem_region helper

which added the #ifdef CONFIG_DEVICE_PRIVATE code in question, except that's a
pretty old commit...  The only thing I'm sure of is that DEVICE_PRIVATE=y and
SPARSEMEM=n blows up. :)

  CC      kernel/resource.o
In file included from ./include/linux/cache.h:5,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:15,
                 from kernel/resource.c:17:
kernel/resource.c: In function '__request_free_mem_region':
kernel/resource.c:1653:28: error: 'PA_SECTION_SHIFT' undeclared (first use in this function); did you mean 'SECTION_SHIFT'?
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
                            ^~~~~~~~~~~~~~~~
./include/uapi/linux/kernel.h:11:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^~~~
./include/linux/kernel.h:33:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^~~~~~~~~~~~~~
kernel/resource.c:1653:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
         ^~~~~
kernel/resource.c:1653:28: note: each undeclared identifier is reported only once for each function it appears in
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
                            ^~~~~~~~~~~~~~~~
./include/uapi/linux/kernel.h:11:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^~~~
./include/linux/kernel.h:33:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^~~~~~~~~~~~~~
kernel/resource.c:1653:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
         ^~~~~
In file included from ./include/asm-generic/bug.h:19,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:15,
                 from kernel/resource.c:17:
kernel/resource.c:1654:48: error: 'MAX_PHYSMEM_BITS' undeclared (first use in this function); did you mean 'MAX_UINSN_BYTES'?
  end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
                                                ^~~~~~~~~~~~~~~~
./include/linux/kernel.h:848:40: note: in definition of macro '__typecheck'
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                        ^
./include/linux/kernel.h:872:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/kernel.h:940:27: note: in expansion of macro '__careful_cmp'
 #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
                           ^~~~~~~~~~~~~
kernel/resource.c:1654:8: note: in expansion of macro 'min_t'
  end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
        ^~~~~
./include/linux/kernel.h:872:2: error: first argument to '__builtin_choose_expr' not a constant
  __builtin_choose_expr(__safe_cmp(x, y), \
  ^~~~~~~~~~~~~~~~~~~~~
./include/linux/kernel.h:940:27: note: in expansion of macro '__careful_cmp'
 #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
                           ^~~~~~~~~~~~~
kernel/resource.c:1654:8: note: in expansion of macro 'min_t'
  end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
        ^~~~~
make[1]: *** [scripts/Makefile.build:273: kernel/resource.o] Error 1
make: *** [Makefile:1726: kernel] Error 2


--==_Exmh_1589022587_4501P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXraPewdmEQWDXROgAQJVZQ//ZMYAfRDOaGeRcZmhKpgaMq3MR3P7L5Aa
w4TzHp31ZVyuGt7Tb9o7WZRYlgPHPQoBqWUbI0ZL5Ev80E//7g+fXQqxrPtpUGGR
LAyOaQ/adybmzSTW79V1Yf2tTIfBwqRQ/WnYQkXl3azERaU62sAGETWoFyVfAspo
kEBKh07eWfhTk2e0Gh2BQzNw0215kh9pyEhnkDizYkUe9yx/wMBSwrBpO6s3xTCx
/qJmwzs8VvXE482CAL5qcyzZAr+A8cnWhIzi9tLQHT2hDu+LSY2jENHpvY18fUMr
nRZtx4oNwz6rW7s7CQMX0QB/yo1ZIahJzGbzOM7Pm+fcMR+uj6THFRj4sElu/bqY
u/d+dDYj1x7GbBenCiK06lGLHnM0RThzLSKQblGCy93B9hQSJFx5vtmxH/asb7uU
qUh0F12kGZ9iVBQkEhhcxMtf8mGOAIdGZtqf+wvG1vPIWywf4V0pIIOW4gEk3/RP
KFlM0/GqulJzCvM1I1t5vufM19vJxcz5W20HldN1y1+zyWL6vw7KpUesHp2342oj
uRij4XiNEgI5W+dyb5XSJIwvIlTBuKu6JC4dAU19vAbN9sY8Ot5fMmwp6Z8gLX1k
c0PMIOewx6jKfsg6vJQEV/zy9SMaMM7Tp9ePDkzyAyXYDLzVRhUSCg2HuIeVCHRt
6xH7VQNFUvg=
=t/Th
-----END PGP SIGNATURE-----

--==_Exmh_1589022587_4501P--
