Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B63C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509D23107
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0wZzzdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgDFNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:21:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728289AbgDFNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586179277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dt00ToAjgq6odVjJUr2HynAfwKXr6ghEKV21ZUG8JdU=;
        b=D0wZzzdU8PqTR3WbL5BZnu4mgcm6k3MgzZczh6Mct2UWT/MniQVMC6xvVBPeH02lFUp0Fk
        N2PjCGUO4iIECw24eVoCeC+FGJWUErKlmwb0/NIMHaoEcc8HYeNpTg1WWrt0gz66eLaxXO
        l2vkcxnW5uBDjeVLedMAp+0/9HbOepE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-2gL22dYHPhSijOz1uGqpmA-1; Mon, 06 Apr 2020 09:21:15 -0400
X-MC-Unique: 2gL22dYHPhSijOz1uGqpmA-1
Received: by mail-wr1-f69.google.com with SMTP id y6so2204339wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dt00ToAjgq6odVjJUr2HynAfwKXr6ghEKV21ZUG8JdU=;
        b=iWTLfA0nRxWUNDMCgzU+d8WMV9kDkgMSIBaFusZekbTr508zc3qkQmco182VQGzQKQ
         DfDhS6YcbqnyK0G9BrFQnNJEsMczK7mJXk83HnCMUe1YR1z6u7+fCm7WetWzPkUJdy90
         VT9nA3XX0XZ2mRAsLfL0z2Sx5qwvY9rktGeA/ajoGA5OJo7f1i5C63YELOD4OFLLJX2m
         SgTLgS/0MjUBcJAY3fmO5L1D2sZCy9vRLMI2dD6E58YZK+e9pK2vTMStaXesGpi8S2xa
         oI+S7ItgC9Ncf6KwwruYKNRRIULSozuCwLASJRwG6Kme0263+b0LRbzNfLfS3zbXye7B
         cQTg==
X-Gm-Message-State: AGi0PuaUkzpsQvr/gzq1nCqzTObSMwkmLXuZo4dBCQEhfSBXLYG55Ns2
        mNunxnUd8695B6k0zHGKq1/4Ptdo9j9J74d4g4UzTAQv1W68pJxJnJViOZdnU0Vr9yWTRX+nh71
        0Qw4KPErmVBMqnNyR/48OIASw
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr11428320wrr.215.1586179274432;
        Mon, 06 Apr 2020 06:21:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTm0wN4Ob+KU8r6bjP+vUj5Sc5r+ElDJG7FGW/nVL32K8rRyDddIp810vWUMYetH05ffupWw==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr11428298wrr.215.1586179274273;
        Mon, 06 Apr 2020 06:21:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z11sm11162174wrv.58.2020.04.06.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:21:13 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:21:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "christophe.lyon@st.com" <christophe.lyon@st.com>,
        kbuild test robot <lkp@intel.com>,
        "daniel.santos@pobox.com" <daniel.santos@pobox.com>,
        Jason Wang <jasowang@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        kvm list <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] vhost: disable for OABI
Message-ID: <20200406092056-mutt-send-email-mst@kernel.org>
References: <20200406121233.109889-1-mst@redhat.com>
 <20200406121233.109889-3-mst@redhat.com>
 <CAK8P3a1nce31itwMKbmXoNZh-Y68m3GX_WwzNiaBuk280VFh-Q@mail.gmail.com>
 <20200406085707-mutt-send-email-mst@kernel.org>
 <CAK8P3a1=-rhiMyAh6=6EwhxSmNnYaXR9NWhh+ZGh4Hh=U_gEuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=-rhiMyAh6=6EwhxSmNnYaXR9NWhh+ZGh4Hh=U_gEuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:15:20PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 6, 2020 at 3:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 06, 2020 at 02:50:32PM +0200, Arnd Bergmann wrote:
> > > On Mon, Apr 6, 2020 at 2:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > >
> > > > +config VHOST_DPN
> > > > +       bool "VHOST dependencies"
> > > > +       depends on !ARM || AEABI
> > > > +       default y
> > > > +       help
> > > > +         Anything selecting VHOST or VHOST_RING must depend on VHOST_DPN.
> > > > +         This excludes the deprecated ARM ABI since that forces a 4 byte
> > > > +         alignment on all structs - incompatible with virtio spec requirements.
> > > > +
> > >
> > > This should not be a user-visible option, so just make this 'def_bool
> > > !ARM || AEABI'
> > >
> >
> > I like keeping some kind of hint around for when one tries to understand
> > why is a specific symbol visible.
> 
> I meant you should remove the "VHOST dependencies" prompt, not the
> help text, which is certainly useful here. You can also use the three lines
> 
>      bool
>      depends on !ARM || AEABI
>      default y
> 
> in front of the help text, but those are equivalent to the one-line version
> I suggested.
> 
>      Arnd

Oh right. Good point. Thanks!

-- 
MST

