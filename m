Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC237C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F562137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbgCaQE3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:04:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgCaQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:04:26 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MALql-1jTRSd3xkp-00BrdT for <linux-kernel@vger.kernel.org>; Tue, 31 Mar
 2020 18:04:25 +0200
Received: by mail-qt1-f176.google.com with SMTP id i3so18735962qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:04:24 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0ZW6WE9aOIDvedDgWazgcy1lTeMG+o8/HVz0I/Gh0b4MSQxt6p
        nEizwzjuZv4+X4HgFLSw/PugzfDsuyn9dlE5LeA=
X-Google-Smtp-Source: ADFU+vsV7OUw/yG7jiZrXNFRLm1eXbesdhE6Gt+5x4dwrPNxojl+8IV+jXHl3G0MV03Bhz5TSjaj1rNqxNpqeElwkyI=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr5691505qtb.142.1585670663815;
 Tue, 31 Mar 2020 09:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr>
 <50d0ce1a96fa978cd0dfabde30cf75d23691622a.1585640942.git.christophe.leroy@c-s.fr>
 <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com> <833d63fe-3b94-a3be-1abb-a629386aa0dd@c-s.fr>
In-Reply-To: <833d63fe-3b94-a3be-1abb-a629386aa0dd@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Mar 2020 18:04:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a244P38c+JCRnf1EscQOSzaQQNZc6b5F=LFE2a_im8AqQ@mail.gmail.com>
Message-ID: <CAK8P3a244P38c+JCRnf1EscQOSzaQQNZc6b5F=LFE2a_im8AqQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] powerpc/platforms: Move files from 4xx to 44x
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:wXb/7BkaxMjzCjUbnx6uHrIPLA9gNqpAmb7B3y1ftL5qH0GeGAm
 lasEOHdiEIxVPUYAPfqTmxlFMT22xpp8vFaUDyQxEtF7kYaM6mMLYMEYLCLFvPpmrwkDFWO
 60wSSrD56d32owwZnIMc1dsLDX99YZ0/spl+eqQ48FULsrmYRbpQ1rmGrXW2G2kHkQoNPyp
 7F9NpeytrYCl61vv/uVNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ni0uznTSXUQ=:uraL2y1f9eNK1mUfyzJ+N0
 eCQAM/Xvk4gcDB/G8+wwa2Z9GKKHxkWQXNuKuCWw0y7l019PBUMqSV1y8Z8u6tHelANNI+Vj5
 u/pWiFbHmArYup3keIZX18aKY00KnAsOprBPhzte5wy9hrz7GCm0lM52VXeN+IfifNhd/iWX/
 t1FNxvieSv+d1z6NmVH16dLBJHlVq7QcZxoalROF9NeRY11btCX0nOW5sQaOo9gh4bvfuRHzo
 xIckrvKreNYcoqURd5AwkiXfC2ySTbSOJVdKEzWsmCVFTRlHl8ToT3JioW2+KVr+fuxBQGYxb
 SdGlfuKSQxJKkMjq04TmdruDzRgf6zylfYf0YpAgdfvKi0daXDWF313PZ/lFSuj/4Erx81me5
 cq5Zh0x2Bfikv6WM4HuP1PQbPpPTrgQWTLNckXTO4EXMctCnL5OblvKM5JDMivAM87EoVYLKN
 NgjoGLZoSW2Vs+zaEVgsYijOobTuqCwvxB13RoJxMwf7zUO8TKVIZS7wuPmVGQapzZBp1JDZp
 A5ZekrIfdcXgVmfMxI+QWSP5OSwI/wzkVG+mk+HbCYEAXTEnHqCCxivTZEGzxaGXcGWS8YrZ2
 tbfUkZ/MCJBIZHI6U7b3x7TEue9CqJgpc29D5JM+tsXOsoI3CcfkCgISkVCfBooBwCRYltMMH
 zZeJOckgbk6JiRFgs31LmISL6UYcg0zOpIbOEEVf2smNT0WU8gZLH1z+9OI8YuEJb4tQcAoU3
 euHeEwkH/uibNG9VDquLfVWXP9QHKy4R9f/1nDMk9nfF4tAE/fTBx7frHOpL1sDCvYEk828qx
 4lw45Ofd3i7CRoCxtGNI0WrwjWac5yx2IsMi/Eij2cJ+HWs1/0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 5:26 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 31/03/2020 à 17:14, Arnd Bergmann a écrit :
> > On Tue, Mar 31, 2020 at 9:49 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >> Only 44x uses 4xx now, so only keep one directory.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   arch/powerpc/platforms/44x/Makefile           |  9 +++++++-
> >>   arch/powerpc/platforms/{4xx => 44x}/cpm.c     |  0
> >
> > No objections to moving everything into one place, but I wonder if the
> > combined name should be 4xx instead of 44x, given that 44x currently
> > include 46x and 47x. OTOH your approach has the advantage of
> > moving fewer files.
> >
>
> In that case, should we also rename CONFIG_44x to CONFIG_4xx ?

That has the risk of breaking user's defconfig files, but given the
small number of users, it may be nicer for consistency. In either
case, the two symbols should probably hang around as synonyms,
the question is just which one is user visible.

       Arnd
