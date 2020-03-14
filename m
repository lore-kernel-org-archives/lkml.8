Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A99C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC302074C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584148301;
	bh=IMRaXpIAqSD0sITdXsIGIexiprNHK4gUV8n24qyawrI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=XtyeB/7Ph1wV0JEZ2t9dbqwXTHqQqp2pdqMrybNplDgsdiOtF6T4kfecDeZACP2z3
	 gRmZsv9CZeBDFmpIx2dJARQd+ViZ68uu0Ef96VIyZGe57nCdY2181uSwYafvqTQuzx
	 LmWc48U8vLbrrQ+kGs5wp0E4gOwjE1jM/0ZKg9AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCNBLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCNBLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:11:39 -0400
Received: from vulkan (unknown [170.249.165.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7EE206FA;
        Sat, 14 Mar 2020 01:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584148298;
        bh=IMRaXpIAqSD0sITdXsIGIexiprNHK4gUV8n24qyawrI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g+g636F3fmJMq4IBq2syWyWc9VMuHDjB6HtLkfIElLozfR2BPf6vndv/WSbmM1PyU
         LOQ51rXGC9A+pkDjuGuXQATMiCpIHbc3w7IWMvn8YdPz/kVKveFMnnh3nMM6EYQmRy
         nA0NLamBH1kSI396ZNCC+XXYYAH0Szn8o9RJyYy4=
Message-ID: <79fbcbf5d88695fe75f596da1ccd9fda5648ef16.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 13 Mar 2020 20:11:36 -0500
In-Reply-To: <87ftedtdw3.fsf@notabene.neil.brown.name>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
         <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
         <875zfbvrbm.fsf@notabene.neil.brown.name>
         <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
         <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
         <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
         <87v9nattul.fsf@notabene.neil.brown.name>
         <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
         <87o8t2tc9s.fsf@notabene.neil.brown.name>
         <5e5a109f2a8f64324c114f4f55b7cb7c21a8d8da.camel@kernel.org>
         <87ftedtdw3.fsf@notabene.neil.brown.name>
Content-Type: multipart/mixed; boundary="=-Bf5h7duNhpRthhzaMH1q"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Bf5h7duNhpRthhzaMH1q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-03-13 at 09:19 +1100, NeilBrown wrote:
> On Thu, Mar 12 2020, Jeff Layton wrote:
> 
> > On Thu, 2020-03-12 at 15:42 +1100, NeilBrown wrote:
> > > On Wed, Mar 11 2020, Linus Torvalds wrote:
> > > 
> > > > On Wed, Mar 11, 2020 at 3:22 PM NeilBrown <neilb@suse.de> wrote:
> > > > > We can combine the two ideas - move the list_del_init() later, and still
> > > > > protect it with the wq locks.  This avoids holding the lock across the
> > > > > callback, but provides clear atomicity guarantees.
> > > > 
> > > > Ugfh. Honestly, this is disgusting.
> > > > 
> > > > Now you re-take the same lock in immediate succession for the
> > > > non-callback case.  It's just hidden.
> > > > 
> > > > And it's not like the list_del_init() _needs_ the lock (it's not
> > > > currently called with the lock held).
> > > > 
> > > > So that "hold the lock over list_del_init()" seems to be horrendously
> > > > bogus. It's only done as a serialization thing for that optimistic
> > > > case.
> > > > 
> > > > And that optimistic case doesn't even *want* that kind of
> > > > serialization. It really just wants a "I'm done" flag.
> > > > 
> > > > So no. Don't do this. It's mis-using the lock in several ways.
> > > > 
> > > >              Linus
> > > 
> > > It seems that test_and_set_bit_lock() is the preferred way to handle
> > > flags when memory ordering is important, and I can't see how to use that
> > > well with an "I'm done" flag.  I can make it look OK with a "I'm
> > > detaching" flag.  Maybe this is better.
> > > 
> > > NeilBrown
> > > 
> > > From f46db25f328ddf37ca9fbd390c6eb5f50c4bd2e6 Mon Sep 17 00:00:00 2001
> > > From: NeilBrown <neilb@suse.de>
> > > Date: Wed, 11 Mar 2020 07:39:04 +1100
> > > Subject: [PATCH] locks: restore locks_delete_lock optimization
> > > 
> > > A recent patch (see Fixes: below) removed an optimization which is
> > > important as it avoids taking a lock in a common case.
> > > 
> > > The comment justifying the optimisation was correct as far as it went,
> > > in that if the tests succeeded, then the values would remain stable and
> > > the test result will remain valid even without a lock.
> > > 
> > > However after the test succeeds the lock can be freed while some other
> > > thread might have only just set ->blocker to NULL (thus allowing the
> > > test to succeed) but has not yet called wake_up() on the wq in the lock.
> > > If the wake_up happens after the lock is freed, a use-after-free error occurs.
> > > 
> > > This patch restores the optimization and adds a flag to ensure this
> > > use-after-free is avoid.  The use happens only when the flag is set, and
> > > the free doesn't happen until the flag has been cleared, or we have
> > > taken blocked_lock_lock.
> > > 
> > > Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/locks.c         | 44 ++++++++++++++++++++++++++++++++++++++------
> > >  include/linux/fs.h |  3 ++-
> > >  2 files changed, 40 insertions(+), 7 deletions(-)
> > > 
> > 
> > Just a note that I'm traveling at the moment, and won't be able do much
> > other than comment on this for a few days.
> > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 426b55d333d5..334473004c6c 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -283,7 +283,7 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
> > >  	struct file_lock *fl;
> > >  
> > >  	list_for_each_entry(fl, list, fl_list) {
> > > -		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
> > > +		pr_warn("%s: fl_owner=%p fl_flags=0x%lx fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
> > >  	}
> > >  }
> > >  
> > > @@ -314,7 +314,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
> > >  	list_for_each_entry(fl, list, fl_list)
> > >  		if (fl->fl_file == filp)
> > >  			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
> > > -				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
> > > +				" fl_owner=%p fl_flags=0x%lx fl_type=0x%x fl_pid=%u\n",
> > >  				list_type, MAJOR(inode->i_sb->s_dev),
> > >  				MINOR(inode->i_sb->s_dev), inode->i_ino,
> > >  				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
> > > @@ -736,10 +736,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
> > >  		waiter = list_first_entry(&blocker->fl_blocked_requests,
> > >  					  struct file_lock, fl_blocked_member);
> > >  		__locks_delete_block(waiter);
> > > -		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> > > -			waiter->fl_lmops->lm_notify(waiter);
> > > -		else
> > > -			wake_up(&waiter->fl_wait);
> > > +		if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
> > > +			if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> > > +				waiter->fl_lmops->lm_notify(waiter);
> > > +			else
> > > +				wake_up(&waiter->fl_wait);
> > > +			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
> > > +		}
> > 
> > I *think* this is probably safe.
> > 
> > AIUI, when you use atomic bitops on a flag word like this, you should
> > use them for all modifications to ensure that your changes don't get
> > clobbered by another task racing in to do a read/modify/write cycle on
> > the same word.
> > 
> > I haven't gone over all of the places where fl_flags is changed, but I
> > don't see any at first glance that do it on a blocked request.
> > 
> > >  	}
> > >  }
> > >  
> > > @@ -753,11 +756,40 @@ int locks_delete_block(struct file_lock *waiter)
> > >  {
> > >  	int status = -ENOENT;
> > >  
> > > +	/*
> > > +	 * If fl_blocker is NULL, it won't be set again as this thread
> > > +	 * "owns" the lock and is the only one that might try to claim
> > > +	 * the lock.  So it is safe to test fl_blocker locklessly.
> > > +	 * Also if fl_blocker is NULL, this waiter is not listed on
> > > +	 * fl_blocked_requests for some lock, so no other request can
> > > +	 * be added to the list of fl_blocked_requests for this
> > > +	 * request.  So if fl_blocker is NULL, it is safe to
> > > +	 * locklessly check if fl_blocked_requests is empty.  If both
> > > +	 * of these checks succeed, there is no need to take the lock.
> > > +	 *
> > > +	 * We perform these checks only if we can set FL_DELETING.
> > > +	 * This ensure that we don't race with __locks_wake_up_blocks()
> > > +	 * in a way which leads it to call wake_up() *after* we return
> > > +	 * and the file_lock is freed.
> > > +	 */
> > > +	if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
> > > +		if (waiter->fl_blocker == NULL &&
> > > +		    list_empty(&waiter->fl_blocked_requests)) {
> > > +			/* Already fully unlinked */
> > > +			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
> > > +			return status;
> > > +		}
> > > +	}
> > > +
> > >  	spin_lock(&blocked_lock_lock);
> > >  	if (waiter->fl_blocker)
> > >  		status = 0;
> > >  	__locks_wake_up_blocks(waiter);
> > >  	__locks_delete_block(waiter);
> > > +	/* This flag might not be set and it is largely irrelevant
> > > +	 * now, but it seem cleaner to clear it.
> > > +	 */
> > > +	clear_bit(FL_DELETING, &waiter->fl_flags);
> > >  	spin_unlock(&blocked_lock_lock);
> > >  	return status;
> > >  }
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 3cd4fe6b845e..4db514f29bca 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1012,6 +1012,7 @@ static inline struct file *get_file(struct file *f)
> > >  #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
> > >  #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
> > >  #define FL_LAYOUT	2048	/* outstanding pNFS layout */
> > > +#define FL_DELETING	32768	/* lock is being disconnected */
> > 
> > nit: Why the big gap?
> 
> No good reason - it seems like a conceptually different sort of flag so
> I vaguely felt that it would help if it were numerically separate.
>  
> > >  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> > >  
> > > @@ -1087,7 +1088,7 @@ struct file_lock {
> > >  						 * ->fl_blocker->fl_blocked_requests
> > >  						 */
> > >  	fl_owner_t fl_owner;
> > > -	unsigned int fl_flags;
> > > +	unsigned long fl_flags;
> > 
> > This will break kABI, so backporting this to enterprise distro kernels
> > won't be trivial. Not a showstopper, but it might be nice to avoid that
> > if we can.
> > 
> > While it's not quite as efficient, we could just do the FL_DELETING
> > manipulation under the flc->flc_lock. That's per-inode, so it should be
> > safe to do it that way.
> 
> If we are going to use a spinlock, I'd much rather not add a flag bit,
> but instead use the blocked_member list_head.
> 

If we do want to go that route though, we'll probably need to make
variants of locks_delete_block that can be called with the flc_lock
held and without. Most of the fs/locks.c callers call it with the
flc_lock held -- most of the others don't.

> I'm almost tempted to suggest adding
>   smp_list_del_init_release() and smp_list_empty_careful_acquire()
> so that list membership can be used as a barrier.  I'm not sure I game
> though.
> 

Those do sound quite handy to have, but I'm not sure it's really
required. We could also just go back to considering the patch that
Linus sent originally, along with changing all of the
wait_event_interruptible calls to use
list_empty(&fl->fl_blocked_member) instead of !fl->fl_blocker as the
condition. (See attached)

-- 
Jeff Layton <jlayton@kernel.org>

--=-Bf5h7duNhpRthhzaMH1q
Content-Disposition: attachment;
	filename="0001-locks-reinstate-locks_delete_lock-optimization.patch"
Content-Type: text/x-patch;
	name="0001-locks-reinstate-locks_delete_lock-optimization.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAzMjQ3N2RhOTlmNDI5ZDIwNGY5N2FmZWYyOTdiYmMzYzE5OGJiMzYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgOSBNYXIgMjAyMCAxNDozNTo0MyAtMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIGxvY2tzOiByZWluc3RhdGUgbG9ja3NfZGVsZXRlX2xvY2sgb3B0aW1pemF0aW9uCgpU
aGVyZSBpcyBtZWFzdXJhYmxlIHBlcmZvcm1hbmNlIGltcGFjdCBpbiBzb21lIHN5bnRoZXRpYyB0
ZXN0cyBpbiBjb21taXQKNmQzOTBlNGI1ZDQ4IChsb2NrczogZml4IGEgcG90ZW50aWFsIHVzZS1h
ZnRlci1mcmVlIHByb2JsZW0gd2hlbiB3YWtldXAKYSB3YWl0ZXIpLiAgRml4IHRoZSByYWNlIGNv
bmRpdGlvbiBpbnN0ZWFkIGJ5IGNsZWFyaW5nIHRoZSBmbF9ibG9ja2VyCnBvaW50ZXIgYWZ0ZXIg
dGhlIHdha2V1cCBhbmQgYnkgdXNpbmcgc21wX2xvYWRfYWNxdWlyZSBhbmQKc21wX3N0b3JlX3Jl
bGVhc2UgdG8gaGFuZGxlIHRoZSBhY2Nlc3MuCgpUaGlzIG1lYW5zIHRoYXQgd2UgY2FuIG5vIGxv
bmdlciB1c2UgdGhlIGNsZWFyaW5nIG9mIGZsX2Jsb2NrZXIgY2xlYXJpbmcKYXMgdGhlIHdhaXQg
Y29uZGl0aW9uLCBzbyBzd2l0Y2ggb3ZlciB0byBjaGVja2luZyB3aGV0aGVyIHRoZQpmbF9ibG9j
a2VkX21lbWJlciBsaXN0IGlzIGVtcHR5LgoKWyBqbGF5dG9uOiB3YWl0IG9uIHRoZSBmbF9ibG9j
a2VkX3JlcXVlc3RzIGxpc3QgdG8gZ28gZW1wdHkgaW5zdGVhZCBvZgoJICAgdGhlIGZsX2Jsb2Nr
ZXIgcG9pbnRlciB0byBjbGVhci4gXQoKQ2M6IHlhbmdlcmt1biA8eWFuZ2Vya3VuQGh1YXdlaS5j
b20+CkNjOiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+CkZpeGVzOiA2ZDM5MGU0YjVkNDggKGxv
Y2tzOiBmaXggYSBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUgcHJvYmxlbSB3aGVuIHdha2V1cCBh
IHdhaXRlcikKU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4K
LS0tCiBmcy9jaWZzL2ZpbGUuYyB8ICAzICsrLQogZnMvbG9ja3MuYyAgICAgfCA0MyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9maWxl
LmMgYi9mcy9jaWZzL2ZpbGUuYwppbmRleCAzYjk0MmVjZGQ0YmUuLjhmOWQ4NDlhMDAxMiAxMDA2
NDQKLS0tIGEvZnMvY2lmcy9maWxlLmMKKysrIGIvZnMvY2lmcy9maWxlLmMKQEAgLTExNjksNyAr
MTE2OSw4IEBAIGNpZnNfcG9zaXhfbG9ja19zZXQoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBm
aWxlX2xvY2sgKmZsb2NrKQogCXJjID0gcG9zaXhfbG9ja19maWxlKGZpbGUsIGZsb2NrLCBOVUxM
KTsKIAl1cF93cml0ZSgmY2lub2RlLT5sb2NrX3NlbSk7CiAJaWYgKHJjID09IEZJTEVfTE9DS19E
RUZFUlJFRCkgewotCQlyYyA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShmbG9jay0+Zmxfd2Fp
dCwgIWZsb2NrLT5mbF9ibG9ja2VyKTsKKwkJcmMgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUo
ZmxvY2stPmZsX3dhaXQsCisJCQkJCWxpc3RfZW1wdHkoJmZsb2NrLT5mbF9ibG9ja2VkX21lbWJl
cikpOwogCQlpZiAoIXJjKQogCQkJZ290byB0cnlfYWdhaW47CiAJCWxvY2tzX2RlbGV0ZV9ibG9j
ayhmbG9jayk7CmRpZmYgLS1naXQgYS9mcy9sb2Nrcy5jIGIvZnMvbG9ja3MuYwppbmRleCA0MjZi
NTVkMzMzZDUuLmU3OGQzN2M3M2RmNSAxMDA2NDQKLS0tIGEvZnMvbG9ja3MuYworKysgYi9mcy9s
b2Nrcy5jCkBAIC03MjUsNyArNzI1LDYgQEAgc3RhdGljIHZvaWQgX19sb2Nrc19kZWxldGVfYmxv
Y2soc3RydWN0IGZpbGVfbG9jayAqd2FpdGVyKQogewogCWxvY2tzX2RlbGV0ZV9nbG9iYWxfYmxv
Y2tlZCh3YWl0ZXIpOwogCWxpc3RfZGVsX2luaXQoJndhaXRlci0+ZmxfYmxvY2tlZF9tZW1iZXIp
OwotCXdhaXRlci0+ZmxfYmxvY2tlciA9IE5VTEw7CiB9CiAKIHN0YXRpYyB2b2lkIF9fbG9ja3Nf
d2FrZV91cF9ibG9ja3Moc3RydWN0IGZpbGVfbG9jayAqYmxvY2tlcikKQEAgLTc0MCw2ICs3Mzks
MTIgQEAgc3RhdGljIHZvaWQgX19sb2Nrc193YWtlX3VwX2Jsb2NrcyhzdHJ1Y3QgZmlsZV9sb2Nr
ICpibG9ja2VyKQogCQkJd2FpdGVyLT5mbF9sbW9wcy0+bG1fbm90aWZ5KHdhaXRlcik7CiAJCWVs
c2UKIAkJCXdha2VfdXAoJndhaXRlci0+Zmxfd2FpdCk7CisKKwkJLyoKKwkJICogVGVsbCB0aGUg
d29ybGQgd2UncmUgZG9uZSB3aXRoIGl0IC0gc2VlIGNvbW1lbnQgYXQKKwkJICogdG9wIG9mIGxv
Y2tzX2RlbGV0ZV9ibG9jaygpLgorCQkgKi8KKwkJc21wX3N0b3JlX3JlbGVhc2UoJndhaXRlci0+
ZmxfYmxvY2tlciwgTlVMTCk7CiAJfQogfQogCkBAIC03NTMsMTEgKzc1OCwzMiBAQCBpbnQgbG9j
a3NfZGVsZXRlX2Jsb2NrKHN0cnVjdCBmaWxlX2xvY2sgKndhaXRlcikKIHsKIAlpbnQgc3RhdHVz
ID0gLUVOT0VOVDsKIAorCS8qCisJICogSWYgZmxfYmxvY2tlciBpcyBOVUxMLCBpdCB3b24ndCBi
ZSBzZXQgYWdhaW4gYXMgdGhpcyB0aHJlYWQKKwkgKiAib3ducyIgdGhlIGxvY2sgYW5kIGlzIHRo
ZSBvbmx5IG9uZSB0aGF0IG1pZ2h0IHRyeSB0byBjbGFpbQorCSAqIHRoZSBsb2NrLiAgU28gaXQg
aXMgc2FmZSB0byB0ZXN0IGZsX2Jsb2NrZXIgbG9ja2xlc3NseS4KKwkgKiBBbHNvIGlmIGZsX2Js
b2NrZXIgaXMgTlVMTCwgdGhpcyB3YWl0ZXIgaXMgbm90IGxpc3RlZCBvbgorCSAqIGZsX2Jsb2Nr
ZWRfcmVxdWVzdHMgZm9yIHNvbWUgbG9jaywgc28gbm8gb3RoZXIgcmVxdWVzdCBjYW4KKwkgKiBi
ZSBhZGRlZCB0byB0aGUgbGlzdCBvZiBmbF9ibG9ja2VkX3JlcXVlc3RzIGZvciB0aGlzCisJICog
cmVxdWVzdC4gIFNvIGlmIGZsX2Jsb2NrZXIgaXMgTlVMTCwgaXQgaXMgc2FmZSB0bworCSAqIGxv
Y2tsZXNzbHkgY2hlY2sgaWYgZmxfYmxvY2tlZF9yZXF1ZXN0cyBpcyBlbXB0eS4gIElmIGJvdGgK
KwkgKiBvZiB0aGVzZSBjaGVja3Mgc3VjY2VlZCwgdGhlcmUgaXMgbm8gbmVlZCB0byB0YWtlIHRo
ZSBsb2NrLgorCSAqLworCWlmICghc21wX2xvYWRfYWNxdWlyZSgmd2FpdGVyLT5mbF9ibG9ja2Vy
KSAmJgorCSAgICBsaXN0X2VtcHR5KCZ3YWl0ZXItPmZsX2Jsb2NrZWRfcmVxdWVzdHMpKQorCQly
ZXR1cm4gc3RhdHVzOworCiAJc3Bpbl9sb2NrKCZibG9ja2VkX2xvY2tfbG9jayk7CiAJaWYgKHdh
aXRlci0+ZmxfYmxvY2tlcikKIAkJc3RhdHVzID0gMDsKIAlfX2xvY2tzX3dha2VfdXBfYmxvY2tz
KHdhaXRlcik7CiAJX19sb2Nrc19kZWxldGVfYmxvY2sod2FpdGVyKTsKKworCS8qCisJICogVGVs
bCB0aGUgd29ybGQgd2UncmUgZG9uZSB3aXRoIGl0IC0gc2VlIGNvbW1lbnQgYXQgdG9wCisJICog
b2YgdGhpcyBmdW5jdGlvbgorCSAqLworCXNtcF9zdG9yZV9yZWxlYXNlKCZ3YWl0ZXItPmZsX2Js
b2NrZXIsIE5VTEwpOwogCXNwaW5fdW5sb2NrKCZibG9ja2VkX2xvY2tfbG9jayk7CiAJcmV0dXJu
IHN0YXR1czsKIH0KQEAgLTEzNTAsNyArMTM3Niw4IEBAIHN0YXRpYyBpbnQgcG9zaXhfbG9ja19p
bm9kZV93YWl0KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlX2xvY2sgKmZsKQogCQll
cnJvciA9IHBvc2l4X2xvY2tfaW5vZGUoaW5vZGUsIGZsLCBOVUxMKTsKIAkJaWYgKGVycm9yICE9
IEZJTEVfTE9DS19ERUZFUlJFRCkKIAkJCWJyZWFrOwotCQllcnJvciA9IHdhaXRfZXZlbnRfaW50
ZXJydXB0aWJsZShmbC0+Zmxfd2FpdCwgIWZsLT5mbF9ibG9ja2VyKTsKKwkJZXJyb3IgPSB3YWl0
X2V2ZW50X2ludGVycnVwdGlibGUoZmwtPmZsX3dhaXQsCisJCQkJCWxpc3RfZW1wdHkoJmZsLT5m
bF9ibG9ja2VkX21lbWJlcikpOwogCQlpZiAoZXJyb3IpCiAJCQlicmVhazsKIAl9CkBAIC0xNDM1
LDcgKzE0NjIsOCBAQCBpbnQgbG9ja3NfbWFuZGF0b3J5X2FyZWEoc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmZpbHAsIGxvZmZfdCBzdGFydCwKIAkJZXJyb3IgPSBwb3NpeF9sb2Nr
X2lub2RlKGlub2RlLCAmZmwsIE5VTEwpOwogCQlpZiAoZXJyb3IgIT0gRklMRV9MT0NLX0RFRkVS
UkVEKQogCQkJYnJlYWs7Ci0JCWVycm9yID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLmZs
X3dhaXQsICFmbC5mbF9ibG9ja2VyKTsKKwkJZXJyb3IgPSB3YWl0X2V2ZW50X2ludGVycnVwdGli
bGUoZmwuZmxfd2FpdCwKKwkJCQkJbGlzdF9lbXB0eSgmZmwuZmxfYmxvY2tlZF9tZW1iZXIpKTsK
IAkJaWYgKCFlcnJvcikgewogCQkJLyoKIAkJCSAqIElmIHdlJ3ZlIGJlZW4gc2xlZXBpbmcgc29t
ZW9uZSBtaWdodCBoYXZlCkBAIC0xNjM4LDcgKzE2NjYsOCBAQCBpbnQgX19icmVha19sZWFzZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbW9kZSwgdW5zaWduZWQgaW50IHR5cGUp
CiAKIAlsb2Nrc19kaXNwb3NlX2xpc3QoJmRpc3Bvc2UpOwogCWVycm9yID0gd2FpdF9ldmVudF9p
bnRlcnJ1cHRpYmxlX3RpbWVvdXQobmV3X2ZsLT5mbF93YWl0LAotCQkJCQkJIW5ld19mbC0+Zmxf
YmxvY2tlciwgYnJlYWtfdGltZSk7CisJCQkJCWxpc3RfZW1wdHkoJm5ld19mbC0+ZmxfYmxvY2tl
ZF9tZW1iZXIpLAorCQkJCQlicmVha190aW1lKTsKIAogCXBlcmNwdV9kb3duX3JlYWQoJmZpbGVf
cndzZW0pOwogCXNwaW5fbG9jaygmY3R4LT5mbGNfbG9jayk7CkBAIC0yMTIyLDcgKzIxNTEsOCBA
QCBzdGF0aWMgaW50IGZsb2NrX2xvY2tfaW5vZGVfd2FpdChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZV9sb2NrICpmbCkKIAkJZXJyb3IgPSBmbG9ja19sb2NrX2lub2RlKGlub2RlLCBm
bCk7CiAJCWlmIChlcnJvciAhPSBGSUxFX0xPQ0tfREVGRVJSRUQpCiAJCQlicmVhazsKLQkJZXJy
b3IgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoZmwtPmZsX3dhaXQsICFmbC0+ZmxfYmxvY2tl
cik7CisJCWVycm9yID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKGZsLT5mbF93YWl0LAorCQkJ
CWxpc3RfZW1wdHkoJmZsLT5mbF9ibG9ja2VkX21lbWJlcikpOwogCQlpZiAoZXJyb3IpCiAJCQli
cmVhazsKIAl9CkBAIC0yMzk5LDcgKzI0MjksOCBAQCBzdGF0aWMgaW50IGRvX2xvY2tfZmlsZV93
YWl0KHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLAogCQllcnJvciA9IHZmc19s
b2NrX2ZpbGUoZmlscCwgY21kLCBmbCwgTlVMTCk7CiAJCWlmIChlcnJvciAhPSBGSUxFX0xPQ0tf
REVGRVJSRUQpCiAJCQlicmVhazsKLQkJZXJyb3IgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUo
ZmwtPmZsX3dhaXQsICFmbC0+ZmxfYmxvY2tlcik7CisJCWVycm9yID0gd2FpdF9ldmVudF9pbnRl
cnJ1cHRpYmxlKGZsLT5mbF93YWl0LAorCQkJCQlsaXN0X2VtcHR5KCZmbC0+ZmxfYmxvY2tlZF9t
ZW1iZXIpKTsKIAkJaWYgKGVycm9yKQogCQkJYnJlYWs7CiAJfQotLSAKMi4yNC4xCgo=


--=-Bf5h7duNhpRthhzaMH1q--

