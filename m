Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2700120780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XHMK0nkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgFWPnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbgFWPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:43:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F528C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:43:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so15727315qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7VlXbhyUYUJUN03OeBT3cNSBeivqJZy9NZ8rrKrnItc=;
        b=XHMK0nkJpJiB/mfYekI7NlotB7iw2rWvBlNASwjNXbiqVlJx9YPDxzUGpq0I6V0IVz
         3dUh0t3iOxO3WerytqVG2IQRykKI+aLp6UuCtbiZNmDop7TQ3ieIIG8r3L8MLKLjuzRA
         SAfrE0MaJ8Gym3PJQ6b3U4meIer5hPzZHNolE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VlXbhyUYUJUN03OeBT3cNSBeivqJZy9NZ8rrKrnItc=;
        b=tX2LkSsCzI/X//TYlRsLOI2CSNX9Vh7K55nbocaatg/ZnXcI6yuGIjzojAqOq7qjmg
         3z5vHwCfaaquUoqfyH15bc1eC8oxkE+UKaETLUVahPcdyrryXwpDO2tS7ZDFK9xLsx9q
         HnaxKjsSpC88fQYeSgRj27AnwGqm1oFONugnL1XKTdoDtdV64ziZEK2kcl4rJcQo7qkR
         K4JXMnPltE4lqqEsL7/RsUTYyVQbaJ+WBYU3cjB3PRtkBdNd4A4rLBki/iSWgD/DVB4V
         AgXIzkzMfPDX5zBfbTkyx/LBiFLaUp4OthTNOAY4nQ0mkLtYxqsmUh8cFH/bQrQk8JfB
         Pu2g==
X-Gm-Message-State: AOAM532uy3cFs2eBbQVfTq63YLKVUTygIJBio2WtZu7q0riyf9H7AtUf
        11fU8faHR5eNbpdFcs7v2ZUq7Q==
X-Google-Smtp-Source: ABdhPJzS4wZ8vqkhsqbp8WTevzokYycPZg8FJKzmZA1Ni6+5zrRBC2SqmbadEF85GYSZtTl9BbqUEw==
X-Received: by 2002:aed:221a:: with SMTP id n26mr15773016qtc.8.1592926987737;
        Tue, 23 Jun 2020 08:43:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d140sm881921qkc.22.2020.06.23.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:43:07 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:43:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] kvm: Fix false positive RCU usage warning
Message-ID: <20200623154306.GF9005@google.com>
References: <20200516082227.22194-1-madhuparnabhowmik10@gmail.com>
 <9fff3c6b-1978-c647-16f7-563a1cdf62ff@redhat.com>
 <20200623150236.GD9005@google.com>
 <20200623153036.GB9914@madhuparna-HP-Notebook>
 <20200623153901.GG9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623153901.GG9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:39:01AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 23, 2020 at 09:00:36PM +0530, Madhuparna Bhowmik wrote:
> > On Tue, Jun 23, 2020 at 11:02:36AM -0400, Joel Fernandes wrote:
> > > On Tue, Jun 23, 2020 at 09:39:53AM +0200, Paolo Bonzini wrote:
> > > > On 16/05/20 10:22, madhuparnabhowmik10@gmail.com wrote:
> > > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > > 
> > > > > Fix the following false positive warnings:
> > > > > 
> > > > > [ 9403.765413][T61744] =============================
> > > > > [ 9403.786541][T61744] WARNING: suspicious RCU usage
> > > > > [ 9403.807865][T61744] 5.7.0-rc1-next-20200417 #4 Tainted: G             L
> > > > > [ 9403.838945][T61744] -----------------------------
> > > > > [ 9403.860099][T61744] arch/x86/kvm/mmu/page_track.c:257 RCU-list traversed in non-reader section!!
> > > > > 
> > > > > and
> > > > > 
> > > > > [ 9405.859252][T61751] =============================
> > > > > [ 9405.859258][T61751] WARNING: suspicious RCU usage
> > > > > [ 9405.880867][T61755] -----------------------------
> > > > > [ 9405.911936][T61751] 5.7.0-rc1-next-20200417 #4 Tainted: G             L
> > > > > [ 9405.911942][T61751] -----------------------------
> > > > > [ 9405.911950][T61751] arch/x86/kvm/mmu/page_track.c:232 RCU-list traversed in non-reader section!!
> > > > > 
> > > > > Since srcu read lock is held, these are false positive warnings.
> > > > > Therefore, pass condition srcu_read_lock_held() to
> > > > > list_for_each_entry_rcu().
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > > ---
> > > > > v2:
> > > > > -Rebase v5.7-rc5
> > > > > 
> > > > >  arch/x86/kvm/mmu/page_track.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > > > > index ddc1ec3bdacd..1ad79c7aa05b 100644
> > > > > --- a/arch/x86/kvm/mmu/page_track.c
> > > > > +++ b/arch/x86/kvm/mmu/page_track.c
> > > > > @@ -229,7 +229,8 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> > > > >  		return;
> > > > >  
> > > > >  	idx = srcu_read_lock(&head->track_srcu);
> > > > > -	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> > > > > +	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node,
> > > > > +				srcu_read_lock_held(&head->track_srcu))
> > > > >  		if (n->track_write)
> > > > >  			n->track_write(vcpu, gpa, new, bytes, n);
> > > > >  	srcu_read_unlock(&head->track_srcu, idx);
> > > > > @@ -254,7 +255,8 @@ void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
> > > > >  		return;
> > > > >  
> > > > >  	idx = srcu_read_lock(&head->track_srcu);
> > > > > -	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> > > > > +	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node,
> > > > > +				srcu_read_lock_held(&head->track_srcu))
> > > > >  		if (n->track_flush_slot)
> > > > >  			n->track_flush_slot(kvm, slot, n);
> > > > >  	srcu_read_unlock(&head->track_srcu, idx);
> > > > > 
> > > > 
> > > > Hi, sorry for the delay in reviewing this patch.  I would like to ask
> > > > Paul about it.
> > > > 
> > > > While you're correctly fixing a false positive, hlist_for_each_entry_rcu
> > > > would have a false _negative_ if you called it under
> > > > rcu_read_lock/unlock and the data structure was protected by SRCU.  This
> > > > is why for example srcu_dereference is used instead of
> > > > rcu_dereference_check, and why srcu_dereference uses
> > > > __rcu_dereference_check (with the two underscores) instead of
> > > > rcu_dereference_check.  Using rcu_dereference_check would add an "||
> > > > rcu_read_lock_held()" to the condition which is wrong.
> > > > 
> > > > I think instead you should add hlist_for_each_srcu and
> > > > hlist_for_each_entry_srcu macro to include/linux/rculist.h.
> > > > 
> > > > There is no need for equivalents of hlist_for_each_entry_continue_rcu
> > > > and hlist_for_each_entry_from_rcu, because they use rcu_dereference_raw.
> > > >  However, it's not documented why they do so.
> > > 
> > > You are right, this patch is wrong, we need a new SRCU list macro to do the
> > > right thing which would also get rid of the last list argument.
> > >
> > Can we really get rid of the last argument? We would need the
> > srcu_struct right for checking?
> 
> Agreed!  However, the API could be simplified by passing in a pointer to
> the srcu_struct instead of a lockdep expression.  An optional lockdep
> expression might still be helpful for calls from the update side,
> of course.

That's true!

thanks,

 - Joel

