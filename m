Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99335C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0420716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNI5197d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgFWOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:24:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732938AbgFWOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RR1B9NfF9KKeLN7WfaVCil2nbXJzIf96KglwlOXnZyY=;
        b=jNI5197dkiHez57eAIBLEKZ76uTPjczUXdmX7Xmyk1z2YSUcaEZwck/EATsn6F5Q0zg0ku
        XVmygqE1mfL1NedtW6RTTjWffbgojDqyDRxsxJjWkG6LR6B+eUlCY9efQ+UHCuG5R9+SVI
        qiHijx2JGECKWkHzwQTEK1sXYbhmeC8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-coSQZCeXOyiW-DXRfbjkPQ-1; Tue, 23 Jun 2020 10:24:33 -0400
X-MC-Unique: coSQZCeXOyiW-DXRfbjkPQ-1
Received: by mail-qk1-f200.google.com with SMTP id l6so15405721qkk.14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RR1B9NfF9KKeLN7WfaVCil2nbXJzIf96KglwlOXnZyY=;
        b=hTW3b21DzcYrPGT+4WcStXlQ7eIQ6NkVzI5wLxCsGFQymCDtevR+5VQpp7g4ZP+ath
         p2tUWaQJAXh7ocp0HaN3J2RwS9WNm72XORiDNcGSyFbR45cyQTBWVbiRJor722hczxK5
         oYbGER1MCy2bm/SYzxRLtAR/gaevbS//j0Puc7F++EcQa0jzYbejhjQAZ7tEgPtzYNlY
         YQJH0A8KB7Qll5TKHrU4IQB/iIC2SyudDAYi4MCRUXitzVqQW7Ho0FWfa5v8kIU+o+mC
         7gU9gJ3r8K5GzVhWmiJtkCcoVdqwBS3xlJvDGUgyXCF9KTXN7e/6xKFHXwUvFKeaPrQJ
         Kkvw==
X-Gm-Message-State: AOAM530FzEp3lGc/UHfYs7mQc9mciULF1CG1o4ZSESIITaUKSfGWHvrN
        LK1GpKSZgwlHOqsPmWLr0ysM6w8YtN20NpJrG/tfru950qqpkNW+2NM1tEAV4FhGksP86DWYUbt
        bHiMVtHOqKfV6317FqFDAArGDyl4GD/YdJo8B3cCx
X-Received: by 2002:a37:27c2:: with SMTP id n185mr7033798qkn.459.1592922272586;
        Tue, 23 Jun 2020 07:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN9dNsQ1OTmPnyWwgxxe4CrufeTopFTwlk33LGRccCWckEmFGROVsT77uvggNbgbCLqsfatkBEIbv2KAIR71o=
X-Received: by 2002:a37:27c2:: with SMTP id n185mr7033772qkn.459.1592922272185;
 Tue, 23 Jun 2020 07:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200621140421.7f4552df@canb.auug.org.au> <20200623103736.25f67de5@canb.auug.org.au>
In-Reply-To: <20200623103736.25f67de5@canb.auug.org.au>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 23 Jun 2020 16:24:21 +0200
Message-ID: <CAO-hwJKX_bdgv=ZOx+KmSEZ1PkAzw-+NUPRBUOH_F8D+P4=XCw@mail.gmail.com>
Subject: Re: linux-next: build failures after merge of the hid tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Cristian Klein <cristian.klein@elastisys.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Cristian, the author of the patch]


On Tue, Jun 23, 2020 at 2:37 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Sun, 21 Jun 2020 14:04:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > drivers/hid/intel-ish-hid/ipc/ipc.c:12:10: fatal error: client.h: No such file or directory
> >    12 | #include "client.h"
> >       |          ^~~~~~~~~~
> > drivers/hid/intel-ish-hid/ipc/pci-ish.c:22:10: fatal error: ishtp-dev.h: No such file or directory
> >    22 | #include "ishtp-dev.h"
> >       |          ^~~~~~~~~~~~~
> >
> > I don't know what caused it, but commit
> >
> >   470376737e88 ("HID: allow building hid.ko as an external module")

I am under the impression that this patch is causing the issue.

I am tempted to revert it (and force push the branch hid/for-5.9/core)
given that the 0-day bot also complained.

> >
> > did not fix it.  BTW, I build with "make O=...".
> >
> > I have used the hid tree from next-20200618 for today.
> >
> > BTW, the hid tree really needs cleaning up, it contains merge commits dating
> > back to April 2018 :-(

We are carefully not force pushing the hid/for-next branch, and all
the merges you are seeing there are the various merges we do after
including a patch that will be sent to linus later. Our for-next
branch never gets merged into for-linus, we handle that separately.

I always thought you prefer not having forced push on the for-next
branch. But if you rather us overwriting the tip of the branch at
every commit, we can do it for sure.

For reference, the way we handle branches are:
- master branch follows Linus' when there is an upstream merge of the
hid/for-linus branch
- every single commit goes into a branch named
for-<kernel_version>/<feature_name>
- those branches are created on top of current master and are never rebased
- every time we add a patch (series) on top of a feature branch, we
merge that into hid/for-next
- when we need to send a pull request to Linus, we merge the matching
"for-<kernel_version>/*" branches into hid/for-linus

This allows to keep a clear view of what is scheduled to be sent. But
the counterpart is that the hid/for-next branch never gets merged back
into hid/for-linus.

Cheers,
Benjamin

> >
> > $ git rev-list --count origin/master..hid/for-next
> > 301
> > $ git rev-list --no-merges --count origin/master..hid/for-next
> > 12
>
> I am still getting this failure.
>
> --
> Cheers,
> Stephen Rothwell

