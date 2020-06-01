Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54642C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E7D206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0ZCrPcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFAVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgFAVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:52:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:52:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so429089pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onQKbzkilz0X5tVc09T8iL8x6pvNazvbXVadw7hgTwg=;
        b=g0ZCrPcw+8Y4ceJnJeW4DMbSloHDtOqZhyhQ3PpwR9AqJxOPW9dw6muw4SjgImhrS6
         8vSLhQEy8iEccEUxm1vsQAz9hFO3RcSlgfNSKB+O9ZlTYX1yuKZGwCWjYvRKCw2RvBgt
         t7B2hoBLMWPzqi7cUHbgmn9qtkFflXg4WZbJsd4J6s9HQeiKhEtOLc+JhoLekK/15yxU
         LHOU7tSnQvcmHifNcOlWT/katcTSXjBJo6bo4n7ez8GE48AZJNDFY4Cj/5ovsa5eg+UK
         GQbnOATDPqwqu951zF/14BCMDtH0O1XFNRkNAIo2tFGZ2/pIZp7N5Sxwfl0McN//rXmQ
         caaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onQKbzkilz0X5tVc09T8iL8x6pvNazvbXVadw7hgTwg=;
        b=lEMmhGLUCRqTJAAC+eHRox3YKcBxmIoDx8bfdNO3cip1r4S/47nEdnPLKID4lxOc5t
         GnS2VaMaT1OkThmuSl2jBa+07N6Fh3VSdR8gv/MCvxlokMm3gNju81qnVRofIHcAzR70
         B+yFhvUlr3L1T2HqKQvpxQfnHJzI5sH46V2Mt2xDi3e8+LNdArtrEl3waXEGEBidOweJ
         NvKGBQz/CVBPaukP5/Mm/eA54UzVTMW6KjrP3L/xKc1EZRSndygTxX18Jr3jQsImyf1/
         Cy8kuT6xdvJ06pd/kj8kfPUOHN4+BQpwNhcNnAmP6beaHptlRR/XkKWeiDAwS8+K/PPM
         Nm/Q==
X-Gm-Message-State: AOAM533vFYSwgUvqNQgHviONmXd3y6RJlka1VINkLAJ7qOh/Ni/DmEbG
        HPdCIrJirAUhlDAaChi8vt7n7s2dO65OtTwJ0YRTZQ==
X-Google-Smtp-Source: ABdhPJwH/d09UUxphQlanLQBcjSqhz0t3KJnbw6ZMwuQXdqQ+tJ/31ktb4sxDBLjxnuw1taD+PyT9F0D75TmRc7A/7w=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr21740309pll.223.1591048326923;
 Mon, 01 Jun 2020 14:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200521100952.GA5360@willie-the-truck> <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
 <20200526202157.GE2206@willie-the-truck> <20200527134104.GA16115@e121166-lin.cambridge.arm.com>
 <20200601070459.GB8601@willie-the-truck>
In-Reply-To: <20200601070459.GB8601@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 14:51:55 -0700
Message-ID: <CAKwvOdmXmxOdW_TJQmYBYDY8gDOacjDTcpSWQGATb2p_85tFAQ@mail.gmail.com>
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        guohanjun@huawei.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:05 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 02:41:04PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, May 26, 2020 at 09:21:57PM +0100, Will Deacon wrote:
> > > Hi Lorenzo, Hanjun, [+Nick]
> > >
> > > On Thu, May 21, 2020 at 06:37:38PM +0100, Lorenzo Pieralisi wrote:
> > > > On Thu, May 21, 2020 at 11:09:53AM +0100, Will Deacon wrote:
> > > > > Hi folks,
> > > > >
> > > > > I just tried booting the arm64 for-kernelci branch under QEMU (version
> > > > > 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a
> > > > > couple of NULL pointer dereferences reported at boot. I think they're
> > > > > both GIC related (log below). I don't see a panic with UBSAN disabled,
> > > > > so something's fishy here.
> > > >
> > > > May I ask you the QEMU command line please - just to make sure I can
> > > > replicate it.
> > >
> > > As it turns out, I'm only able to reproduce this when building with Clang,
> > > but I don't know whether that's because GCC is missing something of Clang
> > > is signalling a false positive. You also don't need all of those whacky
> > > fuzzing options enabled.
> > >
> > > Anyway, to reproduce:
> > >
> > >  $ git checkout for-next/kernelci
> > >  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- defconfig
> > >  <then do a menuconfig and enable UBSAN>
> > >  $ make ARCH=arm64  CC=clang CROSS_COMPILE=aarch64-linux-gnu- Image
> > >
> > > I throw that at QEMU using:
> > >
> > > qemu-system-aarch64 -M virt -machine virtualization=true \
> > >     -machine virt,gic-version=3 \
> > >     -cpu max,sve=off -smp 2 -m 4096 \
> > >     -drive if=pflash,format=raw,file=efi.img,readonly \
> > >     -drive if=pflash,format=raw,file=varstore.img \
> > >     -drive if=virtio,format=raw,file=disk.img \
> > >     -device virtio-scsi-pci,id=scsi0 \
> > >     -device virtio-rng-pci \
> > >     -device virtio-net-pci,netdev=net0 \
> > >     -netdev user,id=net0,hostfwd=tcp::8222-:22 \
> > >     -nographic \
> > >     -kernel ~/work/linux/arch/arm64/boot/Image \
> > >     -append "earlycon root=/dev/vda2"
> > >
> > > I built QEMU a while ago according to:
> > >
> > > https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/docs/qemu/qemu-arm64-howto.html
> > >
> > > and its version 4.2.50 (v4.2.0-779-g4354edb6dcc7).
> > >
> > > My clang is version 11.0.1.
> >
> > Thanks a lot Will.
> >
> > I *think* I was right - it is the ACPI_OFFSET() macro:
> >
> > #define ACPI_OFFSET(d, f)  ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> >
> > that triggers the warnings (I suspected it because at least in one of
> > the warnings I could not see any dereference of any dynamically
> > allocated data).
>
> Cheers, Lorenzo.
>
> > Now on what to do with it - thoughts welcome.
>
> Nick -- any idea what to do about the above? The '#define' pasted by
> Lorenzo is causing a couple of spurious UBSAN splats when compiling with
> clang 11.

If there's undefined behavior from that macro soup, we should be able
to reproduce it outside of the kernel and regardless of target
architecture, right?  The macros aren't too much to throw into a file:

```foo.c
#define acpi_uintptr_t void *
#define ACPI_CAST_PTR(t, p) ((t *) (acpi_uintptr_t) (p))
typedef unsigned char u8;
typedef unsigned long u64;
typedef u64 acpi_size;
#define ACPI_PTR_DIFF(a, b) ((acpi_size) (ACPI_CAST_PTR (u8, (a)) -
ACPI_CAST_PTR (u8, (b))))
#define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)

struct foo {
unsigned char bar;
int baz;
};

int main() {
return ACPI_OFFSET(struct foo, baz);
}
```
I think looks right.  If we run that through -E, and clean that up
further, we get:
```bar.c
typedef unsigned char u8;
typedef unsigned long u64;

struct foo {
unsigned char bar;
int baz;
};

int main() {
return ((u64) (((u8 *) (void *) ((&(((struct foo *) 0)->baz)))) - ((u8
*) (void *) (((void *) 0)))));
}
```
I may be miscounting my parentheses, but how do you take the address
of `type`->`member`?  What does that even mean?

+ some more sanitizer folks and Ard for ACPI.

anyways, running foo.c through a compiler:
$ clang -O2 foo.c -fsanitize=undefined
$ ./a.out
foo.c:15:12: runtime error: member access within null pointer of type
'struct foo'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior foo.c:15:12 in

(msg looks truncated, wtf)

Anyways, it looks like the address of member from NULL subexpression
looks problematic.  I wonder if offsetof can be used here?

#define ACPI_OFFSET(d, f) ACPI_PTR_DIFF (offsetof(d, f), (void *) 0)

Seems to work in my basic test case.  Untested in the kernel.

IIUC, ACPI_OFFSET is trying to calculate the difference between the
offset of a member of a struct and 0?  Isn't that the tautology `x - 0
== x`?
-- 
Thanks,
~Nick Desaulniers
