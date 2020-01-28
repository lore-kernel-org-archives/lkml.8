Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F535C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4B524686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1KTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:19:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:36582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgA1KTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:19:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 917F8B25F;
        Tue, 28 Jan 2020 10:19:46 +0000 (UTC)
Date:   Tue, 28 Jan 2020 11:19:45 +0100
From:   Libor Pechacek <lpechacek@suse.cz>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: drmem: avoid NULL pointer dereference when
 drmem is unavailable
Message-ID: <20200128101945.GA20336@fm.suse.cz>
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

Hello Nathan,

On Thu 23-01-20 09:56:10, Nathan Lynch wrote:
> Libor Pechacek <lpechacek@suse.cz> writes:
> > In KVM guests drmem structure is only zero initialized. Trying to
> > manipulate DLPAR parameters results in a crash in this environment.
> 
> I think this statement needs qualification. Unless I'm mistaken, this
> happens only when you boot a guest without any hotpluggable memory
> configured, and then try to add or remove memory.

Thanks for the review. The introductory statement can indeed be clearer.

[...]
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
> not involve forming out-of-bounds pointers.

Well, this is a tough question for the case when drmem_info->lmbs was not
allocated. Given that the array does not exist, what bounds are we talking
about?

My patch builds on the fact that NULL[0] is NULL and NULL < NULL is false.
Talking about a pointer to one past the last element of an non-existent array
is too much philosophy for me.

For the case when drmem_info->lmbs is allocated, last_lmb is a pointer to one
past the last element of the array as Michal mentioned.

> Even if it's safe, naming that pointer "last_lmb" now actively hinders
> understanding of the code; it should be named "limit" or something.

Good catch.

[...]
> 1 file changed, 36 insertions(+), 7 deletions(-)
> arch/powerpc/include/asm/drmem.h | 43 +++++++++++++++++++++++++++++++++-------
> 
> modified   arch/powerpc/include/asm/drmem.h
> @@ -20,19 +20,48 @@ struct drmem_lmb {
>  
>  struct drmem_lmb_info {
>  	struct drmem_lmb        *lmbs;
> -	int                     n_lmbs;
> +	unsigned int            n_lmbs;
>  	u32                     lmb_size;
>  };
>  
>  extern struct drmem_lmb_info *drmem_info;
>  
> -#define for_each_drmem_lmb_in_range(lmb, start, end)		\
> -	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
> +static inline bool drmem_present(void)
> +{
> +	return drmem_info->lmbs != NULL;
> +}

Yes, use of this test was also my first idea about the fix.

> +static inline struct drmem_lmb *drmem_lmb_index(unsigned int index)
> +{
> +	if (!drmem_present())
> +		return NULL;
>  
> -#define for_each_drmem_lmb(lmb)					\
> -	for_each_drmem_lmb_in_range((lmb),			\
> -		&drmem_info->lmbs[0],				\
> -		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
> +	if (WARN_ON(index >= drmem_info->n_lmbs))
> +		return NULL;

Why is this WARN_ON needed?

> +
> +	return &drmem_info->lmbs[index];
> +}
> +
> +static inline struct drmem_lmb *drmem_first_lmb(void)
> +{
> +	return drmem_lmb_index(0);
> +}
> +
> +static inline struct drmem_lmb *drmem_last_lmb(void)
> +{
> +	if (!drmem_present())
> +		return NULL;
> +
> +	return drmem_lmb_index(drmem_info->n_lmbs - 1);

Is the unsigned integer wraparound intended in drmem_info->n_lmbs == 0 case?

> +}
> +
> +#define for_each_drmem_lmb(lmb)						\
> +	for ((lmb) = drmem_first_lmb();					\

drmem_first_lmb() is essentially a call to drmem_info->lmbs(0). What
happens if drmem_info->n_lmbs is zero and drmem_info->lmbs is not NULL?

> +	     (lmb) != NULL && (lmb) <= drmem_last_lmb();		\
> +	     (lmb)++)
> +
> +#define for_each_drmem_lmb_in_range(lmb, start, end)	\
> +	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
>  
>  /*
>   * The of_drconf_cell_v1 struct defines the layout of the LMB data
> 

After all, I don't mind how the bug will be fixed. As you can see, my
preference is towards simpler solutions.

In my opinion your solution special-cased drmem_info->lmbs == NULL and opened
the doorway to the combination of drmem_info->lmbs != NULL &&
!drmem_info->n_lmbs. Maybe the condition can never become true but the code
should IMHO be robust enough to handle it.

Thanks!

Libor
-- 
Libor Pechacek
SUSE Labs                                Remember to have fun...
