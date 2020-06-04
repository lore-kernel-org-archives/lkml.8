Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8485C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6279206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/rmIX2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgFDRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgFDRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:52:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D1C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:52:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so1438285pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaoQRHYuWirhQ83i+fNS4H0fknYzhKxkt6zmjLs44oE=;
        b=f/rmIX2O3O5HUglhNmxahPTem94vBTlvk4JUufgpO8mRRmbfmsBjg7rXOFIOEO6rWQ
         KxU9fxxevzlcHXjIa8mI4MgnlO0FL4xvf221+M50jTnJM1QQakRRJnecjre/hoYE/HPK
         EVRwAAjjxuADf/alqt7VNYz/mQBCKwyUT3aUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qaoQRHYuWirhQ83i+fNS4H0fknYzhKxkt6zmjLs44oE=;
        b=MDKiwZWY7t/XSho1HMbXx+cgdPEY79uwOrkw6h2AKZavVOJZwjAVrDaeWNfTBHt9+y
         0nKKVBHxwRdyGz+pPxp69YHsK2JXZ2hX/0n9j6c9psEpfG/qXWccM3ruVdZbor1CiQMR
         F35nhJbJ9sZb/RyGxfhu6AgYVH/idWWK2RrxaxNeZmzBUlHbs4KYWNAUZFFmgDyrtAxa
         tGmUi84O8UWnfmRupLtscCr6Qvsp3yIGg6YHfxW3ZF5kUiBRusOwwhidOBsqsaJpTUOv
         gsyhc76EFB4Na/mfFJqmoLcvTUWuKOlP1I9M+fqt3BB+MPUx7WB/baiTqoAzE2oNmpAV
         uG0Q==
X-Gm-Message-State: AOAM533Q+B5BeCmDDSIMhhj4dXpabLyv8JgJ7AHtbLGdKQ7BfASxa0B6
        8oX9+7If+y5IKE7c/cwkFaO20Q==
X-Google-Smtp-Source: ABdhPJwjiDVuThcbOn0ps6jBSIPeXaBHyg0/HA9sRD14Mpe25WmBiFWt30f7PCSO0Ll+qqpnju384Q==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr5762706plr.160.1591293120849;
        Thu, 04 Jun 2020 10:52:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm4986467pfn.123.2020.06.04.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:52:00 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:51:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
Message-ID: <202006041051.B542F1D@keescook>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
> On 2020-06-04 19:18, Vlastimil Babka wrote:
> > On 6/4/20 7:14 PM, Vegard Nossum wrote:
> > > 
> > > Hi all,
> > > 
> > > I ran into a boot problem with latest linus/master
> > > (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:
> > 
> > Hi, what's the .config you use?
> 
> Pretty much x86_64 defconfig minus a few options (PCI, USB, ...)

What are you boot parameters? This must be another corner case...
(I'll try reproducing with your .config)

-- 
Kees Cook
