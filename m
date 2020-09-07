Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15188C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E44121473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="gAvRakCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgIGKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:52:05 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:54076 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgIGKvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:51:42 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 1925AA3403;
        Mon,  7 Sep 2020 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1599475898; bh=iCqjEQ79ZydCPDhRLNRnoSz7hm/L0DINt1C/2Ejpg1M=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=gAvRakCYoV+INCy7F3QNWld1jHtKrHQd11JJSz3vXYTVGZWsjWySjloeGw1nKHJOx
         IQhwRwwewqtTOUhIyN9ja8h8jjA147UyFDvv1Pvi45Uylg1Y70yR+/TWhKeBK3jUeg
         NrTz6iwiRVx/BMssYOKYyGDbRE7XC4YgVom9ggPY=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
Date:   Mon, 7 Sep 2020 12:51:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200821170334.73b52fdd@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I guess there is currently no other way than to use something like Steven
proposed. I implemented and tested the attached patch with a module,
that triggers the soft lockup detection and it works as expected.
I did not use inline functions, but normal function implemented in 
kexec_core,
because there is nothing time critical here.
I also added the mutex_lock to the trylock variant, because then the unlock
function can be the same for both lock functions.

What do you think?

Jörg

---
  kernel/kexec.c                     |  8 ++---
  kernel/kexec_core.c                | 55 ++++++++++++++++++++++++------
  kernel/kexec_file.c                |  6 ++--
  kernel/kexec_internal.h            |  6 +++-
  security/integrity/ima/ima_kexec.c |  2 +-
  5 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..118a012aeac2 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -255,12 +255,12 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, 
unsigned long, nr_segments,
       *
       * KISS: always take the mutex.
       */
-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;

      result = do_kexec_load(entry, nr_segments, segments, flags);

-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();

      return result;
  }
@@ -309,12 +309,12 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, 
entry,
       *
       * KISS: always take the mutex.
       */
-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;

      result = do_kexec_load(entry, nr_segments, ksegments, flags);

-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();

      return result;
  }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..a8337e6114fb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -45,7 +45,8 @@
  #include <crypto/sha.h>
  #include "kexec_internal.h"

-DEFINE_MUTEX(kexec_mutex);
+static atomic_t kexec_busy = ATOMIC_INIT(0);
+static DEFINE_MUTEX(kexec_mutex);

  /* Per cpu memory for storing cpu states in case of system crash. */
  note_buf_t __percpu *crash_notes;
@@ -70,6 +71,40 @@ struct resource crashk_low_res = {
      .desc  = IORES_DESC_CRASH_KERNEL
  };

+int kexec_trylock(void)
+{
+    int ret = atomic_inc_return(&kexec_busy);
+    if (ret > 1) {
+        atomic_dec(&kexec_busy);
+        return 0;
+    }
+    mutex_lock(&kexec_mutex);
+    return 1;
+}
+
+void kexec_lock(void)
+{
+    int ret;
+    /* Prevent spinning, if the lock is busy */
+    mutex_lock(&kexec_mutex);
+    while (1) {
+        ret = atomic_inc_return(&kexec_busy);
+        if (ret > 1) {
+            atomic_dec(&kexec_busy);
+            mutex_unlock(&kexec_mutex);
+        } else {
+            break;
+        }
+    }
+}
+
+void kexec_unlock(void)
+{
+    BUG_ON(atomic_read(&kexec_busy) <= 0);
+    atomic_dec(&kexec_busy);
+    mutex_unlock(&kexec_mutex);
+}
+
  int kexec_should_crash(struct task_struct *p)
  {
      /*
@@ -943,7 +978,7 @@ int kexec_load_disabled;
   */
  void __noclone __crash_kexec(struct pt_regs *regs)
  {
-    /* Take the kexec_mutex here to prevent sys_kexec_load
+    /* Take the kexec_lock here to prevent sys_kexec_load
       * running on one cpu from replacing the crash kernel
       * we are using after a panic on a different cpu.
       *
@@ -951,7 +986,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
       * of memory the xchg(&kexec_crash_image) would be
       * sufficient.  But since I reuse the memory...
       */
-    if (mutex_trylock(&kexec_mutex)) {
+    if (kexec_trylock()) {
          if (kexec_crash_image) {
              struct pt_regs fixed_regs;

@@ -960,7 +995,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
              machine_crash_shutdown(&fixed_regs);
              machine_kexec(kexec_crash_image);
          }
-        mutex_unlock(&kexec_mutex);
+        kexec_unlock();
      }
  }
  STACK_FRAME_NON_STANDARD(__crash_kexec);
@@ -993,10 +1028,10 @@ size_t crash_get_memory_size(void)
  {
      size_t size = 0;

-    mutex_lock(&kexec_mutex);
+    kexec_lock();
      if (crashk_res.end != crashk_res.start)
          size = resource_size(&crashk_res);
-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      return size;
  }

@@ -1016,7 +1051,7 @@ int crash_shrink_memory(unsigned long new_size)
      unsigned long old_size;
      struct resource *ram_res;

-    mutex_lock(&kexec_mutex);
+    kexec_lock();

      if (kexec_crash_image) {
          ret = -ENOENT;
@@ -1054,7 +1089,7 @@ int crash_shrink_memory(unsigned long new_size)
      insert_resource(&iomem_resource, ram_res);

  unlock:
-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      return ret;
  }

@@ -1126,7 +1161,7 @@ int kernel_kexec(void)
  {
      int error = 0;

-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;
      if (!kexec_image) {
          error = -EINVAL;
@@ -1203,7 +1238,7 @@ int kernel_kexec(void)
  #endif

   Unlock:
-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      return error;
  }

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..52ac7573626e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -384,7 +384,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,

      image = NULL;

-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;

      dest_image = &kexec_image;
@@ -456,7 +456,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,
      if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
          arch_kexec_protect_crashkres();

-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      kimage_free(image);
      return ret;
  }
@@ -656,7 +656,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
   * kexec_add_buffer - place a buffer in a kexec segment
   * @kbuf:    Buffer contents and memory parameters.
   *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
   * On successful return, @kbuf->mem will have the physical address of
   * the buffer in memory.
   *
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 39d30ccf8d87..c26d26b3c00e 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -3,6 +3,11 @@
  #define LINUX_KEXEC_INTERNAL_H

  #include <linux/kexec.h>
+#include <linux/atomic.h>
+
+int kexec_trylock(void);
+void kexec_lock(void);
+void kexec_unlock(void);

  struct kimage *do_kimage_alloc_init(void);
  int sanity_check_segment_list(struct kimage *image);
@@ -15,7 +20,6 @@ int kimage_is_destination_range(struct kimage *image,

  int machine_kexec_post_load(struct kimage *image);

-extern struct mutex kexec_mutex;

  #ifdef CONFIG_KEXEC_FILE
  #include <linux/purgatory.h>
diff --git a/security/integrity/ima/ima_kexec.c 
b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..a26cd17b346c 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -75,7 +75,7 @@ static int ima_dump_measurement_list(unsigned long 
*buffer_size, void **buffer,
   * Called during kexec_file_load so that IMA can add a segment to the 
kexec
   * image for the measurement list for the next kernel.
   *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
   */
  void ima_add_kexec_buffer(struct kimage *image)
  {
-- 
2.25.1


