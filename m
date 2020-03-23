Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DCC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F7207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaOh6IUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCWV6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:58:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38824 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgCWV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585000732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrfYR5Mq4/pcFfLsa/LVNTAJa62E45cyd+8qzOhvSWg=;
        b=SaOh6IUnmhnRCCShK7OBy+cqQvSLREkfN0WTDZj5VnbjhGT9N3urxuA4nDW+g9Mkijf/zC
        kM/CceGnNEThJJFpu2DhJCzss1TLpaRo7jYpC4NSdnhp/kHxXQUSnaq2O5axExYjlGJDAK
        OeA1DPOkHP3JIsoLb1Bdh5SBXDEmCNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-wGOFFR_eOx2DBhGjn2MNHQ-1; Mon, 23 Mar 2020 17:58:50 -0400
X-MC-Unique: wGOFFR_eOx2DBhGjn2MNHQ-1
Received: by mail-wr1-f69.google.com with SMTP id d17so8136586wrw.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrfYR5Mq4/pcFfLsa/LVNTAJa62E45cyd+8qzOhvSWg=;
        b=R3GTk9sJuP5wfHgYJwIg7jorE/mxMpbKN4kwGRYfqXPc8cg7Xw+EfGDbh4arIRvc62
         wc4fcWLsaue3c3NnSCDfOD7huSja6lNXnuzKVM7wbEwQ1phf1darVGN4QycKfgPn6b1z
         E0ztPWjlXbLTX2VGJV/W51U5CN2yzeRQczYI0+efw86gNpq/keuKgynnrZt54Qu8/t92
         OXO5RgjUvZaM542Ww59YIbBgbLHzDNn647CT4Ya7BVmC7BFNG4MmzgR9rEqP4AU32hjF
         wpuht3jCKJHLQ3Yf6IRhqxlOVXLMqrZirYAF3BPeWGvuHcwkd5pCV+ky1ExrehJE0zG3
         95dA==
X-Gm-Message-State: ANhLgQ1UBvJsMrDmvFDU02lH8lsAwnSqnWmyccwXcTdckbgaZytLqdv+
        lc8S5IUKAD/DuVqH3H7EZcvKmpo0KNVWFW/YbrvFnnwdFABDmO80k4DZarQj71s1ZO2IAKRwrzZ
        EMPo3Ql4DapZSAQFQjb5fQ+1A
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr30695178wrx.382.1585000729464;
        Mon, 23 Mar 2020 14:58:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtET33cycpmBlukNFuklN1WSVqsTdfPc043Kg05YB8fRQsvxJluzmQGxGP1uB2QGW88BmLZgQ==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr30695156wrx.382.1585000729157;
        Mon, 23 Mar 2020 14:58:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p22sm1224886wmg.37.2020.03.23.14.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:58:48 -0700 (PDT)
Date:   Mon, 23 Mar 2020 17:58:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 7/7] KVM: selftests: Add "delete" testcase to
 set_memory_region_test
Message-ID: <20200323215844.GS127076@xz-x1>
References: <20200320205546.2396-1-sean.j.christopherson@intel.com>
 <20200320205546.2396-8-sean.j.christopherson@intel.com>
 <20200323190636.GM127076@xz-x1>
 <20200323214317.GV28711@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323214317.GV28711@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:43:18PM -0700, Sean Christopherson wrote:
> On Mon, Mar 23, 2020 at 03:06:36PM -0400, Peter Xu wrote:
> > On Fri, Mar 20, 2020 at 01:55:46PM -0700, Sean Christopherson wrote:
> > > +	/*
> > > +	 * Spin until the memory region is moved to a misaligned address.  This
> > > +	 * may or may not trigger MMIO, as the window where the memslot is
> > > +	 * invalid is quite small.
> > > +	 */
> > > +	val = guest_spin_on_val(0);
> > > +	GUEST_ASSERT(val == 1 || val == MMIO_VAL);
> > > +
> > > +	/* Spin until the memory region is realigned. */
> > > +	GUEST_ASSERT(guest_spin_on_val(MMIO_VAL) == 1);
> > 
> > IIUC ideally we should do GUEST_SYNC() after each GUEST_ASSERT() to
> > make sure the two threads are in sync.  Otherwise e.g. there's no
> > guarantee that the main thread won't run too fast to quickly remove
> > the memslot and re-add it back before the guest_spin_on_val() starts
> > above, then the assert could trigger when it reads the value as zero.
> 
> Hrm, I was thinking ucall wasn't available across pthreads, but it's just
> dumped into a global variable.  I'll rework this to replace the udelay()
> hacks with proper synchronization.

I think ucall should work for pthread (shared address space of either
kvm_run or guest memories), however my thought was even simpler than
that, something like:

  - in guest code: do GUEST_SYNC after each GUEST_ASSERT
  - introduce a global_sem
  - in vcpu thread: when receive GUEST_SYNC, do "sem_post(&global_sem)"
  - in main thread: replace all usleep() with "sem_wait(&global_sem)"

-- 
Peter Xu

