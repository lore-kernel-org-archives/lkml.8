Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C3C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E043208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCAAf2+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEAVKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:10:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EAFC061A0C;
        Fri,  1 May 2020 14:10:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h124so10520366qke.11;
        Fri, 01 May 2020 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4raYYwlZeCPb51zzK5P1JX3NYA3M/dL6M9ecAXSbJTM=;
        b=fCAAf2+VOINsY/rRVDMrPybsp9nJTjGZbWjH11kd20m6TV+q7W4IY9T+Bcai3OPD9w
         eFTWq9JcrR8LgWFc8ahCeVJNB9sd2CpWHX5l8LYc2FL3XoDBjwxE3WNISnaRM2U6IVxk
         S3dKP7JMTDgz50CDNmhKJzXojxqk/TQWnlB+wQjBQdRswTXt3goPpdglsuIzVpsDUfx8
         Rgb10kxj5yDzdBn2PE5KWltRRzFVHOs98HU64W1bl694KilSVPVbsQj260l/1IAqVYhL
         nZkSCJVn0HYCir/CipAhFBRbCNHNKWa5yg7Ma/tnKEd/MRx5DsN+8rSCdYEvF2mZrJpW
         eq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4raYYwlZeCPb51zzK5P1JX3NYA3M/dL6M9ecAXSbJTM=;
        b=smdLkJjdHARod5ezHFr7OA90+b1+bnR7jczwWOt9BnIIjwWHSv8nJYeBKh/LLZA392
         fKI6/eWJQpNqvBZ8tyqHY82WhjZBao+D1iwaJMp1Ul+xt3XHgov7ox2IJIOKautDH/dy
         FGxWjduc2mMCQdE78ZYXmcL0B4kuty+AooVGTkJVYFR0Dp5k9q8JD1fuL04QWDPZTRLM
         hfW4DPvHLH6an+Lrfe3vRct6nguMJrwUdJOAP+E5c2W2tweK6yXpg3roReIOUsBmujbV
         Bh3zcPpAkM4uoOycobGfb9ABtKkXRx79uf3CZ3LGsnJrk3izNvw2lOPTYHz9fXUkGU1x
         XHSg==
X-Gm-Message-State: AGi0PuYFF4GsCZnmn+3wAHnvMHzD3gekPqXf9tp/qcv2vPmssrlybMyx
        PwZK3lRqwRRHspr5Dz+I3P4=
X-Google-Smtp-Source: APiQypJS2xBXb/Rw2v0s2jy7FIpC/aX9vUBA0gBSKfTqmuleXydYboe8ODoXXXvx6K9nQWFa/oV17Q==
X-Received: by 2002:a37:9ccb:: with SMTP id f194mr5457334qke.151.1588367443753;
        Fri, 01 May 2020 14:10:43 -0700 (PDT)
Received: from josh-ZenBook ([70.32.0.110])
        by smtp.gmail.com with ESMTPSA id m12sm3528461qtu.42.2020.05.01.14.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 14:10:43 -0700 (PDT)
Date:   Fri, 1 May 2020 17:10:40 -0400
From:   Joshua Abraham <j.abraham1776@gmail.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, corbet@lwn.net, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        j.abraham1776@gmail.com
Subject: Re: [PATCH] docs: kvm: Fix KVM_KVMCLOCK_CTRL API doc
Message-ID: <20200501211040.GA22118@josh-ZenBook>
References: <20200501193404.GA19745@josh-ZenBook>
 <20200501201836.GB4760@linux.intel.com>
 <20200501203234.GA20693@josh-ZenBook>
 <20200501205106.GE4760@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501205106.GE4760@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:51:06PM -0700, Sean Christopherson wrote:
> I don't disagree, but simply doing s/host/guest yields a misleading
> sentence and inconsistencies with the rest of the paragraph.

I see your point. Would this wording be clearer:

"This ioctl sets a flag accessible to the guest indicating that it has been
paused from the host userspace.

The host will set a flag in the pvclock structure that is checked
from the soft lockup watchdog.  The flag is part of the pvclock structure that
is shared between guest and host, specifically the second bit of the flags
field of the pvclock_vcpu_time_info structure.  It will be set exclusively by
the host and read/cleared exclusively by the guest.  The guest operation of
checking and clearing the flag must be an atomic operation so
load-link/store-conditional, or equivalent must be used.  There are two cases
where the guest will clear the flag: when the soft lockup watchdog timer resets
itself or when a soft lockup is detected.  This ioctl can be called any time
after pausing the vcpu, but before it is resumed."
