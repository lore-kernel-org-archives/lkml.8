Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12003C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3730206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gidkRD7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFKRV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:21:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56715C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:21:56 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so6139689ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVX9ekaPnYdKFQialmA9pWxtm/sfM+PeP6v8bCSO494=;
        b=gidkRD7SppUfSRmxawkbWK+atX4gklk6gNZn1cuQDWtfeHQZQKD4tNdZxUPmT0Vvcc
         bHX+nkBEw3pyV4jsZ1tTKKTSkQqpkVLbXnXhQbqBR9TWACUPuoWYKlhaAaJJd71W103p
         F13NHG1IOn99hBN5/iVfSPvoMRHW8DmtPtQTwUEvriTtOMxNxyvTZja0FLezXXP8Gfhm
         2npeJE+YpCmWgBR/cibv55+vBJHwvQNbLohd2V/103ncFjmibpTA1FQch4TyrpKN7R9Z
         CjnnYXFZvV+H6wdL8YRtfAfsnTDMfMWu5bg9qNoH2N3ZZYJ25UiwegK/Pnd+NWidA495
         EZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVX9ekaPnYdKFQialmA9pWxtm/sfM+PeP6v8bCSO494=;
        b=V4IVtxhfGNBT29ELPVRFU9tpsNkfU1/rTaN7DRuqlbpiuZua3TSFAi6QRIsyXIsced
         ytZBADz5fhsz3lVBQgLMYdrds7H7JEU4pu1pHpHH8QZoRkWCWjSatU15n3YB/j88IRux
         jRJbvVxiCPF16e0UIZn4AyC5mfWiuwud8xCJPAy6ga/Rlg7eZjcXo5mqwy8A7hZP44EZ
         Mvg59eo5ZQjfu0rb+Zr6nME82Vfl2q9ZM5aTeX7wev/tdEGUmJnM0lr5igEtMyPVxUU0
         +M/V/TM4tXPnOKhxezPHLaIHWSg3CNUB7Hvwe8EeH8Ur1OWRWOTIy+MsDBHBW5gHe6u3
         qNWw==
X-Gm-Message-State: AOAM5319xI7CrbLQzyvqP1ABPOjL7rI+Oyw8PDgEEXYjTEh548KOqz0M
        KzKu0vltD6ZMzvSfkzzr5MDeiZRVGqSk9YcjCbY=
X-Google-Smtp-Source: ABdhPJwMwiPz2AvbaN0QcSizQNaTy9hvAaHkh2ILfrU+TA1r5OXgR+xwRubIIsb1R9nYHi8emoS+8EIYAGrwvMNtAHw=
X-Received: by 2002:a92:5ed3:: with SMTP id f80mr2410327ilg.33.1591896115642;
 Thu, 11 Jun 2020 10:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
 <20200611165612.GA1225679@bogus>
In-Reply-To: <20200611165612.GA1225679@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 11 Jun 2020 12:21:44 -0500
Message-ID: <CABb+yY1B0X-V90oJR_H2_VwbV9T=kLJpF+qnjbmLCwUtteswOw@mail.gmail.com>
Subject: Re: [GIT PULL] Mailbox changes for v5.8
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:56 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 10, 2020 at 11:10:56PM -0500, Jassi Brar wrote:
....
> >
> > Sivaprakash Murugesan (3):
> >       dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
> >       mailbox: qcom: Add clock driver name in apcs mailbox driver data
> >       mailbox: qcom: Add ipq6018 apcs compatible
>
> You've dropped the binding change that breaks 'make dt_binding_check'
> from this PR, but do you intend to drop it from linux-next because it's
> still in today's next?
>
Yes. I had dropped the offending commit at the last moment.

> And really the above commit should not be applied until the binding
> change is, but fine.
>
I made an exception here because I wanted to make as little change to
my PR as necessary. And it wouldn't cause any regression - the new
compat string has already been acked by you.

thanks.
