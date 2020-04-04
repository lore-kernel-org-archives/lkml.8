Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9369BC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 23:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6C20672
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 23:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExXdZCSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDDXzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 19:55:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgDDXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 19:55:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so10753235wrx.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OEqfbUW4EdwQWkEKUVSfhdZIagLpVMlg6Ov4FrszOWU=;
        b=ExXdZCSXdqH0LfiiEruCb7ZNy8S8Wqgl+1beU7sIwS/4GwQAQ0tHx8ixmxHsmLkpIz
         yUXprcrlRHsDv/BwuMETXv5Ni+8PF8heo4rbha+w2bm1mBU0yKxdLgL8zolFhTdUpH1p
         Gt1CiFN8EDDFN7kWnPpS8btasOL+Gr//ASTX8LDO9WtQszvPN498lig1AOxEIAAalXhR
         Xrcw3V2CPEGaRuWvOahtQQoCLvWfzEpPmt7mRX2TaJMRDTclRQPySUXhLXyjvkDupqeY
         dlonWq3WJMwlpu1J9nMk8RmrMWNxHP2UhXzqn+9Bky+dbv5suTFlgvqmDZEWFeYhNn14
         hJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OEqfbUW4EdwQWkEKUVSfhdZIagLpVMlg6Ov4FrszOWU=;
        b=CT+OkkWhUJUQAsvLUkAKsAP1ZnzTpoMFBN0VmCooyKPGY1bK9/LDARnwWbsjFV87pz
         v+FyAiuPhivTKKqfuWg1j2tO1hD3b2ZLliV8SDuheVAhqpyuLNSDkVTsS2pqfvdYCnQD
         yVomFn5PoTCxrMPFklqvdWDGpb1/pqtMfbYE1dTQzTtRCe3u0nVpBl2HqWqzuli81vZl
         wyoSmwCP948V/ZaLizlb3FA5BODh9T8lQLMzyOQd+XfcVgp9IsR1NUdnF05pKDFXYLhC
         NY0GedLIDWRez+PCRcLrYml4d/MLpjtIz2QWi+R9/B0RdRfjIJNUxqSp1PjqV0tP0irY
         RVXg==
X-Gm-Message-State: AGi0PuYBWlTyGpi3EtvpkQDVP6y/mksJgbKAQ2C6AO5ETldQBxPY/UWl
        buZgwd6yT7B6ROpIXN+cqL4noELW
X-Google-Smtp-Source: APiQypJrOm/E31kEqRrDNX9TpWOBFUHhbNuJUP6JpxHmuovz9jrF0HkCkS5FiLLEQe48A4XbDCweng==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr10433416wru.120.1586044548590;
        Sat, 04 Apr 2020 16:55:48 -0700 (PDT)
Received: from [192.168.1.131] ([93.176.137.11])
        by smtp.gmail.com with ESMTPSA id y33sm2860140wrd.84.2020.04.04.16.55.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 16:55:48 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: Re: [GIT] Networking
To:     linux-kernel@vger.kernel.org
Message-ID: <8a58c60f-dfca-6dba-6ea5-0684b1c5e900@gmail.com>
Date:   Sun, 5 Apr 2020 01:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2015 at 11:31 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

 >> [-Wsizeof-array-argument]

 > Ahh. Google shows that it's an old clang warning that gcc has recently
 > picked up.

 > But even clang doesn't seem to have any way for a project to say
 > "please warn about arrays in function argument declaration". It *is*
 > very traditional idiomatic C, it's just that I personally think it's
 > one of those bad traditional C things exactly because it's so
 > misleading about what actually goes on. But I guess that in practice,
 > the only thing that it actually *affects* is "sizeof" (and assignment
 > to the variable name - something that would be invalid for a real
 > array, but works on argument arrays because they are really just
 > pointers).

 > The "array as function argument" syntax is occasionally useful
 > (particularly for the multi-dimensional array case), so I very much
 > understand why it exists, I just think that in the kernel we'd be
 > better off with the rule that it's against our coding practices.

 >                   Linus


Hi Linus,

First of all, this is my first message to this mailing list, and I'm
trying to reply to a very old thread, so sorry if I don't know how I
should do it.

I have a different approach in my code to avoid that whole class of bugs
relating sizeof and false arrays in function argument declarations.
I do like the sintactic sugar that they provide, so I decided to ban
"sizeof(array)" completely off my code.

I have developed the following macro:

#define ARRAY_BYTES(arr)	(sizeof((arr)[0]) * ARRAY_SIZE(arr))

which compiles to a simple "sizeof(arr)" by undoing the division in
"ARRAY_SIZE()", but with the added benefit that it checks that the
argument is an array (due to "ARRAY_SIZE()"), and if not, compilation
breaks which means that the array is not an array but a pointer.

My rules are:

  - Size of an array (number of elements):
	ARRAY_SIZE(arr)
  - Signed size of an array (normally for loops where I compare against a
  signed variable):
	ARRAY_SSIZE(arr)	defined as: ((ptrdiff_t)ARRAY_SIZE(arr))
  - Size of an array in bytes (normally for buffers):
	ARRAY_BYTES(arr)

No use of "sizeof" is allowed for arrays, which completely rules
out bugs of that class, because I never pass an array to "sizeof", which
is the core of the problem.  I've been using those macros in my code for
8 months, and they work really nice.

I propose to include the macro "ARRAY_BYTES()" in <linux/kernel.h> just
after "ARRAY_SIZE()" and replace every appearance of "sizeof(array)" in
Linux by "ARRAY_BYTES(array)", and modify the coding style guide to ban
"sizeof(array)" completely off the kernel.

Below is a patch with two commits:  one that adds the macro to
<linux/kernel.h>, and another one that serves as an example of usage
for the macro (that one is just as an example).


		Alex.

Please CC me <colomar.6.4.3@gmail.com> in any response to this thread.

 From b5b674d39b28e703300698fa63e4ab4be646df8f Mon Sep 17 00:00:00 2001
From: Alejandro Colomar <colomar.6.4.3@gmail.com>
Date: Sun, 5 Apr 2020 01:45:35 +0200
Subject: [PATCH 1/2] linux/kernel.h: add ARRAY_BYTES() macro

---
  include/linux/kernel.h | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d74a9d6..dc806e2a7799 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -46,6 +46,12 @@
   */
  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))

+/**
+ * ARRAY_BYTES - get the number of bytes in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_BYTES(arr)	(sizeof((arr)[0]) * ARRAY_SIZE(arr))
+
  #define u64_to_user_ptr(x) (		\
  {					\
  	typecheck(u64, (x));		\
-- 
2.25.1


 From 3e7bcf70b708b51a7807c336c5d1b01403989d3b Mon Sep 17 00:00:00 2001
From: Alejandro Colomar <colomar.6.4.3@gmail.com>
Date: Sun, 5 Apr 2020 01:48:17 +0200
Subject: [PATCH 2/2] block, bfq: Use ARRAY_BYTES() for arrays instead of
  sizeof()

---
  block/bfq-cgroup.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 68882b9b8f11..51ba9b9a8855 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -7,6 +7,7 @@
  #include <linux/blkdev.h>
  #include <linux/cgroup.h>
  #include <linux/elevator.h>
+#include <linux/kernel.h>
  #include <linux/ktime.h>
  #include <linux/rbtree.h>
  #include <linux/ioprio.h>
@@ -794,7 +795,8 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, 
struct bio *bio)
  	 * refcounter for bfqg, to let it disappear only after no
  	 * bfq_queue refers to it any longer.
  	 */
-	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
+	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path,
+						ARRAY_BYTES(bfqg->blkg_path));
  	bic->blkcg_serial_nr = serial_nr;
  out:
  	rcu_read_unlock();
-- 
2.25.1

