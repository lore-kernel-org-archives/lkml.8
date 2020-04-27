Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA78C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C0820656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB7VnSaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgD0Ohi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:37:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727834AbgD0Ohh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587998256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dI491+uqcVLGhJLl51discOwhIsOK6fPYn0lrj9azwI=;
        b=cB7VnSaOmPiw8m4FJIsN0lx1YHaSAsMdmaz6Bd8b/kB3b0IqW+C0swfhAv6oh+AgHeWX0t
        7a6sScQWYvP7HDSRHpFIdTpC7JtmVHTBRyHy8jQvuuKcYIX3te1p63PwHzzdSGd0rWYVNI
        w6NoMaQyo4QIics8LSLXP8BbfsHDkwg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451--4HO0W6AOVy4fWo7F_h81A-1; Mon, 27 Apr 2020 10:37:34 -0400
X-MC-Unique: -4HO0W6AOVy4fWo7F_h81A-1
Received: by mail-qt1-f198.google.com with SMTP id z3so20636781qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dI491+uqcVLGhJLl51discOwhIsOK6fPYn0lrj9azwI=;
        b=eVSTCKHR2RdnSEFM79XnUwDf6pXszdmbQBLzGFlDuYWlfOKM4TE10WAP/VVZTG13a8
         gWaqOV/DXKVsCnWTfDhD8qucUw+suMakDZfzBnrw5u/dWj0DNl174phXhz2bFUfTJOnR
         CXx7H4VS6NoynOgpZpukzc9+F7l/nnKTVguiH1XqPPuwbsmkJ/DjL0YPDwechJCo6PLV
         er1gVgLf8hWoS21D4zNTRUPXz4hSAAD9gIvaSXrk0ZTPWw10l2QFCbSKRl0ZDGT5rMP3
         yul/WL8x4aYYKSB1sgFYt0coCKrZfcOiWRoZCNbWBfsYRAQ7qfwLGX8R9oIAfEOJtBoW
         qHDw==
X-Gm-Message-State: AGi0PuYWNZ1Dc6i91GPj7awqmHA04XowbY8NKxsnfL3SoyoSl+MseNxF
        0YSYNM2wTnVDkdscspcIoqOfm1CZ7kL3jFUC+msK/6sNKXFxGwHHMWFNIGLYoJrRPF2dXJKlyZP
        XUU8GQ4bsWDFNE+lYEenUJUO+
X-Received: by 2002:ac8:70c9:: with SMTP id g9mr23361870qtp.375.1587998254324;
        Mon, 27 Apr 2020 07:37:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3MOntIHO6GU9G0j7CB5hrTg6E4pfYWNz7v8nCSIxAIx1xDbSwwoNvtfL/Bg7I4pCVzDsSUw==
X-Received: by 2002:ac8:70c9:: with SMTP id g9mr23361839qtp.375.1587998254074;
        Mon, 27 Apr 2020 07:37:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c6sm10441899qka.58.2020.04.27.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:37:33 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:37:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
Message-ID: <20200427143732.GD48376@xz-x1>
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
 <20200423190941.GN17824@linux.intel.com>
 <20200424202103.GA48376@xz-x1>
 <f1c0ba71-1c5b-a5b7-3123-7ab36a5c5c74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1c0ba71-1c5b-a5b7-3123-7ab36a5c5c74@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 09:48:17AM +0200, Paolo Bonzini wrote:
> On 24/04/20 22:21, Peter Xu wrote:
> > But then shouldn't DIRTY be set as long as KVM_DEBUGREG_BP_ENABLED is set every
> > time before vmenter?  Then it'll somehow go back to switch_db_regs, iiuc...
> > 
> > IIUC RELOAD actually wants to say "reload only for this iteration", that's why
> > it's cleared after each reload.  So maybe...  RELOAD_ONCE?
> > 
> > (Btw, do we have debug regs tests somewhere no matter inside guest or with
> >  KVM_SET_GUEST_DEBUG?)
> 
> What about KVM_DEBUGREG_EFF_DB_DIRTY?

The problem is iiuc we always reload eff_db[] no matter which bit in
switch_db_regs is set, so this may still not clearly identify this bit from the
rest of the two bits...

Actually I think eff_db[] is a bit confusing here in that it can be either the
host specified dbreg values or the guest specified depends on the dynamic value
of KVM_GUESTDBG_USE_HW_BP.

I am thinking maybe it's clearer to have host_db[] and guest_db[], then only
until vmenter do we load either of them by:

  if (KVM_GUESTDBG_USE_HW_BP)
    load(host_db[]);
  else
    load(gueet_db[]);

Then each db[] will be very clear on what's the data is about.  And we don't
need to check KVM_GUESTDBG_USE_HW_BP every time when accessing eff_db[].

> 
> We have them in kvm-unit-tests for debug regs inside the guest, but no
> selftests covering KVM_SET_GUEST_DEBUG.

I see!  Thanks,

-- 
Peter Xu

