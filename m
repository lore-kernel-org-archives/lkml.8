Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32271C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA4C206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GmqrUd2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC0UsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:48:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37167 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0UsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:48:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id x3so12342789qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9q1XY4KqbbTRLheOot7MCrox3Fgc87F65JC9LGYyt/E=;
        b=GmqrUd2C6lvT6vlUdQucy70SSLtfxsKdUjOHWqJyOD8f1vWLJa5e6GYpJ9Npn1jKUh
         RQKqmeIdVm7NetPjv9kPl5b08t/PpjpjUv7DCinp3PrZIwC2UmHt2CpwFM7OOJ6lHiFM
         Q102qGtpZYc7xQKpLdqS7yQXUHF3YHZYzGkfuuSMThrDVUYxKczB+z15Rm9CSHYQlIOz
         fmKXu+PqvhBXZjZtUrzjdZxknkPNMfoKO4wAnvUxi75V++fORXMOHg3aziuDT+9lGaRM
         wzi5R35OV/ah4OcxihiVz15pL/N44chQI0FXkwtkZMiDWJ/3PHJw79yOsQlrvwX1kq6P
         CnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9q1XY4KqbbTRLheOot7MCrox3Fgc87F65JC9LGYyt/E=;
        b=TicfeeESb+uiJM+GcchpXkntsLK1PgWXzjM7zxFpZk9V9GvdcEBmsXXn+VtsWxGFpb
         6ynbkNWLSlB1V6CSvyxtttnYS1bAf6yjDKASWQ1rGeDPMIbbjhuKcjlZLlVkwG06ra7e
         s2IwEMjRwA4j+0y2vs8K3j363UX64VC2Kar/3+z7CPct/5S/KGgdTBEBgtrVzzx3vbQI
         50dhSol9BLFfM0UwUkwnTuSGfS+3NLq9mmnigPrhP0Eir9385neEgsinF5iJ2/A3/ZIn
         tsZOXx0Ye93iNqzdEEcY71uNJ6kYIVhr+N6Z1e/nXjwEkjMyrwx+nkgAZJST1zjTcn6J
         3Vhg==
X-Gm-Message-State: ANhLgQ0g3pPJyqkWI59XSBwFB3I9fIK1vEM+kSWF+PMBOy0J3akcD4MK
        4PQwDxG4XSw+AQ89o+/o6rOSrg==
X-Google-Smtp-Source: ADFU+vum1YDCNVR+ZGbjSSgdxeGaVZ3Vf8cRn4knXCG80t3ZykaXm1aP4n2qerO0tMux7GIpvqDeng==
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr1301375qkl.104.1585342080284;
        Fri, 27 Mar 2020 13:48:00 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p1sm4485204qkf.73.2020.03.27.13.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 13:47:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Memory leaks due to "locking/percpu-rwsem: Remove the embedded rwsem"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
Date:   Fri, 27 Mar 2020 16:47:58 -0400
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        dbueso@suse.de, juri.lelli@redhat.com, longman@redhat.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1CCBDAC-A453-4FF2-908F-0B6E356223D1@lca.pw>
References: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
 <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 27, 2020, at 6:19 AM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Mar 27, 2020, at 5:37 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>=20
>> If the trylock fails, someone else got the lock and we remain on the
>> waitqueue. It seems like a very bad idea to put the task while it
>> remains on the waitqueue, no?
>=20
> Interesting, I thought this was more straightforward to see, but I may =
be wrong as always. At the beginning of percpu_rwsem_wake_function() it =
calls get_task_struct(), but if the trylock failed, it will remain in =
the waitqueue. However, it will run percpu_rwsem_wake_function() again =
with get_task_struct() to increase the refcount. Can you enlighten me =
where it will call put_task_struct() in waitqueue or elsewhere to =
balance the refcount in this case?

I am pretty confident that the linux-next commit,

7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem=E2=80=9D)

Introduced memory leaks,

I put a debugging patch here,

diff --git a/kernel/locking/percpu-rwsem.c =
b/kernel/locking/percpu-rwsem.c
index a008a1ba21a7..857602ef54f1 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -123,8 +123,10 @@ static int percpu_rwsem_wake_function(struct =
wait_queue_entry *wq_entry,
 	struct percpu_rw_semaphore *sem =3D key;
=20
 	/* concurrent against percpu_down_write(), can get stolen */
-	if (!__percpu_rwsem_trylock(sem, reader))
+	if (!__percpu_rwsem_trylock(sem, reader)) {
+		printk("KK __percpu_rwsem_trylock\n");
 		return 1;
+	}
=20
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);

Once those printks() triggered, it ends up with task_struct leaks,

unreferenced object 0xc000200df1422280 (size 8192):
  comm "read_all", pid 12975, jiffies 4297309144 (age 5351.480s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f5c5fa2d>] copy_process+0x26c/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc00020047ef8eb80 (size 120):
  comm "read_all", pid 12975, jiffies 4297309144 (age 5351.480s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004def8a44>] prepare_creds+0x38/0x110
    [<0000000037a68116>] copy_creds+0xbc/0x1d0
    [<0000000016b7471c>] copy_process+0x454/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc000200d96f80800 (size 1384):
  comm "read_all", pid 12975, jiffies 4297309144 (age 5351.480s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 08 f8 96 0d 20 00 c0 10 08 f8 96 0d 20 00 c0  ..... ....... ..
  backtrace:
    [<000000008894d13b>] copy_process+0xa40/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc000001e91ba4000 (size 16384):
  comm "read_all", pid 12982, jiffies 4297309462 (age 5348.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009689397b>] kzalloc.constprop.48+0x1c/0x30
    [<000000001753eb18>] task_numa_fault+0xac8/0x1260
    [<0000000047bb80b1>] __handle_mm_fault+0x12cc/0x1b00
    [<00000000c0a4c8ba>] handle_mm_fault+0x298/0x450
    [<000000003465b20d>] __do_page_fault+0x2b8/0xf90
    [<000000005037fec9>] handle_page_fault+0x10/0x30
unreferenced object 0xc0002015fe4aaa80 (size 8192):
  comm "read_all", pid 13157, jiffies 4297353979 (age 4903.130s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f5c5fa2d>] copy_process+0x26c/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc00020047ef8f080 (size 120):
  comm "read_all", pid 13157, jiffies 4297353979 (age 4903.130s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004def8a44>] prepare_creds+0x38/0x110
    [<0000000037a68116>] copy_creds+0xbc/0x1d0
    [<0000000016b7471c>] copy_process+0x454/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc0002012a9388f00 (size 1384):
  comm "read_all", pid 13157, jiffies 4297353979 (age 4903.130s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 8f 38 a9 12 20 00 c0 10 8f 38 a9 12 20 00 c0  ..8.. ....8.. ..
  backtrace:
    [<000000008894d13b>] copy_process+0xa40/0x1920
    [<0000000099229290>] _do_fork+0xac/0xb20
    [<00000000d40a7825>] __do_sys_clone+0x98/0xe0
    [<00000000c7cd06a4>] ppc_clone+0x8/0xc
unreferenced object 0xc000001c86704000 (size 16384):
  comm "read_all", pid 13164, jiffies 4297354081 (age 4902.110s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009689397b>] kzalloc.constprop.48+0x1c/0x30
    [<000000001753eb18>] task_numa_fault+0xac8/0x1260
    [<0000000047bb80b1>] __handle_mm_fault+0x12cc/0x1b00
    [<00000000c0a4c8ba>] handle_mm_fault+0x298/0x450
    [<000000003465b20d>] __do_page_fault+0x2b8/0xf90
    [<000000005037fec9>] handle_page_fault+0x10/0x30=
