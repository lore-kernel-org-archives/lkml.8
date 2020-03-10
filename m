Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1D2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ3LCU7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJGcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:32:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgCJGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583821926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yU8oUTA8/wnaOz9hoJioLzE4hVFWMjV/4+YfFPe8NY=;
        b=aZ3LCU7SduD5XEMiwKFoEifIBfoOmMeOA4uqX7fAg2KkJZXV8XyWGzAwrZ5k9uJaKI36c0
        hWqzo3WgyALMCjFq/cG6Q7IRGo1jrKqRnLy1UHX/NkE47sKK6VTl0RlHsTEoPUX/+Yu0g1
        58U5bzzgraNTLZs9a853e/kIAdbSzFk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-6kUlt1K1Nl-7ydPIcaviOA-1; Tue, 10 Mar 2020 02:32:03 -0400
X-MC-Unique: 6kUlt1K1Nl-7ydPIcaviOA-1
Received: by mail-qk1-f200.google.com with SMTP id m6so5708402qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yU8oUTA8/wnaOz9hoJioLzE4hVFWMjV/4+YfFPe8NY=;
        b=HM3cqJya6N7dBH0oBSLe8uAI6pv5U/8CgGpYzdFdtcquZHx6EGZSLSe1m3CWbniqwV
         mANsWAab2HjXIrrQocQyiNzDruM5j/jfSDCfxUEV6VaMlw9e/fbH62zX3eRMnJb6U8zu
         vDi3gylv92MSs0nFNXbhPhrUtncTNhCfQtlwoUKgZ1ko7ei6UXSNJtWVzEPmqY4awyMR
         tQpMONilzKPPNJYFAm9yjUuTLaO5/zy0Wm4ix2CH+gQLBkwlpB6sVa+UWypo60FVjs0+
         AJ9E50ypSvcMliuvXt4atjG8j80oDot2NItTsIxbfELKqkNPqxX30/ujhuc/sVFBcs2E
         wWMQ==
X-Gm-Message-State: ANhLgQ1V3GKz8yrkxdHPJ3O4m3903zOCC45086fTW8r9WcOC2Abj9avH
        CGmGbRzBj0O2EL/WWstdpRBiURXw31Sr6P5sq+vRNd1icCVAWeWNmcXic8dAcUfeB99Eg7MR0np
        77K3Jy8NM13OfuZlt+Jfn5a9+
X-Received: by 2002:ad4:510f:: with SMTP id g15mr17843674qvp.105.1583821923117;
        Mon, 09 Mar 2020 23:32:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuxiDdLJVlLKqFBw/p9Wp9h+eHv1I2YQjlDbjEPANoQ+DnOSPJfUC4oUjNeZIuVmyLRb0N5hg==
X-Received: by 2002:ad4:510f:: with SMTP id g15mr17843652qvp.105.1583821922918;
        Mon, 09 Mar 2020 23:32:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id e7sm14687548qtp.0.2020.03.09.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:32:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 02:31:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200310022931-mutt-send-email-mst@kernel.org>
References: <20200304174947.69595-6-peterx@redhat.com>
 <202003061911.MfG74mgX%lkp@intel.com>
 <20200309213554.GF4206@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309213554.GF4206@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:35:54PM -0400, Peter Xu wrote:
> I'll probably also
> move KVM_DIRTY_LOG_PAGE_OFFSET==0 definition to uapi/linux/kvm.h.


IMHO KVM_DIRTY_LOG_PAGE_OFFSET is kind of pointless anyway - 
we won't be able to move data around just by changing the
uapi value since userspace isn't
recompiled when kernel changes ...


> -- 
> Peter Xu

