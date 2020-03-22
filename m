Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2144DC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3820722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AznKW8a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCVFlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 01:41:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51889 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgCVFlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 01:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584855698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9uyrweGHZQGxIp4uBrTVmnRgE+IcgAxrg3YHUzMhEKM=;
        b=AznKW8a/BPO02Zsa86JPOjiyGGSjFPigpTz/OjDF7X8g6c3B3tHw9W073epf7afx3vHcuv
        pk1cUDB29dbv0pnbQLM8H5ftIIHP1B0a04OdcJlDqfYpvpNGLImsJTy5ZUiIUR8bAJo5Rx
        Mf6zzNXtoTBnYc42UUpPm19uvaM7K5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-f6goE7KzM6Gu4t4Se8tiUA-1; Sun, 22 Mar 2020 01:41:36 -0400
X-MC-Unique: f6goE7KzM6Gu4t4Se8tiUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7330F8017CC;
        Sun, 22 Mar 2020 05:41:35 +0000 (UTC)
Received: from t490s (ovpn-112-50.phx2.redhat.com [10.3.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 650475DA7D;
        Sun, 22 Mar 2020 05:41:34 +0000 (UTC)
Date:   Sun, 22 Mar 2020 01:41:31 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200322054131.GC1068248@t490s>
References: <20200322013525.1095493-1-aquini@redhat.com>
 <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s>
 <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 09:31:42PM -0700, Andrew Morton wrote:
> On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > + */
> > > > +static void force_lru_add_drain_all(void)
> > > > +{
> > > > +	sched_yield();
> > > > +	system("echo 1 > /proc/sys/vm/compact_memory");
> > > > +}
> > > 
> > > What is the sched_yield() for?
> > >
> > 
> > Mostly it's there to provide a sleeping gap after the fault, whithout 
> > actually adding an arbitrary value with usleep(). 
> > 
> > It's not a hard requirement, but, in some of the tests I performed 
> > (whithout that sleeping gap) I would still see around 1% chance 
> > of hitting the false-negative. After adding it I could not hit
> > the issue anymore.
> 
> It's concerning that such deep machinery as pagevec draining is visible
> to userspace.
> 
> I suppose that for consistency and correctness we should perform a
> drain prior to each read from /proc/*/pagemap.  Presumably this would
> be far too expensive.
> 
> Is there any other way?  One such might be to make the MLOCK_ONFAULT
> pages bypass the lru_add_pvecs?
>

Well,

I admit I wasn't taking the approach of changing the kernel because I was 
thinking it would require a partial, or even full, revert of commit 
9c4e6b1a7027f, and that would be increasing complexity, but on a 
second thought, it seems that we might just be missing:

diff --git a/mm/swap.c b/mm/swap.c
index cf39d24ada2a..b1601228ded4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -473,6 +473,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
                __mod_zone_page_state(page_zone(page), NR_MLOCK,
                                    hpage_nr_pages(page));
                count_vm_event(UNEVICTABLE_PGMLOCKED);
+               SetPageUnevictable(page);
        }
        lru_cache_add(page);
 }


I'll take a closer look into it, as well as test it properly, tomorrow. 
Thanks for the heads up, Andrew.
-- Rafael

