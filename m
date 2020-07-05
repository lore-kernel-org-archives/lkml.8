Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485A920782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSrJ6ieT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGECok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 22:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGECok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:44:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D652C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2aRzJJZ6llsJJNnz5pBbngiYwHyozuVHCDy1h81iPNE=; b=NSrJ6ieT3Z24MjVhs62Z22VWio
        TBtG5TGQgNnPYEkKJMDGQgQtPutcc6vjlWoDmJsqQ5e2Bpn4bPyJFkvP2O048xJ/opl55tp3kQBmN
        UgmA0t/6qdV7m5JvFbB4h0DpdnG3ucxAGT8rgpqTvblCTalK/HX+coDcPfbQA6AINRdwtotTHUE8j
        JyvQ8kyUwN0FjjdhwnQHvswwX0q/a64WuQPOHjJ/76zvsUEUkF9vB+fK6kXo8/ekhxqcm7auwoRol
        kEyRBtO8DJNz4v6YJnnS5RzxDtWRoBROh5R+vjX1DFZ8/kYe1EmNoj50rNeIk8db04OnUg+tcISKc
        HRj0oPuw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrudx-0004eY-0Z; Sun, 05 Jul 2020 02:44:37 +0000
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy6545@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
 <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
 <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
 <202007041804.B5E229E2B6@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a7dd50b-b4b3-d9fa-dbb0-8c30d522b945@infradead.org>
Date:   Sat, 4 Jul 2020 19:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202007041804.B5E229E2B6@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 6:10 PM, Kees Cook wrote:
> On Sat, Jul 04, 2020 at 08:10:33PM -0400, Matthew Wilcox wrote:
>> Left-right tree makes no sense. It doesn't distinguish the rbtree from its
>> predecessor the avl tree.  I don't think it's helpful to rename a standard
>> piece of computing terminology unless it's actually hurting us to have it.
>> Obviously if it were called a "master-slave" tree, I would be in favour of
>> renaming it.
> 
> (No one has suggested renaming red/black trees, so I think the
> slippery-slope argument can be set aside here.)

Did you read this message?

https://lore.kernel.org/ksummit-discuss/CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com/

> As for the actual proposal on white/black-list, I've always been annoyed
> by the poor description it provides (and I get to see it A LOT being
> the seccomp maintainer). I welcome allow/deny-list (though the change is
> not new for seccomp -- the man pages were updated last year (thanks
> mkerrisk). :)
> 


-- 
~Randy

