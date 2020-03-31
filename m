Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92F02071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgCaPOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:14:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgCaPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:14:35 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MVMNF-1jjvry48xT-00SMaS for <linux-kernel@vger.kernel.org>; Tue, 31 Mar
 2020 17:14:34 +0200
Received: by mail-qv1-f47.google.com with SMTP id ca9so11008120qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:14:33 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0iyAGQuLkx4eOLJpI6knGcmDUfm/cMbo32dnT/xdJmJPbxojMj
        pFdyNqBcC2nBt2MWJo7MutSnW2XNc7ISVWabg3c=
X-Google-Smtp-Source: ADFU+vtTtXExWagKN6fS5j5yvDDyyCE4ZLiUO7VBKSTqzOXDQQPyix7FtQaVbGVOLp5dhnbRWBA6qiR5PaNOWFkiOk8=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr17309984qva.222.1585667672757;
 Tue, 31 Mar 2020 08:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr>
 <50d0ce1a96fa978cd0dfabde30cf75d23691622a.1585640942.git.christophe.leroy@c-s.fr>
In-Reply-To: <50d0ce1a96fa978cd0dfabde30cf75d23691622a.1585640942.git.christophe.leroy@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Mar 2020 17:14:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com>
Message-ID: <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] powerpc/platforms: Move files from 4xx to 44x
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nHhIWP8qjwD85qW+WedtAa0znCYJE+D1ll3QmuaR0ITO4RcyNd1
 6V8V3+xtMgMVP0qddd8vHMcAG2bVvtfOMjmBSg6h25S/ubQOyq5pNQC8VzAvmnHawhWyvKj
 1J0D87UzJyB6XOZWsbN0iRdUz8TX05c0Ts04ZA07iS4WwK/6iG2J3S8kTmsDRfoGYw68AkL
 5e6I2t8L++RatG9Bg7GPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tPl1QdLDuKA=:0+cGPotFVq4g6HDH8OWCIK
 ooxmF6ltXlh80uAikmimxhopPHnDZn0FrNuslI4TI3/RxJHpm5gQvalppsFBqU5HUUOgYFhEa
 XiPLH5OCNydzq5Gx+mrRrcGH20Es9JzMuy5tStD+KVDrB+llks9ivlhTqVtTAJx0eWojls37T
 zABqPZSDtAX0jbQdOEMSD6BVVYuQ6GwORueJQNXOq7iCAhjzK3ArxJHbGfUzPDjO3Wr5Qr+Gz
 /+EJ6EpDFYsxT1Skc6vzJUVSxPM1CU7oDZgyRjsEMVuqiSwKyIcw8zDP94U0aqQYTIohcKcCg
 IY0kLKc/uQ9kIu98eJndV80oFN7HbeCvNThdExs5AU7OKP9JNw0D+iUbrWT4h7cWWG5iF60pZ
 kIWuuawOEY1fCzPW35biOX69SilsauC7tdsG3KFfmytMNJtdvbh5yOpvFiXlivV2rRCSzm7BU
 XhU3g/ZRdonpp10AmEzoY4WBu1/nOP006QDIOTS4ZdupxfM0tPTP8qSZNZJHclQkjd/OErvxx
 FYeOqmRE+lCafUg/BJVwd8pzINNo+PdN/rak0jyZIOALOW9b89uuvIcSmg88uhxjcKMNZFvgv
 EK1rq+cv/N0xN5PWYHKd7f9Ie3dgdP6okkp07cz5nkfw9JjAnybGt0rW+cB/REPSoq9tGCLhd
 vFmqDolWzapevQMf2SM82SiymBywOAcjOXK3HUfCtSdMVz61IG/dlReO7X3pCaJU4RdUmfJ+Z
 ZOqMa9JesNeSVq5rdfrZc+a4YWnjUhiXFey6Fnik/eT27hI/5o/RK2t6nSF7fx4EwvdfCpCue
 XgVF6en/nr9ULTWKlpYQ3K3tM/T88kAiHBLjy8Hed8UC3z/5ac=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 9:49 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Only 44x uses 4xx now, so only keep one directory.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/platforms/44x/Makefile           |  9 +++++++-
>  arch/powerpc/platforms/{4xx => 44x}/cpm.c     |  0

No objections to moving everything into one place, but I wonder if the
combined name should be 4xx instead of 44x, given that 44x currently
include 46x and 47x. OTOH your approach has the advantage of
moving fewer files.

       Arnd
