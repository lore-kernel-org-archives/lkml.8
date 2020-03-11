Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AAC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A72073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5dHeWnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgCKRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:45:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43603 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730568AbgCKRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583948716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AB8Xr/U170UK1wx2l/F+WJsKF1gpUCBlvtcUiwS4DKw=;
        b=b5dHeWnFVc795gzOCHfG+taxyZnLAIswfiXbkbfKGb3lfDbm7f745A4pd222tXgDN7g3Z3
        0/n4lgk952w5eves5o2D2h0gQ6QUZH3eeKpd1UTARI0BWpMS4uBXVocx4MRZG968U+OSiy
        01uFWfhuwoyqLQOeWPFx1NxcyGLScf0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-UOReIK3aNUCe5QSnRhrRlw-1; Wed, 11 Mar 2020 13:45:15 -0400
X-MC-Unique: UOReIK3aNUCe5QSnRhrRlw-1
Received: by mail-qt1-f199.google.com with SMTP id d2so1710604qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AB8Xr/U170UK1wx2l/F+WJsKF1gpUCBlvtcUiwS4DKw=;
        b=ScOt8CZIYZJ+gJwt738SyEBpjjgTrNJNxoG5Jp89vH0K6hvT/Ecx7LTEO9NeAR0d8g
         Tedku3Xa3NXPBxIxMXMykXNwqggfaGrJwL1dmfo5en+oHa0a9Lnv9vy9lEUAK7GyXtve
         5jo2rJtpEXCfzuJcZXyhL9HFTpokXUpy/xIMYw7SiQ/y/Q90NjqBuYrxVZGBp5Zvgoo3
         SLchOox+anQ/zmRYq1o6ba2coSZFOVLsD+YhYOtntKI0Br5DQrkXmkHYSRqKlvk0DnmP
         X6xjuM4YauiV4zwx3EC8oi0HqU0OXLqUJ/AXJMxbizwGWM57RXurcDZyAK1n1Tl+lI2j
         OyPQ==
X-Gm-Message-State: ANhLgQ3WIiuGiWp57h9YzSuKg0RYRqyrlAhIB4Pr/y9zcKn79RNwoq+2
        88HIa5VPLTV7zH4WH41JBgadBsjqGAzmlvK5xP3TjEjf6B1d2KlOixgu0v+6kmTyR0Gu4ff+Cv/
        Kf1FdBHZ6LxXinNIZlCYrAXt7
X-Received: by 2002:a37:3c7:: with SMTP id 190mr3983851qkd.130.1583948713758;
        Wed, 11 Mar 2020 10:45:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvnvBW0KU19maXwWy9gbtSBb/6E4IjU2yQzpZ+WMaT2HfH/SpqJrH1c4nEHWDgV/4Uz0pUc3A==
X-Received: by 2002:a37:3c7:: with SMTP id 190mr3983828qkd.130.1583948713469;
        Wed, 11 Mar 2020 10:45:13 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 128sm863687qki.103.2020.03.11.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:45:12 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:45:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 13/14] KVM: selftests: Let dirty_log_test async for
 dirty ring test
Message-ID: <20200311174510.GJ479302@xz-x1>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309222534.345748-1-peterx@redhat.com>
 <20200310082704.cvmy6h4u7t2spncd@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310082704.cvmy6h4u7t2spncd@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:27:04AM +0100, Andrew Jones wrote:
> >  enum log_mode_t {
> >  	/* Only use KVM_GET_DIRTY_LOG for logging */
> > @@ -156,6 +167,33 @@ enum log_mode_t {
> >  static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
> >  /* Logging mode for current run */
> >  static enum log_mode_t host_log_mode;
> > +pthread_t vcpu_thread;
> > +
> > +/* Only way to pass this to the signal handler */
> > +struct kvm_vm *current_vm;
> 
> nit: above two new globals could be static

Will do.

-- 
Peter Xu

