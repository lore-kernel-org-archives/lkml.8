Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590527885;
	bh=MFAehDAU7MZpexynosp2Nf/gW4GxzaTvFvckT1FHhHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQyBXTg4jZWLMA+n49aiGhUpIVR5f7dct/cxTFgM2LpYt3TlTQqpn/8UXDoMwQiD4
	 dslO+qFf4yzNxD6yuv8jCC00l6WsMARwl8bqH45OqVe5otdwbsvEHNLci/Z5qzB6ny
	 b4fRQRmm2SVMOTSXl3VOndLi6nr/TB/LQ2dZEF+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390981AbgEZVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:18:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34773 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390009AbgEZVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:18:03 -0400
Received: by mail-io1-f65.google.com with SMTP id f3so23717703ioj.1;
        Tue, 26 May 2020 14:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVVBuWO3qFEQRVDuoZfe9DGQFjStmCr4atb2ZbHcO8E=;
        b=AeIMKfN+5/n35HclKzNcOmYZEHwr4aO5D22NgPTX0dZZd3IZA0o3V4+sWavKqjj4n+
         v3NSl4Q84NKqB08tflrt19o816L5AD26NDl+tjY3+N6dAZbA9LVDk0KAjHgWfiedF11e
         ig0FZTMLuDQb3VRw7mU18Lyip2Jyq4Exct58ZW5aEW+HsKq2GfuiIXg+JzmaRV0kZAJh
         MD5zlWqs+SEx4jEBMftjR61OD238wRcAkvrKAx2Uk1QgmkXjB5CgAoShKksVfdMLzkfl
         k31uLOlKxklTS804TuUCRhPy0TuhnalUSyWkarIjG869Bn9IjOe9JM/ka1Rsv9qpqVfD
         494g==
X-Gm-Message-State: AOAM532CMPu0zXjNXOKQe3C3Wzy7TC0CdFk1Y+1Vim29E74DnRcs9UaC
        DvghuHL8BfBi9WVfFNHPZA==
X-Google-Smtp-Source: ABdhPJwQrpel77itHrejAW3V1OCVBywOqev2wghw6aLmvMslUJY88azNYlGgJ1qYFsSmB5E2n/qkqA==
X-Received: by 2002:a6b:7017:: with SMTP id l23mr4256428ioc.140.1590527882382;
        Tue, 26 May 2020 14:18:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x22sm567394ill.9.2020.05.26.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:18:01 -0700 (PDT)
Received: (nullmailer pid 389955 invoked by uid 1000);
        Tue, 26 May 2020 21:18:00 -0000
Date:   Tue, 26 May 2020 15:18:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     chenzhou <chenzhou10@huawei.com>, James Morse <james.morse@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        John.p.donnelly@oracle.com, pkushwaha@marvell.com,
        Simon Horman <horms@verge.net.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document
 linux,low-memory-range for arm64 kdump
Message-ID: <20200526211800.GA352001@bogus>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
 <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
 <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:24:11AM +0800, chenzhou wrote:
> Hi Rob,

+James M (It's nice to Cc folks if you mention/quote them)


> On 2020/5/21 21:29, Rob Herring wrote:
> > On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
> >> Add documentation for DT property used by arm64 kdump:
> >> linux,low-memory-range.
> >> "linux,low-memory-range" is an another memory region used for crash
> >> dump kernel devices.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> > chosen is now a schema documented here[1].
> Ok, that is, i don't need to modify the doc in kernel, just create a pull request in github [1]?
> 
> >
> >> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> >> index 45e79172a646..bfe6fb6976e6 100644
> >> --- a/Documentation/devicetree/bindings/chosen.txt
> >> +++ b/Documentation/devicetree/bindings/chosen.txt
> >> @@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
> >>  and the size are expressed in #address-cells and #size-cells,
> >>  respectively, of the root node.
> >>
> >> +linux,low-memory-range
> >> +----------------------
> >> +This property (arm64 only) holds a base address and size, describing a
> >> +limited region below 4G. Similar to "linux,usable-memory-range", it is
> >> +an another memory range which may be considered available for use by the
> >> +kernel.
> > Why can't you just add a range to "linux,usable-memory-range"? It
> > shouldn't be hard to figure out which part is below 4G.
> I did like this in my previous version, such as v5. After discussed with James, i modified it to the current way.
> 
> We think the existing behavior should be unchanged, which helps with keeping compatibility with existing
> user-space and older kdump kernels.
> 
> The comments from James:
> > linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
> Won't this break if your kdump kernel doesn't know what the extra parameters are?
> Or if it expects two ranges, but only gets one? These DT properties should be treated as
> ABI between kernel versions, we can't really change it like this.
> 
> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
> think the simplest thing to do is to add an 'linux,low-memory-range' that we
> memblock_add() after memblock_cap_memory_range() has been called.
> If its missing, or the new kernel doesn't know what its for, everything keeps working.


I don't think there's a compatibility issue here though. The current 
kernel doesn't care if the property is longer than 1 base+size. It only 
checks if the size is less than 1 base+size. And yes, we can rely on 
that implementation detail. It's only an ABI if an existing user 
notices.

Now, if the low memory is listed first, then an older kdump kernel 
would get a different memory range. If that's a problem, then define 
that low memory goes last. 

Rob
