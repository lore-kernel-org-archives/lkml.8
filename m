Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388EC20723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+Ak9Acf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgEZPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:22:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20646 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728279AbgEZPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590506520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3+ppRcVa8JUx5xospoY4qvA4Dy/RVPkzAWBhYz6jMk=;
        b=M+Ak9AcfgPiRwAzxxUQ/f5o4Xf2z7T3WMB4M6070LnZ98vRAkt/xskJer6+f5vMyskWbFj
        Dkr6yvM+t2WeO8OpOqnYBZq4wBBnR2/S4Rxhet+t56yx6FzN9KClrBl5AfIb5TvLzCPqce
        zJYl6nTA/jXAxS9q2imJdU5cgsvSaEg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-5t3PSVTrM0iEmrG0PzdkEQ-1; Tue, 26 May 2020 11:21:56 -0400
X-MC-Unique: 5t3PSVTrM0iEmrG0PzdkEQ-1
Received: by mail-qv1-f69.google.com with SMTP id i6so19973984qvq.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3+ppRcVa8JUx5xospoY4qvA4Dy/RVPkzAWBhYz6jMk=;
        b=owWO4ibNpAc6Xzqzg8F4g15WPWm4mamdIdlML27gwUOmAJG4fyA36XK6pNO2Y9ztdx
         FIZlUXtJu6blQT6k9dpk5MfNe/urTw6pYLB5/tBc3rDlRgK2N/s2QQg6XxG+XmsUKPw6
         xre9905V0Jf3tFlS2eKK3/BxyKjaQFpti84h+WXW2QgXyRKmU6HKIehpRLxEXg1czddg
         3wTgWhd+A5+GTXUoB0kYzhVLju+LwGQ2qY/hNwwYRhoaqix1HCaJOlHOkGccfn6kuE2G
         WDHEUT35rpbPAiEahVjSGdzdWRWcqG2gytQQZrWZIFMLuLCBjCcE2w7gWq1t+mcbhL1A
         YBYA==
X-Gm-Message-State: AOAM531u91V5zW+6APGFzBoo495rOtuAcmlkGY+TalZ2C3ve3NmA8NNT
        iKFnxxfIOUi9wdgocrFk5gNJuAnIVuVDsn0JOJN76dSVIoUeF5JWU7LkmEmXlyGoEnBMHkADqMy
        ottWOKxeaIPIqZ1Zb+XcduC6Q
X-Received: by 2002:a37:8485:: with SMTP id g127mr1722247qkd.119.1590506515948;
        Tue, 26 May 2020 08:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6I359ATFqenFd4WKNpAxEarPbZQCXQ/leY7dTJyfr+l/Cwhca0PRwy+0p6X3ojbPmmxjSCQ==
X-Received: by 2002:a37:8485:: with SMTP id g127mr1722213qkd.119.1590506515664;
        Tue, 26 May 2020 08:21:55 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w68sm7877836qkc.68.2020.05.26.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:21:54 -0700 (PDT)
Date:   Tue, 26 May 2020 11:21:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kbuild-all@lists.01.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v9 07/14] KVM: Don't allocate dirty bitmap if dirty ring
 is enabled
Message-ID: <20200526152152.GA1194141@xz-x1>
References: <20200523225659.1027044-8-peterx@redhat.com>
 <20200526150547.GC30967@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526150547.GC30967@xsang-OptiPlex-9020>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:05:47PM +0800, kbuild test robot wrote:
> >> arch/x86/kvm/mmu/mmu.c:1280:3: warning: Returning an integer in a function with pointer return type is not portable. [CastIntegerToAddressAtReturn]
>      return false;
>      ^

A rebase accident for quite a few versions...  Fixed.

-- 
Peter Xu

