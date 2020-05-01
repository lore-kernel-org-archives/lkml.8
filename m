Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD8C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C620E21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEa5VUFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEAUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgEAUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:32:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B802C061A0C;
        Fri,  1 May 2020 13:32:38 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so5319176qvz.8;
        Fri, 01 May 2020 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GKObwP+oI90NidOkL7spbQgfL9OtnIPhqYuuk+u7vcA=;
        b=NEa5VUFHFN9pSfOFWWOvNixxL8e1jQ6dq5bDeW5Uu5qWDIBHWRXiLfrR2qVz2m/eU4
         EDyGPlrxHBaj6DWXXulrkG6RpeExEsX4y1OOx/P5vCPjvbOF3Mhfqe0etcuZB5o6Wx6c
         QRPx9yHx/rEkBD3PsNGwDFou5dNGBHh/hG9J9UjUjK1vgwGhY1OINPtYG4M60qPq8Mdx
         1qiRjjiHvlUgmj7h+QXQ9JzPevJSQGt1tIStbGBJ2nGZh4PS8Hlukw/OOLQcGdWaCCkk
         w+TC6RQj/Hayd5aMotsqUu+6lAD00Smx0nWito3sf2k9J6I3DoWr0jlL1afg5tzKKVld
         grsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GKObwP+oI90NidOkL7spbQgfL9OtnIPhqYuuk+u7vcA=;
        b=HMwTIHPdxkUleyiTfenfydSa1Qdhb9ZAswqfUOA33q2gsK3S4Ph1YFd7iJI9APOIey
         D2bugGtOXaDu7/2uQQ+S0h//qPmCxWlcyb9gOzFAogfJiDmbpIxTiQjlhloIHOlAwbJo
         /CquK7CLdlwqAfJRZGkeqLhoFCpoGgNeMPzdIPZ0mBee6u1XgBt5Xom4I8FM9vlprj9n
         GNhR+bl4YXFvWZj7ZJnGiW/31olCWgiogH/xjww2X55V0KYcsS7F3PddOMbqb41KSA8B
         x8F5MufsabcAcCmH9YrsMQfz1l/3VuCoRmH03ZHesDB54uKCyuPN0Vrh2OsMiO523yZo
         wF/w==
X-Gm-Message-State: AGi0PuYczHQFEDvavAl+PZBrY3fqBXDItIZcq9AjprGeV+j31xCjuU6Y
        gUB+XbjfvszA9UUn0BnjUkQ=
X-Google-Smtp-Source: APiQypLPEWxnBpaD476aGFUga0bSleBwKVkF25WOkXqrRkJfYU/Y+hXRXAo3vVJWRnguW8g1KJ9aMw==
X-Received: by 2002:a0c:d652:: with SMTP id e18mr5608057qvj.58.1588365157323;
        Fri, 01 May 2020 13:32:37 -0700 (PDT)
Received: from josh-ZenBook ([70.32.0.110])
        by smtp.gmail.com with ESMTPSA id z90sm3455696qtd.75.2020.05.01.13.32.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 13:32:36 -0700 (PDT)
Date:   Fri, 1 May 2020 16:32:34 -0400
From:   Joshua Abraham <j.abraham1776@gmail.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, corbet@lwn.net, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kvm: Fix KVM_KVMCLOCK_CTRL API doc
Message-ID: <20200501203234.GA20693@josh-ZenBook>
References: <20200501193404.GA19745@josh-ZenBook>
 <20200501201836.GB4760@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501201836.GB4760@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:18:36PM -0700, Sean Christopherson wrote:
> No, the current documentation is correct.  It's probably not as clear as
> it could be, but it's accurate as written.  More below.
> 
> The ioctl() signals to the host kernel that host userspace has paused the
> vCPU.
> 
> >  The host will set a flag in the pvclock structure that is checked
> 
> The host kernel, i.e. KVM, then takes that information and forwards it to
> the guest kernel via the aforementioned pvclock flag.
> 
> The proposed change would imply the ioctl() is somehow getting routed
> directly to the guest, which is wrong.

The rationale is that the guest is what consumes the pvclock flag, the
host kernel does nothing interesting (from the API caller perspective) 
besides setting up the kvmclock update. The ioctl calls kvm_set_guest_paused() 
which even has a comment saying "[it] indicates to the guest kernel that it has 
been stopped by the hypervisor." I think that the docs first sentence should 
clearly reflect that the API tells the guest that it has been paused. 

-Josh
