Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150320739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZhx8ody"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCTQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:08:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25665 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbgCTQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584720530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+2BZLljduDR4gY9kJvfaxoG77rg51FKrPLFzBeLubM=;
        b=KZhx8odyDLqY/cCqwW445AjCK9R7MnjzROOB/V0psd2U1rzrG9On1cjxWYvk0XxfNvipyH
        VU/06jYO9lk8oUgJ8nDs/uVqaMi5FHx3Xo70bwfbx5SmfpnSYgJHpUhRtlH/EM0koWv/vR
        GKBNP05f/YrFQmsPS/iVxtwONL+u46s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-iyaH6NcLOuildf2WJdn0Wg-1; Fri, 20 Mar 2020 12:08:48 -0400
X-MC-Unique: iyaH6NcLOuildf2WJdn0Wg-1
Received: by mail-wm1-f71.google.com with SMTP id v184so1971715wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R+2BZLljduDR4gY9kJvfaxoG77rg51FKrPLFzBeLubM=;
        b=P6mLRvX0uBwPDmi8ma80LfeTDqXjDm6s3o8nq4CKrP0YwYcjeAUNcw5fH2xrfji1bD
         mpTZb6GmqCXYZf3BQSDLfc3mANXh5Wmkp5aGz3ShM2Li5Sf8j4UOkteIyjjK8g6gy4OI
         CHE7j4NFRq0JeizYBIpb1ljIWMsMHL/kB3yBJL8/WeIjEl1ye2SEcP338gqyRf7nSsxA
         4raxkMc4o7JNrCBhAVQPwfhYm5JXdHmGPg0FtQLcRylpUTn2WgH/8dySZbcaszC8Uacp
         D1ioGSCINpqPY6DENxGoEk+tTHXkmEfJmwHHXaK++rZFNcP7eEHZcciw8nc6Vk0+81P4
         y6Kg==
X-Gm-Message-State: ANhLgQ0hj+csYMbWYQeeo81Mbkk1cW0ITDeSGuY3qLiEVsUV83tEYqCd
        grvbCVcRN0H3mOkh394U9rwKGrWXPY1/DS0woGv4fbQSoiUHHq1dYcL74OqsIQZcEbaIuvlCb4C
        MJznBcnGRNBuAnNM+v20YKy3Z
X-Received: by 2002:a05:6000:370:: with SMTP id f16mr12276234wrf.9.1584720527390;
        Fri, 20 Mar 2020 09:08:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvO1+wVJWGCOAIsUa5XTIUbHwop7hDHw1XAgSOqKk8kdtayaPKfI3Y8uamOGk69TeQA1/LHmQ==
X-Received: by 2002:a05:6000:370:: with SMTP id f16mr12276192wrf.9.1584720527078;
        Fri, 20 Mar 2020 09:08:47 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id x5sm9157795wrv.67.2020.03.20.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:08:46 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:08:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: slab-out-of-bounds due to "KVM: Dynamically size memslot array
 based on number of used slots"
Message-ID: <20200320160842.GE127076@xz-x1>
References: <8922D835-ED2A-4C48-840A-F568E20B5A7C@lca.pw>
 <20200320043403.GH11305@linux.intel.com>
 <5FF6AF4E-EB99-4111-BBB2-FE09FFBEF5C4@lca.pw>
 <20200320135346.GA16533@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320135346.GA16533@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:53:46AM -0700, Sean Christopherson wrote:
> On Fri, Mar 20, 2020 at 09:49:03AM -0400, Qian Cai wrote:
> > 
> > 
> > > On Mar 20, 2020, at 12:34 AM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > > 
> > > On Thu, Mar 19, 2020 at 11:59:23PM -0400, Qian Cai wrote:
> > >> Reverted the linux-next commit 36947254e5f98 (“KVM: Dynamically size memslot array based on number of used slots”)
> > >> fixed illegal slab object redzone accesses.
> > >> 
> > >> [6727.939776][ T1818] BUG: KASAN: slab-out-of-bounds in gfn_to_hva+0xc1/0x2b0 [kvm]
> > >> search_memslots at include/linux/kvm_host.h:1035
> > > 
> > > Drat.  I'm guessing lru_slot is out of range after a memslot is deleted.
> > > This should fix the issue, though it may not be the most proper fix, e.g.
> > > it might be better to reset lru_slot when deleting a memslot.  I'll try and
> > > reproduce tomorrow, unless you can confirm this does the trick.
> > 
> > It works fine.
> 
> Thanks!  I'll send a proper patch in a bit, tweaking a selftest to try and
> hit this as well.

Would resetting lru_slot be better?  So to avoid other potential
references to an obsolete lru_slot outside search_memslots().  E.g., I
see that s390 has another function (gfn_to_memslot_approx) used it.

Thanks,

-- 
Peter Xu

