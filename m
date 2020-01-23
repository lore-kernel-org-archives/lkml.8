Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF21DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0F120684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWQKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:10:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:10:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5ECD2AD7B;
        Thu, 23 Jan 2020 16:10:50 +0000 (UTC)
Date:   Thu, 23 Jan 2020 17:10:47 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Libor Pechacek <lpechacek@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: drmem: avoid NULL pointer dereference when
 drmem is unavailable
Message-ID: <20200123161047.GQ4113@kitsune.suse.cz>
References: <20200116102758.GC25138@fm.suse.cz>
 <87o8uudv51.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8uudv51.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:56:10AM -0600, Nathan Lynch wrote:
> Hello and thanks for the patch.
> 
> Libor Pechacek <lpechacek@suse.cz> writes:
> > In KVM guests drmem structure is only zero initialized. Trying to
> > manipulate DLPAR parameters results in a crash in this environment.
> 
> I think this statement needs qualification. Unless I'm mistaken, this
> happens only when you boot a guest without any hotpluggable memory
> configured, and then try to add or remove memory.
> 
> 
> > diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
> > index 3d76e1c388c2..28c3d936fdf3 100644
> > --- a/arch/powerpc/include/asm/drmem.h
> > +++ b/arch/powerpc/include/asm/drmem.h
> > @@ -27,12 +27,12 @@ struct drmem_lmb_info {
> >  extern struct drmem_lmb_info *drmem_info;
> >  
> >  #define for_each_drmem_lmb_in_range(lmb, start, end)		\
> > -	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
> > +	for ((lmb) = (start); (lmb) < (end); (lmb)++)
> >  
> >  #define for_each_drmem_lmb(lmb)					\
> >  	for_each_drmem_lmb_in_range((lmb),			\
> >  		&drmem_info->lmbs[0],				\
> > -		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
> > +		&drmem_info->lmbs[drmem_info->n_lmbs])
> >  
> >  /*
> >   * The of_drconf_cell_v1 struct defines the layout of the LMB data
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > index c126b94d1943..4ea6af002e27 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > @@ -236,9 +236,9 @@ static int get_lmb_range(u32 drc_index, int n_lmbs,
> >  	if (!start)
> >  		return -EINVAL;
> >  
> > -	end = &start[n_lmbs - 1];
> > +	end = &start[n_lmbs];
> >  
> > -	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
> > +	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs];
> >  	if (end > last_lmb)
> >  		return -EINVAL;
> 
> Is this not undefined behavior? I'd rather do this in a way that does
> not involve forming out-of-bounds pointers. Even if it's safe, naming
> that pointer "last_lmb" now actively hinders understanding of the code;
> it should be named "limit" or something.

Indeed, the name might be misleading now.

However, the loop differes from anything else we have in the kernel.

The standard explicitly allows the pointer to point just after the last
element to allow expressing the iteration limit without danger of
overflow.

Thanks

Michal
