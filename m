Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE62C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B4D206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgAJQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:08:42 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42185 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAJQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:08:42 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mxlio-1jbl4Q20f0-00zCYA; Fri, 10 Jan 2020 17:08:40 +0100
Received: by mail-qk1-f176.google.com with SMTP id x1so2261329qkl.12;
        Fri, 10 Jan 2020 08:08:40 -0800 (PST)
X-Gm-Message-State: APjAAAVgOjebwofTM/mFCu8bw1/rdiLSHIpX9JvcygAtuM8nnS2yR9/t
        liDzXpCK9SC5svZzpqbNN0sogeJlpeIPHJtk/AA=
X-Google-Smtp-Source: APXvYqwgR+v2dv7/wMiPhy4qejKcroBZGOTJpncOfoV6xo0lxkaX6tajyPVMXo1tCxNdr63wM5fqZURB8K6fDlcen38=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr3907390qka.286.1578672519276;
 Fri, 10 Jan 2020 08:08:39 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mOzsaD+ZnN+ZKvmcan=K=KbnTjUOe1y8fS8WOMXT+Dw@mail.gmail.com>
 <5E8DACB3-3B53-4E22-A834-4CEDFC6A1757@holtmann.org>
In-Reply-To: <5E8DACB3-3B53-4E22-A834-4CEDFC6A1757@holtmann.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 17:08:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1K79zGvi3hc4aw4vcsni1cx4u121OBHgWiaFSPxpA6ZQ@mail.gmail.com>
Message-ID: <CAK8P3a1K79zGvi3hc4aw4vcsni1cx4u121OBHgWiaFSPxpA6ZQ@mail.gmail.com>
Subject: Re: [RFC] y2038: HCI_TIME_STAMP with time64
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Rich Felker <dalias@libc.org>, Guy Harris <guy@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F28jPf5GZ+WmuA3iHbrtqw8QiiM++Cuoik1Swos6o4bXD8lBcIL
 2XJCWUNuEgU3GrUpRx0Kkvb3x0ruNrlLYpoal4c7XI2Q4BJJkaqXYqCCxUYdQzEFVPRDGtx
 SOOyvTzAomd/aIyL5lPBeEm5SrNS/TXVfp4zjMMCfE6akKfHBaDPpKByrRx3KSy5aBy9EcS
 cfBJNH2cRYYOG8aCH1KTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oocsPDZtf/w=:2C/Ew3v5hGxjIrWfq63bTb
 77bh6rDaZN/NOR6rBVRm64qgGG1Uxn3qeuiZgdXeadR3Ov33szcYxIX/APz9T96kXNdKnHEmr
 RjyBrf/UxBO2siH/+GpvsO+wjqlobN3Mfv1oggAKKJ38bCfE3c5NEm4OECgxrCzKAvnx6movI
 p9+OefJFYUmC3Gqel5u4y2Qr8Paa58FGYE1582HO5L0Q373HKB3aWViV6ntGtlDBtxaY+bYbC
 mdhqq1l8cTLHBR0qS+M0PG/gOcJl25YtbBPbGVAFpqwL7Gk1iJRVDvEzSvlR8Bitu4gZCf9BA
 0orCYEQFZXb+hzJpUK/0XzOMsp7P1C67b5ILgzpMxQ+Tsc6w6pT1P6mAFPS17oK9f+Ijy3gqd
 CWVUz6cG/OpfDAIGI5iwh60V1WT8MkvjO/OybNMZrlIjE8EMCe27AYVk+DhzsdfpvFZW8DtPN
 stCStJ7gNYdEqBeMG68vnYNyxiuhWVK30xZNJDfFMMsqo+x5dqoxM8RNaxGqhNv/lxrz3XScj
 PteBtKbFlH8fljbQhycfwJBfQ4M1247zPxQhEgbMY/u34lFwaKAgBha26gANL9Ym423dXp2vN
 fIZmvFs3IoAVlkTuPqK0r+csLM+Up7p22WPbiMUcAS+Gd7HH7RAiOovDjnatUsK/ou+5ON5Rq
 efEsfpo3j0czcPvAS1HzQ3W9tfXS8uUJVjSYL87pknlCYAr3Hv+TyG3LBCfr1PD3lSmB+f6+b
 Za4wb2mgXxaBP/MZvfY2/RgLDNZx0ZaUomePrIScrRmZBuDTNSwBny6O0ovskCBU20gTDiM8z
 wddlozwp4/pEjUDL+0CjqC33ErbtmReEp7WyDrCyfIujrNKgT3Fig9s5s+/smtl8l4C3zp06h
 UO4ifX+W7S1DhnwerNfg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:44 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > I noticed earlier this week that the HCI_CMSG_TSTAMP/HCI_TIME_STAMP
> > interface has no time64 equivalent, as we apparently missed that when
> > converting the normal socket timestamps to support both time32 and time64
> > variants of the sockopt and cmsg data.
...
> > When using HCI_TIME_STAMP on a 32-bit system with a time64
> > libc, users will interpret the { s32 tv_sec; s32 tv_usec } layout of
> > the kernel as { s64 tv_sec; ... }, which puts complete garbage
> > into the timestamp regardless of whether this code runs before or
> > after y2038. From looking at codesearch.debian.org, I found two
> > users of this: libpcap and hcidump. There are probably others that
> > are not part of Debian.
...
> > 3. Add support for the normal SO_TIMESTAMPNS_NEW sockopt in
> >   HCI, providing timestamps in the unambiguous { long long tv_sec;
> >   long long tv_nsec; } format to user space, and change applications
> >   to use that if supported by the kernel.
>
> I have added SO_TIMESTAMP* to every Bluetooth socket a while back. And that should be used by the majority of the tools. One exception might by hcidump which has been replaced by btmon already anyway.
>
> So I would not bother with HCI_TIME_STAMP fixing. We can do 2) if someone really still wants to use that socket option. However I am under the impression that 3) should be already possible.

Ok, excellent, I had not realized this works already.

I have now also checked
https://github.com/the-tcpdump-group/libpcap/blob/master/pcap-bt-monitor-linux.c
which uses SO_TIMESTAMP and then should work. I guess this is similar
to what btmon does.

For libpcap that leaves
https://github.com/the-tcpdump-group/libpcap/blob/master/pcap-bt-linux.c#L358

which needs a fairly simply fix on 32-bit architectures to copy the
two 32-bit fields
into the longer pkth.ts fields individually rather than using a memcpy.
I've added Guy Harris to Cc, he seems to be the maintainer for this file
according to the git history.

The same change is needed for
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/hcidump.c#n233
if there are any remaining users. I can send you a patch if you want.

        Arnd
