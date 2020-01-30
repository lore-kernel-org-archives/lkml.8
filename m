Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89651C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F8720674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZ6hrhFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA3WJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:09:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35136 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA3WJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:09:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so2211066pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUexxNUx2dGjQIPMcFbU0fVcZMDC50Hvbcrbeq+H2V0=;
        b=TZ6hrhFuqgBA4J1CeCNDRVu7W6cC06JV/7oLVVdX5AikBVmwiWHR8bfUZWuKOljo99
         x30t0zV7uxM0dzEeSbBCqbgHacMW+OHT3zzhLCkrHtIZALyuI//pE+6bkJvt8b9rUzwS
         NXacaeOJGQFQ387XD3h0B8ntMsYNMi9Ee1ZTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUexxNUx2dGjQIPMcFbU0fVcZMDC50Hvbcrbeq+H2V0=;
        b=jk0jusqfNT9iM0BD46t8PgtfYbFI2uzOlGNinhbGSqg8zhekLjXpSxRdme+Y7QDSjT
         /hB8L378qF8ShRbZOFgmmwOF32sWMwkZfrWoCdXTaUGTxglLn32miKPdxAZUj194X7hW
         3/0eOGLraoH5GOkKULxienGA3GvAsVDKQGVCxdfX4XGmqMEdi9crwQqNCO3ALLR5d7fr
         fLaItZPDOUjd/8CnTLoqR1iY0dC88CotxvYKYFThONc8UiK1MxUZiEMVlRW8l3qZQG70
         ZLOLYtaa/vKme6brrKxgRar+FaiBgiB0yLLsNEsZXu6hxjrfszPux84EcVXRNd1+1Xdc
         guhw==
X-Gm-Message-State: APjAAAX4MRpyQsfrrhnj18YglV7xF8JVfJ6LLzKR6D2WderX8ixFnzbI
        0nWOHKJwKnuE+ZEUEUtK6iYUrg==
X-Google-Smtp-Source: APXvYqykPZTCjcvVR9SGe1agZZrOZfRDah7+fVB0EvIAQLg3I5L4pet/YQS99dtHp1ZsnUufEj+7hQ==
X-Received: by 2002:a63:f142:: with SMTP id o2mr6696978pgk.181.1580422146031;
        Thu, 30 Jan 2020 14:09:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm7678551pgt.22.2020.01.30.14.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:09:05 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:09:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] Discard .note.gnu.property sections in generic NOTES
Message-ID: <202001301407.0C25389FC2@keescook>
References: <20200124181819.4840-1-hjl.tools@gmail.com>
 <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook>
 <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
 <202001301143.288B55DCC1@keescook>
 <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
 <202001301206.13AF0512@keescook>
 <CAMe9rOoU1B8enyoL4-SSQKYLHpevR5yrbp5ewztC=Owr69y2SQ@mail.gmail.com>
 <CAMe9rOpkrPOsymJiBv0i3_Q6hp=fyUYLqBKpOZAHx3d5t54GDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOpkrPOsymJiBv0i3_Q6hp=fyUYLqBKpOZAHx3d5t54GDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:48:38PM -0800, H.J. Lu wrote:
> Here is a patch to discard .note.gnu.property sections in generic NOTES.

Thanks! This looks good, though please send not as an attachment. :)

Also, one more nit: the comment style should be:

/*
 * First line of text, blah blah ...
 * ... blah blah, end of text.
 */


-- 
Kees Cook
