Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA7DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FB8206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV6CBrEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635502AbgDPMVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:21:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2635421AbgDPMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587039654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N//aUi9ilfSYZbtt9uubNhdLlMHa9VPzC/9aWc7u2N4=;
        b=TV6CBrEOpmWjIdSjNFIyBBxbVxnW1vZwBpM+nEFbziHjfTD1lMafWgBfFgYEMhlzSjVvFP
        43eL+wswiT81sTOO5cNMAWYDWpvy8gHKTWn7Rx39eLEUeTPBr3z7rAaoWYThPYk4OzPtGO
        LrBlUIsyBa20ny3ZniiYZ4eAt6gWVnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-UlnQvrd8OZSrEW39ykNGkA-1; Thu, 16 Apr 2020 08:20:52 -0400
X-MC-Unique: UlnQvrd8OZSrEW39ykNGkA-1
Received: by mail-wm1-f71.google.com with SMTP id f8so1338301wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N//aUi9ilfSYZbtt9uubNhdLlMHa9VPzC/9aWc7u2N4=;
        b=spULp70nsL0p2Vlpb8Iqrd+wFyWC2S8WJgt6KdhTYcJ3AOmzzZk8vfZuq1bbaA1ctx
         c4dXPAYOjKaVLgQ1l3uIiIM6H8aLPz0GA3d2T6H+E2vMRMkJOSyRQksZYE27zR2yNAbA
         hMnKdQs1CjoHEU5gUJ6llmN9o+Ra4G25VWNX3xGxjjD2UcKhGw5Y8v5F5rLKpknNFnMy
         GrwgRjIh/3Jx0HpCsnDPHmT76GwOEPmv8WdEhDWcQHP/aEnDPLpsQl87pWCd6WdSPZv1
         s5C6Iaem6dWyGebDt7tp3hyW3MkzqqgX9zluAtyn866b3/USC3MaDMcmAY/G//brpbbg
         PY/w==
X-Gm-Message-State: AGi0PubV2rGMkgkbQ6FIk7O5I+05mR+550eXQu86b4+NOhcnxsPW1oI7
        X8yjqKrZX2KVk+A4i/HbC5BaJcWipjCRt3ehl1ePv1AbvMjw7BrqacH2ZV70Unv+fTiOLVvijhS
        gohkglMnkMA/Rk2P9mzaqAKyc
X-Received: by 2002:a1c:a344:: with SMTP id m65mr4634834wme.20.1587039648640;
        Thu, 16 Apr 2020 05:20:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7Zr1AmadDiZcqsAC7y2lchYjfJabub1W1Nve6Z9EGEGzkMDXcyVU803uWBITr/U3dkRDooA==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr4634814wme.20.1587039648429;
        Thu, 16 Apr 2020 05:20:48 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id a67sm3645719wmc.30.2020.04.16.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:20:47 -0700 (PDT)
Date:   Thu, 16 Apr 2020 08:20:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, ashutosh.dixit@intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        eli@mellanox.com, eperezma@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, hulkci@huawei.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        matej.genci@nutanix.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20200416081330-mutt-send-email-mst@kernel.org>
References: <20200414123606-mutt-send-email-mst@kernel.org>
 <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:46:33PM -0700, Linus Torvalds wrote:
> On Tue, Apr 14, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio: fixes, cleanups
> 
> Looking at this, about 75% of it looks like it should have come in
> during the merge window, not now.
> 
>               Linus

Well it's all just fallout from

	commit 61b89f23f854f458b8e23719978df58260f051ed
	Author: Michael S. Tsirkin <mst@redhat.com>
	Date:   Mon Apr 6 08:42:55 2020 -0400

	    vhost: force spec specified alignment on types

which I didn't know we need until things landed upstream and
people started testing with weird configs.

That forced changes to a header file and the rest followed.

We could just ignore -mabi=apcs-gnu build being broken for this release -
is that preferable? Pls let me know.

-- 
MST

