Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDAEC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9454A207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA1AGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47593 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:39 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOe-00033I-VG; Tue, 28 Jan 2020 01:06:26 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-01-27

up to:  fd928f3e32ba: alarmtimer: Make alarmtimer_get_rtcdev() a stub when CONFIG_RTC_CLASS=n


The timekeeping and timers departement provides:

  - Time namespace support:

    If a container migrates from one host to another then it expects that
    clocks based on MONOTONIC and BOOTTIME are not subject to
    disruption. Due to different boot time and non-suspended runtime these
    clocks can differ significantly on two hosts, in the worst case time
    goes backwards which is a violation of the POSIX requirements.

    The time namespace addresses this problem. It allows to set offsets for
    clock MONOTONIC and BOOTTIME once after creation and before tasks are
    associated with the namespace. These offsets are taken into account by
    timers and timekeeping including the VDSO.

    Offsets for wall clock based clocks (REALTIME/TAI) are not provided by
    this mechanism. While in theory possible, the overhead and code
    complexity would be immense and not justified by the esoteric potential
    use cases which were discussed at Plumbers '18.

    The overhead for tasks in the root namespace (host time offsets = 0) is
    in the noise and great effort was made to ensure that especially in the
    VDSO. If time namespace is disabled in the kernel configuration the
    code is compiled out.

    Kudos to Andrei Vagin and Dmitry Sofanov who implemented this feature
    and kept on for more than a year addressing review comments, finding
    better solutions. A pleasant experience.

  - Overhaul of the alarmtimer device dependency handling to ensure that
    the init/suspend/resume ordering is correct.

  - A new clocksource/event driver for Microchip PIT64

  - Suspend/resume support for the Hyper-V clocksource

  - The usual pile of fixes, updates and improvements mostly in the
    driver code.


Thanks,

	tglx

------------------>
Andrea Parri (2):
      clocksource/drivers/hyper-v: Untangle stimers and timesync from clocksources
      clocksource/drivers/hyper-v: Set TSC clocksource as default w/ InvariantTSC

Andrei Vagin (23):
      lib/vdso: Add unlikely() hint into vdso_read_begin()
      lib/vdso: Mark do_hres() and do_coarse() as __always_inline
      ns: Introduce Time Namespace
      time: Add timens_offsets to be used for tasks in time namespace
      posix-clocks: Rename the clock_get() callback to clock_get_timespec()
      posix-clocks: Rename .clock_get_timespec() callbacks accordingly
      alarmtimer: Rename gettime() callback to get_ktime()
      alarmtimer: Provide get_timespec() callback
      posix-clocks: Introduce clock_get_ktime() callback
      posix-timers: Use clock_get_ktime() in common_timer_get()
      posix-clocks: Wire up clock_gettime() with timens offsets
      time: Add do_timens_ktime_to_host() helper
      timerfd: Make timerfd_settime() time namespace aware
      posix-timers: Make timer_settime() time namespace aware
      alarmtimer: Make nanosleep() time namespace aware
      hrtimers: Prepare hrtimer_nanosleep() for time namespaces
      posix-timers: Make clock_nanosleep() time namespace aware
      fs/proc: Introduce /proc/pid/timens_offsets
      selftests/timens: Add a test for timerfd
      selftests/timens: Add a test for clock_nanosleep()
      selftests/timens: Add timer offsets test
      selftests/timens: Add a simple perf test for clock_gettime()
      selftests/timens: Check for right timens offsets after fork and exec

Biju Das (1):
      dt-bindings: timer: renesas, cmt: Document r8a774b1 CMT support

Boqun Feng (1):
      clocksource/drivers/hyper-v: Reserve PAGE_SIZE space for tsc page

Christophe Leroy (3):
      lib/vdso: Let do_coarse() return 0 to simplify the callsite
      lib/vdso: Avoid duplication in __cvdso_clock_getres()
      lib/vdso: Only read hrtimer_res when needed in __cvdso_clock_getres()

Chunyan Zhang (1):
      tick/common: Touch watchdog in tick_unfreeze() on all CPUs

Claudiu Beznea (2):
      clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support
      clocksource/drivers/timer-microchip-pit64b: Fix sparse warning

Colin Ian King (1):
      clocksource/drivers/bcm2835_timer: Fix memory leak of timer

Dexuan Cui (1):
      clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation

Dmitry Safonov (10):
      fs/proc: Respect boottime inside time namespace for /proc/uptime
      x86/vdso: Restrict splitting VVAR VMA
      x86/vdso: Provide vdso_data offset on vvar_page
      x86/vdso: Add time napespace page
      time: Allocate per-timens vvar page
      x86/vdso: Handle faults on timens page
      x86/vdso: On timens page fault prefault also VVAR page
      x86/vdso: Zap vvar pages when switching to a time namespace
      selftests/timens: Add Time Namespace test for supported clocks
      selftests/timens: Add procfs selftest

Jules Irenge (1):
      hrtimer: Add missing sparse annotation for __run_timer()

Krzysztof Kozlowski (2):
      clocksource: Fix Kconfig indentation
      clocksource/drivers/exynos_mct: Rename Exynos to lowercase

Paul Cercueil (1):
      time/sched_clock: Disable interrupts in sched_clock_register()

Rajan Vaja (1):
      clocksource/drivers/cadence-ttc: Use ttc driver as platform driver

Randy Dunlap (1):
      clocksource: Fix Kconfig miscues

Stephen Boyd (5):
      alarmtimer: Unregister wakeup source when module get fails
      alarmtimer: Update alarmtimer_get_rtcdev() docs to reflect reality
      alarmtimer: Make alarmtimer platform device child of RTC device
      alarmtimer: Use wakeup source from alarmtimer platform device
      alarmtimer: Make alarmtimer_get_rtcdev() a stub when CONFIG_RTC_CLASS=n

Thomas Gleixner (3):
      ARM: vdso: Set BUILD_VDSO32 and provide 32bit fallbacks
      lib/vdso: Prepare for time namespace support
      MIPS: vdso: Define BUILD_VDSO32 when building a 32bit kernel

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix uninitialized pointer access

Vincenzo Frascino (7):
      arm64: compat: vdso: Expose BUILD_VDSO32
      lib/vdso: Build 32 bit specific functions in the right context
      lib/vdso: Remove VDSO_HAS_32BIT_FALLBACK
      lib/vdso: Remove checks on return value for 32 bit vDSO
      arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
      mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
      x86/vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

Yangtao Li (4):
      clocksource/drivers/em_sti: Convert to devm_platform_ioremap_resource
      clocksource/drivers/em_sti: Fix variable declaration in em_sti_probe
      clocksource/drivers/timer-ti-dm: Convert to devm_platform_ioremap_resource
      clocksource/drivers/timer-ti-dm: Switch to platform_get_irq


 .../devicetree/bindings/arm/atmel-sysregs.txt      |   6 +
 .../devicetree/bindings/timer/renesas,cmt.txt      |   2 +
 MAINTAINERS                                        |   2 +
 arch/arm/include/asm/vdso/gettimeofday.h           |  36 ++
 arch/arm/vdso/Makefile                             |   2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |   2 +-
 arch/mips/include/asm/vdso/gettimeofday.h          |   2 -
 arch/mips/vdso/Makefile                            |   4 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/entry/vdso/vdso-layout.lds.S              |  13 +-
 arch/x86/entry/vdso/vdso2c.c                       |   3 +
 arch/x86/entry/vdso/vma.c                          | 120 +++++-
 arch/x86/include/asm/vdso.h                        |   1 +
 arch/x86/include/asm/vdso/gettimeofday.h           |  10 +-
 arch/x86/include/asm/vvar.h                        |  13 +-
 arch/x86/kernel/vmlinux.lds.S                      |   4 +-
 drivers/clocksource/Kconfig                        |  76 ++--
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/bcm2835_timer.c                |   5 +-
 drivers/clocksource/em_sti.c                       |   7 +-
 drivers/clocksource/exynos_mct.c                   |   2 +-
 drivers/clocksource/hyperv_timer.c                 |  84 +++-
 drivers/clocksource/timer-cadence-ttc.c            |  26 +-
 drivers/clocksource/timer-microchip-pit64b.c       | 451 ++++++++++++++++++++
 drivers/clocksource/timer-ti-dm.c                  |  20 +-
 drivers/hv/hv_util.c                               |   8 +-
 fs/proc/base.c                                     |  94 +++++
 fs/proc/namespaces.c                               |   4 +
 fs/proc/uptime.c                                   |   3 +
 fs/timerfd.c                                       |   3 +
 include/clocksource/hyperv_timer.h                 |   2 +-
 include/linux/alarmtimer.h                         |   4 +
 include/linux/hrtimer.h                            |   3 +-
 include/linux/nsproxy.h                            |   2 +
 include/linux/proc_ns.h                            |   3 +
 include/linux/time.h                               |   6 +
 include/linux/time_namespace.h                     | 133 ++++++
 include/linux/user_namespace.h                     |   1 +
 include/uapi/linux/sched.h                         |   6 +
 include/vdso/datapage.h                            |  19 +-
 include/vdso/helpers.h                             |   2 +-
 init/Kconfig                                       |   8 +
 kernel/fork.c                                      |  16 +-
 kernel/nsproxy.c                                   |  41 +-
 kernel/time/Makefile                               |   1 +
 kernel/time/alarmtimer.c                           | 121 +++---
 kernel/time/hrtimer.c                              |  14 +-
 kernel/time/namespace.c                            | 468 +++++++++++++++++++++
 kernel/time/posix-clock.c                          |   8 +-
 kernel/time/posix-cpu-timers.c                     |  32 +-
 kernel/time/posix-stubs.c                          |  15 +-
 kernel/time/posix-timers.c                         |  88 ++--
 kernel/time/posix-timers.h                         |   7 +-
 kernel/time/sched_clock.c                          |   7 +-
 kernel/time/tick-common.c                          |   2 +
 lib/vdso/Kconfig                                   |   6 +
 lib/vdso/gettimeofday.c                            | 204 +++++++--
 mm/mmap.c                                          |   2 +
 tools/perf/examples/bpf/5sec.c                     |   6 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/timens/.gitignore          |   8 +
 tools/testing/selftests/timens/Makefile            |   7 +
 tools/testing/selftests/timens/clock_nanosleep.c   | 149 +++++++
 tools/testing/selftests/timens/config              |   1 +
 tools/testing/selftests/timens/exec.c              |  94 +++++
 tools/testing/selftests/timens/gettime_perf.c      |  95 +++++
 tools/testing/selftests/timens/log.h               |  26 ++
 tools/testing/selftests/timens/procfs.c            | 144 +++++++
 tools/testing/selftests/timens/timens.c            | 190 +++++++++
 tools/testing/selftests/timens/timens.h            | 100 +++++
 tools/testing/selftests/timens/timer.c             | 122 ++++++
 tools/testing/selftests/timens/timerfd.c           | 128 ++++++
 72 files changed, 3027 insertions(+), 270 deletions(-)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 kernel/time/namespace.c
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/exec.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/procfs.c
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h
 create mode 100644 tools/testing/selftests/timens/timer.c
 create mode 100644 tools/testing/selftests/timens/timerfd.c

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 9fbde401a090..e003a553b986 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -10,6 +10,12 @@ PIT Timer required properties:
 - interrupts: Should contain interrupt for the PIT which is the IRQ line
   shared across all System Controller members.
 
+PIT64B Timer required properties:
+- compatible: Should be "microchip,sam9x60-pit64b"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt for PIT64B timer
+- clocks: Should contain the available clock sources for PIT64B timer.
+
 System Timer (ST) required properties:
 - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
 - reg: Should contain registers location and length
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index a444cfc5852a..a747fabab7d3 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -29,6 +29,8 @@ Required Properties:
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
     - "renesas,r8a774a1-cmt1" for the 48-bit CMT devices included in r8a774a1.
+    - "renesas,r8a774b1-cmt0" for the 32-bit CMT0 device included in r8a774b1.
+    - "renesas,r8a774b1-cmt1" for the 48-bit CMT devices included in r8a774b1.
     - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
     - "renesas,r8a774c0-cmt1" for the 48-bit CMT devices included in r8a774c0.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..f6d00023e56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13214,6 +13214,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
+F:	include/linux/time_namespace.h
+F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 0ad2429c324f..fe6e1f65932d 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -52,6 +52,24 @@ static __always_inline long clock_gettime_fallback(
 	return ret;
 }
 
+static __always_inline long clock_gettime32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline int clock_getres_fallback(
 					clockid_t _clkid,
 					struct __kernel_timespec *_ts)
@@ -70,6 +88,24 @@ static __always_inline int clock_getres_fallback(
 	return ret;
 }
 
+static __always_inline int clock_getres32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline u64 __arch_get_hw_counter(int clock_mode)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 0fda344beb0b..1babb392e70a 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -14,7 +14,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
-ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
 
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index c50ee1b7d5cd..537b1e695365 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -16,7 +16,7 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
-#define VDSO_HAS_32BIT_FALLBACK		1
+#define BUILD_VDSO32			1
 
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index 0ae9b4cbc153..a58687e26c5d 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -96,8 +96,6 @@ static __always_inline int clock_getres_fallback(
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline long clock_gettime32_fallback(
 					clockid_t _clkid,
 					struct old_timespec32 *_ts)
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index e05938997e69..b2a2e032dc99 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -18,6 +18,10 @@ ccflags-vdso := \
 	$(filter -mno-loongson-%,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 
+ifndef CONFIG_64BIT
+ccflags-vdso += -DBUILD_VDSO32
+endif
+
 ifdef CONFIG_CC_IS_CLANG
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..a2488c372fa1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,6 +124,7 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..ea7e0155c604 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -16,18 +16,23 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
-	vvar_page = vvar_start;
+	vvar_start = . - 4 * PAGE_SIZE;
+	vvar_page  = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page  = vvar_start + 3 * PAGE_SIZE;
+
+#undef _ASM_X86_VVAR_H
+	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) timens_ ## name = timens_page + offset;
+#include <asm/vvar.h>
+#undef EMIT_VVAR
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3a4d8d4d39f8..3842873b3ae3 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -75,12 +75,14 @@ enum {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -93,6 +95,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f5937742b290..c1b8496b5606 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,16 +14,30 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
+
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
 #include <asm/vvar.h>
+#include <asm/tlb.h>
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <clocksource/hyperv_timer.h>
 
+#undef _ASM_X86_VVAR_H
+#define EMIT_VVAR(name, offset)	\
+	const size_t name ## _offset = offset;
+#include <asm/vvar.h>
+
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+}
+#undef EMIT_VVAR
+
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
@@ -37,6 +51,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 						image->alt_len));
 }
 
+static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -84,10 +99,74 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	const struct vdso_image *image = new_vma->vm_mm->context.vdso_image;
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef CONFIG_TIME_NS
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+#else
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
+	unsigned long pfn;
 	long sym_offset;
 
 	if (!image)
@@ -107,8 +186,36 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		return VM_FAULT_SIGBUS;
 
 	if (sym_offset == image->sym_vvar_page) {
-		return vmf_insert_pfn(vma, vmf->address,
-				__pa_symbol(&__vvar_page) >> PAGE_SHIFT);
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the sym_vvar_page offset and
+		 * the real VVAR page is mapped with the sym_timens_page
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (timens_page) {
+			unsigned long addr;
+			vm_fault_t err;
+
+			/*
+			 * Optimization: inside time namespace pre-fault
+			 * VVAR page too. As on timens page there are only
+			 * offsets for clocks on VVAR, it'll be faulted
+			 * shortly by VDSO code.
+			 */
+			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+
+			pfn = page_to_pfn(timens_page);
+		}
+
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
@@ -123,6 +230,14 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
+	} else if (sym_offset == image->sym_timens_page) {
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
@@ -136,6 +251,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 /*
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 230474e2ddb5..bbcdc7b8f963 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -21,6 +21,7 @@ struct vdso_image {
 	long sym_vvar_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index e9ee139cf29e..6ee1f7dba34b 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -21,6 +21,7 @@
 #include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
+#define __timens_vdso_data (TIMENS(_vdso_data))
 
 #define VDSO_HAS_TIME 1
 
@@ -56,6 +57,13 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_TIME_NS
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return __timens_vdso_data;
+}
+#endif
+
 #ifndef BUILD_VDSO32
 
 static __always_inline
@@ -96,8 +104,6 @@ long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 #else
 
-#define VDSO_HAS_32BIT_FALLBACK	1
-
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 32f5d9a0b90e..183e98e49ab9 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,10 +19,10 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
 
-#if defined(__VVAR_KERNEL_LDS)
-
-/* The kernel linker script defines its own magic to put vvars in the
- * right place.
+#ifdef EMIT_VVAR
+/*
+ * EMIT_VVAR() is used by the kernel linker script to put vvars in the
+ * right place. Also, it's used by kernel code to import offsets values.
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
@@ -33,9 +33,12 @@ extern char __vvar_page;
 
 #define DECLARE_VVAR(offset, type, name)				\
 	extern type vvar_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));
+	__attribute__((visibility("hidden")));				\
+	extern type timens_ ## name[CS_BASES]				\
+	__attribute__((visibility("hidden")));				\
 
 #define VVAR(name) (vvar_ ## name)
+#define TIMENS(name) (timens_ ## name)
 
 #define DEFINE_VVAR(type, name)						\
 	type name[CS_BASES]						\
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..e3296aa028fe 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -193,12 +193,10 @@ SECTIONS
 		__vvar_beginning_hack = .;
 
 		/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) 			\
+#define EMIT_VVAR(name, offset)				\
 		. = __vvar_beginning_hack + offset;	\
 		*(.vvar_ ## name)
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 		/*
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76cb1768..cc909e465823 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -88,7 +88,7 @@ config ROCKCHIP_TIMER
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  Enables the support for the rockchip timer driver.
+	  Enables the support for the Rockchip timer driver.
 
 config ARMADA_370_XP_TIMER
 	bool "Armada 370 and XP timer driver" if COMPILE_TEST
@@ -162,13 +162,13 @@ config NPCM7XX_TIMER
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
-	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
+	  where TIMER0 serves as clockevent and TIMER1 serves as clocksource.
 
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
 	help
-	  Enables support for the cadence ttc driver.
+	  Enables support for the Cadence TTC driver.
 
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
@@ -190,10 +190,10 @@ config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Use the always on PRCMU Timer as clocksource
+	  Use the always on PRCMU Timer as clocksource.
 
 config CLPS711X_TIMER
-	bool "Cirrus logic timer driver" if COMPILE_TEST
+	bool "Cirrus Logic timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Cirrus Logic PS711 timer.
@@ -205,11 +205,11 @@ config ATLAS7_TIMER
 	  Enables support for the Atlas7 timer.
 
 config MXS_TIMER
-	bool "Mxs timer driver" if COMPILE_TEST
+	bool "MXS timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select STMP_DEVICE
 	help
-	  Enables support for the Mxs timer.
+	  Enables support for the MXS timer.
 
 config PRIMA2_TIMER
 	bool "Prima2 timer driver" if COMPILE_TEST
@@ -238,10 +238,10 @@ config KEYSTONE_TIMER
 	  Enables support for the Keystone timer.
 
 config INTEGRATOR_AP_TIMER
-	bool "Integrator-ap timer driver" if COMPILE_TEST
+	bool "Integrator-AP timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Enables support for the Integrator-ap timer.
+	  Enables support for the Integrator-AP timer.
 
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
@@ -283,8 +283,8 @@ config CLKSRC_NPS
 	select TIMER_OF if OF
 	help
 	  NPS400 clocksource support.
-	  Got 64 bit counter with update rate up to 1000MHz.
-	  This counter is accessed via couple of 32 bit memory mapped registers.
+	  It has a 64-bit counter with update rate up to 1000MHz.
+	  This counter is accessed via couple of 32-bit memory-mapped registers.
 
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
@@ -305,14 +305,14 @@ config ARC_TIMERS
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
 	  (ARC700 as well as ARC HS38).
-	  TIMER0 serves as clockevent while TIMER1 provides clocksource
+	  TIMER0 serves as clockevent while TIMER1 provides clocksource.
 
 config ARC_TIMERS_64BIT
 	bool "Support for 64-bit counters in ARC HS38 cores" if COMPILE_TEST
 	depends on ARC_TIMERS
 	select TIMER_OF
 	help
-	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
+	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP).
 	  RTC is implemented inside the core, while GFRC sits outside the core in
 	  ARConnect IP block. Driver automatically picks one of them for clocksource
 	  as appropriate.
@@ -390,7 +390,7 @@ config ARM_GLOBAL_TIMER
 	select TIMER_OF if OF
 	depends on ARM
 	help
-	  This options enables support for the ARM global timer unit
+	  This option enables support for the ARM global timer unit.
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
@@ -403,14 +403,14 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	depends on ARM_GLOBAL_TIMER
 	default y
 	help
-	 Use ARM global timer clock source as sched_clock
+	  Use ARM global timer clock source as sched_clock.
 
 config ARMV7M_SYSTICK
 	bool "Support for the ARMv7M system time" if COMPILE_TEST
 	select TIMER_OF if OF
 	select CLKSRC_MMIO
 	help
-	  This options enables support for the ARMv7M system timer unit
+	  This option enables support for the ARMv7M system timer unit.
 
 config ATMEL_PIT
 	bool "Atmel PIT support" if COMPILE_TEST
@@ -460,7 +460,7 @@ config VF_PIT_TIMER
 	bool
 	select CLKSRC_MMIO
 	help
-	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
 
 config OXNAS_RPS_TIMER
 	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
@@ -470,7 +470,7 @@ config OXNAS_RPS_TIMER
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
 
 config SYS_SUPPORTS_SH_CMT
-        bool
+	bool
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
@@ -490,13 +490,13 @@ config SPRD_TIMER
 	  Enables support for the Spreadtrum timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
-        bool
+	bool
 
 config SYS_SUPPORTS_SH_TMU
-        bool
+	bool
 
 config SYS_SUPPORTS_EM_STI
-        bool
+	bool
 
 config CLKSRC_JCORE_PIT
 	bool "J-Core PIT timer driver" if COMPILE_TEST
@@ -523,7 +523,7 @@ config SH_TIMER_MTU2
 	help
 	  This enables build of a clockevent driver for the Multi-Function
 	  Timer Pulse Unit 2 (MTU2) hardware available on SoCs from Renesas.
-	  This hardware comes with 16 bit-timer registers.
+	  This hardware comes with 16-bit timer registers.
 
 config RENESAS_OSTM
 	bool "Renesas OSTM timer driver" if COMPILE_TEST
@@ -580,7 +580,7 @@ config CLKSRC_TANGO_XTAL
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  This enables the clocksource for Tango SoC
+	  This enables the clocksource for Tango SoC.
 
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
@@ -591,24 +591,24 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
-	  H83069 cpu.
+	  H83069 CPU.
 
 config H8300_TPU
-        bool "Clocksource for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clocksource for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
-	  H8S2678 cpu.
+	  H8S2678 CPU.
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
@@ -666,8 +666,8 @@ config CSKY_MP_TIMER
 	help
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
 	  system.
-	  csky,mptimer is not only used in SMP system, it also could be used
-	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+	  csky,mptimer is not only used in SMP system, it also could be used in
+	  single core system. It's not a mmio reg and it uses mtcr/mfcr instruction.
 
 config GX6605S_TIMER
 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
@@ -697,4 +697,14 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config MICROCHIP_PIT64B
+	bool "Microchip PIT64B support"
+	depends on OF || COMPILE_TEST
+	select CLKSRC_MMIO
+	help
+	  This option enables Microchip PIT64B timer for Atmel
+	  based system. It supports the oneshot, the periodic
+	  modes and high resolution. It is used as a clocksource
+	  and a clockevent.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4dfe4225ece7..713686faa549 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
+obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 2b196cbfadb6..b235f446ee50 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -121,7 +121,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
-		goto err_iounmap;
+		goto err_timer_free;
 	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
@@ -130,6 +130,9 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	return 0;
 
+err_timer_free:
+	kfree(timer);
+
 err_iounmap:
 	iounmap(base);
 	return ret;
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 9039df4f90e2..ab190dffb1ed 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,9 +279,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	struct resource *res;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
@@ -295,8 +293,7 @@ static int em_sti_probe(struct platform_device *pdev)
 		return irq;
 
 	/* map memory, let base point to the STI instance */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 74cb299f5089..a267fe31ef13 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4 MCT(Multi-Core Timer) support
+ * Exynos4 MCT(Multi-Core Timer) support
 */
 
 #include <linux/interrupt.h>
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 287d8d58c21a..9d808d595ca8 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -66,7 +66,7 @@ static int hv_ce_set_next_event(unsigned long delta,
 {
 	u64 current_tick;
 
-	current_tick = hyperv_cs->read(NULL);
+	current_tick = hv_read_reference_counter();
 	current_tick += delta;
 	hv_init_timer(0, current_tick);
 	return 0;
@@ -302,22 +302,33 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * the other that uses the TSC reference page feature as defined in the
  * TLFS.  The MSR version is for compatibility with old versions of
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ *
+ * The Hyper-V clocksource ratings of 250 are chosen to be below the
+ * TSC clocksource rating of 300.  In configurations where Hyper-V offers
+ * an InvariantTSC, the TSC is not marked "unstable", so the TSC clocksource
+ * is available and preferred.  With the higher rating, it will be the
+ * default.  On older hardware and Hyper-V versions, the TSC is marked
+ * "unstable", so no TSC clocksource is created and the selected Hyper-V
+ * clocksource will be the default.
  */
 
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
+u64 (*hv_read_reference_counter)(void);
+EXPORT_SYMBOL_GPL(hv_read_reference_counter);
 
-static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
+static union {
+	struct ms_hyperv_tsc_page page;
+	u8 reserved[PAGE_SIZE];
+} tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return &tsc_pg;
+	return &tsc_pg.page;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
+static u64 notrace read_hv_clock_tsc(void)
 {
-	u64 current_tick = hv_read_tsc_page(&tsc_pg);
+	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -325,20 +336,50 @@ static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
+{
+	return read_hv_clock_tsc();
+}
+
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_tsc() - hv_sched_clock_offset;
+}
+
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
 }
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 400,
-	.read	= read_hv_clock_tsc,
+	.rating	= 250,
+	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend= suspend_hv_clock_tsc,
+	.resume	= resume_hv_clock_tsc,
 };
 
-static u64 notrace read_hv_clock_msr(struct clocksource *arg)
+static u64 notrace read_hv_clock_msr(void)
 {
 	u64 current_tick;
 	/*
@@ -350,15 +391,20 @@ static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
+{
+	return read_hv_clock_msr();
+}
+
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_msr() - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 400,
-	.read	= read_hv_clock_msr,
+	.rating	= 250,
+	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -371,8 +417,8 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = virt_to_phys(&tsc_pg);
+	hv_read_reference_counter = read_hv_clock_tsc;
+	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
@@ -389,7 +435,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
@@ -411,10 +457,10 @@ void __init hv_init_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
 		return;
 
-	hyperv_cs = &hyperv_cs_msr;
+	hv_read_reference_counter = read_hv_clock_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9ba9a3..38858e141731 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
 
 /*
  * This driver configures the 2 16/32-bit count-up timers as follows:
@@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	return 0;
 }
 
-/**
- * ttc_timer_init - Initialize the timer
- *
- * Initializes the timer hardware and register the clock source and clock event
- * timers with Linux kernal timer framework
- */
-static int __init ttc_timer_init(struct device_node *timer)
+static int __init ttc_timer_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	static int initialized;
 	int clksel, ret;
 	u32 timer_width = 16;
+	struct device_node *timer = pdev->dev.of_node;
 
 	if (initialized)
 		return 0;
@@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
 	return 0;
 }
 
-TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
+static const struct of_device_id ttc_timer_of_match[] = {
+	{.compatible = "cdns,ttc"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
+
+static struct platform_driver ttc_timer_driver = {
+	.driver = {
+		.name	= "cdns_ttc_timer",
+		.of_match_table = ttc_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
new file mode 100644
index 000000000000..bd63d3484838
--- /dev/null
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 64-bit Periodic Interval Timer driver
+ *
+ * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define MCHP_PIT64B_CR			0x00	/* Control Register */
+#define MCHP_PIT64B_CR_START		BIT(0)
+#define MCHP_PIT64B_CR_SWRST		BIT(8)
+
+#define MCHP_PIT64B_MR			0x04	/* Mode Register */
+#define MCHP_PIT64B_MR_CONT		BIT(0)
+#define MCHP_PIT64B_MR_ONE_SHOT		(0)
+#define MCHP_PIT64B_MR_SGCLK		BIT(3)
+#define MCHP_PIT64B_MR_PRES		GENMASK(11, 8)
+
+#define MCHP_PIT64B_LSB_PR		0x08	/* LSB Period Register */
+
+#define MCHP_PIT64B_MSB_PR		0x0C	/* MSB Period Register */
+
+#define MCHP_PIT64B_IER			0x10	/* Interrupt Enable Register */
+#define MCHP_PIT64B_IER_PERIOD		BIT(0)
+
+#define MCHP_PIT64B_ISR			0x1C	/* Interrupt Status Register */
+
+#define MCHP_PIT64B_TLSBR		0x20	/* Timer LSB Register */
+
+#define MCHP_PIT64B_TMSBR		0x24	/* Timer MSB Register */
+
+#define MCHP_PIT64B_PRES_MAX		0x10
+#define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
+#define MCHP_PIT64B_PRES_TO_MODE(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
+#define MCHP_PIT64B_MODE_TO_PRES(m)	((MCHP_PIT64B_MR_PRES & (m)) >> 8)
+#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
+#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
+
+#define MCHP_PIT64B_NAME		"pit64b"
+
+/**
+ * struct mchp_pit64b_timer - PIT64B timer data structure
+ * @base: base address of PIT64B hardware block
+ * @pclk: PIT64B's peripheral clock
+ * @gclk: PIT64B's generic clock
+ * @mode: precomputed value for mode register
+ */
+struct mchp_pit64b_timer {
+	void __iomem	*base;
+	struct clk	*pclk;
+	struct clk	*gclk;
+	u32		mode;
+};
+
+/**
+ * mchp_pit64b_clkevt - PIT64B clockevent data structure
+ * @timer: PIT64B timer
+ * @clkevt: clockevent
+ */
+struct mchp_pit64b_clkevt {
+	struct mchp_pit64b_timer	timer;
+	struct clock_event_device	clkevt;
+};
+
+#define to_mchp_pit64b_timer(x) \
+	((struct mchp_pit64b_timer *)container_of(x,\
+		struct mchp_pit64b_clkevt, clkevt))
+
+/* Base address for clocksource timer. */
+static void __iomem *mchp_pit64b_cs_base;
+/* Default cycles for clockevent timer. */
+static u64 mchp_pit64b_ce_cycles;
+
+static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
+{
+	unsigned long	flags;
+	u32		low, high;
+
+	raw_local_irq_save(flags);
+
+	/*
+	 * When using a 64 bit period TLSB must be read first, followed by the
+	 * read of TMSB. This sequence generates an atomic read of the 64 bit
+	 * timer value whatever the lapse of time between the accesses.
+	 */
+	low = readl_relaxed(base + MCHP_PIT64B_TLSBR);
+	high = readl_relaxed(base + MCHP_PIT64B_TMSBR);
+
+	raw_local_irq_restore(flags);
+
+	return (((u64)high << 32) | low);
+}
+
+static inline void mchp_pit64b_reset(struct mchp_pit64b_timer *timer,
+				     u64 cycles, u32 mode, u32 irqs)
+{
+	u32 low, high;
+
+	low = cycles & MCHP_PIT64B_LSBMASK;
+	high = cycles >> 32;
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	writel_relaxed(mode | timer->mode, timer->base + MCHP_PIT64B_MR);
+	writel_relaxed(high, timer->base + MCHP_PIT64B_MSB_PR);
+	writel_relaxed(low, timer->base + MCHP_PIT64B_LSB_PR);
+	writel_relaxed(irqs, timer->base + MCHP_PIT64B_IER);
+	writel_relaxed(MCHP_PIT64B_CR_START, timer->base + MCHP_PIT64B_CR);
+}
+
+static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
+static u64 mchp_pit64b_sched_read_clk(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
+static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
+			  MCHP_PIT64B_IER_PERIOD);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
+
+	return 0;
+}
+
+static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer->gclk);
+	clk_disable_unprepare(timer->pclk);
+}
+
+static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
+{
+	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+
+	clk_prepare_enable(timer->pclk);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_prepare_enable(timer->gclk);
+}
+
+static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
+{
+	struct mchp_pit64b_clkevt *irq_data = dev_id;
+
+	/* Need to clear the interrupt. */
+	readl_relaxed(irq_data->timer.base + MCHP_PIT64B_ISR);
+
+	irq_data->clkevt.event_handler(&irq_data->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
+					    u32 max_rate)
+{
+	u32 tmp;
+
+	for (*pres = 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
+		tmp = clk_rate / (*pres + 1);
+		if (tmp <= max_rate)
+			break;
+	}
+
+	/* Use the bigest prescaler if we didn't match one. */
+	if (*pres == MCHP_PIT64B_PRES_MAX)
+		*pres = MCHP_PIT64B_PRES_MAX - 1;
+}
+
+/**
+ * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
+ *			   runtime; this includes prescaler and SGCLK bit
+ *
+ * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
+ * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
+ * could be changed via clock APIs. The chosen clock (pclk or gclk) could be
+ * divided by the internal PIT64B's divider.
+ *
+ * This function, first tries to use GCLK by requesting the desired rate from
+ * PMC and then using the internal PIT64B prescaler, if any, to reach the
+ * requested rate. If PCLK/GCLK < 3 (condition requested by PIT64B hardware)
+ * then the function falls back on using PCLK as clock source for PIT64B timer
+ * choosing the highest prescaler in case it doesn't locate one to match the
+ * requested frequency.
+ *
+ * Below is presented the PIT64B block in relation with PMC:
+ *
+ *                                PIT64B
+ *  PMC             +------------------------------------+
+ * +----+           |   +-----+                          |
+ * |    |-->gclk -->|-->|     |    +---------+  +-----+  |
+ * |    |           |   | MUX |--->| Divider |->|timer|  |
+ * |    |-->pclk -->|-->|     |    +---------+  +-----+  |
+ * +----+           |   +-----+                          |
+ *                  |      ^                             |
+ *                  |     sel                            |
+ *                  +------------------------------------+
+ *
+ * Where:
+ *	- gclk rate <= pclk rate/3
+ *	- gclk rate could be requested from PMC
+ *	- pclk rate is fixed (cannot be requested from PMC)
+ */
+static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
+					unsigned long max_rate)
+{
+	unsigned long pclk_rate, diff = 0, best_diff = ULONG_MAX;
+	long gclk_round = 0;
+	u32 pres, best_pres = 0;
+
+	pclk_rate = clk_get_rate(timer->pclk);
+	if (!pclk_rate)
+		return -EINVAL;
+
+	timer->mode = 0;
+
+	/* Try using GCLK. */
+	gclk_round = clk_round_rate(timer->gclk, max_rate);
+	if (gclk_round < 0)
+		goto pclk;
+
+	if (pclk_rate / gclk_round < 3)
+		goto pclk;
+
+	mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
+	best_diff = abs(gclk_round / (pres + 1) - max_rate);
+	best_pres = pres;
+
+	if (!best_diff) {
+		timer->mode |= MCHP_PIT64B_MR_SGCLK;
+		goto done;
+	}
+
+pclk:
+	/* Check if requested rate could be obtained using PCLK. */
+	mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
+	diff = abs(pclk_rate / (pres + 1) - max_rate);
+
+	if (best_diff > diff) {
+		/* Use PCLK. */
+		best_pres = pres;
+	} else {
+		/* Use GCLK. */
+		timer->mode |= MCHP_PIT64B_MR_SGCLK;
+		clk_set_rate(timer->gclk, gclk_round);
+	}
+
+done:
+	timer->mode |= MCHP_PIT64B_PRES_TO_MODE(best_pres);
+
+	pr_info("PIT64B: using clk=%s with prescaler %u, freq=%lu [Hz]\n",
+		timer->mode & MCHP_PIT64B_MR_SGCLK ? "gclk" : "pclk", best_pres,
+		timer->mode & MCHP_PIT64B_MR_SGCLK ?
+		gclk_round / (best_pres + 1) : pclk_rate / (best_pres + 1));
+
+	return 0;
+}
+
+static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
+					  u32 clk_rate)
+{
+	int ret;
+
+	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
+
+	mchp_pit64b_cs_base = timer->base;
+
+	ret = clocksource_mmio_init(timer->base, MCHP_PIT64B_NAME, clk_rate,
+				    210, 64, mchp_pit64b_clksrc_read);
+	if (ret) {
+		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
+
+		/* Stop timer. */
+		writel_relaxed(MCHP_PIT64B_CR_SWRST,
+			       timer->base + MCHP_PIT64B_CR);
+
+		return ret;
+	}
+
+	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
+
+	return 0;
+}
+
+static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
+					  u32 clk_rate, u32 irq)
+{
+	struct mchp_pit64b_clkevt *ce;
+	int ret;
+
+	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
+	if (!ce)
+		return -ENOMEM;
+
+	mchp_pit64b_ce_cycles = DIV_ROUND_CLOSEST(clk_rate, HZ);
+
+	ce->timer.base = timer->base;
+	ce->timer.pclk = timer->pclk;
+	ce->timer.gclk = timer->gclk;
+	ce->timer.mode = timer->mode;
+	ce->clkevt.name = MCHP_PIT64B_NAME;
+	ce->clkevt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
+	ce->clkevt.rating = 150;
+	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
+	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
+	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
+	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
+	ce->clkevt.cpumask = cpumask_of(0);
+	ce->clkevt.irq = irq;
+
+	ret = request_irq(irq, mchp_pit64b_interrupt, IRQF_TIMER,
+			  "pit64b_tick", ce);
+	if (ret) {
+		pr_debug("clkevt: Failed to setup PIT64B IRQ\n");
+		kfree(ce);
+		return ret;
+	}
+
+	clockevents_config_and_register(&ce->clkevt, clk_rate, 1, ULONG_MAX);
+
+	return 0;
+}
+
+static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
+					    bool clkevt)
+{
+	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
+	struct mchp_pit64b_timer timer;
+	unsigned long clk_rate;
+	u32 irq = 0;
+	int ret;
+
+	/* Parse DT node. */
+	timer.pclk = of_clk_get_by_name(node, "pclk");
+	if (IS_ERR(timer.pclk))
+		return PTR_ERR(timer.pclk);
+
+	timer.gclk = of_clk_get_by_name(node, "gclk");
+	if (IS_ERR(timer.gclk))
+		return PTR_ERR(timer.gclk);
+
+	timer.base = of_iomap(node, 0);
+	if (!timer.base)
+		return -ENXIO;
+
+	if (clkevt) {
+		irq = irq_of_parse_and_map(node, 0);
+		if (!irq) {
+			ret = -ENODEV;
+			goto io_unmap;
+		}
+	}
+
+	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
+	ret = mchp_pit64b_init_mode(&timer, freq);
+	if (ret)
+		goto irq_unmap;
+
+	ret = clk_prepare_enable(timer.pclk);
+	if (ret)
+		goto irq_unmap;
+
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK) {
+		ret = clk_prepare_enable(timer.gclk);
+		if (ret)
+			goto pclk_unprepare;
+
+		clk_rate = clk_get_rate(timer.gclk);
+	} else {
+		clk_rate = clk_get_rate(timer.pclk);
+	}
+	clk_rate = clk_rate / (MCHP_PIT64B_MODE_TO_PRES(timer.mode) + 1);
+
+	if (clkevt)
+		ret = mchp_pit64b_init_clkevt(&timer, clk_rate, irq);
+	else
+		ret = mchp_pit64b_init_clksrc(&timer, clk_rate);
+
+	if (ret)
+		goto gclk_unprepare;
+
+	return 0;
+
+gclk_unprepare:
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer.gclk);
+pclk_unprepare:
+	clk_disable_unprepare(timer.pclk);
+irq_unmap:
+	irq_dispose_mapping(irq);
+io_unmap:
+	iounmap(timer.base);
+
+	return ret;
+}
+
+static int __init mchp_pit64b_dt_init(struct device_node *node)
+{
+	static int inits;
+
+	switch (inits++) {
+	case 0:
+		/* 1st request, register clockevent. */
+		return mchp_pit64b_dt_init_timer(node, true);
+	case 1:
+		/* 2nd request, register clocksource. */
+		return mchp_pit64b_dt_init_timer(node, false);
+	}
+
+	/* The rest, don't care. */
+	return -EINVAL;
+}
+
+TIMER_OF_DECLARE(mchp_pit64b, "microchip,sam9x60-pit64b", mchp_pit64b_dt_init);
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5394d9dbdfbc..269a994d6a99 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *mem, *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -796,24 +795,16 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!irq)) {
-		dev_err(dev, "%s: no IRQ resource.\n", __func__);
-		return -ENODEV;
-	}
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
+
 	timer->fclk = ERR_PTR(-ENODEV);
-	timer->io_base = devm_ioremap_resource(dev, mem);
+	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
@@ -836,7 +827,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (pdata)
 		timer->errata = pdata->timer_errata;
 
-	timer->irq = irq->start;
 	timer->pdev = pdev;
 
 	pm_runtime_enable(dev);
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd8457346..296f9098c9e4 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -211,7 +211,7 @@ static struct timespec64 hv_get_adj_host_time(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host_ts.lock, flags);
-	reftime = hyperv_cs->read(hyperv_cs);
+	reftime = hv_read_reference_counter();
 	newtime = host_ts.host_time + (reftime - host_ts.ref_time);
 	ts = ns_to_timespec64((newtime - WLTIMEDELTA) * 100);
 	spin_unlock_irqrestore(&host_ts.lock, flags);
@@ -250,7 +250,7 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
 	 */
 	spin_lock_irqsave(&host_ts.lock, flags);
 
-	cur_reftime = hyperv_cs->read(hyperv_cs);
+	cur_reftime = hv_read_reference_counter();
 	host_ts.host_time = hosttime;
 	host_ts.ref_time = cur_reftime;
 
@@ -315,7 +315,7 @@ static void timesync_onchannelcallback(void *context)
 					sizeof(struct vmbuspipe_hdr) +
 					sizeof(struct icmsg_hdr)];
 				adj_guesttime(timedatap->parenttime,
-					      hyperv_cs->read(hyperv_cs),
+					      hv_read_reference_counter(),
 					      timedatap->flags);
 			}
 		}
@@ -524,7 +524,7 @@ static struct ptp_clock *hv_ptp_clock;
 static int hv_timesync_init(struct hv_util_service *srv)
 {
 	/* TimeSync requires Hyper-V clocksource. */
-	if (!hyperv_cs)
+	if (!hv_read_reference_counter)
 		return -ENODEV;
 
 	spin_lock_init(&host_ts.lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..5adc6390ac3a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1533,6 +1534,96 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
+#ifdef CONFIG_TIME_NS
+static int timens_offsets_show(struct seq_file *m, void *v)
+{
+	struct task_struct *p;
+
+	p = get_proc_task(file_inode(m->file));
+	if (!p)
+		return -ESRCH;
+	proc_timens_show_offsets(p, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct proc_timens_offset offsets[2];
+	char *kbuf = NULL, *pos, *next_line;
+	struct task_struct *p;
+	int ret, noffsets;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Parse the user data */
+	ret = -EINVAL;
+	noffsets = 0;
+	for (pos = kbuf; pos; pos = next_line) {
+		struct proc_timens_offset *off = &offsets[noffsets];
+		int err;
+
+		/* Find the end of line and ensure we don't look past it */
+		next_line = strchr(pos, '\n');
+		if (next_line) {
+			*next_line = '\0';
+			next_line++;
+			if (*next_line == '\0')
+				next_line = NULL;
+		}
+
+		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+				&off->val.tv_sec, &off->val.tv_nsec);
+		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
+			goto out;
+		noffsets++;
+		if (noffsets == ARRAY_SIZE(offsets)) {
+			if (next_line)
+				count = next_line - kbuf;
+			break;
+		}
+	}
+
+	ret = -ESRCH;
+	p = get_proc_task(inode);
+	if (!p)
+		goto out;
+	ret = proc_timens_set_offset(file, p, offsets, noffsets);
+	put_task_struct(p);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static int timens_offsets_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, timens_offsets_show, inode);
+}
+
+static const struct file_operations proc_timens_offsets_operations = {
+	.open		= timens_offsets_open,
+	.read		= seq_read,
+	.write		= timens_offsets_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_TIME_NS */
+
 static ssize_t comm_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *offset)
 {
@@ -3015,6 +3106,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
+#endif
+#ifdef CONFIG_TIME_NS
+	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
 #endif
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f78b09..8b5c720fe5d7 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -33,6 +33,10 @@ static const struct proc_ns_operations *ns_entries[] = {
 #ifdef CONFIG_CGROUPS
 	&cgroupns_operations,
 #endif
+#ifdef CONFIG_TIME_NS
+	&timens_operations,
+	&timens_for_children_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..5a1b228964fb 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_add_boottime(&uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
diff --git a/fs/timerfd.c b/fs/timerfd.c
index ac7f59a58f94..c5509d2448e3 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 553e539469f0..34eef083c988 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -30,7 +30,7 @@ extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
 #ifdef CONFIG_HYPERV_TIMER
-extern struct clocksource *hyperv_cs;
+extern u64 (*hv_read_reference_counter)(void);
 extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 74748e306f4b..05e758b8b894 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -60,7 +60,11 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval);
 u64 alarm_forward_now(struct alarm *alarm, ktime_t interval);
 ktime_t alarm_expires_remaining(const struct alarm *alarm);
 
+#ifdef CONFIG_RTC_CLASS
 /* Provide way to access the rtc device being used by alarmtimers */
 struct rtc_device *alarmtimer_get_rtcdev(void);
+#else
+static inline struct rtc_device *alarmtimer_get_rtcdev(void) { return NULL; }
+#endif
 
 #endif
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1f98b52118f0..15c8ac313678 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -508,8 +508,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
-			      const enum hrtimer_mode mode,
+extern long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 2ae1b1a4d84d..074f395b9ad2 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -35,6 +35,8 @@ struct nsproxy {
 	struct mnt_namespace *mnt_ns;
 	struct pid_namespace *pid_ns_for_children;
 	struct net 	     *net_ns;
+	struct time_namespace *time_ns;
+	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
 };
 extern struct nsproxy init_nsproxy;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index d31cb6215905..d312e6281e69 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -32,6 +32,8 @@ extern const struct proc_ns_operations pidns_for_children_operations;
 extern const struct proc_ns_operations userns_operations;
 extern const struct proc_ns_operations mntns_operations;
 extern const struct proc_ns_operations cgroupns_operations;
+extern const struct proc_ns_operations timens_operations;
+extern const struct proc_ns_operations timens_for_children_operations;
 
 /*
  * We always define these enumerators
@@ -43,6 +45,7 @@ enum {
 	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
+	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/time.h b/include/linux/time.h
index 8e10b9dbd8c2..8ef5e5cc9f57 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -110,4 +110,10 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
  * Equivalent to !(time_before32(@t, @l) || time_after32(@t, @h)).
  */
 #define time_between32(t, l, h) ((u32)(h) - (u32)(l) >= (u32)(t) - (u32)(l))
+
+struct timens_offset {
+	s64	sec;
+	u64	nsec;
+};
+
 #endif
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
new file mode 100644
index 000000000000..824d54e057eb
--- /dev/null
+++ b/include/linux/time_namespace.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIMENS_H
+#define _LINUX_TIMENS_H
+
+
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <linux/ns_common.h>
+#include <linux/err.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+struct timens_offsets {
+	struct timespec64 monotonic;
+	struct timespec64 boottime;
+};
+
+struct time_namespace {
+	struct kref		kref;
+	struct user_namespace	*user_ns;
+	struct ucounts		*ucounts;
+	struct ns_common	ns;
+	struct timens_offsets	offsets;
+	struct page		*vvar_page;
+	/* If set prevents changing offsets after any task joined namespace. */
+	bool			frozen_offsets;
+} __randomize_layout;
+
+extern struct time_namespace init_time_ns;
+
+#ifdef CONFIG_TIME_NS
+extern int vdso_join_timens(struct task_struct *task,
+			    struct time_namespace *ns);
+
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	kref_get(&ns->kref);
+	return ns;
+}
+
+struct time_namespace *copy_time_ns(unsigned long flags,
+				    struct user_namespace *user_ns,
+				    struct time_namespace *old_ns);
+void free_time_ns(struct kref *kref);
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+struct vdso_data *arch_get_vdso_data(void *vvar_page);
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+	kref_put(&ns->kref, free_time_ns);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
+
+struct proc_timens_offset {
+	int			clockid;
+	struct timespec64	val;
+};
+
+int proc_timens_set_offset(struct file *file, struct task_struct *p,
+			   struct proc_timens_offset *offsets, int n);
+
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
+
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct time_namespace *ns = current->nsproxy->time_ns;
+
+	if (likely(ns == &init_time_ns))
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, &ns->offsets);
+}
+
+#else
+static inline int vdso_join_timens(struct task_struct *task,
+				   struct time_namespace *ns)
+{
+	return 0;
+}
+
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	return NULL;
+}
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+}
+
+static inline
+struct time_namespace *copy_time_ns(unsigned long flags,
+				    struct user_namespace *user_ns,
+				    struct time_namespace *old_ns)
+{
+	if (flags & CLONE_NEWTIME)
+		return ERR_PTR(-EINVAL);
+
+	return old_ns;
+}
+
+static inline int timens_on_fork(struct nsproxy *nsproxy,
+				 struct task_struct *tsk)
+{
+	return 0;
+}
+
+static inline void timens_add_monotonic(struct timespec64 *ts) { }
+static inline void timens_add_boottime(struct timespec64 *ts) { }
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
+#endif
+
+#endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index fb9f4f799554..6ef1c7109fc4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -45,6 +45,7 @@ enum ucount_type {
 	UCOUNT_NET_NAMESPACES,
 	UCOUNT_MNT_NAMESPACES,
 	UCOUNT_CGROUP_NAMESPACES,
+	UCOUNT_TIME_NAMESPACES,
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 4a0217832464..2e3bc22c6f20 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,12 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 2e302c0f41f7..c5f347cc5e55 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,6 +21,8 @@
 #define CS_RAW		1
 #define CS_BASES	(CS_RAW + 1)
 
+#define VCLOCK_TIMENS	UINT_MAX
+
 /**
  * struct vdso_timestamp - basetime per clock_id
  * @sec:	seconds
@@ -48,6 +50,7 @@ struct vdso_timestamp {
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
+ * @offset[clock_id]:	time namespace offset per clock_id
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -55,6 +58,17 @@ struct vdso_timestamp {
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
+ *
+ * @basetime is used to store the base time for the system wide time getter
+ * VVAR page.
+ *
+ * @offset is used by the special time namespace VVAR pages which are
+ * installed instead of the real VVAR page. These namespace pages must set
+ * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
+ * time namespace slow path. The namespace aware functions retrieve the
+ * real system wide VVAR page, read host time and add the per clock offset.
+ * For clocks which are not affected by time namespace adjustment the
+ * offset must be zero.
  */
 struct vdso_data {
 	u32			seq;
@@ -65,7 +79,10 @@ struct vdso_data {
 	u32			mult;
 	u32			shift;
 
-	struct vdso_timestamp	basetime[VDSO_BASES];
+	union {
+		struct vdso_timestamp	basetime[VDSO_BASES];
+		struct timens_offset	offset[VDSO_BASES];
+	};
 
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 01641dbb68ef..9a2af9fca45e 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -10,7 +10,7 @@ static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
 
-	while ((seq = READ_ONCE(vd->seq)) & 1)
+	while (unlikely((seq = READ_ONCE(vd->seq)) & 1))
 		cpu_relax();
 
 	smp_rmb();
diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..9b7f144a6d35 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1080,6 +1080,14 @@ config UTS_NS
 	  In this namespace tasks see different info provided with the
 	  uname() system call
 
+config TIME_NS
+	bool "TIME namespace"
+	depends on GENERIC_VDSO_TIME_NS
+	default y
+	help
+	  In this namespace boottime and monotonic clocks can be set.
+	  The time will keep going with the same pace.
+
 config IPC_NS
 	bool "IPC namespace"
 	depends on (SYSVIPC || POSIX_MQUEUE)
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..363595815144 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1832,6 +1832,7 @@ static __latent_entropy struct task_struct *copy_process(
 	struct multiprocess_signals delayed;
 	struct file *pidfile = NULL;
 	u64 clone_flags = args->flags;
+	struct nsproxy *nsp = current->nsproxy;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1874,8 +1875,16 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	if (clone_flags & CLONE_THREAD) {
 		if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
-		    (task_active_pid_ns(current) !=
-				current->nsproxy->pid_ns_for_children))
+		    (task_active_pid_ns(current) != nsp->pid_ns_for_children))
+			return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * If the new process will be in a different time namespace
+	 * do not allow it to share VM or a thread group with the forking task.
+	 */
+	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
+		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2811,7 +2820,8 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
-				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP))
+				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
+				CLONE_NEWTIME))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index c815f58e6bc0..ed9882108cd2 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -18,6 +18,7 @@
 #include <linux/pid_namespace.h>
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
+#include <linux/time_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
@@ -40,6 +41,10 @@ struct nsproxy init_nsproxy = {
 #ifdef CONFIG_CGROUPS
 	.cgroup_ns		= &init_cgroup_ns,
 #endif
+#ifdef CONFIG_TIME_NS
+	.time_ns		= &init_time_ns,
+	.time_ns_for_children	= &init_time_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -106,8 +111,18 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 		goto out_net;
 	}
 
+	new_nsp->time_ns_for_children = copy_time_ns(flags, user_ns,
+					tsk->nsproxy->time_ns_for_children);
+	if (IS_ERR(new_nsp->time_ns_for_children)) {
+		err = PTR_ERR(new_nsp->time_ns_for_children);
+		goto out_time;
+	}
+	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
+
 	return new_nsp;
 
+out_time:
+	put_net(new_nsp->net_ns);
 out_net:
 	put_cgroup_ns(new_nsp->cgroup_ns);
 out_cgroup:
@@ -136,15 +151,16 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
+	int ret;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP)))) {
-		get_nsproxy(old_ns);
-		return 0;
-	}
-
-	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
+			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
+			get_nsproxy(old_ns);
+			return 0;
+		}
+	} else if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
@@ -162,6 +178,12 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
+	ret = timens_on_fork(new_ns, tsk);
+	if (ret) {
+		free_nsproxy(new_ns);
+		return ret;
+	}
+
 	tsk->nsproxy = new_ns;
 	return 0;
 }
@@ -176,6 +198,10 @@ void free_nsproxy(struct nsproxy *ns)
 		put_ipc_ns(ns->ipc_ns);
 	if (ns->pid_ns_for_children)
 		put_pid_ns(ns->pid_ns_for_children);
+	if (ns->time_ns)
+		put_time_ns(ns->time_ns);
+	if (ns->time_ns_for_children)
+		put_time_ns(ns->time_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
@@ -192,7 +218,8 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	int err = 0;
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP)))
+			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
+			       CLONE_NEWTIME)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 1867044800bb..c8f00168afe8 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
+obj-$(CONFIG_TIME_NS)				+= namespace.o
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 451f9d05ccfe..2ffb466af77e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
@@ -36,13 +37,15 @@
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
- * @gettime:		Function to read the time correlating to the base
+ * @get_ktime:		Function to read the time correlating to the base
+ * @get_timespec:	Function to read the namespace time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
-	ktime_t			(*gettime)(void);
+	ktime_t			(*get_ktime)(void);
+	void			(*get_timespec)(struct timespec64 *tp);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -55,8 +58,6 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 #endif
 
 #ifdef CONFIG_RTC_CLASS
-static struct wakeup_source *ws;
-
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
@@ -66,8 +67,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
  * This function returns the rtc device to use for wakealarms.
- * If one has not already been chosen, it checks to see if a
- * functional rtc device is available.
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
@@ -87,7 +86,8 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
-	struct wakeup_source *__ws;
+	struct platform_device *pdev;
+	int ret = 0;
 
 	if (rtcdev)
 		return -EBUSY;
@@ -97,26 +97,31 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
-	__ws = wakeup_source_register(dev, "alarmtimer");
+	pdev = platform_device_register_data(dev, "alarmtimer",
+					     PLATFORM_DEVID_AUTO, NULL, 0);
+	if (!IS_ERR(pdev))
+		device_init_wakeup(&pdev->dev, true);
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (!rtcdev) {
+	if (!IS_ERR(pdev) && !rtcdev) {
 		if (!try_module_get(rtc->owner)) {
-			spin_unlock_irqrestore(&rtcdev_lock, flags);
-			return -1;
+			ret = -1;
+			goto unlock;
 		}
 
 		rtcdev = rtc;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
-		ws = __ws;
-		__ws = NULL;
+		pdev = NULL;
+	} else {
+		ret = -1;
 	}
+unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
-	wakeup_source_unregister(__ws);
+	platform_device_unregister(pdev);
 
-	return 0;
+	return ret;
 }
 
 static inline void alarmtimer_rtc_timer_init(void)
@@ -138,11 +143,6 @@ static void alarmtimer_rtc_interface_remove(void)
 	class_interface_unregister(&alarmtimer_rtc_interface);
 }
 #else
-struct rtc_device *alarmtimer_get_rtcdev(void)
-{
-	return NULL;
-}
-#define rtcdev (NULL)
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
 static inline void alarmtimer_rtc_timer_init(void) { }
@@ -207,7 +207,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->gettime());
+		restart = alarm->function(alarm, base->get_ktime());
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (restart != ALARMTIMER_NORESTART) {
@@ -217,7 +217,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	}
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_fired(alarm, base->gettime());
+	trace_alarmtimer_fired(alarm, base->get_ktime());
 	return ret;
 
 }
@@ -225,7 +225,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	return ktime_sub(alarm->node.expires, base->gettime());
+	return ktime_sub(alarm->node.expires, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 
@@ -270,7 +270,7 @@ static int alarmtimer_suspend(struct device *dev)
 		spin_unlock_irqrestore(&base->lock, flags);
 		if (!next)
 			continue;
-		delta = ktime_sub(next->expires, base->gettime());
+		delta = ktime_sub(next->expires, base->get_ktime());
 		if (!min || (delta < min)) {
 			expires = next->expires;
 			min = delta;
@@ -281,7 +281,7 @@ static int alarmtimer_suspend(struct device *dev)
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
-		__pm_wakeup_event(ws, 2 * MSEC_PER_SEC);
+		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
 		return -EBUSY;
 	}
 
@@ -296,7 +296,7 @@ static int alarmtimer_suspend(struct device *dev)
 	/* Set alarm, if in the past reject suspend briefly to handle */
 	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
 	if (ret < 0)
-		__pm_wakeup_event(ws, MSEC_PER_SEC);
+		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
 }
 
@@ -364,7 +364,7 @@ void alarm_start(struct alarm *alarm, ktime_t start)
 	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_start(alarm, base->gettime());
+	trace_alarmtimer_start(alarm, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_start);
 
@@ -377,7 +377,7 @@ void alarm_start_relative(struct alarm *alarm, ktime_t start)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	start = ktime_add_safe(start, base->gettime());
+	start = ktime_add_safe(start, base->get_ktime());
 	alarm_start(alarm, start);
 }
 EXPORT_SYMBOL_GPL(alarm_start_relative);
@@ -414,7 +414,7 @@ int alarm_try_to_cancel(struct alarm *alarm)
 		alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_cancel(alarm, base->gettime());
+	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(alarm_try_to_cancel);
@@ -474,7 +474,7 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	return alarm_forward(alarm, base->gettime(), interval);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
@@ -500,7 +500,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 		return;
 	}
 
-	delta = ktime_sub(absexp, base->gettime());
+	delta = ktime_sub(absexp, base->get_ktime());
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
 	if (!freezer_delta || (delta < freezer_delta)) {
@@ -632,7 +632,7 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
 	if (!absolute)
-		expires = ktime_add_safe(expires, base->gettime());
+		expires = ktime_add_safe(expires, base->get_ktime());
 	if (sigev_none)
 		alarm->node.expires = expires;
 	else
@@ -657,23 +657,40 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
 }
 
 /**
- * alarm_clock_get - posix clock_get interface
+ * alarm_clock_get_timespec - posix clock_get_timespec interface
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
- * Provides the underlying alarm base time.
+ * Provides the underlying alarm base time in a tasks time namespace.
  */
-static int alarm_clock_get(clockid_t which_clock, struct timespec64 *tp)
+static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
 
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->gettime());
+	base->get_timespec(tp);
+
 	return 0;
 }
 
+/**
+ * alarm_clock_get_ktime - posix clock_get_ktime interface
+ * @which_clock: clockid
+ *
+ * Provides the underlying alarm base time in the root namespace.
+ */
+static ktime_t alarm_clock_get_ktime(clockid_t which_clock)
+{
+	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
+
+	if (!alarmtimer_get_rtcdev())
+		return -EINVAL;
+
+	return base->get_ktime();
+}
+
 /**
  * alarm_timer_create - posix timer_create interface
  * @new_timer: k_itimer pointer to manage
@@ -747,7 +764,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 		struct timespec64 rmt;
 		ktime_t rem;
 
-		rem = ktime_sub(absexp, alarm_bases[type].gettime());
+		rem = ktime_sub(absexp, alarm_bases[type].get_ktime());
 
 		if (rem <= 0)
 			return 0;
@@ -816,9 +833,11 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
-		ktime_t now = alarm_bases[type].gettime();
+		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
@@ -837,7 +856,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
-	.clock_get		= alarm_clock_get,
+	.clock_get_ktime	= alarm_clock_get_ktime,
+	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_del		= common_timer_del,
@@ -866,6 +886,12 @@ static struct platform_driver alarmtimer_driver = {
 	}
 };
 
+static void get_boottime_timespec(struct timespec64 *tp)
+{
+	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
+}
+
 /**
  * alarmtimer_init - Initialize alarm timer code
  *
@@ -874,17 +900,18 @@ static struct platform_driver alarmtimer_driver = {
  */
 static int __init alarmtimer_init(void)
 {
-	struct platform_device *pdev;
-	int error = 0;
+	int error;
 	int i;
 
 	alarmtimer_rtc_timer_init();
 
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
-	alarm_bases[ALARM_REALTIME].gettime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
-	alarm_bases[ALARM_BOOTTIME].gettime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
@@ -898,15 +925,7 @@ static int __init alarmtimer_init(void)
 	if (error)
 		goto out_if;
 
-	pdev = platform_device_register_simple("alarmtimer", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		error = PTR_ERR(pdev);
-		goto out_drv;
-	}
 	return 0;
-
-out_drv:
-	platform_driver_unregister(&alarmtimer_driver);
 out_if:
 	alarmtimer_rtc_interface_remove();
 	return error;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8de90ea31280..3a609e7344f3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer_clock_base *base,
 			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags)
+			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	int restart;
@@ -1910,8 +1910,8 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
-		       const enum hrtimer_mode mode, const clockid_t clockid)
+long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
+		       const clockid_t clockid)
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
@@ -1923,7 +1923,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1958,7 +1958,8 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
+				 CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1978,7 +1979,8 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
+				 CLOCK_MONOTONIC);
 }
 #endif
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
new file mode 100644
index 000000000000..12858507d75a
--- /dev/null
+++ b/kernel/time/namespace.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Andrei Vagin <avagin@openvz.org>
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+
+#include <linux/time_namespace.h>
+#include <linux/user_namespace.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/seq_file.h>
+#include <linux/proc_ns.h>
+#include <linux/export.h>
+#include <linux/time.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+
+#include <vdso/datapage.h>
+
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else {
+		tim = ktime_sub(tim, offset);
+		if (unlikely(tim > KTIME_MAX))
+			tim = KTIME_MAX;
+	}
+
+	return tim;
+}
+
+static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
+}
+
+static void dec_time_namespaces(struct ucounts *ucounts)
+{
+	dec_ucount(ucounts, UCOUNT_TIME_NAMESPACES);
+}
+
+/**
+ * clone_time_ns - Clone a time namespace
+ * @user_ns:	User namespace which owns a new namespace.
+ * @old_ns:	Namespace to clone
+ *
+ * Clone @old_ns and set the clone refcount to 1
+ *
+ * Return: The new namespace or ERR_PTR.
+ */
+static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
+					  struct time_namespace *old_ns)
+{
+	struct time_namespace *ns;
+	struct ucounts *ucounts;
+	int err;
+
+	err = -ENOSPC;
+	ucounts = inc_time_namespaces(user_ns);
+	if (!ucounts)
+		goto fail;
+
+	err = -ENOMEM;
+	ns = kmalloc(sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		goto fail_dec;
+
+	kref_init(&ns->kref);
+
+	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!ns->vvar_page)
+		goto fail_free;
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto fail_free_page;
+
+	ns->ucounts = ucounts;
+	ns->ns.ops = &timens_operations;
+	ns->user_ns = get_user_ns(user_ns);
+	ns->offsets = old_ns->offsets;
+	ns->frozen_offsets = false;
+	return ns;
+
+fail_free_page:
+	__free_page(ns->vvar_page);
+fail_free:
+	kfree(ns);
+fail_dec:
+	dec_time_namespaces(ucounts);
+fail:
+	return ERR_PTR(err);
+}
+
+/**
+ * copy_time_ns - Create timens_for_children from @old_ns
+ * @flags:	Cloning flags
+ * @user_ns:	User namespace which owns a new namespace.
+ * @old_ns:	Namespace to clone
+ *
+ * If CLONE_NEWTIME specified in @flags, creates a new timens_for_children;
+ * adds a refcounter to @old_ns otherwise.
+ *
+ * Return: timens_for_children namespace or ERR_PTR.
+ */
+struct time_namespace *copy_time_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct time_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWTIME))
+		return get_time_ns(old_ns);
+
+	return clone_time_ns(user_ns, old_ns);
+}
+
+static struct timens_offset offset_from_ts(struct timespec64 off)
+{
+	struct timens_offset ret;
+
+	ret.sec = off.tv_sec;
+	ret.nsec = off.tv_nsec;
+
+	return ret;
+}
+
+/*
+ * A time namespace VVAR page has the same layout as the VVAR page which
+ * contains the system wide VDSO data.
+ *
+ * For a normal task the VVAR pages are installed in the normal ordering:
+ *     VVAR
+ *     PVCLOCK
+ *     HVCLOCK
+ *     TIMENS   <- Not really required
+ *
+ * Now for a timens task the pages are installed in the following order:
+ *     TIMENS
+ *     PVCLOCK
+ *     HVCLOCK
+ *     VVAR
+ *
+ * The check for vdso_data->clock_mode is in the unlikely path of
+ * the seq begin magic. So for the non-timens case most of the time
+ * 'seq' is even, so the branch is not taken.
+ *
+ * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
+ * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * update to finish and for 'seq' to become even anyway.
+ *
+ * Timens page has vdso_data->clock_mode set to VCLOCK_TIMENS which enforces
+ * the time namespace handling path.
+ */
+static void timens_setup_vdso_data(struct vdso_data *vdata,
+				   struct time_namespace *ns)
+{
+	struct timens_offset *offset = vdata->offset;
+	struct timens_offset monotonic = offset_from_ts(ns->offsets.monotonic);
+	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
+
+	vdata->seq			= 1;
+	vdata->clock_mode		= VCLOCK_TIMENS;
+	offset[CLOCK_MONOTONIC]		= monotonic;
+	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
+	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
+	offset[CLOCK_BOOTTIME]		= boottime;
+	offset[CLOCK_BOOTTIME_ALARM]	= boottime;
+}
+
+/*
+ * Protects possibly multiple offsets writers racing each other
+ * and tasks entering the namespace.
+ */
+static DEFINE_MUTEX(offset_lock);
+
+static void timens_set_vvar_page(struct task_struct *task,
+				struct time_namespace *ns)
+{
+	struct vdso_data *vdata;
+	unsigned int i;
+
+	if (ns == &init_time_ns)
+		return;
+
+	/* Fast-path, taken by every task in namespace except the first. */
+	if (likely(ns->frozen_offsets))
+		return;
+
+	mutex_lock(&offset_lock);
+	/* Nothing to-do: vvar_page has been already initialized. */
+	if (ns->frozen_offsets)
+		goto out;
+
+	ns->frozen_offsets = true;
+	vdata = arch_get_vdso_data(page_address(ns->vvar_page));
+
+	for (i = 0; i < CS_BASES; i++)
+		timens_setup_vdso_data(&vdata[i], ns);
+
+out:
+	mutex_unlock(&offset_lock);
+}
+
+void free_time_ns(struct kref *kref)
+{
+	struct time_namespace *ns;
+
+	ns = container_of(kref, struct time_namespace, kref);
+	dec_time_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+	ns_free_inum(&ns->ns);
+	__free_page(ns->vvar_page);
+	kfree(ns);
+}
+
+static struct time_namespace *to_time_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct time_namespace, ns);
+}
+
+static struct ns_common *timens_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static struct ns_common *timens_for_children_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns_for_children;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static void timens_put(struct ns_common *ns)
+{
+	put_time_ns(to_time_ns(ns));
+}
+
+static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
+{
+	struct time_namespace *ns = to_time_ns(new);
+	int err;
+
+	if (!current_is_single_threaded())
+		return -EUSERS;
+
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
+	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+		return -EPERM;
+
+	timens_set_vvar_page(current, ns);
+
+	err = vdso_join_timens(current, ns);
+	if (err)
+		return err;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	nsproxy->time_ns = ns;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns_for_children);
+	nsproxy->time_ns_for_children = ns;
+	return 0;
+}
+
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+{
+	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
+	struct time_namespace *ns = to_time_ns(nsc);
+	int err;
+
+	/* create_new_namespaces() already incremented the ref counter */
+	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
+		return 0;
+
+	timens_set_vvar_page(tsk, ns);
+
+	err = vdso_join_timens(tsk, ns);
+	if (err)
+		return err;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	nsproxy->time_ns = ns;
+
+	return 0;
+}
+
+static struct user_namespace *timens_owner(struct ns_common *ns)
+{
+	return to_time_ns(ns)->user_ns;
+}
+
+static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
+{
+	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return;
+	time_ns = to_time_ns(ns);
+
+	show_offset(m, CLOCK_MONOTONIC, &time_ns->offsets.monotonic);
+	show_offset(m, CLOCK_BOOTTIME, &time_ns->offsets.boottime);
+	put_time_ns(time_ns);
+}
+
+int proc_timens_set_offset(struct file *file, struct task_struct *p,
+			   struct proc_timens_offset *offsets, int noffsets)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timespec64 tp;
+	int i, err;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return -ESRCH;
+	time_ns = to_time_ns(ns);
+
+	if (!file_ns_capable(file, time_ns->user_ns, CAP_SYS_TIME)) {
+		put_time_ns(time_ns);
+		return -EPERM;
+	}
+
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&tp);
+			break;
+		case CLOCK_BOOTTIME:
+			ktime_get_boottime_ts64(&tp);
+			break;
+		default:
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = -ERANGE;
+
+		if (off->val.tv_sec > KTIME_SEC_MAX ||
+		    off->val.tv_sec < -KTIME_SEC_MAX)
+			goto out;
+
+		tp = timespec64_add(tp, off->val);
+		/*
+		 * KTIME_SEC_MAX is divided by 2 to be sure that KTIME_MAX is
+		 * still unreachable.
+		 */
+		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
+			goto out;
+	}
+
+	mutex_lock(&offset_lock);
+	if (time_ns->frozen_offsets) {
+		err = -EACCES;
+		goto out_unlock;
+	}
+
+	err = 0;
+	/* Don't report errors after this line */
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+		struct timespec64 *offset = NULL;
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			offset = &time_ns->offsets.monotonic;
+			break;
+		case CLOCK_BOOTTIME:
+			offset = &time_ns->offsets.boottime;
+			break;
+		}
+
+		*offset = off->val;
+	}
+
+out_unlock:
+	mutex_unlock(&offset_lock);
+out:
+	put_time_ns(time_ns);
+
+	return err;
+}
+
+const struct proc_ns_operations timens_operations = {
+	.name		= "time",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+const struct proc_ns_operations timens_for_children_operations = {
+	.name		= "time_for_children",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_for_children_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+struct time_namespace init_time_ns = {
+	.kref		= KREF_INIT(3),
+	.user_ns	= &init_user_ns,
+	.ns.inum	= PROC_TIME_INIT_INO,
+	.ns.ops		= &timens_operations,
+	.frozen_offsets	= true,
+};
+
+static int __init time_ns_init(void)
+{
+	return 0;
+}
+subsys_initcall(time_ns_init);
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 200fb2d3be99..77c0c2370b6d 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -310,8 +310,8 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 }
 
 const struct k_clock clock_posix_dynamic = {
-	.clock_getres	= pc_clock_getres,
-	.clock_set	= pc_clock_settime,
-	.clock_get	= pc_clock_gettime,
-	.clock_adj	= pc_clock_adjtime,
+	.clock_getres		= pc_clock_getres,
+	.clock_set		= pc_clock_settime,
+	.clock_get_timespec	= pc_clock_gettime,
+	.clock_adj		= pc_clock_adjtime,
 };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 42d512fcfda2..8ff6da77a01f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1391,26 +1391,26 @@ static int thread_cpu_timer_create(struct k_itimer *timer)
 }
 
 const struct k_clock clock_posix_cpu = {
-	.clock_getres	= posix_cpu_clock_getres,
-	.clock_set	= posix_cpu_clock_set,
-	.clock_get	= posix_cpu_clock_get,
-	.timer_create	= posix_cpu_timer_create,
-	.nsleep		= posix_cpu_nsleep,
-	.timer_set	= posix_cpu_timer_set,
-	.timer_del	= posix_cpu_timer_del,
-	.timer_get	= posix_cpu_timer_get,
-	.timer_rearm	= posix_cpu_timer_rearm,
+	.clock_getres		= posix_cpu_clock_getres,
+	.clock_set		= posix_cpu_clock_set,
+	.clock_get_timespec	= posix_cpu_clock_get,
+	.timer_create		= posix_cpu_timer_create,
+	.nsleep			= posix_cpu_nsleep,
+	.timer_set		= posix_cpu_timer_set,
+	.timer_del		= posix_cpu_timer_del,
+	.timer_get		= posix_cpu_timer_get,
+	.timer_rearm		= posix_cpu_timer_rearm,
 };
 
 const struct k_clock clock_process = {
-	.clock_getres	= process_cpu_clock_getres,
-	.clock_get	= process_cpu_clock_get,
-	.timer_create	= process_cpu_timer_create,
-	.nsleep		= process_cpu_nsleep,
+	.clock_getres		= process_cpu_clock_getres,
+	.clock_get_timespec	= process_cpu_clock_get,
+	.timer_create		= process_cpu_timer_create,
+	.nsleep			= process_cpu_nsleep,
 };
 
 const struct k_clock clock_thread = {
-	.clock_getres	= thread_cpu_clock_getres,
-	.clock_get	= thread_cpu_clock_get,
-	.timer_create	= thread_cpu_timer_create,
+	.clock_getres		= thread_cpu_clock_getres,
+	.clock_get_timespec	= thread_cpu_clock_get,
+	.timer_create		= thread_cpu_timer_create,
 };
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 20c65a7d4e3a..fcb3b21d8bdc 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,9 +78,11 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
@@ -126,6 +129,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime_t texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -144,7 +148,10 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -215,6 +222,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime_t texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -233,7 +241,10 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0ec5b7a1d769..ff0eb30de346 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -165,12 +166,17 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 }
 
 /* Get clock_realtime */
-static int posix_clock_realtime_get(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_get_realtime_ktime(clockid_t which_clock)
+{
+	return ktime_get_real();
+}
+
 /* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
@@ -187,18 +193,25 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 /*
  * Get monotonic time for posix timers
  */
-static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
+static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
+{
+	return ktime_get();
+}
+
 /*
  * Get monotonic-raw time for posix timers
  */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -213,6 +226,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -222,18 +236,29 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
-static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
+static ktime_t posix_get_boottime_ktime(const clockid_t which_clock)
+{
+	return ktime_get_boottime();
+}
+
+static int posix_get_tai_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_clocktai_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_get_tai_ktime(clockid_t which_clock)
+{
+	return ktime_get_clocktai();
+}
+
 static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
@@ -645,7 +670,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -663,12 +687,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
@@ -781,7 +800,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -866,6 +885,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
@@ -1067,7 +1088,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	error = kc->clock_get(which_clock, &kernel_tp);
+	error = kc->clock_get_timespec(which_clock, &kernel_tp);
 
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
@@ -1149,7 +1170,7 @@ SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	err = kc->clock_get(which_clock, &ts);
+	err = kc->clock_get_timespec(which_clock, &ts);
 
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
@@ -1200,7 +1221,22 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
 {
-	return hrtimer_nanosleep(rqtp, flags & TIMER_ABSTIME ?
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -1261,7 +1297,8 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_get_realtime_timespec,
+	.clock_get_ktime	= posix_get_realtime_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1279,8 +1316,9 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_ktime_get_ts,
-	.nsleep			= common_nsleep,
+	.clock_get_timespec	= posix_get_monotonic_timespec,
+	.clock_get_ktime	= posix_get_monotonic_ktime,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1295,22 +1333,23 @@ static const struct k_clock clock_monotonic = {
 
 static const struct k_clock clock_monotonic_raw = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_monotonic_raw,
+	.clock_get_timespec	= posix_get_monotonic_raw,
 };
 
 static const struct k_clock clock_realtime_coarse = {
 	.clock_getres		= posix_get_coarse_res,
-	.clock_get		= posix_get_realtime_coarse,
+	.clock_get_timespec	= posix_get_realtime_coarse,
 };
 
 static const struct k_clock clock_monotonic_coarse = {
 	.clock_getres		= posix_get_coarse_res,
-	.clock_get		= posix_get_monotonic_coarse,
+	.clock_get_timespec	= posix_get_monotonic_coarse,
 };
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_tai,
+	.clock_get_ktime	= posix_get_tai_ktime,
+	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1326,8 +1365,9 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
-	.nsleep			= common_nsleep,
+	.clock_get_ktime	= posix_get_boottime_ktime,
+	.clock_get_timespec	= posix_get_boottime_timespec,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 897c29e162b9..f32a2ebba9b8 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -6,8 +6,11 @@ struct k_clock {
 				struct timespec64 *tp);
 	int	(*clock_set)(const clockid_t which_clock,
 			     const struct timespec64 *tp);
-	int	(*clock_get)(const clockid_t which_clock,
-			     struct timespec64 *tp);
+	/* Returns the clock value in the current time namespace. */
+	int	(*clock_get_timespec)(const clockid_t which_clock,
+				      struct timespec64 *tp);
+	/* Returns the clock value in the root time namespace. */
+	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index dbd69052eaa6..e4332e3e2d56 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -169,14 +169,15 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
-	unsigned long r;
+	unsigned long r, flags;
 	char r_unit;
 	struct clock_read_data rd;
 
 	if (cd.rate > rate)
 		return;
 
-	WARN_ON(!irqs_disabled());
+	/* Cannot register a sched_clock with interrupts on */
+	local_irq_save(flags);
 
 	/* Calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&new_mult, &new_shift, rate, NSEC_PER_SEC, 3600);
@@ -233,6 +234,8 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
 		enable_sched_clock_irqtime();
 
+	local_irq_restore(flags);
+
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 59225b484e4e..7e5d3524e924 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/sched.h>
@@ -558,6 +559,7 @@ void tick_unfreeze(void)
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
+		touch_softlockup_watchdog();
 		tick_resume_local();
 	}
 
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 9fe698ff62ec..d883ac299508 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -24,4 +24,10 @@ config GENERIC_COMPAT_VDSO
 	help
 	  This config option enables the compat VDSO layer.
 
+config GENERIC_VDSO_TIME_NS
+	bool
+	help
+	  Selected by architectures which support time namespaces in the
+	  VDSO
+
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 42bd8ab955fa..f8b8ec5e63ac 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,12 +38,22 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
-static int do_hres(const struct vdso_data *vd, clockid_t clk,
-		   struct __kernel_timespec *ts)
+#ifdef CONFIG_TIME_NS
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+			  struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
-	u64 cycles, last, sec, ns;
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct timens_offset *offs = &vdns->offset[clk];
+	const struct vdso_timestamp *vdso_ts;
+	u64 cycles, last, ns;
 	u32 seq;
+	s64 sec;
+
+	if (clk != CLOCK_MONOTONIC_RAW)
+		vd = &vd[CS_HRES_COARSE];
+	else
+		vd = &vd[CS_RAW];
+	vdso_ts = &vd->basetime[clk];
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -58,6 +68,10 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
+	/* Add the namespace offset */
+	sec += offs->sec;
+	ns += offs->nsec;
+
 	/*
 	 * Do this outside the loop: a race inside the loop could result
 	 * in __iter_div_u64_rem() being extremely slow.
@@ -67,18 +81,128 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	return 0;
 }
+#else
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return NULL;
+}
+
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+			  struct __kernel_timespec *ts)
+{
+	return -EINVAL;
+}
+#endif
 
-static void do_coarse(const struct vdso_data *vd, clockid_t clk,
-		      struct __kernel_timespec *ts)
+static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
+				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u64 cycles, last, sec, ns;
 	u32 seq;
 
+	do {
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. Time namespace
+		 * enabled tasks have a special VVAR page installed which
+		 * has vd->seq set to 1 and vd->clock_mode set to
+		 * VCLOCK_TIMENS. For non time namespace affected tasks
+		 * this does not affect performance because if vd->seq is
+		 * odd, i.e. a concurrent update is in progress the extra
+		 * check for vd->clock_mode is just a few extra
+		 * instructions while spin waiting for vd->seq to become
+		 * even again.
+		 */
+		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_hres_timens(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
+		cycles = __arch_get_hw_counter(vd->clock_mode);
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return -1;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+#ifdef CONFIG_TIME_NS
+static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			    struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 nsec;
+	s64 sec;
+	s32 seq;
+
 	do {
 		seq = vdso_read_begin(vd);
+		sec = vdso_ts->sec;
+		nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	nsec += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+	return 0;
+}
+#else
+static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			    struct __kernel_timespec *ts)
+{
+	return -1;
+}
+#endif
+
+static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
+				     struct __kernel_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u32 seq;
+
+	do {
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. See comment in
+		 * do_hres().
+		 */
+		while ((seq = READ_ONCE(vd->seq)) & 1) {
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_coarse_timens(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	return 0;
 }
 
 static __maybe_unused int
@@ -96,15 +220,16 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 	 * clocks are handled in the VDSO directly.
 	 */
 	msk = 1U << clock;
-	if (likely(msk & VDSO_HRES)) {
-		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
-	} else if (msk & VDSO_COARSE) {
-		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
-		return 0;
-	} else if (msk & VDSO_RAW) {
-		return do_hres(&vd[CS_RAW], clock, ts);
-	}
-	return -1;
+	if (likely(msk & VDSO_HRES))
+		vd = &vd[CS_HRES_COARSE];
+	else if (msk & VDSO_COARSE)
+		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+	else if (msk & VDSO_RAW)
+		vd = &vd[CS_RAW];
+	else
+		return -1;
+
+	return do_hres(vd, clock, ts);
 }
 
 static __maybe_unused int
@@ -117,6 +242,7 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -125,20 +251,16 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 
 	ret = __cvdso_clock_gettime_common(clock, &ts);
 
-#ifdef VDSO_HAS_32BIT_FALLBACK
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
-#else
-	if (unlikely(ret))
-		ret = clock_gettime_fallback(clock, &ts);
-#endif
 
-	if (likely(!ret)) {
-		res->tv_sec = ts.tv_sec;
-		res->tv_nsec = ts.tv_nsec;
-	}
+	/* For ret == 0 */
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
@@ -156,6 +278,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 	}
 
 	if (unlikely(tz != NULL)) {
+		if (IS_ENABLED(CONFIG_TIME_NS) &&
+		    vd->clock_mode == VCLOCK_TIMENS)
+			vd = __arch_get_timens_vdso_data();
+
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
 	}
@@ -167,7 +293,12 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	__kernel_old_time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	__kernel_old_time_t t;
+
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
+	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
@@ -181,7 +312,6 @@ static __maybe_unused
 int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	u64 hrtimer_res;
 	u32 msk;
 	u64 ns;
 
@@ -189,27 +319,24 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
-	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
 	 * clocks are handled in the VDSO directly.
 	 */
 	msk = 1U << clock;
-	if (msk & VDSO_HRES) {
+	if (msk & (VDSO_HRES | VDSO_RAW)) {
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
-		ns = hrtimer_res;
+		ns = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
 	} else if (msk & VDSO_COARSE) {
 		/*
 		 * Preserves the behaviour of posix_get_coarse_res().
 		 */
 		ns = LOW_RES_NSEC;
-	} else if (msk & VDSO_RAW) {
-		/*
-		 * Preserves the behaviour of posix_get_hrtimer_res().
-		 */
-		ns = hrtimer_res;
 	} else {
 		return -1;
 	}
@@ -231,6 +358,7 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -239,18 +367,14 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 
 	ret = __cvdso_clock_getres_common(clock, &ts);
 
-#ifdef VDSO_HAS_32BIT_FALLBACK
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
-#else
-	if (unlikely(ret))
-		ret = clock_getres_fallback(clock, &ts);
-#endif
 
-	if (likely(!ret && res)) {
+	if (likely(res)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 #endif /* VDSO_HAS_CLOCK_GETRES */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9c648524e4dc..60c17d3c8762 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3342,6 +3342,8 @@ static const struct vm_operations_struct special_mapping_vmops = {
 	.fault = special_mapping_fault,
 	.mremap = special_mapping_mremap,
 	.name = special_mapping_name,
+	/* vDSO code relies that VVAR can't be accessed remotely */
+	.access = NULL,
 };
 
 static const struct vm_operations_struct legacy_special_mapping_vmops = {
diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index b9c203219691..e6b6181c6dc6 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -41,9 +41,11 @@
 
 #include <bpf.h>
 
-int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
+#define NSEC_PER_SEC	1000000000L
+
+int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
 {
-	return sec == 5;
+	return sec / NSEC_PER_SEC == 5ULL;
 }
 
 license(GPL);
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b001c602414b..c4939a2a5f5d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -50,6 +50,7 @@ TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
 TARGETS += sysctl
+TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
 endif
diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
new file mode 100644
index 000000000000..789f21e81028
--- /dev/null
+++ b/tools/testing/selftests/timens/.gitignore
@@ -0,0 +1,8 @@
+clock_nanosleep
+exec
+gettime_perf
+gettime_perf_cold
+procfs
+timens
+timer
+timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
new file mode 100644
index 000000000000..e9fb30bd8aeb
--- /dev/null
+++ b/tools/testing/selftests/timens/Makefile
@@ -0,0 +1,7 @@
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
+TEST_GEN_PROGS_EXTENDED := gettime_perf
+
+CFLAGS := -Wall -Werror -pthread
+LDFLAGS := -lrt -ldl
+
+include ../lib.mk
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..8e7b7c72ef65
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <signal.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+void test_sig(int sig)
+{
+	if (sig == SIGUSR2)
+		pthread_exit(NULL);
+}
+
+struct thread_args {
+	struct timespec *now, *rem;
+	pthread_mutex_t *lock;
+	int clockid;
+	int abs;
+};
+
+void *call_nanosleep(void *_args)
+{
+	struct thread_args *args = _args;
+
+	clock_nanosleep(args->clockid, args->abs ? TIMER_ABSTIME : 0, args->now, args->rem);
+	pthread_mutex_unlock(args->lock);
+	return NULL;
+}
+
+int run_test(int clockid, int abs)
+{
+	struct timespec now = {}, rem;
+	struct thread_args args = { .now = &now, .rem = &rem, .clockid = clockid};
+	struct timespec start;
+	pthread_mutex_t lock;
+	pthread_t thread;
+	int j, ok, ret;
+
+	signal(SIGUSR1, test_sig);
+	signal(SIGUSR2, test_sig);
+
+	pthread_mutex_init(&lock, NULL);
+	pthread_mutex_lock(&lock);
+
+	if (clock_gettime(clockid, &start) == -1) {
+		if (errno == EINVAL && check_skip(clockid))
+			return 0;
+		return pr_perror("clock_gettime");
+	}
+
+
+	if (abs) {
+		now.tv_sec = start.tv_sec;
+		now.tv_nsec = start.tv_nsec;
+	}
+
+	now.tv_sec += 3600;
+	args.abs = abs;
+	args.lock = &lock;
+	ret = pthread_create(&thread, NULL, call_nanosleep, &args);
+	if (ret != 0) {
+		pr_err("Unable to create a thread: %s", strerror(ret));
+		return 1;
+	}
+
+	/* Wait when the thread will call clock_nanosleep(). */
+	ok = 0;
+	for (j = 0; j < 8; j++) {
+		/* The maximum timeout is about 5 seconds. */
+		usleep(10000 << j);
+
+		/* Try to interrupt clock_nanosleep(). */
+		pthread_kill(thread, SIGUSR1);
+
+		usleep(10000 << j);
+		/* Check whether clock_nanosleep() has been interrupted or not. */
+		if (pthread_mutex_trylock(&lock) == 0) {
+			/**/
+			ok = 1;
+			break;
+		}
+	}
+	if (!ok)
+		pthread_kill(thread, SIGUSR2);
+	pthread_join(thread, NULL);
+	pthread_mutex_destroy(&lock);
+
+	if (!ok) {
+		ksft_test_result_pass("clockid: %d abs:%d timeout\n", clockid, abs);
+		return 1;
+	}
+
+	if (rem.tv_sec < 3300 || rem.tv_sec > 3900) {
+		pr_fail("clockid: %d abs: %d remain: %ld\n",
+			clockid, abs, rem.tv_sec);
+		return 1;
+	}
+	ksft_test_result_pass("clockid: %d abs:%d\n", clockid, abs);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	ksft_set_plan(4);
+
+	check_config_posix_timers();
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC, 0);
+	ret |= run_test(CLOCK_MONOTONIC, 1);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 0);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 1);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
diff --git a/tools/testing/selftests/timens/config b/tools/testing/selftests/timens/config
new file mode 100644
index 000000000000..4480620f6f49
--- /dev/null
+++ b/tools/testing/selftests/timens/config
@@ -0,0 +1 @@
+CONFIG_TIME_NS=y
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..87b47b557a7a
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+int main(int argc, char *argv[])
+{
+	struct timespec now, tst;
+	int status, i;
+	pid_t pid;
+
+	if (argc > 1) {
+		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
+			return pr_perror("sscanf");
+
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
+		}
+		return 0;
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now.tv_sec) > 5)
+			return pr_fail("%ld %ld\n",
+					now.tv_sec, tst.tv_sec);
+	}
+
+	if (argc > 1)
+		return 0;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		/* Check that a child process is in the new timens. */
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+				return pr_fail("%ld %ld\n",
+						now.tv_sec + OFFSET, tst.tv_sec);
+		}
+
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+
+	ksft_test_result_pass("exec\n");
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..7bf841a3967b
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <dlfcn.h>
+
+#include "log.h"
+#include "timens.h"
+
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+static void fill_function_pointers(void)
+{
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		pr_err("[WARN]\tfailed to find vDSO\n");
+		return;
+	}
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		pr_err("Warning: failed to find clock_gettime in vDSO\n");
+
+}
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+	vdso_clock_gettime(clockid, &start);
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+		vdso_clock_gettime(clockid, &tp);
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	ksft_set_plan(8);
+
+	fill_function_pointers();
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_MONOTONIC_COARSE, "monotonic-coarse", false);
+	test(CLOCK_MONOTONIC_RAW, "monotonic-raw", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare_timens())
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_MONOTONIC_COARSE, "monotonic-coarse", true);
+	test(CLOCK_MONOTONIC_RAW, "monotonic-raw", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/timens/log.h b/tools/testing/selftests/timens/log.h
new file mode 100644
index 000000000000..db64df2a8483
--- /dev/null
+++ b/tools/testing/selftests/timens/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
new file mode 100644
index 000000000000..43d93f4006b9
--- /dev/null
+++ b/tools/testing/selftests/timens/procfs.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define MAX_TEST_TIME_SEC		(60*5)
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME))
+		return pr_perror("setns()");
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare_timens())
+		return -1;
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_err("The same child_ns after CLONE_NEWTIME");
+
+	if (_settime(CLOCK_BOOTTIME, TEN_DAYS_IN_SEC))
+		return -1;
+
+	return 0;
+}
+
+static int read_proc_uptime(struct timespec *uptime)
+{
+	unsigned long up_sec, up_nsec;
+	FILE *proc;
+
+	proc = fopen("/proc/uptime", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/uptime");
+		return -1;
+	}
+
+	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
+		if (errno) {
+			pr_perror("fscanf");
+			return -errno;
+		}
+		pr_err("failed to parse /proc/uptime");
+		return -1;
+	}
+	fclose(proc);
+
+	uptime->tv_sec = up_sec;
+	uptime->tv_nsec = up_nsec;
+	return 0;
+}
+
+static int check_uptime(void)
+{
+	struct timespec uptime_new, uptime_old;
+	time_t uptime_expected;
+	double prec = MAX_TEST_TIME_SEC;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (read_proc_uptime(&uptime_old))
+		return 1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (read_proc_uptime(&uptime_new))
+		return 1;
+
+	uptime_expected = uptime_old.tv_sec + TEN_DAYS_IN_SEC;
+	if (fabs(difftime(uptime_new.tv_sec, uptime_expected)) > prec) {
+		pr_fail("uptime in /proc/uptime: old %ld, new %ld [%ld]",
+			uptime_old.tv_sec, uptime_new.tv_sec,
+			uptime_old.tv_sec + TEN_DAYS_IN_SEC);
+		return 1;
+	}
+
+	ksft_test_result_pass("Passed for /proc/uptime\n");
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	if (init_namespaces())
+		return 1;
+
+	ret |= check_uptime();
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
new file mode 100644
index 000000000000..559d26e21ba0
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+struct test_clock {
+	clockid_t id;
+	char *name;
+	/*
+	 * off_id is -1 if a clock has own offset, or it contains an index
+	 * which contains a right offset of this clock.
+	 */
+	int off_id;
+	time_t offset;
+};
+
+#define ct(clock, off_id)	{ clock, #clock, off_id }
+static struct test_clock clocks[] = {
+	ct(CLOCK_BOOTTIME, -1),
+	ct(CLOCK_BOOTTIME_ALARM, 1),
+	ct(CLOCK_MONOTONIC, -1),
+	ct(CLOCK_MONOTONIC_COARSE, 1),
+	ct(CLOCK_MONOTONIC_RAW, 1),
+};
+#undef ct
+
+static int child_ns, parent_ns = -1;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME)) {
+		pr_perror("setns()");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	if (parent_ns == -1) {
+		parent_ns = open(path, O_RDONLY);
+		if (parent_ns <= 0)
+			return pr_perror("Unable to open %s", path);
+	}
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare_timens())
+		return  -1;
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_perror("The same child_ns after CLONE_NEWTIME");
+
+	return 0;
+}
+
+static int test_gettime(clockid_t clock_index, bool raw_syscall, time_t offset)
+{
+	struct timespec child_ts_new, parent_ts_old, cur_ts;
+	char *entry = raw_syscall ? "syscall" : "vdso";
+	double precision = 0.0;
+
+	if (check_skip(clocks[clock_index].id))
+		return 0;
+
+	switch (clocks[clock_index].id) {
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		precision = -2.0;
+		break;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &parent_ts_old, raw_syscall))
+		return -1;
+
+	child_ts_new.tv_nsec = parent_ts_old.tv_nsec;
+	child_ts_new.tv_sec = parent_ts_old.tv_sec + offset;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, child_ts_new.tv_sec) < precision) {
+		ksft_test_result_fail(
+			"Child's %s (%s) time has not changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		return -1;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, parent_ts_old.tv_sec) > DAY_IN_SEC) {
+		ksft_test_result_fail(
+			"Parent's %s (%s) time has changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		/* Let's play nice and put it closer to original */
+		clock_settime(clocks[clock_index].id, &cur_ts);
+		return -1;
+	}
+
+	ksft_test_result_pass("Passed for %s (%s)\n",
+				clocks[clock_index].name, entry);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	time_t offset;
+	int ret = 0;
+
+	nscheck();
+
+	check_config_posix_timers();
+
+	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
+
+	if (init_namespaces())
+		return 1;
+
+	/* Offsets have to be set before tasks enter the namespace. */
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			continue;
+		offset = TEN_DAYS_IN_SEC + i * 1000;
+		clocks[i].offset = offset;
+		if (_settime(clocks[i].id, offset))
+			return 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			offset = clocks[clocks[i].off_id].offset;
+		else
+			offset = clocks[i].offset;
+		ret |= test_gettime(i, true, offset);
+		ret |= test_gettime(i, false, offset);
+	}
+
+	if (ret)
+		ksft_exit_fail();
+
+	ksft_exit_pass();
+	return !!ret;
+}
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
new file mode 100644
index 000000000000..e09e7e39bc52
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TIMENS_H__
+#define __TIMENS_H__
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00000080
+#endif
+
+static int config_posix_timers = true;
+
+static inline void check_config_posix_timers(void)
+{
+	if (timer_create(-1, 0, 0) == -1 && errno == ENOSYS)
+		config_posix_timers = false;
+}
+
+static inline bool check_skip(int clockid)
+{
+	if (config_posix_timers)
+		return false;
+
+	switch (clockid) {
+	/* Only these clocks are supported without CONFIG_POSIX_TIMERS. */
+	case CLOCK_BOOTTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_REALTIME:
+		return false;
+	default:
+		ksft_test_result_skip("Posix Clocks & timers are not supported\n");
+		return true;
+	}
+
+	return false;
+}
+
+static inline int unshare_timens(void)
+{
+	if (unshare(CLONE_NEWTIME)) {
+		if (errno == EPERM)
+			ksft_exit_skip("need to run as root\n");
+		return pr_perror("Can't unshare() timens");
+	}
+	return 0;
+}
+
+static inline int _settime(clockid_t clk_id, time_t offset)
+{
+	int fd, len;
+	char buf[4096];
+
+	if (clk_id == CLOCK_MONOTONIC_COARSE || clk_id == CLOCK_MONOTONIC_RAW)
+		clk_id = CLOCK_MONOTONIC;
+
+	len = snprintf(buf, sizeof(buf), "%d %ld 0", clk_id, offset);
+
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+
+	return 0;
+}
+
+static inline int _gettime(clockid_t clk_id, struct timespec *res, bool raw_syscall)
+{
+	int err;
+
+	if (!raw_syscall) {
+		if (clock_gettime(clk_id, res)) {
+			pr_perror("clock_gettime(%d)", (int)clk_id);
+			return -1;
+		}
+		return 0;
+	}
+
+	err = syscall(SYS_clock_gettime, clk_id, res);
+	if (err)
+		pr_perror("syscall(SYS_clock_gettime(%d))", (int)clk_id);
+
+	return err;
+}
+
+static inline void nscheck(void)
+{
+	if (access("/proc/self/ns/time", F_OK) < 0)
+		ksft_exit_skip("Time namespaces are not supported\n");
+}
+
+#endif
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
new file mode 100644
index 000000000000..0cca7aafc4bd
--- /dev/null
+++ b/tools/testing/selftests/timens/timer.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	timer_t fd;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		if (timer_create(clockid, &sevp, &fd) == -1) {
+			if (errno == ENOSYS) {
+				ksft_test_result_skip("Posix Clocks & timers are supported\n");
+				return 0;
+			}
+			return pr_perror("timerfd_create");
+		}
+
+		if (i == 1)
+			flags |= TIMER_ABSTIME;
+		if (timer_settime(fd, flags, &new_value, NULL) == -1)
+			return pr_perror("timerfd_settime");
+
+		if (timer_gettime(fd, &new_value) == -1)
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(3);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare_timens())
+		return 1;
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
new file mode 100644
index 000000000000..eff1ec5ff215
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static int tclock_gettime(clock_t clockid, struct timespec *now)
+{
+	if (clockid == CLOCK_BOOTTIME_ALARM)
+		clockid = CLOCK_BOOTTIME;
+	return clock_gettime(clockid, now);
+}
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	int fd, i;
+
+	if (tclock_gettime(clockid, &now))
+		return pr_perror("clock_gettime(%d)", clockid);
+
+	for (i = 0; i < 2; i++) {
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		fd = timerfd_create(clockid, 0);
+		if (fd == -1)
+			return pr_perror("timerfd_create(%d)", clockid);
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime(%d)", clockid);
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime(%d)", clockid);
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+
+		close(fd);
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(3);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare_timens())
+		return 1;
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}

