Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2807FC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0387420836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+ZT+oVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgEAQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbgEAQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:56:29 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D1C061A0C;
        Fri,  1 May 2020 09:56:28 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 1so6630369vsl.9;
        Fri, 01 May 2020 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnSnMv8XzmfxgR0vO6m5ur1+/cJdg2NiZ0ZLBo2dLag=;
        b=U+ZT+oVZn5PeeGbL8HgwsYh978Ogq1KjKGD2pSFgOpkDX3foYRdIiaQN0l3DgvNeSg
         4puZ1YF8Ka33KoUlY161JoGdrXXYsclYcVchPE6MLtsUF9T41KfR8UcGgBtm+yZ58Ymb
         sN3Cvc1vtx5jdZSjqQuUR4CHkaIZPFSkS/n97O3MPMSByuRb7d9CzedGyIRitTU6SLjQ
         X56IG2+397mjNEuhhv+WJgsHOh3o7uL/b6Hb8b2JroZqP+VCDUZx6X61yCrR9mvlk0av
         PYYvRrgG7GLj6oaRcb8J4VnkNDqYkVjHIAysR3vqV5wliLW1pcSz5jOBx9jIP749ba0r
         g5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnSnMv8XzmfxgR0vO6m5ur1+/cJdg2NiZ0ZLBo2dLag=;
        b=G8wT5UtArk1/MTVcAkATcdtCIwqDj80SJffEM0VBc1ypuWUxucJMLHnu4l7sp+C5Nu
         tPt2qylG0v1Py+YGesnnuJHzZ+of3VPEtLZtegPqm2T0TZdkh0Etgmj2UlX8BLSEHI8p
         md0tYhBHUZbJucirH8fdQ/17FAeut/mvmaDt43ArEwcUMdFjvEUmgvRgRmiUKON+vHNO
         vpoNBeJDcYszP4BgrPzppvKIMnLog4puA3VIOnQOat+y7Vui3tJr4wBIlXjtFGUvhSXT
         gqj4zAy7GyXmUzNobh7m0jR7MoWPEHxZnlEuCfSlF21YDp0fcDQWxbmBEg2H/uOAX+J1
         A+nA==
X-Gm-Message-State: AGi0PuYMBkpIkWDpw1LBBZu0OlrDknmPB88FYkq48g3U0H/kqc3YVTIq
        B4RaMoLAD6WwvGEyEBLrEt6rmeh7Lar4g4c8yx3iBNNW
X-Google-Smtp-Source: APiQypLX+MNk2MVsI90CjjX+XQgqi69d/zhYAFCmA4/I/aageL0f1auEd0W3hC9qQSVN2zR/r+kMScRCKk6jrVMtWt0=
X-Received: by 2002:a67:7913:: with SMTP id u19mr4045503vsc.6.1588352187352;
 Fri, 01 May 2020 09:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200430080619.67ff0ac0@canb.auug.org.au>
In-Reply-To: <20200430080619.67ff0ac0@canb.auug.org.au>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Fri, 1 May 2020 09:56:15 -0700
Message-ID: <CANRwn3QB+3DH94rzm24H8kCqmbwZr7p1XUdMK81tBFEnpvRSzw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the hid tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies. I copied the wrong commit SHA when generating this
commit. Commit cd47de45b855 is the reference to this commit in our
input-wacom tree, not upstream. The correct Fixes tag should indeed
be:

Fixes: 912c6aa67ad4 ("HID: wacom: Add 2nd gen Intuos Pro Small support")

Thanks,
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

On Wed, Apr 29, 2020 at 3:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>
> Hi all,
>
> In commit
>
>   dcce8ef8f70a ("HID: wacom: Report 2nd-gen Intuos Pro S center button st=
atus over BT")
>
> Fixes tag
>
>   Fixes: cd47de45b855 ("HID: wacom: Add 2nd gen Intuos Pro Small support"=
)
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 912c6aa67ad4 ("HID: wacom: Add 2nd gen Intuos Pro Small support")
>
> --
> Cheers,
> Stephen Rothwell
