Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D8F2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSwF+D08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFEMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:01:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726409AbgFEMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591358470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koYvTfzTJI5r8VtL4DRaQD0KHilxQUR15cCQUq6rzzk=;
        b=TSwF+D08gH++PGzYkupFxklImL29cWqoN77yRSwzBBg184UO9gYo22/EI1WcJ0CVnZ9TjF
        cNoaXaGC0j9JxdErx8/INfCF/plDVQqoZ3ye2orEg0r8E+OourXs4v7mGqET9iTXsBKJ6C
        vP3lPANHjFLk6AQnKZS6MDsWnQJHpHY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-KUiqteraNQCYKU01UePq1w-1; Fri, 05 Jun 2020 08:01:09 -0400
X-MC-Unique: KUiqteraNQCYKU01UePq1w-1
Received: by mail-ed1-f70.google.com with SMTP id n17so3855148eda.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=koYvTfzTJI5r8VtL4DRaQD0KHilxQUR15cCQUq6rzzk=;
        b=VwT9xCYxOOgl3E79gjkNwd2wPtOu7DoI3aY4UaAL+DPntzh0hjBamWH+ZK5alerAGE
         LR8ZgR2vtK/0apYIUB44cn0mCtlBgn80hYtjZfA9DhS6JDVgM7kj/kDyGaKMdlJW3qhK
         RYIxWTzVfePbo34UJV54xXESHRj15edos5iz2IsJI2NwMiKkM9rrID/C2j93uOXg9S9U
         w8BRFzIrT9JzWwAs6GqtSWn1M9L02GHOfqvRTaXHYduR6JCKQxrrOMy296DEiM9rALOf
         8dPszKEi4el3zB62egoRsRz5EP1sEODeq2PjQVlL2V/Izn6xYk7m1aTQDTCKQjIRJ/VG
         dX3w==
X-Gm-Message-State: AOAM531621iMJuyX2Wc4q5YH8YLsOh7+IuOrxMIuVytTq3wHzsledKh3
        Q2xgthqP+yeoBywMqMZDhHmHHFnURay3+GNvD57iBLYhVDpxb8FbIicpnP7BvtkpGxFRARf59ef
        YRgPREs1NwYjNNOphAsVbdH+W
X-Received: by 2002:a17:906:3282:: with SMTP id 2mr7348341ejw.93.1591358466800;
        Fri, 05 Jun 2020 05:01:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4mg+1ju4xwuQjCgV74nKX0+9fP5fpSq/euIfIv9LH5AlAojtnD1kk4Ji9SxivYef/Pf9tLg==
X-Received: by 2002:a17:906:3282:: with SMTP id 2mr7348292ejw.93.1591358466170;
        Fri, 05 Jun 2020 05:01:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f13sm4674767edk.36.2020.06.05.05.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 05:01:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: nVMX: Properly handle kvm_read/write_guest_virt*() result
In-Reply-To: <20200605115906.532682-1-vkuznets@redhat.com>
References: <20200605115906.532682-1-vkuznets@redhat.com>
Date:   Fri, 05 Jun 2020 14:01:04 +0200
Message-ID: <87v9k5d8n3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Syzbot reports the following issue:

Noticed while sending: the prefix of the patch should be "KVM: VMX:" as
it is not only nested related...

-- 
Vitaly

