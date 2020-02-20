Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D7C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CF920801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbnmAXzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgBTXYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:24:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33653 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgBTXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:24:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so274347lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XIeBZDogNfaTWSyvaUAomCKZ8CEnFBAh/xMXEs0iMRU=;
        b=jbnmAXzsLQ7KRZ5bLhIAqCC9dJBGm537bHk5dY+iNKRAWNXr8iJM42DaqbMqdp8snm
         DK4FrswCJtyE//7/bU+cHi9lL51gtdHrtJtfjNazLBOxcfjXGERoZUx7yBL1zT4xzThk
         ROMPSiJX81blZe/I+zPgU2DWzWeMGCRmNg2KG8JDJNjacFYQQn6BFYIQogcCckyrzAKZ
         FQcqJluSLsrncvSNBCNAZ1B6ye6ZrGVkFYR/dXw0USISC6dRHwZB4vd2EmlcAz1klrOA
         s4kLdW8spYly14p4JazHiWXgePXoJTS1jH2srp1FffbfRdNBTHEngmQBYZJMr0C2TBVl
         9Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XIeBZDogNfaTWSyvaUAomCKZ8CEnFBAh/xMXEs0iMRU=;
        b=hn4KPMZANySD6adFHDar8WegDU+Wg0MfOaVYFrwMeqXehb2FY3tOk5HfrWlpaD4tlc
         8Xt161ymb3DKmCwbi1RlalNC5yPVKem8Vso3pCBrON9150rTpOH374es49VFcXgBMEkW
         07ZVSBDHwvShcO4HKN28bSPrfBhyg1Pfdny2V20QaapGhNmby8RfR7SKtRdJUdL5RsO+
         SarFrmH+umGJ1QzRXV4zAWwzyjKUUesUFiZ0N+lRruvpAoNWrp3IIBqzmEiodX7Sps2S
         bOazj5k3gKEmDfjiCFnPjw82lyP+Rh9GsV8s7d3pUIc9h27+a0qIduH1loI0vsKqJKS8
         /O6Q==
X-Gm-Message-State: APjAAAW+52Gx8M8fVU3iU6s3IqjMAzrrw3FLXq1FOZk6foIN3YfzpU9s
        oSJcRYlE/QoeL3QaQw7nPVp8ulJMeFBlJy7GIDIGnQ==
X-Google-Smtp-Source: APXvYqypcU/r1i45FPqCupRHRb73pHgOjAIxggW06CsnHK9DRgJT7I31tHfuM0OA63RqhRTqCvU4JP+OmLyEAqIOs9I=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr20328632ljb.150.1582241040193;
 Thu, 20 Feb 2020 15:24:00 -0800 (PST)
MIME-Version: 1.0
References: <CABayD+ch3XBvJgJc+uoF6JSP0qZGq2zKHN-hTc0Vode-pi80KA@mail.gmail.com>
 <52450536-AF7B-4206-8F05-CF387A216031@amacapital.net> <3de6e962-3277-ddbd-8c78-eaf754973928@amd.com>
 <CABayD+fBpP-W_jfVuy_+shh+Sj_id79+ECG+R5H=W9Jmcii8qg@mail.gmail.com> <e5ef78d4-2764-cbbb-d3d6-69621e1d6490@amd.com>
In-Reply-To: <e5ef78d4-2764-cbbb-d3d6-69621e1d6490@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Thu, 20 Feb 2020 15:23:23 -0800
Message-ID: <CABayD+fTa=dtbb3E4+kgQkNqDHYUfJGJTUfN5PirBit6Xp4JeQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] mm: x86: Invoke hypercall when page encryption
 status is changed
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        David Rientjes <rientjes@google.com>, x86@kernel.org,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:43 PM Brijesh Singh <brijesh.singh@amd.com> wrote=
:
>
>
>
> On 2/20/20 2:43 PM, Steve Rutherford wrote:
> > On Thu, Feb 20, 2020 at 7:55 AM Brijesh Singh <brijesh.singh@amd.com> w=
rote:
> >>
> >>
> >>
> >> On 2/19/20 8:12 PM, Andy Lutomirski wrote:
> >>>
> >>>
> >>>> On Feb 19, 2020, at 5:58 PM, Steve Rutherford <srutherford@google.co=
m> wrote:
> >>>>
> >>>> =EF=BB=BFOn Wed, Feb 12, 2020 at 5:18 PM Ashish Kalra <Ashish.Kalra@=
amd.com> wrote:
> >>>>>
> >>>>> From: Brijesh Singh <brijesh.singh@amd.com>
> >>>>>
> >>>>> Invoke a hypercall when a memory region is changed from encrypted -=
>
> >>>>> decrypted and vice versa. Hypervisor need to know the page encrypti=
on
> >>>>> status during the guest migration.
> >>>>
> >>>> One messy aspect, which I think is fine in practice, is that this
> >>>> presumes that pages are either treated as encrypted or decrypted. If
> >>>> also done on SEV, the in-place re-encryption supported by SME would
> >>>> break SEV migration. Linux doesn't do this now on SEV, and I don't
> >>>> have an intuition for why Linux might want this, but we will need to
> >>>> ensure it is never done in order to ensure that migration works down
> >>>> the line. I don't believe the AMD manual promises this will work
> >>>> anyway.
> >>>>
> >>>> Something feels a bit wasteful about having all future kernels
> >>>> universally announce c-bit status when SEV is enabled, even if KVM
> >>>> isn't listening, since it may be too old (or just not want to know).
> >>>> Might be worth eliding the hypercalls if you get ENOSYS back? There
> >>>> might be a better way of passing paravirt config metadata across tha=
n
> >>>> just trying and seeing if the hypercall succeeds, but I'm not super
> >>>> familiar with it.
> >>>
> >>> I actually think this should be a hard requirement to merge this. The=
 host needs to tell the guest that it supports this particular migration st=
rategy and the guest needs to tell the host that it is using it.  And the g=
uest needs a way to tell the host that it=E2=80=99s *not* using it right no=
w due to kexec, for example.
> >>>
> >>> I=E2=80=99m still uneasy about a guest being migrated in the window w=
here the hypercall tracking and the page encryption bit don=E2=80=99t match=
.  I guess maybe corruption in this window doesn=E2=80=99t matter?
> >>>
> >>
> >> I don't think there is a corruption issue here. Let's consider the bel=
ow
> >> case:
> >>
> >> 1) A page is transmitted as C=3D1 (encrypted)
> >>
> >> 2) During the migration window, the page encryption bit is changed
> >>    to C=3D0 (decrypted)
> >>
> >> 3) #2 will cause a change in page table memory, thus dirty memory
> >>    the tracker will create retransmission of the page table memory.
> >>
> >> 4) The page itself will not be re-transmitted because there was
> >>    no change to the content of the page.
> >>
> >> On destination, the read from the page will get the ciphertext.
> >>
> >> The encryption bit change in the page table is used on the next access=
.
> >> The user of the page needs to ensure that data is written with the
> >> correct encryption bit before reading.
> >>
> >> thanks
> >
> >
> > I think the issue results from a slightly different perspective than
> > the one you are using. I think the situation Andy is interested in is
> > when a c-bit change and a write happen close in time. There are five
> > events, and the ordering matters:
> > 1) Guest dirties the c-bit in the guest
> > 2) Guest dirties the page
> > 3) Host userspace observes the c-bit logs
> > 4) Host userspace observes the page dirty logs
> > 5) Host transmits the page
> >
> > If these are reordered to:
> > 3) Host userspace observes the c-bit logs
> > 1) Guest dirties the c-bit in the guest
> > 2) Guest dirties the page
> > 4) Host userspace observes the page dirty logs
> > 5) Host transmits the page (from the wrong c-bit perspective!)
> >
> > Then the host will transmit a page with the wrong c-bit status and
> > clear the dirty bit for that page. If the guest page is not
> > retransmitted incidentally later, then this page will be corrupted.
> >
> > If you treat pages with dirty c-bits as dirty pages, then you will
> > check the c-bit logs later and observe the dirty c-bit and retransmit.
> > There might be some cleverness around enforcing that you always fetch
> > the c-bit logs after fetching the dirty logs, but I haven't convinced
> > myself that this works yet. I think it might, since then the c-bits
> > are at least as fresh as the dirty bits.
> >
>
> Unlike the dirty log, the c-bit log maintains the complete state.
> So, I think it is the Host userspace responsibility to ensure that it
> either keeps track of any c-bit log changes since it last sync'ed.
> During the migration, after pausing the guest it can get the recent
> c-bit log and compare if something has changed since it last sync'ed.
> If so, then retransmit the page with new c-bit state.
>
> > The main uncertainty that comes to mind for that strategy is if, on
> > multi-vCPU VMs, the page dirtying event (from the new c-bit
> > perspective) and the c-bit status change hypercall can themselves
> > race. If a write from the new c-bit perspective can arrive before the
> > c-bit status change arrives in the c-bit logs, we will need to treat
> > pages with dirty c-bits as dirty pages.
> >
>
> I believe if host userspace tracks the changes in the c-bit log since
> it last synced then this problem can be avoided. Do you think we should
> consider tracking the last sync changes in KVM or let the host userspace
> handle it.
Punting this off to userspace to handle works. If storing the old
c-bit statuses in userspace becomes a memory issue (unlikely), we can
fix that down the line.

Andy, are your concerns about the raceyness of c-bit tracking resolved?
