Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59927C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DAD20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSTs7G5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDJAHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:07:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41834 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDJAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:07:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id z23so213939lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inzVyw6Ot/LgxDWOIQtKmkQVDEN4+rg6ys6xtOG3kl4=;
        b=SSTs7G5AW5Jc7I+C1WtZ9C/PnjS7Hvz4y5rUIMgax7RffUNOKUfaYATuO2YOBkdvTW
         iLKR3f++3jkecH5xYvwGvyNY2rqoNjog8zLh58gI5OsGHGi6mFO2TgiclVSXHriRvBcY
         KoEBdfuZ6bzXKEF9OLSrvSjSPXpom7tQ7wzvfnDYT9298AiaaLbiDJeR7wzxj99vPPOB
         Ho0rchYWdmfELpxzzZeDNPKS3eni7mCSkoTx6bSI3rK5CFKbtdyhSAdMymy6oI0DfYyo
         TWjZlz8KYT2gmXNzryg7OLwScO43rIDPjeoPoBxb1uUdlcj7ekqcIMQnNBBr5L1qaiTn
         CA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inzVyw6Ot/LgxDWOIQtKmkQVDEN4+rg6ys6xtOG3kl4=;
        b=b4gFoG0KxZLMeGdKh86t84tS8Nb7+wFhXkj4gNuuMwLzHeSgKVyqOyEFgtVWy1lqDF
         24OxyA9jBjBxFzozGiZHWRyEtIAa8Fh2v+aPIy3AJsNZF/BlsRGYcjii5VvJAmzOCC8b
         /jhFYfvnUMdO2/NQ3ikZ2zvWdi5h0CkOqHcvTv7lrypHuSCh0+f0nFRyoQyYrIcvyURG
         ZXrmzsMtWEFPC7f/A0TMxhm42kqGgTnaSss5AnUoWtsFVlnfRjTJS9EjFZyctO3HUzMD
         useZHp6HbHggiKF+QHs1wk5w1kDqpkaXZvHz0v78vpifC3bmWTgxPiZ7x34fEFvpeoh1
         4rcQ==
X-Gm-Message-State: AGi0PuaOewuEFlst2kES9vlV8L/Q92xZ6M344iedXsedxPzzPu4mCZyB
        zH5496BcySpy/Q1MhFeTUULMiP5FIILFDqw8WrfRqQ==
X-Google-Smtp-Source: APiQypJncgehuG48oarwmUwjxZUSTUp6xCpRFT1boMzt+K1Iy3DAaDT0Y65SllVLPGfJCrLM2ugt0Svep5pP1sSrk2Y=
X-Received: by 2002:ac2:515d:: with SMTP id q29mr1019159lfd.210.1586477218911;
 Thu, 09 Apr 2020 17:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585548051.git.ashish.kalra@amd.com> <4d4fbe2b9acda82c04834682900acf782182ec23.1585548051.git.ashish.kalra@amd.com>
 <CABayD+eOCpTGjvxwhtP85j98BKvCxtG8QDBYSC0E08GnaA12jw@mail.gmail.com> <20200408014852.GA27608@ashkalra_ubuntu_server>
In-Reply-To: <20200408014852.GA27608@ashkalra_ubuntu_server>
From:   Steve Rutherford <srutherford@google.com>
Date:   Thu, 9 Apr 2020 17:06:21 -0700
Message-ID: <CABayD+eaeLZ++Hh8RC=5gWehgJs+tN3Ad39Nx7bF4foEido7jw@mail.gmail.com>
Subject: Re: [PATCH v6 11/14] KVM: x86: Introduce KVM_SET_PAGE_ENC_BITMAP ioctl
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 6:49 PM Ashish Kalra <ashish.kalra@amd.com> wrote:
>
> Hello Steve,
>
> On Tue, Apr 07, 2020 at 05:26:33PM -0700, Steve Rutherford wrote:
> > On Sun, Mar 29, 2020 at 11:23 PM Ashish Kalra <Ashish.Kalra@amd.com> wr=
ote:
> > >
> > > From: Brijesh Singh <Brijesh.Singh@amd.com>
> > >
> > > The ioctl can be used to set page encryption bitmap for an
> > > incoming guest.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: Borislav Petkov <bp@suse.de>
> > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > Cc: x86@kernel.org
> > > Cc: kvm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >  Documentation/virt/kvm/api.rst  | 22 +++++++++++++++++
> > >  arch/x86/include/asm/kvm_host.h |  2 ++
> > >  arch/x86/kvm/svm.c              | 42 +++++++++++++++++++++++++++++++=
++
> > >  arch/x86/kvm/x86.c              | 12 ++++++++++
> > >  include/uapi/linux/kvm.h        |  1 +
> > >  5 files changed, 79 insertions(+)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/=
api.rst
> > > index 8ad800ebb54f..4d1004a154f6 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -4675,6 +4675,28 @@ or shared. The bitmap can be used during the g=
uest migration, if the page
> > >  is private then userspace need to use SEV migration commands to tran=
smit
> > >  the page.
> > >
> > > +4.126 KVM_SET_PAGE_ENC_BITMAP (vm ioctl)
> > > +---------------------------------------
> > > +
> > > +:Capability: basic
> > > +:Architectures: x86
> > > +:Type: vm ioctl
> > > +:Parameters: struct kvm_page_enc_bitmap (in/out)
> > > +:Returns: 0 on success, -1 on error
> > > +
> > > +/* for KVM_SET_PAGE_ENC_BITMAP */
> > > +struct kvm_page_enc_bitmap {
> > > +       __u64 start_gfn;
> > > +       __u64 num_pages;
> > > +       union {
> > > +               void __user *enc_bitmap; /* one bit per page */
> > > +               __u64 padding2;
> > > +       };
> > > +};
> > > +
> > > +During the guest live migration the outgoing guest exports its page =
encryption
> > > +bitmap, the KVM_SET_PAGE_ENC_BITMAP can be used to build the page en=
cryption
> > > +bitmap for an incoming guest.
> > >
> > >  5. The kvm_run structure
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> > > index 27e43e3ec9d8..d30f770aaaea 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1271,6 +1271,8 @@ struct kvm_x86_ops {
> > >                                   unsigned long sz, unsigned long mod=
e);
> > >         int (*get_page_enc_bitmap)(struct kvm *kvm,
> > >                                 struct kvm_page_enc_bitmap *bmap);
> > > +       int (*set_page_enc_bitmap)(struct kvm *kvm,
> > > +                               struct kvm_page_enc_bitmap *bmap);
> > >  };
> > >
> > >  struct kvm_arch_async_pf {
> > > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > > index bae783cd396a..313343a43045 100644
> > > --- a/arch/x86/kvm/svm.c
> > > +++ b/arch/x86/kvm/svm.c
> > > @@ -7756,6 +7756,47 @@ static int svm_get_page_enc_bitmap(struct kvm =
*kvm,
> > >         return ret;
> > >  }
> > >
> > > +static int svm_set_page_enc_bitmap(struct kvm *kvm,
> > > +                                  struct kvm_page_enc_bitmap *bmap)
> > > +{
> > > +       struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> > > +       unsigned long gfn_start, gfn_end;
> > > +       unsigned long *bitmap;
> > > +       unsigned long sz, i;
> > > +       int ret;
> > > +
> > > +       if (!sev_guest(kvm))
> > > +               return -ENOTTY;
> > > +
> > > +       gfn_start =3D bmap->start_gfn;
> > > +       gfn_end =3D gfn_start + bmap->num_pages;
> > > +
> > > +       sz =3D ALIGN(bmap->num_pages, BITS_PER_LONG) / 8;
> > > +       bitmap =3D kmalloc(sz, GFP_KERNEL);
> > > +       if (!bitmap)
> > > +               return -ENOMEM;
> > > +
> > > +       ret =3D -EFAULT;
> > > +       if (copy_from_user(bitmap, bmap->enc_bitmap, sz))
> > > +               goto out;
> > > +
> > > +       mutex_lock(&kvm->lock);
> > > +       ret =3D sev_resize_page_enc_bitmap(kvm, gfn_end);
> > I realize now that usermode could use this for initializing the
> > minimum size of the enc bitmap, which probably solves my issue from
> > the other thread.
> > > +       if (ret)
> > > +               goto unlock;
> > > +
> > > +       i =3D gfn_start;
> > > +       for_each_clear_bit_from(i, bitmap, (gfn_end - gfn_start))
> > > +               clear_bit(i + gfn_start, sev->page_enc_bmap);
> > This API seems a bit strange, since it can only clear bits. I would
> > expect "set" to force the values to match the values passed down,
> > instead of only ensuring that cleared bits in the input are also
> > cleared in the kernel.
> >
>
> The sev_resize_page_enc_bitmap() will allocate a new bitmap and
> set it to all 0xFF's, therefore, the code here simply clears the bits
> in the bitmap as per the cleared bits in the input.

If I'm not mistaken, resize only reinitializes the newly extended part
of the buffer, and copies the old values for the rest.
With the API you proposed you could probably reimplement a normal set
call by calling get, then reset, and then set, but this feels
cumbersome.

--Steve
