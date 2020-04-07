Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49990C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BCA2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5kSqJxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgDGPzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:55:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgDGPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=evMROeiOPSEkTnQc1NkJrMpIxagj6DaDwYzvXfWtXk0=; b=u5kSqJxduuO9fYXZ3frJ35LDTQ
        u4TE3Sro3SU6PZZxQlQijr/vWMx/RVh4apLfQxiRt2B8MtVSYq3CD1UHyLgyy7L0RGU6PMVPXvMh7
        TqE0Jg5bc2seVALXHMZGoGQ1REQBZ8ZL1F4mEHW9hZC2HKFLvsXR2qzOpkevZTklYKQ/frNhDOc42
        xOkgD7i1RFuljZNlpUkagNBwD8pmh0lAkVRYHTR8N+CvdjuU7GnnfnrSlA00fDxfP8Mgsh0bVSA1x
        I7xicMeSV1OJaxTbzJvsmJdTaag12QxQhTFtGQSwsG1h/UFn3QkIqKn9P7NM6kwSMxq28mmMgBl3g
        FhDGxsCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLqYv-0002Jv-Kr; Tue, 07 Apr 2020 15:54:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0B023010C8;
        Tue,  7 Apr 2020 17:54:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D96D62B99BB3E; Tue,  7 Apr 2020 17:54:49 +0200 (CEST)
Date:   Tue, 7 Apr 2020 17:54:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
References: <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
 <20200404143224.GL2452@worktop.programming.kicks-ass.net>
 <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
 <20200406102107.GI20730@hirez.programming.kicks-ass.net>
 <20200407185008.c819005f0174cae76c44a135@kernel.org>
 <20200407111535.GT20730@hirez.programming.kicks-ass.net>
 <20200408004111.3dd597f2a7c6172b4c71a9ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408004111.3dd597f2a7c6172b4c71a9ba@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:41:11AM +0900, Masami Hiramatsu wrote:
> On Tue, 7 Apr 2020 13:15:35 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > > > Also, all the VMX bits seems to qualify as FPU (I can't remember seeing
> > > > that previously):
> > > 
> > > Oops, let me check it.
> > 
> > I just send you another patch that could do with insn_is_vmx()
> > (sorry!!!)
> 
> Hmm, it is hard to find out the vmx insns. Maybe we need to clarify it by
> opcode pattern. (like "VM.*")

Yeah, I know. Maybe I should just keep it as I have for now.

One thing I thought of is we could perhaps add manual markers in
x86-opcode-map.txt. The '{','}' characters appear unused so far, we
perhaps we can use them to classify things.

That could maybe replace "mmx_expr" as well. That is, something like so:

---

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..e01b76e0a294 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -462,9 +462,9 @@ AVXcode: 1
 75: pcmpeqw Pq,Qq | vpcmpeqw Vx,Hx,Wx (66),(v1)
 76: pcmpeqd Pq,Qq | vpcmpeqd Vx,Hx,Wx (66),(v1)
 # Note: Remove (v), because vzeroall and vzeroupper becomes emms without VEX.
-77: emms | vzeroupper | vzeroall
-78: VMREAD Ey,Gy | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
-79: VMWRITE Gy,Ey | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
+77: emms {FPU} | vzeroupper | vzeroall
+78: VMREAD Ey,Gy {VMX} | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
+79: VMWRITE Gy,Ey {VMX} | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
 7a: vcvtudq2pd/uqq2pd Vpd,Wx (F3),(ev) | vcvtudq2ps/uqq2ps Vpd,Wx (F2),(ev) | vcvttps2qq/pd2qq Vx,Wx (66),(ev)
 7b: vcvtusi2sd Vpd,Hpd,Ev (F2),(ev) | vcvtusi2ss Vps,Hps,Ev (F3),(ev) | vcvtps2qq/pd2qq Vx,Wx (66),(ev)
 7c: vhaddpd Vpd,Hpd,Wpd (66) | vhaddps Vps,Hps,Wps (F2)
@@ -965,9 +965,9 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
+0: SGDT Ms | VMCALL (001),(11B) {VMX} | VMLAUNCH (010),(11B) {VMX} | VMRESUME (011),(11B) {VMX} | VMXOFF (100),(11B) {VMX} | PCONFIG (101),(11B) | ENCLV (000),(11B)
 1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
-2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
+2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) {VMX} | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
 5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B)
@@ -987,8 +987,8 @@ GrpTable: Grp9
 3: xrstors
 4: xsavec
 5: xsaves
-6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B)
-7: VMPTRST Mq | VMPTRST Mq (F3) | RDSEED Rv (11B)
+6: VMPTRLD Mq {VMX} | VMCLEAR Mq (66) {VMX} | VMXON Mq (F3) {VMX} | RDRAND Rv (11B)
+7: VMPTRST Mq {VMX} | VMPTRST Mq (F3) {VMX} | RDSEED Rv (11B)
 EndTable
 
 GrpTable: Grp10
@@ -1036,10 +1036,10 @@ GrpTable: Grp14
 EndTable
 
 GrpTable: Grp15
-0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+0: fxsave {FPU} | RDFSBASE Ry (F3),(11B)
+1: fxrstor {FPU} | RDGSBASE Ry (F3),(11B)
+2: ldmxcsr {FPU} | vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
+3: stmxcsr {FPU} | vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
 6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
