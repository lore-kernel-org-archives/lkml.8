Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02299206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFEWmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:42:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:51110 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgFEWmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:42:15 -0400
IronPort-SDR: 5ZzKNYisRwCwv9n47htYf3j5QcYJrCAkjEFjd1z+x5/0BIujuP8TlCenqZK5qpaN556STjKTwy
 h4U4mmKMcVrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 15:42:14 -0700
IronPort-SDR: 1awNLVZn28bzCXE18oeaLM73kW8zuL4Uorek+FgidFZ+2iNhIEoAuk9JpLxxAtbXjoH546OvzD
 BXdtwhGP+m9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="348580264"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 05 Jun 2020 15:42:14 -0700
Date:   Fri, 5 Jun 2020 15:42:31 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200605224231.GA7466@ranerica-svr.sc.intel.com>
References: <20200602184212.10813-1-bshanks@codeweavers.com>
 <20200604001243.GA24742@ranerica-svr.sc.intel.com>
 <CALCETrXrvNZQUqfjF+-=jh1TMBpdB0PT-8J5wWDO83+i3B5Q1w@mail.gmail.com>
 <E32838F8-665E-488F-96E4-040DD7BDA284@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E32838F8-665E-488F-96E4-040DD7BDA284@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:58:13AM -0700, Brendan Shanks wrote:
> 
> > On Jun 3, 2020, at 9:39 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > 
> > On Wed, Jun 3, 2020 at 5:12 PM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com <mailto:ricardo.neri-calderon@linux.intel.com>> wrote:
> >> 
> >> On Tue, Jun 02, 2020 at 11:42:12AM -0700, Brendan Shanks wrote:
> >>> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> >>> processes.
> >>> 
> >>> Wine users have found a small number of Windows apps using SLDT that
> >>> were crashing when run on UMIP-enabled systems.
> >>> 
> >>> Reported-by: Andreas Rammhold <andi@notmuch.email>
> >>> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >>> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> >>> ---
> >>> arch/x86/kernel/umip.c | 23 ++++++++++++++---------
> >>> 1 file changed, 14 insertions(+), 9 deletions(-)
> >>> 
> >>> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> >>> index 8d5cbe1bbb3b..59dfceac5cc0 100644
> >>> --- a/arch/x86/kernel/umip.c
> >>> +++ b/arch/x86/kernel/umip.c
> >>> @@ -64,6 +64,8 @@
> >>> #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
> >>> #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
> >>> 
> >>> +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
> >>> +
> >>> /*
> >>>  * The SGDT and SIDT instructions store the contents of the global descriptor
> >>>  * table and interrupt table registers, respectively. The destination is a
> >>> @@ -244,16 +246,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
> >>>              *data_size += UMIP_GDT_IDT_LIMIT_SIZE;
> >>>              memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
> >>> 
> >>> -     } else if (umip_inst == UMIP_INST_SMSW) {
> >>> -             unsigned long dummy_value = CR0_STATE;
> >>> +     } else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
> >>> +                umip_inst == UMIP_INST_STR) {
> >>> +             unsigned long dummy_value;
> >>> +
> >>> +             if (umip_inst == UMIP_INST_SMSW)
> >>> +                     dummy_value = CR0_STATE;
> >>> +             else if (umip_inst == UMIP_INST_STR)
> >>> +                     dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
> >>> +             else
> >>> +                     dummy_value = 0;
> >> 
> >> Perhaps you can return a non-zero value for SLDT if it has an LDT, as
> >> Andy had suggested. Maybe this can be implemented by looking at
> >> current->mm->context.ldt
> >> 
> >> I guess the non-zero value can be (GDT_ENTRY_LDT*8).
> > 
> > You could probably even get away with always returning a nonzero
> > value.  After all, an empty LDT is quite similar to no LDT.
> 
> 
> Is something like this what you both had in mind?

> I don’t have any software handy to test the LDT-present case though.

Perhaps you can insert a test in the kernel selftest. Something like
this (based on Andreas' test program):

--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -220,12 +220,23 @@ static void install_invalid(const struct user_desc *desc, bool oldmode)
 	}
 }

+unsigned long test(void)
+{
+	 unsigned char ldtr[5] = "\xef\xbe\xad\xde";
+	 unsigned long ldt = 0;
+	 asm("sldt %0\n" : "=m" (ldtr));
+	 ldt = *((unsigned long *)&ldtr[0]);
+	 printf ("LDT base: 0x%lx\n", ldt);
+	 return (ldt);
+}
+
 static int safe_modify_ldt(int func, struct user_desc *ptr,
                           unsigned long bytecount)
 {
 	int ret = syscall(SYS_modify_ldt, 0x11, ptr, bytecount);
 	if (ret < -1)
 	errno = -ret;
+	test();
 	return ret;
 }

Thanks and BR,
Ricardo
> 
> 
>                 else if (umip_inst == UMIP_INST_STR)
>                         dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
>                 else if (umip_inst == UMIP_INST_SLDT)
>                 {
> #ifdef CONFIG_MODIFY_LDT_SYSCALL
>                         down_read(&current->mm->context.ldt_usr_sem);
>                         if (current->mm->context.ldt)
>                                 dummy_value = GDT_ENTRY_LDT * 8;
>                         else
>                                 dummy_value = 0;
>                         up_read(&current->mm->context.ldt_usr_sem);
> #else
>                         dummy_value = 0;
> #endif
> 

It looks fine to me. Perhaps Andy prefers a simpler, always-non-zero
implementation?

Thanks and BR,
Ricardo
