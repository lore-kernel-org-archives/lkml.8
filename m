Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5002C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907E420663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCHMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 08:25:34 -0400
Received: from sg2plout10-02.prod.sin2.secureserver.net ([182.50.145.5]:60616
        "EHLO sg2plout10-02.prod.sin2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgCHMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 08:25:33 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2020 08:25:33 EDT
Received: from mail-oi1-f172.google.com ([209.85.167.172])
        by :SMTPAUTH: with ESMTPSA
        id AushjL9TYO6ZBAuskjSSOO; Sun, 08 Mar 2020 05:18:11 -0700
X-CMAE-Analysis: v=2.3 cv=BaWmLYl2 c=1 sm=1 tr=0
 a=Y+b99WSDUBXwRGtcog24Ag==:117 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=1_j9CwCaYTysT8vyirYA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: kaiwan@kaiwantech.com
Received: by mail-oi1-f172.google.com with SMTP id l12so7374731oil.9;
        Sun, 08 Mar 2020 05:18:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0qMGNtbgT0CLSw7vFCRkXqWhn8Tv1o7mrYdIm0JByBZM66CeVW
        aBi5pUB+1C3DzKJxidAisBPB2IvvO2FEX6njS90=
X-Google-Smtp-Source: ADFU+vtZnWMkbiL1bXf+FNyxSs2l/kh0C8lBmhrcLdSBCJkRlC3KOJuhCbp7XEyp4s5Om4jf+N/09525fkXc4ZKhqvc=
X-Received: by 2002:aca:5044:: with SMTP id e65mr8541289oib.28.1583669887378;
 Sun, 08 Mar 2020 05:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <202003021038.8F0369D907@keescook> <20200305151010.835954-1-nivedita@alum.mit.edu>
 <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
In-Reply-To: <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
From:   Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Date:   Sun, 8 Mar 2020 17:47:50 +0530
X-Gmail-Original-Message-ID: <CAPDLWs-b0NjDx4A=wdd6aJu84Wrc2wk6QZAf6EYGbqWyy-4ZFw@mail.gmail.com>
Message-ID: <CAPDLWs-b0NjDx4A=wdd6aJu84Wrc2wk6QZAf6EYGbqWyy-4ZFw@mail.gmail.com>
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfA50qyIlkVVHqwvhiVy51LCaeXikHE5ZfTHtJvQTeBKBpAxc3GA5+SHnjOiUpG4oZ00GXu12yjgqmiWDaw2sy0G1CK2UJ6H2oPsgrMOQUtKUF4nr+Pcf
 fN+MoFxTSylJOAo3i4JthnH6SMKgdVx3I5bgd4i9ByHqA7m2lT/3ZZp22V4ZBXChA36IplHl/lTN5ge6JRvBTfU8sB8dwBuUr5weO7herzpDdEttfo/bp+3m
 i+drPBLWNmwItSVko4UtZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 8:48 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 3/5/20 4:10 PM, Arvind Sankar wrote:
> > For security, don't display the kernel's virtual memory layout.
> >
> > Kees Cook points out:
> > "These have been entirely removed on other architectures, so let's
> > just do the same for ia32 and remove it unconditionally."
> >
> > 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> > 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> > 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> > fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> > adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> Aww, why wasn't this made configurable? I found these memory map printouts
> very useful for development.

Same here! IMO, the kernel segment layout is useful for devs/debug purposes.
Perhaps:
a) all these printk's could be gathered into one function and invoked
only when DEBUG (or equivalent) is defined?
b) else, the s/pr_info/pr_devel approach with %pK should be good?
-Kaiwan.
