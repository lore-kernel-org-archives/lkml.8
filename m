Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F532C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBBD20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSx0giQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFAOJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:09:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48145C05BD43;
        Mon,  1 Jun 2020 07:09:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k22so7723294qtm.6;
        Mon, 01 Jun 2020 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fbZdYm4tTM0Wf8wHGSlW2NhyIxRchTNsSSc7i/vJwUY=;
        b=kSx0giQCmk8jKz9zLHENY9L49nkWaOdhf+miZFc4fUnYnH7yS+vGn2/UTMyAtN0saj
         Tttps9HZ5cPkvO6Bp3q0M1JMTVSHO/b7dPGrON3WScYc42ArduTtXxavwG2byBagNkyS
         uZnAeV9585cA4t/2Qmm92YBK/7TrZzb7LRxbIYIms66qvQ/5NearRkjNwbxF0SfKoyQ6
         dnfNen+c0Y+/0Vv8AK04BshId5yeqj+4zxYRQ/wfvMDTi6leZvlxQ90wJYne/qfy4ooP
         0u0jHEf8Zo85zsMRwArtNNk3iDF73CPaNSlUbNqFxaXMmC5zvH+0WITyHmP2bbf4JkYS
         MeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fbZdYm4tTM0Wf8wHGSlW2NhyIxRchTNsSSc7i/vJwUY=;
        b=MdRdm8cuODrYcE2dFlXABkLNjLV0LRnZ4iIr2sSzP7b7vReVIZJkrBOgI9lUdKiIGU
         Ni36qWv99tDtMz89rwSPt9jL3j1ASMSwK64qrp55PwSYf1eBY1EnwkbDT+O+bH8P9T+f
         1vcQGgApSVKte4bgDljm3oyXhSwkT3AaRj+b6s5ZINwgCQPvQTX8qIBFYFVm3FHDi53u
         4BMB8DacTRHM37wOuXE67JfEg7vruW6//P/23qy2n59mmJkWyU62kmcnW5KeOnC1AxtF
         CJJwv6YdoKw2eAilJ7C8Su4KhbHY8c9CIdke/XwVEz90UbI0v/1XqxGwF0+LYW6YXoAc
         naIA==
X-Gm-Message-State: AOAM530LEeNk51+VeHI2yP8lesyoAHWu9VZGjzM9KIyz51sl0mZ3u0oH
        LwAGk0NGiuryfuIjLfC8SB6PWBRtcYj0dFCXttQ=
X-Google-Smtp-Source: ABdhPJwGW2ZENsU+eUl90VzY2ukI4PYEvzXgVI2JyhW55CHCb4hCQO0fv4p5gwypjw2JD23oGBIulQwZc2NO51VKkdk=
X-Received: by 2002:aed:2ca5:: with SMTP id g34mr6557125qtd.13.1591020593557;
 Mon, 01 Jun 2020 07:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de> <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
 <4fe27809-552e-ea98-ba1f-cbf68e625d22@web.de>
In-Reply-To: <4fe27809-552e-ea98-ba1f-cbf68e625d22@web.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 1 Jun 2020 16:09:42 +0200
Message-ID: <CAFLxGvzS+o0Q2w1at8aJkhJ6BAcemL_LO9rrOT0O-TKewB0gYw@mail.gmail.com>
Subject: Re: [1/2] ubifs: Fix potential memory leaks while iterating entries
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 4:00 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> >> I suggest to avoid the specification of duplicate function calls
> >> (also for the desired exception handling).
> >> Will it be helpful to add a few jump targets?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/coding-style.rst?id=3D3d77e6a8804abcc0504c904bd6e5c=
df3a5cf8162#n455
> > I've thought about using "goto err_tag_2" in kill_xattrs code block to =
release prev xent,
>
> I propose to choose better labels.
>
>
> > but later it needs to jump to 'out_release tag=E2=80=98 for releasing p=
reviously requested memory,
> > which can clutter the code.
>
> Would you like to reconsider this view?
>
>
> > It seems that two consecutive 'goto tags' will make the code less reada=
ble.
>
> How do you think about to try another software adjustment out in such a d=
esign direction?
>
>
> Can it make sense to combine changes together with the update step
> =E2=80=9Cubifs: dent: Fix some potential memory leaks while iterating ent=
ries=E2=80=9D
> into a single patch?
> https://lore.kernel.org/linux-mtd/20200601091037.3794172-2-chengzhihao1@h=
uawei.com/
> https://lore.kernel.org/patchwork/patch/1250456/

No. Please stop this kind of bikeshedding.
Zhihao, feel free to ignore all "advice" given by Markus Elfring.

--=20
Thanks,
//richard
