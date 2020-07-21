Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A83C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3ADE2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOZplhzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgGUVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgGUVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:18:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB09C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so10787462ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oZ+JoLZ43wxde/v2pWNQdBZEy1k9AMtxsdeltF18Z30=;
        b=fOZplhzkfQjlmMs+fOOuHWAQH5KetgWFj/VhzU6eSu8vpND0m0V1TjB7faHy1uVoIa
         sZC4ttKuAEfqwYAq8Iu35cFDDvzYO2gjOwmE/6e8Ntj3StOFb5lCeFP9XVDQn4B8x528
         /Pwo508mh8yuA8uMG1/YVxp+HL2r0nOycSxXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZ+JoLZ43wxde/v2pWNQdBZEy1k9AMtxsdeltF18Z30=;
        b=om5HotdUqXjzXvy26ENCMk4KMIzwsMBroRTwwb1RcO4JPxAGcNI2boUifcT6DO7LN9
         U+/5ocOzo5wZvdegWMbTx151Tkzg67k9Jz5BmJVtnHBJ7Y5ABaHforya/w+yAO/0F3Dt
         nJ+YIhtl8oGr+I4x4gbEqrX5v6nyOrCCKLwwjsuIBdx2biVWOMvhJOXKkdOq1O4E12oT
         +N1hLc9td0WYkUVRFUtOCJY/yZ2MJU030Z6+zbdi5+amjqvve93L/b3mNKX5l1nfahxy
         rgK1XlQIPWlo+6i9RtIZGb6EvwkBUzgLWPFrg3qrBHs3zH+DL42U4SFRVRUdNhvVMi0g
         v/Xg==
X-Gm-Message-State: AOAM532BkmOb43pwEPadaZLhqFO5DyoKdPPjTgTv5Y7eqHem/CfBalVy
        bJ8biDD74tL23ElBgD+XgAeZGQ==
X-Google-Smtp-Source: ABdhPJz5PFwUqQLM2s2i11W2OpAjR8V3PUupz65U68wR4YNmFEEFoBSMVi6o9VV+D61gFDTdZgWxIQ==
X-Received: by 2002:a17:90a:70cd:: with SMTP id a13mr6768113pjm.89.1595366331967;
        Tue, 21 Jul 2020 14:18:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c71sm4448104pje.32.2020.07.21.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:18:51 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:18:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned
 sections
Message-ID: <202007211416.1A2B618DE@keescook>
References: <202007211143.AC36D096@keescook>
 <87r1t43a8e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1t43a8e.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:05:05PM +0200, Thomas Gleixner wrote:
> Kees,
> 
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
> >> From: Joerg Roedel <jroedel@suse.de>
> >> 
> >> Align the end of the .bss..page_aligned and .data..page_aligned section
> >> on page-size too. Otherwise the linker might place other objects on the
> >> page of the last ..page_aligned object. This is inconsistent with other
> >> objects in those sections, which all have their own page.
> >
> > What problem was actually encountered? (i.e. why is it a problem for the
> > other data to be in the page of the page-aligned data? shouldn't those
> > data have their own, separate, alignment hint?)
> 
> See: lore.kernel.org/r/87sgdmm8u4.fsf@nanos.tec.linutronix.de

Ah-ha: "But with explicit sections which store only page aligned objects
there is an implicit guarantee that the object is alone in the page
in which it is placed. That works for all objects except the last
one. That's inconsistent."

Understood now. The bit in this commit log for "which all have their own
page" wasn't clear to me about _why_ (it was coming from .page_aligned,
which means both aligned and dedicated).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
