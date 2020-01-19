Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBEDC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4520730
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzGSL2YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgASKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:12:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbgASKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579428768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRdC5C9SszzHrx5URtnzUXOg+cpaWM91XUEJs3Q6WUQ=;
        b=HzGSL2YWHWOflty+9mNCmWyFMcOJNFZOsWM5YsgYoU1AOjhnjmurmrDmkJUJ4txEdDoZUv
        j3E3Snk29DejO4DQ7Wj2YLMf4Cuxyc/lGDiLypCGXy1gGP1EiQDhy6LVviw1GVVa426osV
        GKZGCXokcUz+M4oRusWu4RtxgY5Sptg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-HexgPQatMXOzJWRK0k3PwA-1; Sun, 19 Jan 2020 05:12:43 -0500
X-MC-Unique: HexgPQatMXOzJWRK0k3PwA-1
Received: by mail-qk1-f197.google.com with SMTP id 65so18592756qkl.23
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 02:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRdC5C9SszzHrx5URtnzUXOg+cpaWM91XUEJs3Q6WUQ=;
        b=RES5agqlxFivMMRMrVHR/4xbNCLQDDF4wxxh7Nj99bfeLW/fMElUaspzUFSMuWwngf
         BXAv4KO3y1S+cmBDj9VI/C3Ke8yLphed+/yZIuUXwb+ytIDd9RoWpt6mb2GEgcaKppGS
         kISQ4g2i6M15s3avwca4Cn95clqpPp0IwmDQE8Yc2xFBlRVp9EZHav/eAU3AHtP9bidu
         vLLMHjq4+dngiy9+rpeA5DlzVnqgcRi9V9eNlKJlbN+s81amJuUhdvgmbuSbUh/3xZ9c
         XFVnExR2rbD8UXMhrWwiUmJ4PIcfjIJzEJmHrmRjxJ9/s62KvFNAvWNgV3fNpa7dfMmQ
         e4RA==
X-Gm-Message-State: APjAAAVfNpvLRFHlciDWn8YjJgTUCULee5p8ukmvWe9Hjy0ogtmwjJH1
        Dk5Vx/m1Yjh39piHFVVUKAkyqeDiqCWlMLj4NoMQmGFLxAE7thcNPyS3QzQrdscOwyfMMYxhIUm
        Hg3hTWbB7VGUIabFCRRQHAsId
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr15879988qvs.159.1579428762705;
        Sun, 19 Jan 2020 02:12:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlPeGl3vOoGh87qeXcfrEvupqg6iDr2WU7KLpGIgdBVXimjeVKIOsMBPWxHRjhIbTCSqQDqQ==
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr15879976qvs.159.1579428762519;
        Sun, 19 Jan 2020 02:12:42 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id h32sm16168861qth.2.2020.01.19.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 02:12:41 -0800 (PST)
Date:   Sun, 19 Jan 2020 05:12:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200119051145-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:09:53AM +0100, Paolo Bonzini wrote:
> On 09/01/20 20:15, Peter Xu wrote:
> > Regarding dropping the indices: I feel like it can be done, though we
> > probably need two extra bits for each GFN entry, for example:
> > 
> >   - Bit 0 of the GFN address to show whether this is a valid publish
> >     of dirty gfn
> > 
> >   - Bit 1 of the GFN address to show whether this is collected by the
> >     user
> 
> We can use bit 62 and 63 of the GFN.

If we are short on bits we can just use 1 bit. E.g. set if
userspace has collected the GFN.

> I think this can be done in a secure way.  Later in the thread you say:
> 
> > We simply check fetch_index (sorry I
> > meant this when I said reset_index, anyway it's the only index that we
> > expose to userspace) to make sure:
> > 
> >   reset_index <= fetch_index <= dirty_index
> 
> So this means that KVM_RESET_DIRTY_RINGS should only test the "collected
> by user" flag on dirty ring entries between reset_index and dirty_index.
> 
> Also I would make it
> 
>    00b (invalid GFN) ->
>      01b (valid gfn published by kernel, which is dirty) ->
>        1*b (gfn dirty page collected by userspace) ->
>          00b (gfn reset by kernel, so goes back to invalid gfn)
> That is 10b and 11b are equivalent.  The kernel doesn't read that bit if
> userspace has collected the page.
> 
> Paolo

