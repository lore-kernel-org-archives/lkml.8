Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0001CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD223120
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpkurE4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgHFRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:21:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729376AbgHFRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596734464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0yMbsT7pcgi1iAHyYcod+CvrElFV6deSSG6mOjxpA8=;
        b=JpkurE4TQ0HhBbugzOI7UcoukIohiO+2Q5pZdlZta5wGBQh2pLUmIxq935ZGVMRDOU724r
        ucCGYCiLwevzBgTcx3OoYOAhWyEp4urAQQBfXgdMC+HUyEiw9BIFqhjKmfxoy6b4WXPCq7
        gesZp62tf4JugFPJPFt1yEBtsQy+A7I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-UXY6awtINe2hI5AmW3Xsdw-1; Thu, 06 Aug 2020 07:39:12 -0400
X-MC-Unique: UXY6awtINe2hI5AmW3Xsdw-1
Received: by mail-ej1-f72.google.com with SMTP id lg2so13622407ejb.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 04:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z0yMbsT7pcgi1iAHyYcod+CvrElFV6deSSG6mOjxpA8=;
        b=QNqNJkPyFAAc+YLamO7ydEFLRpENZjOJbFGCYyn0/+i077yzpdg8+MOgV2VOO7yX1R
         /RzKbvFwmI05cpjGeLc73sbSCWsQDVsMnDuiPW70ZueTn4ulSOk4kJZOM5+n5Oo5r7fJ
         MayOJOc2MO3REePgQLjEFEkgwgHACU4G75UFtiY501YbSW8RvZYsD/5igTtkFfWyip9G
         KTkZEazA/wjogoZ5+81VNCNtVI656ba3/OFqtbOh6GGRjNZmLpT2m+oKf2ipEr/E7R+X
         TxrhIUWFqy2K/4dZHZ/kCUpzgCYLNmCM1JPfUpgbERFC7FMfr9wOEUw/p7dtWdUPaM/N
         2CLg==
X-Gm-Message-State: AOAM530a1OQ34t/1GErgOkR+rb6HDcAnFt7XIsA5EbYde+cPpykuMkIk
        02OqlrjjXjkaavNFCHRT6ZKRd25bk5BQkNctk3MwjFGtuuGMlTr6FJ/S+YjQ0DbeY1roTk9Much
        DtOtKjakPjxM6jXGmD1dGITaN
X-Received: by 2002:a50:d485:: with SMTP id s5mr3707037edi.285.1596713951113;
        Thu, 06 Aug 2020 04:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9gpH7Y4wZjbEShVJ7bFDHbXcr/x4vdBu+Kk8uS1Zn8NzRbVW/Adp0kk2I0m9EFJ/FFoNX6Q==
X-Received: by 2002:a50:d485:: with SMTP id s5mr3707021edi.285.1596713950936;
        Thu, 06 Aug 2020 04:39:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w7sm3521262ejb.3.2020.08.06.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 04:39:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Xu <peterx@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
In-Reply-To: <20200806055008-mutt-send-email-mst@kernel.org>
References: <20200728143741.2718593-1-vkuznets@redhat.com> <20200805201851-mutt-send-email-mst@kernel.org> <873650p1vo.fsf@vitty.brq.redhat.com> <20200806055008-mutt-send-email-mst@kernel.org>
Date:   Thu, 06 Aug 2020 13:39:09 +0200
Message-ID: <87wo2cngv6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> About the feature bit, I am not sure why it's really needed. A single
> mmio access is cheaper than two io accesses anyway, right? So it makes
> sense for a kvm guest whether host has this feature or not.
> We need to be careful and limit to a specific QEMU implementation
> to avoid tripping up bugs, but it seems more appropriate to
> check it using pci host IDs.

Right, it's just that "running on KVM" is too coarse grained, we just
need a way to somehow distinguish between "known/good" and
"unknown/buggy" configurations.

-- 
Vitaly

