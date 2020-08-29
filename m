Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D1C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDF20757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598722222;
	bh=dGx5NTRYdvcgFWUnpTmfWkyTqmN3E0P8dtfTmx4wvWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tSK3h81YwkS0ZSAYAbIASdQTUgTxWXYAdQyhXQvzMbM4jUw1RrSdlHjQgppz4L0qU
	 08yZ2kHhSirI4zsXzpNncmuhnWpFX3D51ff5YohmtO8LJSD8rZrP+5AQdL9bgdTBq2
	 MQKs7tiboOIIBKzSC5wEIxVxOGXjPowz3Ekb2Hns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgH2RaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgH2RaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:30:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A1C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:30:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so2296876ljj.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tcoa+YjQiCXzGdpiXTdeu40vvjnErZlPnbw45C2h1Hg=;
        b=YhUjtZ6UWDO6ICBxyUejNtYoojZ1/MzasHc6HRhV1QQG0ZTdq1nBIaLOW2DmRHE1RK
         8sokc72j0PovTAfxw6ZBkZRQnzWFlOSdsut22Y5F3m8DXx3aZaYvcaysiimrlXYjmvVQ
         fx718s8yIazse/haX/97e3zZOvICf6iGBWCFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tcoa+YjQiCXzGdpiXTdeu40vvjnErZlPnbw45C2h1Hg=;
        b=nV6Jdhe2N0N7Z2a8QtqmcGT6pAS5EcLlGt7nmAO6jBvB2wfrh+Yu1fQhjexVVEQ3rX
         Sb2uC2njqBI8WzPdoI3UbvwhTRtABrmNJqpy9YZpH4XKGrkr3QTqbbBPwdScNJUWcRYn
         Faka/rin2qN7p8YCis89yiiN/ZJBW2B+AAE41z3BmfkHOIkXc5DAACbMNS4TuUzn2g0E
         UrRl77xHpBhWVj5ZgBs1a0vBwAk2XHbcUsX85P7IlhzF5jWXlY5rvWOtub9csPpHKC3q
         cGRHlH18Hr98aGi6v6fzhgky45xwWkYmJlrJ57HZji8csMcslGg8yUUoMkXt9swiBSPE
         U0pQ==
X-Gm-Message-State: AOAM531JzI3WkMhFQQsCs4L3gcQMC/tynODv7iFtpviOSQmdWi1yctJq
        MWvCTyPiYpfKJc2jj5XgHj+eGrObh/DkLg==
X-Google-Smtp-Source: ABdhPJyVybST233gDo9rXkxO9dv1Z7lyU/McUpacGaU+90Fc7a7g3UHSIGaAx4CBxLLo8j2ND/Kbxg==
X-Received: by 2002:a2e:2c17:: with SMTP id s23mr2000405ljs.265.1598722215878;
        Sat, 29 Aug 2020 10:30:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x14sm584874ljd.1.2020.08.29.10.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 10:30:12 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c15so1356510lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:30:12 -0700 (PDT)
X-Received: by 2002:ac2:58db:: with SMTP id u27mr2019987lfo.142.1598722211766;
 Sat, 29 Aug 2020 10:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200829105116.GA246533@roeck-us.net> <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Aug 2020 10:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
Message-ID: <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008765a305ae078552"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008765a305ae078552
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 29, 2020 at 5:46 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> But the pointer is already 32-bit, so simply cast the pointer to u32.

Yeah, that code was completely pointless. If the pointer had actually
been 64-bit, the old code would have warned too.

The odd thing is that the fsl_iowrite64() functions make sense. It's
only the fsl_ioread64() functions that seem to be written by somebody
who is really confused.

That said, this patch only humors the confusion. The cast to 'u32' is
completely pointless. In fact, it seems to be actively wrong, because
it means that the later "fsl_addr + 1" is done entirely incorrectly -
it now literally adds "1" to an integer value, while the iowrite()
functions will add one to a "u32 __iomem *" pointer (so will do
pointer arithmetic, and add 4).

So this code has never ever worked correctly to begin with, but the
patches to fix the warning miss the point. The problem isn't the
warning, the problem is that the code is broken and completely wrong
to begin with.

And the "lower_32_bits()" thing has always been pure and utter
confusion and complete garbage.

I *think* the right patch is the one attached, but since this code is
clearly utterly broken, I'd want somebody to test it.

It has probably never ever worked on 32-bit powerpc, or did so purely
by mistake (perhaps because nobody really cares - the only 64-bit use
is this:

    static dma_addr_t get_cdar(struct fsldma_chan *chan)
    {
        return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
    }

and there are two users of that: one which ignores the return value,
and one that looks like it might end up half-way working even if the
value read was garbage (it's used only to compare against a "current
descriptor" value).

Anyway, the fix is definitely not to just shut up the warning. The
warning is only a sign of utter confusion in that driver.

Can somebody with the hardware test this on 32-bit ppc?

And if not (judging by just how broken those functions are, maybe it
never did work), can somebody with a ppc32 setup at least compile-test
this patch and look at whether it makes sense, in ways the old code
did not.

                Linus

--0000000000008765a305ae078552
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kefxvfs30>
X-Attachment-Id: f_kefxvfs30

IGRyaXZlcnMvZG1hL2ZzbGRtYS5oIHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1h
L2ZzbGRtYS5oIGIvZHJpdmVycy9kbWEvZnNsZG1hLmgKaW5kZXggNTZmMThhZTk5MjMzLi5jNTc0
ZDIyM2Q1MmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hL2ZzbGRtYS5oCisrKyBiL2RyaXZlcnMv
ZG1hL2ZzbGRtYS5oCkBAIC0yMDUsMTAgKzIwNSwxMCBAQCBzdHJ1Y3QgZnNsZG1hX2NoYW4gewog
I2Vsc2UKIHN0YXRpYyB1NjQgZnNsX2lvcmVhZDY0KGNvbnN0IHU2NCBfX2lvbWVtICphZGRyKQog
ewotCXUzMiBmc2xfYWRkciA9IGxvd2VyXzMyX2JpdHMoYWRkcik7Ci0JdTY0IGZzbF9hZGRyX2hp
ID0gKHU2NClpbl9sZTMyKCh1MzIgKikoZnNsX2FkZHIgKyAxKSkgPDwgMzI7CisJdTMyIHZhbF9s
byA9IGluX2xlMzIoKHUzMiBfX2lvbWVtICopYWRkcik7CisJdTMyIHZhbF9oaSA9IGluX2xlMzIo
KHUzMiBfX2lvbWVtICopYWRkciArIDEpOwogCi0JcmV0dXJuIGZzbF9hZGRyX2hpIHwgaW5fbGUz
MigodTMyICopZnNsX2FkZHIpOworCXJldHVybiAoKHU2NCl2YWxfaGkgPDwgMzIpICsgdmFsX2xv
OwogfQogCiBzdGF0aWMgdm9pZCBmc2xfaW93cml0ZTY0KHU2NCB2YWwsIHU2NCBfX2lvbWVtICph
ZGRyKQpAQCAtMjE5LDEwICsyMTksMTAgQEAgc3RhdGljIHZvaWQgZnNsX2lvd3JpdGU2NCh1NjQg
dmFsLCB1NjQgX19pb21lbSAqYWRkcikKIAogc3RhdGljIHU2NCBmc2xfaW9yZWFkNjRiZShjb25z
dCB1NjQgX19pb21lbSAqYWRkcikKIHsKLQl1MzIgZnNsX2FkZHIgPSBsb3dlcl8zMl9iaXRzKGFk
ZHIpOwotCXU2NCBmc2xfYWRkcl9oaSA9ICh1NjQpaW5fYmUzMigodTMyICopZnNsX2FkZHIpIDw8
IDMyOworCXUzMiB2YWxfaGkgPSBpbl9iZTMyKCh1MzIgX19pb21lbSAqKWFkZHIpOworCXUzMiB2
YWxfbG8gPSBpbl9iZTMyKCh1MzIgX19pb21lbSAqKWFkZHIrMSk7CiAKLQlyZXR1cm4gZnNsX2Fk
ZHJfaGkgfCBpbl9iZTMyKCh1MzIgKikoZnNsX2FkZHIgKyAxKSk7CisJcmV0dXJuICgodTY0KXZh
bF9oaSA8PCAzMikgKyB2YWxfbG87CiB9CiAKIHN0YXRpYyB2b2lkIGZzbF9pb3dyaXRlNjRiZSh1
NjQgdmFsLCB1NjQgX19pb21lbSAqYWRkcikK
--0000000000008765a305ae078552--
