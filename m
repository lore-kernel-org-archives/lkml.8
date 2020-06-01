Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842B62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591030299;
	bh=ehIgjqfbBBjxDPUjD2WX+8FA7eGuKdelQD+KI1hrAg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A1LxEFGVT7At6m3MXC+D1dbYxAUR1iij3WNj7kN6AxusKoULcc4QIHe//46O2EVeE
	 +9T9nRmgiY3RM7hTGkFFkubFwVFe6oDIPLuytA4X8Fix/V1ceeLF9Phk2LLOhvd3qJ
	 rh3OC/6gQpjqlgAaBRqq5P4+bSNZq/WDtIg9fxX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFAQvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:51:38 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7485A2086A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591030297;
        bh=ehIgjqfbBBjxDPUjD2WX+8FA7eGuKdelQD+KI1hrAg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uXO8ySExjM2Fo4MQ6Xeg5b01OrE4WYgaXZuCMxO9s/SmQ1An0pmbF2nfDt3SoDuzr
         3G5cpXO8S3WieWOYfhvTIAsbl0pwhQYG0qRmqfOZ2AyTyYG8jsDz7PdXwcnwfrpHWu
         8ngXfjRabAdR8GZAGBzjMUEJ5D24y3vHlccwnHHs=
Received: by mail-wm1-f43.google.com with SMTP id k26so202466wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:51:37 -0700 (PDT)
X-Gm-Message-State: AOAM532sCJC8RbRUC7cPZKw+HG4UqZ7qb6smYPyo7PiNBni5oG38Hxt7
        3WX7OjXpQSwIfaf/R5B+EYOEEaeBUxowv2lhl7XQGw==
X-Google-Smtp-Source: ABdhPJxTbhyy5JlsvE6bc8xkZzvDwdVQHFocVib0238l3FWMXeebYTBbDyNENu2bwwiGB3rzKLw990EquTaln20n2ek=
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr206945wme.21.1591030295821;
 Mon, 01 Jun 2020 09:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
 <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl> <d1b55f25-e54c-b259-8836-d834a572de3b@apertussolutions.com>
In-Reply-To: <d1b55f25-e54c-b259-8836-d834a572de3b@apertussolutions.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jun 2020 09:51:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVPK=m3F84NtiU59SLyDrBNxi1ONyhH1GuOhx4aGU=_fQ@mail.gmail.com>
Message-ID: <CALCETrVPK=m3F84NtiU59SLyDrBNxi1ONyhH1GuOhx4aGU=_fQ@mail.gmail.com>
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>,
        grub-devel@gnu.org, LKML <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com, X86 ML <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        Matthew Garrett <mjg59@google.com>, phcoder@gmail.com,
        piotr.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 8:33 AM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 5/7/20 7:06 AM, Daniel Kiper wrote:
> > Hi =C5=81ukasz,
> >
> > On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
> >> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
>
> ...
>
> >> In OS-MLE table there is a buffer for TPM event log, however I see tha=
t
> >> you are not using it, but instead allocate space somewhere in the
> >
> > I think that this part requires more discussion. In my opinion we shoul=
d
> > have this region dynamically allocated because it gives us more flexibi=
lity.
> > Of course there is a question about the size of this buffer too. I am
> > not sure about that because I have not checked yet how many log entries
> > are created by the SINIT ACM. Though probably it should not be large...
> >
> >> memory. I am just wondering if, from security perspective, it will be
> >> better to use memory from TXT heap for event log, like we do in TBOOT.
> >
> > Appendix F, TPM Event Log, has following sentence: There are no
> > requirements for event log to be in DMA protected memory =E2=80=93 SINI=
T will
> > not enforce it.
> >
> > I was thinking about it and it seems to me that the TPM event log does
> > not require any special protections. Any changes in it can be quickly
> > detected by comparing hashes with the TPM PCRs. Does not it?
> >
>
> I think it would be beneficial to consider the following in deciding
> where the log is placed. There are two areas of attack/manipulation that
> need to be considered. The first area is the log contents itself, which
> as Daniel has pointed out, the log contents do not really need to be
> protected from tampering as that would/should be detected during
> verification by the attestor. The second area that we need to consider
> is the log descriptors themselves. If these are in an area that can be
> manipulated, it is an opportunity for an attacker to attempt to
> influence the ACM's execution. For a little perspective, the ACM
> executes from CRAM to take the most possible precaution to ensure that
> it cannot be tampered with during execution. This is very important
> since it runs a CPU mode (ACM Mode) that I would consider to be higher
> (or lower depending on how you view it) than SMM. As a result, the txt
> heap is also included in what is mapped into CRAM. If the event log is
> place in the heap, this ensures that the ACM is not using memory outside
> of CRAM during execution. Now as Daniel has pointed out, the down side
> to this is that it greatly restricts the log size and can only be
> managed by a combination of limiting the number of events and
> restricting what content is carried in the event data field.

Can you clarify what the actual flow of control is?  If I had to guess, it'=
s:

GRUB (or other bootloader) writes log.

GRUB transfers control to the ACM.  At this point, GRUB is done
running and GRUB code will not run again.

ACM validates system configuration and updates TPM state using magic
privileged TPM access.

ACM transfers control to the shiny new Linux secure launch entry point

Maybe this is right, and maybe this is wrong.  But I have some
questions about this whole setup.  Is the ACM code going to inspect
this log at all?  If so, why?  Who supplies the ACM code?  If the ACM
can be attacked by putting its inputs (e.g. this log) in the wrong
place in memory, why should this be considered anything other than a
bug in the ACM?

If GRUB is indeed done by the time anyone consumes the log, why does
GRUB care where the log ends up?

And finally, the log presumably has nonzero size, and it would be nice
not to pin some physical memory forever for the log.  Could the kernel
copy it into tmpfs during boot so it's at least swappable and then
allow userspace to delete it when userspace is done with it?
