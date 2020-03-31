Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3626C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB51C20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCaSiz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:38:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgCaSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:38:53 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MIxBa-1jceow0gdm-00KRBo for <linux-kernel@vger.kernel.org>; Tue, 31 Mar
 2020 20:38:52 +0200
Received: by mail-qv1-f46.google.com with SMTP id bp12so7417514qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:38:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0tbmbAIJOt3BD5pbtSwx9MkZibq02wQ9VFN0H1ndFO9MbWSAKe
        Rp5JqslkzbX4zKXbHhzCAOUTptOhMpmlGAsVWR8=
X-Google-Smtp-Source: ADFU+vuTGFGpCxNIh+cobymgdpMJ4evVMQiQmSWM3uw7oyUk1XxgrJtQG+HV5AiOi7nmMntLNw37psCO8HP1MAfYp7o=
X-Received: by 2002:a0c:f647:: with SMTP id s7mr18334119qvm.4.1585679931041;
 Tue, 31 Mar 2020 11:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr>
 <50d0ce1a96fa978cd0dfabde30cf75d23691622a.1585640942.git.christophe.leroy@c-s.fr>
 <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com>
 <833d63fe-3b94-a3be-1abb-a629386aa0dd@c-s.fr> <CAK8P3a244P38c+JCRnf1EscQOSzaQQNZc6b5F=LFE2a_im8AqQ@mail.gmail.com>
 <74e76b4e-5e4f-f3de-96a8-f6a451b3243a@c-s.fr>
In-Reply-To: <74e76b4e-5e4f-f3de-96a8-f6a451b3243a@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Mar 2020 20:38:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1jM8W72iH0qmMLRBRsv8ANYdL0xro0iWty3FvM6HTd0A@mail.gmail.com>
Message-ID: <CAK8P3a1jM8W72iH0qmMLRBRsv8ANYdL0xro0iWty3FvM6HTd0A@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] powerpc/platforms: Move files from 4xx to 44x
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:T7JWZ/SrY725G9NuCQvDKkK2WnO7EVVEYP7XBHUazcx7PU310HL
 kwfFf3Zp8xVXVUT99DuL1vxQs5fLjjHtErwUplDqIjFBQ+tyISw/EBH/ALX7Cbe1+0B5Be7
 mRKg5X2jT0Qo9RmGNFxXYA9vl76DnaSMiy984g2wVDI/pHQPw4hA3o0fbo3ua5G3E0NFT1P
 VJceP2KZASxegqQKyZ8gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYlOC/DahJk=:uNYfcZDk8JgPHTauOyFLTX
 QqkdyIy3q6nPdd7Osa+aj6sT/3XdP2OyEv6kP6SsJPXmdN21Vx9B4l+AOHzC5ResMjDUeYOrs
 h1ULjClDIdqvazAyGUpCqPbkqwNK6gANew7rGB5WSui62/pkNKJn/an6U7R4Zi1QlreH1c+kf
 I5cbiY6gnslGn1VNkn4Gp9OZDTkEqDXe/IltdoLVIEhuL/DpaKU9FExrlKlaaEX0uRpo2xif0
 FgvgZ0lZOi2TllqiS9yMzxIv5ADVqr2BfnRK/EKEAswJ0zhnQDp0AcER8hUycZlsrPUJNDALK
 cjxla8a0/mHK2zhqnfuzGWO9myDnfIQeFVldPm8pT0tKvkMcgmZL9HxctntkRNwoTA8YJZ760
 JAX5+J7IXuBgxv2LnreZ/lSkOGZDLcTZlhd/cmVivEmcG1U2CyYTIf0kW4fj7CZO5RbKsb8QZ
 TVccRVGzgvtHkx81FcOR9QyHTqcehRTaBXcxDiNU4HNmUZCB9eQm0t0ZOquzZesCtCXN0+uER
 G1bd3mPe+7dSDWj8uz544YGPCmoS74Q0MCVFOZn5J5UbPjTZ1o5NFmnL3FBDEWxTlmeNiC6In
 O+rxQKCIGaq55oqXUbndjxei/3ZqJa4hJLkErysmFzxABlPSuW7s44LkbaAxY3RWl529fmHQ1
 3O4JWZe6FkCN8Qe5GbxaVEV6Dfapm4DU55n04wrUS5p0WmLLowUcYadqBvKKmFy5ONp6WvjYC
 DzeyGA4WSWsnZj8Stxbs9VIvLrJUxixt7nhzVRg8foso74HKo82eMd486Pn3fYwchQs2BDo6J
 mfA7b8YHYFbmZ48jGGtVfZyO8P+pgjQX8BjOQ65S7a8d70sUvs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 6:19 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 31/03/2020 à 18:04, Arnd Bergmann a écrit :
> > That has the risk of breaking user's defconfig files, but given the
> > small number of users, it may be nicer for consistency. In either
> > case, the two symbols should probably hang around as synonyms,
> > the question is just which one is user visible.
> >
>
> Not sure it is a good idea to keep two synonyms. In the past we made our
> best to remove synonyms (We had CONFIG_8xx and CONFIG_PPC_8xx being
> synonyms, we had CONFIG_6xx and CONFIG_BOOK3S_32 and
> CONFIG_PPC_STD_MMU_32 being synonyms).
> I think it is a lot cleaner when we can avoid synonyms.

Ok, fair enough.

> By the way I already dropped CONFIG_4xx in previous patch (8/11). It was
> not many 4xx changed to 44x. It would be a lot more in the other way
> round I'm afraid.

Right. Maybe stay with 44x for both then (as in your current patches), as it
means changing less in a part of the code that has few users anyway.

      Arnd
