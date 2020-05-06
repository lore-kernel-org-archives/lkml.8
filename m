Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CF6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86062145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnUkRVFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgEFRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:50:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgEFRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588787423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Z05vQkXn+ziuAvD6utXhI68kib5oxgxkY6iHW+5GBI=;
        b=cnUkRVFrybEEdTFd3rk0q/ZxCvKAZn8PiarCfOIHbyJ7/ni8wy+K9wFD8hQj37yj6kvpnR
        EFGC8qwF5cWZZcTdFcCI5VI6AXce8nZRt/MdAn4i8ofqrSr3QOREwvAxqXAWrVY9yAW8Tw
        p6vnDUocrOgIB+Y9KRtFgL2pro/2k3A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Pix_RzyKP6GkQCYJjQ8tRQ-1; Wed, 06 May 2020 13:50:15 -0400
X-MC-Unique: Pix_RzyKP6GkQCYJjQ8tRQ-1
Received: by mail-qt1-f200.google.com with SMTP id v18so3284568qtq.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Z05vQkXn+ziuAvD6utXhI68kib5oxgxkY6iHW+5GBI=;
        b=ioJFLqJaYeviZe7G2Ux7eRpssTKZG3htIWXVZv3rGw/u1he83YLQj8xJbfodU1ctqG
         8nRnE7oF2CoyT9pRI3HXpk0Zjgvlv4MklG2CWsH0DSm0RJPX+1LeoMeOwn5nkd9GCILm
         R7VmRFwElZA7Firc0mN26FikvEoPW8jFuW98ZBb6yFFhf957jxhRmKHwyP7kyNNfO2hz
         Gz5+5n8+JrjDEbCUtyXDbpm2BhtLC0WdVmdEuhLHKlG66++Yz1ENND28CJRbKtPq6kqV
         yYv07LUd10otKUOPbG8npZdhfWzJdxwKTArqGZSFdwMHybHoXJYwkreXBJa2tiGCAHj3
         3VYQ==
X-Gm-Message-State: AGi0PuYeWvSlE7KljxK8BhYz2S64X+XMAeB47gJ6hNKpLqNPHSxxGwmr
        p2zx/5/kNEW6NyLMVvMkx3fhjXnG6ptWMtUlUcdRBh0I3sWyXnnP6zkPxH9figjwVOESIIklRDt
        d4PF5y1h3IEcTNhw8RCMC5y4e
X-Received: by 2002:ad4:5449:: with SMTP id h9mr9475638qvt.108.1588787415483;
        Wed, 06 May 2020 10:50:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLqVrwGhKkJV64MsIWU5/JpO0dfx6jsJGkVCuI8nRpNJiKMXo0786rKvdn7EkGwPa5Czka7LQ==
X-Received: by 2002:ad4:5449:: with SMTP id h9mr9475615qvt.108.1588787415250;
        Wed, 06 May 2020 10:50:15 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 124sm2289941qkn.73.2020.05.06.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:50:14 -0700 (PDT)
Date:   Wed, 6 May 2020 13:50:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 9/9] KVM: VMX: pass correct DR6 for GD userspace exit
Message-ID: <20200506175013.GP6299@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506111034.11756-10-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:10:34AM -0400, Paolo Bonzini wrote:
> When KVM_EXIT_DEBUG is raised for the disabled-breakpoints case (DR7.GD),
> DR6 was incorrectly copied from the value in the VM.  Instead,
> DR6.BD should be set in order to catch this case.
> 
> On AMD this does not need any special code because the processor triggers
> a #DB exception that is intercepted.  However, the testcase would fail
> without the previous patch because both DR6.BS and DR6.BD would be set.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

