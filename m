Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51550C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EFA2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGOTuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:50:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65184 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbgGOTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:50:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FJWwfH080464;
        Wed, 15 Jul 2020 15:49:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32a7hmsem7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:49:44 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FJX4wk081184;
        Wed, 15 Jul 2020 15:49:43 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32a7hmsek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:49:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FJjdho014553;
        Wed, 15 Jul 2020 19:49:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 327527vtr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:49:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FJncK964749592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 19:49:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E57652051;
        Wed, 15 Jul 2020 19:49:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.215])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D84D25204E;
        Wed, 15 Jul 2020 19:49:34 +0000 (GMT)
Date:   Wed, 15 Jul 2020 22:49:33 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-ID: <20200715194933.GC1166045@linux.ibm.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
 <202007151232.0DA220B2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007151232.0DA220B2@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=5
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007150149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:36:02PM -0700, Kees Cook wrote:
> On Wed, Jul 15, 2020 at 01:32:27AM +0300, Jarkko Sakkinen wrote:
> > Introduce new API for allocating space for code generaed at run-time
> > leveraging from module_alloc() and module_memfree() code. Use this to
> > perform memory allocations in the kprobes code in order to loose the
> > bound between kprobes and modules subsystem.
> > 
> > Initially, use this API only with arch/x86 and define a new config
> > flag CONFIG_ARCH_HAS_TEXT_ALLOC to promote the availability of the
> > new API.
> > [...]
> > diff --git a/include/linux/text.h b/include/linux/text.h
> > new file mode 100644
> > index 000000000000..a27d4a42ecda
> > --- /dev/null
> > +++ b/include/linux/text.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _LINUX_TEXT_H
> > +#define _LINUX_TEXT_H
> > +
> > +/*
> > + * An allocator used for allocating modules, core sections and init sections.
> > + * Returns NULL on failure.
> > + */
> > +void *text_alloc(unsigned long size);
> > +
> > +/*
> > + * Free memory returned from text_alloc().
> > + */
> > +void text_free(void *region);
> > +
> > +#endif /* _LINUX_TEXT_H */
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 2e97febeef77..fa7687eb0c0e 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/cpu.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/text.h>
> >  
> >  #include <asm/sections.h>
> >  #include <asm/cacheflush.h>
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >  
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(PAGE_SIZE);
> > +#else
> >  	return module_alloc(PAGE_SIZE);
> > +#endif
> 
> This seems like it shouldn't be needed. I think text_alloc() should
> always be visible. In the ARCH_HAS... case it will call the arch
> implementation, and without it should just call module_alloc():
> 
> For example:
> void *text_alloc(unsigned long size)
> {
> #ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> 	return arch_text_alloc(size);
> #else
> 	return module_alloc(size);
> #endif
> }

This inverts the dependcy chain, IMHO, module_alloc() is a special case
of text_alloc() and not vice versa.

The addition of #ifdefs to alloc_insn_page() is not needed because it is
anyway overriden on x86, so I don't see a point in added #ifdefs until
another arch will enable ARCH_HAS_TEXT_ALLOC.

> -- 
> Kees Cook

-- 
Sincerely yours,
Mike.
