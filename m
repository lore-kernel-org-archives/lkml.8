Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91361C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A73A2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HheXlu1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCJOJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:09:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgCJOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583849367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byWQY42UbKEvCBp8MZXn5MOeNLyHCCWS7iASAAIHrRc=;
        b=HheXlu1SVyi3nfmcJWM7USg9CMbR7wXPqNuSBv+Jsm0QeZNoVLyjYWyhfca4yI39Qr2OCY
        nsRWLKsYAD009t2bClX0PKQjlTTq3Xlt8kK9iPMmHBAUR3XLhdB+2/wWzdCcU33Ja25GWl
        fbuaYPnHe7zYGZdrserRPrcLBlnicNg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-lfW40ij5PLuqsiI-hXSeAw-1; Tue, 10 Mar 2020 10:09:26 -0400
X-MC-Unique: lfW40ij5PLuqsiI-hXSeAw-1
Received: by mail-qt1-f199.google.com with SMTP id n4so9228940qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byWQY42UbKEvCBp8MZXn5MOeNLyHCCWS7iASAAIHrRc=;
        b=XC2RqXYJbeiIudSqjqndwmkmIg5P2AXkTZs7GYfE7TjQSxUlBYE14JO/OKgi4INHLh
         kiX0FB9lDZESep1h16bSE2lBosLOEI/br0qetUshof4hG0wRkYaOAHEYOC+sSSyRsc2/
         txE6WmDzGsS5XT2CmmIjpbulr0afV/t4XIkt5/f1e8ET4+aavoDjRiIk5Uo6x5iRYAwH
         OBp2f46dhOHm/YVbuy+0ExPKBrPTS70sl8UpeDqMyqKzAw/86WP197fj1El7mgL1aItt
         6pR6gJJaR7LOcpEeHGehQnf0kICY8xKG93XVpdL4s+VjyHa7SSRt8WPPpPNtWk+Rwk6y
         qlqQ==
X-Gm-Message-State: ANhLgQ28ntu0NAexC2ZTqD4v0d7vXL6RUE7ggo34cs/mw4fYvwmW+8xr
        wm/ROV16vutswvVHGfRiCKoa+y99m9fVSRSPgHwvE6Y7uc5F9diW4b/PJPJXwRYnJS1vOEWCJRH
        QbuCMz24NNIAzRr5hwgmuX6Tm
X-Received: by 2002:a05:6214:1749:: with SMTP id dc9mr19418536qvb.236.1583849365643;
        Tue, 10 Mar 2020 07:09:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuselEllZdFmXTm+ij76DcuB/hAvX4mBLfQIVzSXmReeE0fULDXOqySrnGv9L/lJyNuHicsAw==
X-Received: by 2002:a05:6214:1749:: with SMTP id dc9mr19418482qvb.236.1583849365206;
        Tue, 10 Mar 2020 07:09:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k25sm361047qtm.94.2020.03.10.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:09:24 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:09:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v5 05/14] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200310140921.GD326977@xz-x1>
References: <20200304174947.69595-6-peterx@redhat.com>
 <202003061911.MfG74mgX%lkp@intel.com>
 <20200309213554.GF4206@xz-x1>
 <20200310022931-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310022931-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:31:55AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 09, 2020 at 05:35:54PM -0400, Peter Xu wrote:
> > I'll probably also
> > move KVM_DIRTY_LOG_PAGE_OFFSET==0 definition to uapi/linux/kvm.h.
> 
> 
> IMHO KVM_DIRTY_LOG_PAGE_OFFSET is kind of pointless anyway - 
> we won't be able to move data around just by changing the
> uapi value since userspace isn't
> recompiled when kernel changes ...

Yes I think we can even drop this KVM_DIRTY_LOG_PAGE_OFFSET==0
definition.  IMHO it's only a matter of whether we would like to
directly reference this value in the common code (e.g., for kernel
virt/kvm_main.c) or we want quite a few of this instead:

#ifdef KVM_DIRTY_LOG_PAGE_OFFSET
..
#endif

I slightly prefer to not use lots of "#ifdef"s so I chose to make sure
it's defined.  However I've no strong opinion on this either. So I'm
open to change that if anyone insists with some reasons.

Thanks,

-- 
Peter Xu

