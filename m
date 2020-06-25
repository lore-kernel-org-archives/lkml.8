Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9908FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782772082F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406072AbgFYQTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:19:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:30787 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403801AbgFYQT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:19:29 -0400
IronPort-SDR: S04fEYccWwZNbvnoaFnftt6MxbOIs4+yhxCnwGznd3+fG1oAzV+E2fsKKee9cl6de3xRIjdQ5q
 P1fAn3tZyphw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="142457446"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="142457446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:19:28 -0700
IronPort-SDR: N9tJPPOGImzce/BCrRcztPutPH65wKOMSkP3zPADynUrY/MFt87CDqHFdq2SsaX4Ju6+F+w3px
 CuDQ1fahxb+w==
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="265397318"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.77.14])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 09:19:26 -0700
Message-ID: <d428591efe6eb2b74791ce424b9d7e49a3b32898.camel@linux.intel.com>
Subject: Re: [PATCH v3 09/10] kallsyms: Hide layout
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tony Luck <tony.luck@intel.com>
Date:   Thu, 25 Jun 2020 09:19:24 -0700
In-Reply-To: <202006240815.45AAD55@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
         <20200623172327.5701-10-kristen@linux.intel.com>
         <CAG48ez3YHoPOTZvabsNUcr=GP-rX+OXhNT54KcZT9eSQ28Fb8Q@mail.gmail.com>
         <202006240815.45AAD55@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 08:18 -0700, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 12:21:16PM +0200, Jann Horn wrote:
> > On Tue, Jun 23, 2020 at 7:26 PM Kristen Carlson Accardi
> > <kristen@linux.intel.com> wrote:
> > > This patch makes /proc/kallsyms display alphabetically by symbol
> > > name rather than sorted by address in order to hide the newly
> > > randomized address layout.
> > [...]
> > > +static int sorted_show(struct seq_file *m, void *p)
> > > +{
> > > +       struct list_head *list = m->private;
> > > +       struct kallsyms_iter_list *iter;
> > > +       int rc;
> > > +
> > > +       if (list_empty(list))
> > > +               return 0;
> > > +
> > > +       iter = list_first_entry(list, struct kallsyms_iter_list,
> > > next);
> > > +
> > > +       m->private = iter;
> > > +       rc = s_show(m, p);
> > > +       m->private = list;
> > > +
> > > +       list_del(&iter->next);
> > > +       kfree(iter);
> > 
> > Does anything like this kfree() happen if someone only reads the
> > start
> > of kallsyms and then closes the file? IOW, does "while true; do
> > head
> > -n1 /proc/kallsyms; done" leak memory?
> 
> Oop, nice catch. It seems the list would need to be walked on s_stop.
> 
> > > +       return rc;
> > > +}
> > [...]
> > > +static int kallsyms_list_cmp(void *priv, struct list_head *a,
> > > +                            struct list_head *b)
> > > +{
> > > +       struct kallsyms_iter_list *iter_a, *iter_b;
> > > +
> > > +       iter_a = list_entry(a, struct kallsyms_iter_list, next);
> > > +       iter_b = list_entry(b, struct kallsyms_iter_list, next);
> > > +
> > > +       return strcmp(iter_a->iter.name, iter_b->iter.name);
> > > +}
> > 
> > This sorts only by name, but kallsyms prints more information
> > (module
> > names and types). This means that if there are elements whose names
> > are the same, but whose module names or types are different, then
> > some
> > amount of information will still be leaked by the ordering of
> > elements
> > with the same name. In practice, since list_sort() is stable, this
> > means you can see the ordering of many modules, and you can see the
> > ordering of symbols with same name but different visibility (e.g.
> > "t
> > user_read" from security/selinux/ss/policydb.c vs "T user_read"
> > from
> > security/keys/user_defined.c, and a couple other similar cases).
> 
> i.e. sub-sort by visibility?
> 
> > [...]
> > > +#if defined(CONFIG_FG_KASLR)
> > > +/*
> > > + * When fine grained kaslr is enabled, we need to
> > > + * print out the symbols sorted by name rather than by
> > > + * by address, because this reveals the randomization order.
> > > + */
> > > +static int kallsyms_open(struct inode *inode, struct file *file)
> > > +{
> > > +       int ret;
> > > +       struct list_head *list;
> > > +
> > > +       list = __seq_open_private(file, &kallsyms_sorted_op,
> > > sizeof(*list));
> > > +       if (!list)
> > > +               return -ENOMEM;
> > > +
> > > +       INIT_LIST_HEAD(list);
> > > +
> > > +       ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
> > > +       if (ret != 0)
> > > +               return ret;
> > > +
> > > +       list_sort(NULL, list, kallsyms_list_cmp);
> > 
> > This permits running an algorithm (essentially mergesort) with
> > secret-dependent branches and memory addresses on essentially
> > secret
> > data, triggerable and arbitrarily repeatable (although with partly
> > different addresses on each run) by the attacker, and probably a
> > fairly low throughput (comparisons go through indirect function
> > calls,
> > which are slowed down by retpolines, and linked list iteration
> > implies
> > slow pointer chases). Those are fairly favorable conditions for
> > typical side-channel attacks.
> > 
> > Do you have estimates of how hard it would be to leverage such side
> > channels to recover function ordering (both on old hardware that
> > only
> > has microcode fixes for Spectre and such, and on newer hardware
> > with
> > enhanced IBRS and such)?
> 
> I wonder, instead, if sorting should be just done once per module
> load/unload? That would make the performance and memory management
> easier too.
> 

My first solution (just don't show kallsyms at all for non-root) is
looking better and better :). But seriously, I will rewrite this one
with something like this, but I think we are going to need another
close look to see if sidechannel issues still exist with the new
implementation. Hopefully Jann can take another look then.


