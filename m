Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AABDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDA421582
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="Cp99L3PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIIFqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:46:22 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:45234 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:46:19 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 74EECA344A;
        Wed,  9 Sep 2020 05:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1599630368; bh=I28CTFjbhssCEfwxzmd4PPRUAkEBJjiHohaBYh+LaFE=;
        h=Subject:From:To:Message-ID:Date:MIME-Version;
        b=Cp99L3PR+b3qKSSdQp7CvOLgCrchDY+/haBgRyGwJ6f1cC3rxX2ZprLDHBvTg4rW6
         2onwlNZAlCL8oC7mzvjiMnxqe/kboc6HB3u8bcuV+qiRKRtmsdr3JsVH3EoRu7qZ4r
         4MQeh8PzL/5sq/j2s6DOIFD7THqG2niN0H54jSIw=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
From:   Joerg Vehlow <lkml@jv-coder.de>
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
 <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
 <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
 <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
Message-ID: <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de>
Date:   Wed, 9 Sep 2020 07:46:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the new version of the patch based on Peters suggestion
It looks like it works fine. I added the BUG_ON to __crash_kexec, 
because it is a precondition, that panic_cpu is set correctly, otherwise 
the whole locking logic fails.

The mutex_trylock can still be used, because it is only in syscall 
context and no interrupt context.

Jörg

---
  kernel/kexec.c          |  8 ++--
  kernel/kexec_core.c     | 86 +++++++++++++++++++++++++++--------------
  kernel/kexec_file.c     |  4 +-
  kernel/kexec_internal.h |  6 ++-
  4 files changed, 69 insertions(+), 35 deletions(-)

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
index c19c0dad1ebe..71682a33b1ba 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -45,7 +45,7 @@
  #include <crypto/sha.h>
  #include "kexec_internal.h"

-DEFINE_MUTEX(kexec_mutex);
+static DEFINE_MUTEX(kexec_mutex);

  /* Per cpu memory for storing cpu states in case of system crash. */
  note_buf_t __percpu *crash_notes;
@@ -70,6 +70,43 @@ struct resource crashk_low_res = {
      .desc  = IORES_DESC_CRASH_KERNEL
  };

+void kexec_lock(void)
+{
+    /*
+     * LOCK kexec_mutex        cmpxchg(&panic_cpu, INVALID, cpu)
+     *   MB                  MB
+     * panic_cpu == INVALID        kexec_mutex == LOCKED
+     *
+     * Ensures either we observe the cmpxchg, or crash_kernel() observes
+     * our lock acquisition.
+     */
+    mutex_lock(&kexec_mutex);
+    smp_mb();
+    atomic_cond_read_acquire(&panic_cpu, VAL == PANIC_CPU_INVALID);
+}
+
+int kexec_trylock(void) {
+    if (!mutex_trylock(&kexec_mutex)) {
+        return 0;
+    }
+    smp_mb();
+    if (atomic_read(&panic_cpu) != PANIC_CPU_INVALID) {
+         mutex_unlock(&kexec_mutex);
+         return 0;
+    }
+    return 1;
+}
+
+void kexec_unlock(void)
+{
+    mutex_unlock(&kexec_mutex);
+}
+
+int kexec_is_locked(void)
+{
+    return mutex_is_locked(&kexec_mutex);
+}
+
  int kexec_should_crash(struct task_struct *p)
  {
      /*
@@ -943,24 +980,15 @@ int kexec_load_disabled;
   */
  void __noclone __crash_kexec(struct pt_regs *regs)
  {
-    /* Take the kexec_mutex here to prevent sys_kexec_load
-     * running on one cpu from replacing the crash kernel
-     * we are using after a panic on a different cpu.
-     *
-     * If the crash kernel was not located in a fixed area
-     * of memory the xchg(&kexec_crash_image) would be
-     * sufficient.  But since I reuse the memory...
-     */
-    if (mutex_trylock(&kexec_mutex)) {
-        if (kexec_crash_image) {
-            struct pt_regs fixed_regs;
-
-            crash_setup_regs(&fixed_regs, regs);
-            crash_save_vmcoreinfo();
-            machine_crash_shutdown(&fixed_regs);
-            machine_kexec(kexec_crash_image);
-        }
-        mutex_unlock(&kexec_mutex);
+    BUG_ON(atomic_read(&panic_cpu) != raw_smp_processor_id());
+
+    if (!kexec_is_locked() && kexec_crash_image) {
+        struct pt_regs fixed_regs;
+
+        crash_setup_regs(&fixed_regs, regs);
+        crash_save_vmcoreinfo();
+        machine_crash_shutdown(&fixed_regs);
+        machine_kexec(kexec_crash_image);
      }
  }
  STACK_FRAME_NON_STANDARD(__crash_kexec);
@@ -977,9 +1005,11 @@ void crash_kexec(struct pt_regs *regs)
      this_cpu = raw_smp_processor_id();
      old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
      if (old_cpu == PANIC_CPU_INVALID) {
-        /* This is the 1st CPU which comes here, so go ahead. */
-        printk_safe_flush_on_panic();
-        __crash_kexec(regs);
+        if (!kexec_is_locked()) {
+            /* This is the 1st CPU which comes here, so go ahead. */
+            printk_safe_flush_on_panic();
+            __crash_kexec(regs);
+        }

          /*
           * Reset panic_cpu to allow another panic()/crash_kexec()
@@ -993,10 +1023,10 @@ size_t crash_get_memory_size(void)
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

@@ -1016,7 +1046,7 @@ int crash_shrink_memory(unsigned long new_size)
      unsigned long old_size;
      struct resource *ram_res;

-    mutex_lock(&kexec_mutex);
+    kexec_lock();

      if (kexec_crash_image) {
          ret = -ENOENT;
@@ -1054,7 +1084,7 @@ int crash_shrink_memory(unsigned long new_size)
      insert_resource(&iomem_resource, ram_res);

  unlock:
-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      return ret;
  }

@@ -1126,7 +1156,7 @@ int kernel_kexec(void)
  {
      int error = 0;

-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;
      if (!kexec_image) {
          error = -EINVAL;
@@ -1203,7 +1233,7 @@ int kernel_kexec(void)
  #endif

   Unlock:
-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      return error;
  }

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..d40b0aedc187 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -362,7 +362,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,

      image = NULL;

-    if (!mutex_trylock(&kexec_mutex))
+    if (!kexec_trylock())
          return -EBUSY;

      dest_image = &kexec_image;
@@ -434,7 +434,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,
      if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
          arch_kexec_protect_crashkres();

-    mutex_unlock(&kexec_mutex);
+    kexec_unlock();
      kimage_free(image);
      return ret;
  }
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 39d30ccf8d87..2c1683cb1082 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -15,7 +15,11 @@ int kimage_is_destination_range(struct kimage *image,

  int machine_kexec_post_load(struct kimage *image);

-extern struct mutex kexec_mutex;
+void kexec_lock(void);
+int kexec_trylock(void);
+void kexec_unlock(void);
+int kexec_is_locked(void);
+

  #ifdef CONFIG_KEXEC_FILE
  #include <linux/purgatory.h>
-- 
2.25.1


