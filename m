Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6742C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 17:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3E2404E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592675513;
	bh=82NjauDJlTIVsz/7NSlMR0NOPfEGE23VmIXJnYf+sz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HcmoP7wFGIGuESwyeCt/GLYc9HOSg8QP/EmWBzPHRnko9S2ZDBhyhBZFLLL61TkQw
	 wJnE73vgZ1XdOoxoXWFDnQj3Y21GWwKeM05kT55q2n5qWPpo7v3mJdRuMF/nXzLbQB
	 qslvq3P86gyPDR8WQKPPOhPQA6J5W2xQMoxFPPZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFTRvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 13:51:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38371 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFTRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:51:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so14963931ljv.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rw44qjrMFmBDRvnMPg4gkmrn1yIH4AjuHTLNJbCwI1k=;
        b=GdLj8pr5S7cigC4cW+Xmxd38FrVQGbVitJGT9j7Q5GXeusFmgKX8LlgD6DzMflaUnu
         qQs/SLBfxFvz+tDtG/rljCMnv8zcDSp66pAREwA6hSY6HnWUarFujX3/l7KxQzHbR5zr
         LP0+ZM1GtqvmvOCGfqguHi3FbKw9iUoe5Q4Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rw44qjrMFmBDRvnMPg4gkmrn1yIH4AjuHTLNJbCwI1k=;
        b=JrQwOWQMav3DfwEh//vSjIddmmMQMFScQPMTfh9poBF0+l9njMfGID727rml7GV+eI
         gkVuyr14LffQKs/Drp6tOt9SZmXkzEOUm0KqvxidlFAJPVYqC9YMfev+uhuxRJpyY0ZE
         874Uj4ncHSYQ/5dWpsfSKFhLl/I7wCOdXgsJ/nde41D7uS4G0hrfZa7nJ9WCxHh9qSzt
         hCcNhcgsKp4kPmCHDdvCGeu6+HfHO9AVjNDdUBX3dzF7oZHYSpODvZMc/2bisdHpyhJU
         YzSIY7VlbPSjoyyLRE19lkNiOT/HnClBPZCaHJyx3BHW7/NyvUIA+hVRc3Fc6qZUf+KV
         LWEA==
X-Gm-Message-State: AOAM532QxsBQRQMOC5PXz7iKyS4u3zZi6V/s/yTZlwfOhnNlmOy/oGWf
        IEo4KM0nkExwNXr1C2uOxJshLlz5Gx8=
X-Google-Smtp-Source: ABdhPJxWKlVfa6fELgS4YqkZl/goxkz2Ta55nGUFTCorA8HyFhImdnumltOFkEbguOmskZchUtY44A==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr4314499ljh.318.1592675448775;
        Sat, 20 Jun 2020 10:50:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q1sm1793774lji.71.2020.06.20.10.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 10:50:47 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q19so15011173lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 10:50:47 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr4489285ljj.102.1592675446808;
 Sat, 20 Jun 2020 10:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390>
 <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
 <20200619074233.GA3723@lst.de> <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
 <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
In-Reply-To: <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 10:50:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=who=jSnB3RmZTUOn7aShx6rqHeS8E7tDv6f+kVUQUVBAw@mail.gmail.com>
Message-ID: <CAHk-=who=jSnB3RmZTUOn7aShx6rqHeS8E7tDv6f+kVUQUVBAw@mail.gmail.com>
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 9:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm staring at that opatch and not seeing how it could _possibly_ make
> any difference in code generation.
>
> Which is the obvious next step: would you mind compiling that file
> with and without the patch and sending me the two object files?

Hmm. I did that here (well, I did the probe_roms.s files) and with gcc
I didn't see any difference in the generated code what-so-ever. The
assembler comments changed (because the line numbers changed), but the
code didn't.

With clang, the only difference is a slight code generation change in
the end condition of the top for-loop in 'probe_roms()'.

But that clang difference literally seems to be about instruction
scheduling, not about any semantic change, although I find the code
hard to read because clang has rotated the loop so it looks entirely
different.

Anyway, even after going through a compiler, the difference that
Christoph's patch could possibly make is not obvious.

So yeah, I'd like to see what the code generation difference is for
you, since it seems to matter to your install for some odd reason.

                      Linus
