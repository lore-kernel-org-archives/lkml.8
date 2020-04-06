Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EECC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A94522263
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIVgOdOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDFNCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:02:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24568 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728138AbgDFNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586178129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPjD/qOa5eohxkp3ciJYq8E962y8rH1Z+TEQ1dfdaNU=;
        b=LIVgOdOL/H71WNHI6o90ZKZ+LyhODZU3q3afogGyvFjRXlAPPvL3ipCXzVo2FfjBG6GkAQ
        g9216cAy+xzFi+rIOBohXTlybg5OX3Nl73WkqmalatmzM9WhNoggwaClz7i7YOmnb9Upwh
        4aEol6VgOQiLIpykmU8hxnvHAzs5nl8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-iTxUDT34MsOH4jM5WxR21A-1; Mon, 06 Apr 2020 09:02:07 -0400
X-MC-Unique: iTxUDT34MsOH4jM5WxR21A-1
Received: by mail-wm1-f70.google.com with SMTP id z24so4079742wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPjD/qOa5eohxkp3ciJYq8E962y8rH1Z+TEQ1dfdaNU=;
        b=dVtlIRjxiGmt68EjeBBjSNp36/D2KZTkUQ0iBWtJvksvw2gf9AgnDMATS+i5fj9+Po
         w4FM5dH4d62MNCu8Q5R5zhkxwf0Uip0xHUVU7FpRnMiwhKrbaAXyImnmQdwOaSLzct/c
         uR+luBdEl4F/5upgkPtmQGXhIRhXmzW0Ta/b1elQUaRM/Ht0/fcZzwGfhv3eTCFBq6cL
         ZHpmysp9m4RdZEQNcHijlPOMFkxi5qOhVcAB+LYi227VEp6OdiSaHrRk4G6CVgg7CpYe
         PsoSqdkCRtbuFmGTNEZLN2Zt7Q5Yv5fP7osYn++MRKtcThXl0o/vQDqhugYhXUtGNw5H
         jQwg==
X-Gm-Message-State: AGi0PuY/RylneGyGkMear6q3XKK2nx6VYx4hTcCIVAaOBdeycQgBi4RE
        xq7k5uwqEZOFjs5mk0HEctx7CHv5JgHoIF/8LNbNp7k1uxZODcfMoGk9ygLdhaAxAlPy0m7dWvc
        qMVH8Kmn/g58N3VjNW+NJQ8x3
X-Received: by 2002:adf:a350:: with SMTP id d16mr23217854wrb.277.1586178126528;
        Mon, 06 Apr 2020 06:02:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzhJTMgG+3y4mdFbTRg4CPv7sYAgX9HM+UKNa2TYFJhIuv1nrWp08PsZCLMr3COjkc520wRg==
X-Received: by 2002:adf:a350:: with SMTP id d16mr23217808wrb.277.1586178126236;
        Mon, 06 Apr 2020 06:02:06 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n1sm13731659wrw.52.2020.04.06.06.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:02:05 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:02:02 -0400
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
Message-ID: <20200406085707-mutt-send-email-mst@kernel.org>
References: <20200406121233.109889-1-mst@redhat.com>
 <20200406121233.109889-3-mst@redhat.com>
 <CAK8P3a1nce31itwMKbmXoNZh-Y68m3GX_WwzNiaBuk280VFh-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1nce31itwMKbmXoNZh-Y68m3GX_WwzNiaBuk280VFh-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:50:32PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 6, 2020 at 2:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> >
> > +config VHOST_DPN
> > +       bool "VHOST dependencies"
> > +       depends on !ARM || AEABI
> > +       default y
> > +       help
> > +         Anything selecting VHOST or VHOST_RING must depend on VHOST_DPN.
> > +         This excludes the deprecated ARM ABI since that forces a 4 byte
> > +         alignment on all structs - incompatible with virtio spec requirements.
> > +
> 
> This should not be a user-visible option, so just make this 'def_bool
> !ARM || AEABI'
> 
>       Arnd

I like keeping some kind of hint around for when one tries to understand
why is a specific symbol visible.

-- 
MST

