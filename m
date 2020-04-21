Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A53C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2599F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587497765;
	bh=e5vzBRiKD7qRmjfy3fJ2DQ3XrNVykKQVbGFCxw3kEXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RaebEDkKqqN47LCBOz05avb00YZgl4G0Ma8Or3JJZ6BrNBClaNG3iCyzSMszAVUCA
	 2crhO4Kmls3blpxkD3sLlsdF7YnCxUVRJnTPYY0ZgO7yetgCJUyKwRRgDx6EeECI3a
	 AUI9oiD/GsPNsvmseOQx++J/0rqTGCKQdXuEqQ0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDUTgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:36:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD1C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:36:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z26so15231224ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soISMDc5vWhNYzK+GwCUX1p3xFLbvdhV8HpKz6VNPro=;
        b=cWm26Mw32WNe1HlZTZP1780+TbW6oTXKHG8/Jk3ZsVNovz7AVAIUeJ7MlbzoLXHWC1
         YavoHy/0AyrgjNdVf1YNA0w0DId/VE3w8ic/s/3ZmNo/liIm2sWDUAEsH4g197A8jpoQ
         QPWMFJ1Qd+bipFsUJFsbEyTMK2eZKmQWkX6u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soISMDc5vWhNYzK+GwCUX1p3xFLbvdhV8HpKz6VNPro=;
        b=Beb1MGfCJeyyqZ40jNAFSMlJu6My2aioXvv302KXCN2/dVSWQ/uJgwSlHYKla9rZlG
         LNzRBQ524i/Iz/q+l2k+oyv6NZSjdXQRI4KusFFrMgTKhWnPc/eHMUyIipy6Y4M4hfTm
         5Dm8FUNynrEsr/XbG9VvhUCRWfgBZS1B7XHWMZCNl/+Jei0TG5EOA9S8NO3cf9oYM9Km
         1UDR+94uaBbRWx7/WfdU8GylJ1yQvVSm1yjENMuWD9hRXi/snugFQyArQ1Tul1Eg/v6I
         AGT8aPc9eBTj+69JMRSVp9ZHXDACbtmuBuaNZvQIQ3XxOSUBrSSrOy3KIoVAG7T5Sikt
         sjkQ==
X-Gm-Message-State: AGi0PuYYWzwUU4ypXvVw1XH4EplrubNb9S6R1SJ6UdIhRRSCvlCl9gIo
        u1NqpOLtILjJI60baWYancWtjdmiqhg=
X-Google-Smtp-Source: APiQypKaHZGwRY+EKCUX7UjiLtb9LjBLpxngLBAq51s0qQANLnfAlwVg4gZ+crF09cYF8x7BPXSksw==
X-Received: by 2002:a2e:8549:: with SMTP id u9mr9267663ljj.24.1587497760113;
        Tue, 21 Apr 2020 12:36:00 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p14sm2827713lfe.87.2020.04.21.12.35.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:35:59 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y4so15225991ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:35:58 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr2085741ljp.209.1587497758653;
 Tue, 21 Apr 2020 12:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200421160651.19274-1-pbonzini@redhat.com>
In-Reply-To: <20200421160651.19274-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 12:35:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVo7CzzjEYp+G7+MjNSg4cURR4SeUTvQSYVBFn3o5TPw@mail.gmail.com>
Message-ID: <CAHk-=whVo7CzzjEYp+G7+MjNSg4cURR4SeUTvQSYVBFn3o5TPw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.7-rc3
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 9:07 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
>
> for you to fetch changes up to 00a6a5ef39e7db3648b35c86361058854db84c83:

Did you perhaps forget to force-update that tag?

That tree still shows the tag from April 7 (that I merged in commit
0339eb95403f).

                     Linus
