Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053F520725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYEPfjqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGJR0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGJR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:26:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A805C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:26:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so5736200ilh.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqJnoWCCHedrq/sE7xptu8e2ktVbhXZt758ObhyN/DU=;
        b=pYEPfjqtWC03FcbjU/vEyI2Jvj2Cb+4dFJ/rm83f9F0tVa8/blrrwdEUgp3cbYB8N5
         HWfrtZkVga6TgVkLCIw+THtL6JYGn1jt/kUPIAYT8ss/SXt4NkopRFDH0i2RChiRHvJ9
         R55Mw9NYvpS0DVGIKhSE7hIXLRGpMZT5FEFLxgGuan+vg6TAFuh1SFHgQeWOzSg3qyXl
         o77Pwecu6eTEdXbw5VU1gszypRoJDiZBitxlUPSqgD+qtLaCP17oThyYNor1oT9OyeYD
         7TEMmClSqhcUpmLEgFI/wQe3v/OsJG1Yeinb7tz399sGHmP/Gg3ZvPHhOAT5SJpEZw+H
         OAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqJnoWCCHedrq/sE7xptu8e2ktVbhXZt758ObhyN/DU=;
        b=qG3gIM3zW7r8Xu09oTpv08jhPccmSlsi13x3+45MolBwf1ULEm+sXu1S/0U6e0HDqg
         vu7eDywwL87f5yBbbraBXWg4a2xGiud6UV6Cg4CKnu2KV2Nrw5fqPn8atrozHvn2dbvQ
         fJjxezJJm7zTXJfElfYqdCoxgSLSgXWM2QBzJ5U7oQlspqKapw5m3s2DpjqDExmmZ27G
         guYA81/dnTeVPr9cxEH1O+2QncSAAoE6hc1+PL9mHNHEswM7tsfQ3yadjdnGHkMBr2jK
         soS+2kVLC2fGLjoC4EG/SxR1MiSB11R5LFO8ipxyOWQBcbt9ClpWlhcp7g5z8/cePGIS
         Dcyg==
X-Gm-Message-State: AOAM532s4WJvGjw/BWyfuDsIunDtGbCCQesxEpOkFemUXmEMy5OoW2gz
        UOTwvdYgTreJoJoj5HwzPjzQ5I3RN1kjRCB+MPvzqA==
X-Google-Smtp-Source: ABdhPJzVe0a9jszJB19e1xo/iSDPtoEHSBeXIWF2pykmj4cfJKn+W3IarW3EmlujvPOweLPlaRRs1dxg51l/elCSVLw=
X-Received: by 2002:a92:b685:: with SMTP id m5mr53354561ill.118.1594402011252;
 Fri, 10 Jul 2020 10:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
 <0c892b1e-6fe6-2aa7-602e-f5fadc54c257@redhat.com> <CALMp9eQXHGnXo4ACX2-qYww4XdRODMn-O6CAvhupib67Li9S2w@mail.gmail.com>
 <9e784c62-15ee-63b7-4942-474493bac536@redhat.com>
In-Reply-To: <9e784c62-15ee-63b7-4942-474493bac536@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Jul 2020 10:26:40 -0700
Message-ID: <CALMp9eRGTedw-wNL4HcrJOpAQBa_Qsqcir0BtJ-dEO6EhvWGqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:16 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/07/20 19:13, Jim Mattson wrote:
> > On Fri, Jul 10, 2020 at 10:06 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 10/07/20 18:30, Jim Mattson wrote:
> >>>>
> >>>> This can be problem when having a mixed setup of machines with 5-level page
> >>>> tables and machines with 4-level page tables, as live migration can change
> >>>> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
> >>>
> >>> Huh? Changing MAXPHYADDR while the guest runs should be illegal. Or
> >>> have I missed some peculiarity of LA57 that makes MAXPHYADDR a dynamic
> >>> CPUID information field?
> >>
> >> Changing _host_ MAXPHYADDR while the guest runs, such as if you migrate
> >> from a host-maxphyaddr==46 to a host-maxphyaddr==52 machine (while
> >> keeping guest-maxphyaddr==46).
> >
> > Ah, but what does that have to do with LA57?
>
> Intel only has MAXPHYADDR > 46 on LA57 machines (because in general OSes
> like to have a physical 1:1 map into the kernel part of the virtual
> address space, so having a higher MAXPHYADDR would be of limited use
> with 48-bit linear addresses).

We all know that the direct map is evil. :-)

Sorry it took me so long to get there. I didn't realize that Linux was
incapable of using more physical memory than it could map into the
kernel's virtual address space. (Wasn't that the whole point of PAE
originally?)
