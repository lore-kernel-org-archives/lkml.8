Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F140820730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dH/c+R4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgDIUBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:01:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SjN+JhclUblTWmy2C4ct/M0oaI4FrKWg5Po4Rykmx9Y=; b=dH/c+R4aBxsUPTXlLcLRPPjTOx
        bP3/mGmvDrmzrvopk7RoSbZA6eih46prEmPypQBG4qxUYIWAxIJJzVvL9koNvVV43BbBcG06TR+uC
        Rau+4w2WlO05kq9/+Z8PjU17s79/1F93CUZz82ZHaooKW4tn4wvnpQbAsxX9SrWmi1Kulwma5mLkI
        yYZ4usuBEhDvwoq5KE3TJJPAFk+9SppT9O9UN4PXYEO8jlhCep+DXkaOG2gyRKAYPO7Sh+/TfkRDv
        QCLn+27PkxlUBBHvE7I0qoRM/kqp35aGc9lbrx2Dnz3C6twrb3/mqfY3iWB/SNPpOZjCZwXf81APx
        uYyx8VMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMdMf-0002Ha-0Z; Thu, 09 Apr 2020 20:01:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DADD79810C0; Thu,  9 Apr 2020 22:01:25 +0200 (CEST)
Date:   Thu, 9 Apr 2020 22:01:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mhiramat@kernel.org
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200409200125.GB2483@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
 <20200409170916.GR20760@hirez.programming.kicks-ass.net>
 <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:15:57PM +0200, Christian König wrote:
> Am 09.04.20 um 19:09 schrieb Peter Zijlstra:
> > On Thu, Apr 09, 2020 at 05:59:56PM +0200, Peter Zijlstra wrote:
> > [SNIP]
> > > I'll need another approach, let me consider.
> > Christian; it says these files are generated, does that generator know
> > which functions are wholly in FPU context and which are not?
> 
> Well that "generator" is still a human being :)
> 
> It's just that the formulae for the calculation come from the hardware team
> and we are not able to easily transcript them to fixed point calculations.

Well, if it's a human, can this human respect the kernel coding style a
bit more :-) Some of that stuff is atrocious.

> > My current thinking is that if I annotate all functions that are wholly
> > inside kernel_fpu_start() with an __fpu function attribute, then I can
> > verify that any call from regular text to fpu text only happens inside
> > kernel_fpu_begin()/end(). And I can ensure that all !__fpu annotation
> > fuctions only contain !fpu instructions.
> 
> Yeah, that sounds like a good idea to me and should be easily doable.
> 
> > Can that generator add the __fpu function attribute or is that something
> > that would need to be done manually (which seems like it would be
> > painful, since it is quite a bit of code) ?
> 
> We are currently in the process of moving all the stuff which requires
> floating point into a single C file(s) and then make sure that we only call
> those within kernel_fpu_begin()/end() blocks.

Can you make the build system stick all those .o files in a single
archive? That's the only way I can do call validation; external
relocatoin records do not contain the section.

> Annotating those function with __fpu or even saying to gcc that all code of
> those files should go into a special text.fpu segment shouldn't be much of a
> problem.

Guess what the __fpu attribute does ;-)

With the below patch (which is on to of newer versions of the objtool
patches send earlier, let me know if you want a full set) that only
converts a few files, but fully converts:

  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c

But building it (and this is an absolute pain; when you're reworking
this, can you pretty please also fix the Makefiles?), we get:

  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o: warning: objtool: dcn_validate_bandwidth()+0x34fa: FPU instruction outside of kernel_fpu_{begin,end}()

$ ./scripts/faddr2line defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o dcn_validate_bandwidth+0x34fa
dcn_validate_bandwidth+0x34fa/0x57ce:
dcn_validate_bandwidth at /usr/src/linux-2.6/defconfig-build/../drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1293 (discriminator 5)

# ./objdump-func.sh defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o dcn_validate_bandwidth | grep 34fa
34fa     50fa:  f2 0f 10 b5 60 ff ff    movsd  -0xa0(%rbp),%xmm6

Which seems to indicate there's still problms with the current code.



---
 arch/x86/include/asm/fpu/api.h                     | 12 +++++++++++
 arch/x86/kernel/vmlinux.lds.S                      |  1 +
 .../gpu/drm/amd/display/dc/calcs/dcn_calc_math.c   | 25 +++++++++++-----------
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  4 ++--
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  | 10 ++++-----
 .../amd/display/dc/dml/display_rq_dlg_helpers.c    |  2 +-
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       | 10 ++++-----
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h |  2 ++
 tools/objtool/check.c                              |  7 +++++-
 tools/objtool/elf.h                                |  2 +-
 13 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 64be4426fda9..19eaf98bbb0a 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -12,11 +12,23 @@
 #define _ASM_X86_FPU_API_H
 #include <linux/bottom_half.h>

+#ifdef CONFIG_STACK_VALIDATION
+
+#define __fpu __section(".text.fpu")
+
 #define _ASM_ANNOTATE_FPU(at)						\
 		     ".pushsection .discard.fpu_safe\n"			\
 		     ".long " #at " - .\n"				\
 		     ".popsection\n"					\

+#else
+
+#define __fpu
+
+#define _ASM_ANNOTATE_FPU(at)
+
+#endif /* CONFIG_STACK_VALIDATION */
+
 #define annotate_fpu() ({						\
 	asm volatile("%c0:\n\t"						\
 		     _ASM_ANNOTATE_FPU(%c0b)				\
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1bf7e312361f..8442f8633d07 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -139,6 +139,7 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
+		*(.text.fpu)

 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
index 07d18e78de49..57ab3aafef5a 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
@@ -36,7 +36,7 @@
  * remain as-is as it provides us with a guarantee from HW that it is correct.
  */

-float dcn_bw_mod(const float arg1, const float arg2)
+__fpu float dcn_bw_mod(const float arg1, const float arg2)
 {
 	if (isNaN(arg1))
 		return arg2;
@@ -45,7 +45,7 @@ float dcn_bw_mod(const float arg1, const float arg2)
 	return arg1 - arg1 * ((int) (arg1 / arg2));
 }

-float dcn_bw_min2(const float arg1, const float arg2)
+__fpu float dcn_bw_min2(const float arg1, const float arg2)
 {
 	if (isNaN(arg1))
 		return arg2;
@@ -58,7 +58,7 @@ unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int arg2)
 {
 	return arg1 > arg2 ? arg1 : arg2;
 }
-float dcn_bw_max2(const float arg1, const float arg2)
+__fpu float dcn_bw_max2(const float arg1, const float arg2)
 {
 	if (isNaN(arg1))
 		return arg2;
@@ -67,25 +67,26 @@ float dcn_bw_max2(const float arg1, const float arg2)
 	return arg1 > arg2 ? arg1 : arg2;
 }

-float dcn_bw_floor2(const float arg, const float significance)
+__fpu float dcn_bw_floor2(const float arg, const float significance)
 {
 	if (significance == 0)
 		return 0;
 	return ((int) (arg / significance)) * significance;
 }
-float dcn_bw_floor(const float arg)
+
+__fpu float dcn_bw_floor(const float arg)
 {
 	return ((int) (arg));
 }

-float dcn_bw_ceil(const float arg)
+__fpu float dcn_bw_ceil(const float arg)
 {
 	float flr = dcn_bw_floor2(arg, 1);

 	return flr + 0.00001 >= arg ? arg : flr + 1;
 }

-float dcn_bw_ceil2(const float arg, const float significance)
+__fpu float dcn_bw_ceil2(const float arg, const float significance)
 {
 	float flr = dcn_bw_floor2(arg, significance);
 	if (significance == 0)
@@ -93,17 +94,17 @@ float dcn_bw_ceil2(const float arg, const float significance)
 	return flr + 0.00001 >= arg ? arg : flr + significance;
 }

-float dcn_bw_max3(float v1, float v2, float v3)
+__fpu float dcn_bw_max3(float v1, float v2, float v3)
 {
 	return v3 > dcn_bw_max2(v1, v2) ? v3 : dcn_bw_max2(v1, v2);
 }

-float dcn_bw_max5(float v1, float v2, float v3, float v4, float v5)
+__fpu float dcn_bw_max5(float v1, float v2, float v3, float v4, float v5)
 {
 	return dcn_bw_max3(v1, v2, v3) > dcn_bw_max2(v4, v5) ? dcn_bw_max3(v1, v2, v3) : dcn_bw_max2(v4, v5);
 }

-float dcn_bw_pow(float a, float exp)
+__fpu float dcn_bw_pow(float a, float exp)
 {
 	float temp;
 	/*ASSERT(exp == (int)exp);*/
@@ -120,7 +121,7 @@ float dcn_bw_pow(float a, float exp)
 	}
 }

-double dcn_bw_fabs(double a)
+__fpu double dcn_bw_fabs(double a)
 {
 	if (a > 0)
 		return (a);
@@ -129,7 +130,7 @@ double dcn_bw_fabs(double a)
 }


-float dcn_bw_log(float a, float b)
+__fpu float dcn_bw_log(float a, float b)
 {
 	int * const exp_ptr = (int *)(&a);
 	int x = *exp_ptr;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 3960a8db94cb..b3e305d9d1c9 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -435,7 +435,7 @@ static void pipe_ctx_to_e2e_pipe_params (

 }

-static void dcn_bw_calc_rq_dlg_ttu(
+static __fpu void dcn_bw_calc_rq_dlg_ttu(
 		const struct dc *dc,
 		const struct dcn_bw_internal_vars *v,
 		struct pipe_ctx *pipe,
@@ -1388,7 +1388,7 @@ static unsigned int dcn_find_normalized_clock_vdd_Level(
 	return vdd_level;
 }

-unsigned int dcn_find_dcfclk_suits_all(
+__fpu unsigned int dcn_find_dcfclk_suits_all(
 	const struct dc *dc,
 	struct dc_clocks *clocks)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index ca807846032f..0cbb58fc7fb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -115,7 +115,7 @@ static bool is_dual_plane(enum source_format_class source_format)
 	return ret_val;
 }

-static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
+static __fpu double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
 		double refclk_freq_in_mhz,
 		double pclk_freq_in_mhz,
 		bool odm_combine,
@@ -162,7 +162,7 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 		return (4 * 1024);
 }

-static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
+static __fpu void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
 		display_data_rq_regs_st *rq_regs,
 		const display_data_rq_sizing_params_st rq_sizing)
 {
@@ -313,7 +313,7 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 			full_swath_bytes_packed_c);
 }

-static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
+static __fpu void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 		display_data_rq_dlg_params_st *rq_dlg_param,
 		display_data_rq_misc_params_st *rq_misc_param,
 		display_data_rq_sizing_params_st *rq_sizing_param,
@@ -763,7 +763,7 @@ void dml20_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,

 // Note: currently taken in as is.
 // Nice to decouple code from hw register implement and extract code that are repeated for luma and chroma.
-static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
+static __fpu void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
@@ -1611,7 +1611,7 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
 }

-static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
+static __fpu void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 		double *refcyc_per_req_delivery_pre_cur,
 		double *refcyc_per_req_delivery_cur,
 		double refclk_freq_in_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index e2d82aacd3bc..36541cba3894 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -133,7 +133,7 @@ void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, display_rq_dlg_p
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }

-void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, display_dlg_sys_params_st dlg_sys_param)
+__fpu void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, display_dlg_sys_params_st dlg_sys_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
index 723af0b2dda0..e86b1d0128cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
@@ -28,7 +28,7 @@

 #include "dml_inline_defs.h"

-double dml_round(double a)
+__fpu double dml_round(double a)
 {
 	double round_pt = 0.5;
 	double ceil = dml_ceil(a, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 87d682d25278..a0b0eb2f0fe3 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -323,7 +323,7 @@ static inline uint32_t calc_dsc_bpp_x16(uint32_t stream_bandwidth_kbps, uint32_t
 /* Get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range, and timing's pixel clock
  * and uncompressed bandwidth.
  */
-static void get_dsc_bandwidth_range(
+static __fpu void get_dsc_bandwidth_range(
 		const uint32_t min_bpp,
 		const uint32_t max_bpp,
 		const struct dsc_enc_caps *dsc_caps,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 03ae15946c6d..535770930343 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -40,7 +40,7 @@
 	break


-void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc, enum max_min max_min, float bpp)
+__fpu void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc, enum max_min max_min, float bpp)
 {
 	int mode = MODE_SELECT(444, 422, 420);
 	int sel = table_hash(mode, bpc, max_min);
@@ -85,7 +85,7 @@ void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc, enum ma
 	memcpy(qps, table[index].qps, sizeof(qp_set));
 }

-double dsc_roundf(double num)
+__fpu double dsc_roundf(double num)
 {
 	if (num < 0.0)
 		num = num - 0.5;
@@ -95,7 +95,7 @@ double dsc_roundf(double num)
 	return (int)(num);
 }

-double dsc_ceil(double num)
+__fpu double dsc_ceil(double num)
 {
 	double retval = (int)num;

@@ -105,7 +105,7 @@ double dsc_ceil(double num)
 	return (int)retval;
 }

-void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
+__fpu void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
 {
 	int   *p = ofs;

@@ -172,7 +172,7 @@ int median3(int a, int b, int c)
 	return b;
 }

-void calc_rc_params(struct rc_params *rc, enum colour_mode cm, enum bits_per_comp bpc, float bpp, int slice_width, int slice_height, int minor_version)
+__fpu void calc_rc_params(struct rc_params *rc, enum colour_mode cm, enum bits_per_comp bpc, float bpp, int slice_width, int slice_height, int minor_version)
 {
 	float bpp_group;
 	float initial_xmit_delay_factor;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 1f6e63b71456..38b3c4ac96dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -98,7 +98,7 @@ static void copy_rc_to_cfg(struct drm_dsc_config *dsc_cfg, const struct rc_param
 		dsc_cfg->rc_buf_thresh[i] = rc->rc_buf_thresh[i];
 }

-int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_parameters *dsc_params)
+__fpu int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_parameters *dsc_params)
 {
 	enum colour_mode  mode = pps->convert_rgb ? CM_RGB :
 							(pps->simple_422  ? CM_444 :
@@ -115,7 +115,7 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par

 	double d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;

-	// TODO: Make sure the formula for calculating this is precise (ceiling vs. floor, and at what point they should be applied)
+	// TODO: Make sure the formula for calculating this is precise (ceiling vs. floor, and at what point they should be applied
 	if (pps->native_422 || pps->native_420)
 		d_bytes_per_pixel /= 2;

diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
index 45a07eeffbb6..d2ea6cf65f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
@@ -26,6 +26,8 @@
 #ifndef _DCN_CALC_MATH_H_
 #define _DCN_CALC_MATH_H_

+#include <asm/fpu/api.h>
+
 float dcn_bw_mod(const float arg1, const float arg2);
 float dcn_bw_min2(const float arg1, const float arg2);
 unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int arg2);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1607a698eccd..02a51fedd031 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -252,6 +252,9 @@ static int decode_instructions(struct objtool_file *file)
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;

+		if (!strcmp(sec->name, ".text.fpu"))
+			sec->fpu = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -288,8 +291,10 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}

-			sym_for_each_insn(file, func, insn)
+			sym_for_each_insn(file, func, insn) {
 				insn->func = func;
+				insn->fpu_safe = sec->fpu;
+			}
 		}
 	}

diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c61e24..a743f2f28feb 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata;
+	bool changed, text, rodata, fpu;
 };

 struct symbol {

