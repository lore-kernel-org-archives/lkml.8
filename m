Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349E720722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXqfYEcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENLgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:36:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D487C061A0C;
        Thu, 14 May 2020 04:36:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so2319316lfb.8;
        Thu, 14 May 2020 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGigY40HNC0vIIg2KqrMRVX3IHwlm3zXsKb7MGlt1hE=;
        b=eXqfYEcGXhSVo+xqDDZGlPliR281ArKBPClCeLdkTj649PZFDo0KHiPpfLyMmVbOBB
         W2dQj8QZV3a6sYqgDyggORuRFa2RhWt1VedY9tRCcV24BFp8iju+JKwPzuGw6SgkGFC0
         FYPhLZ6d8dJ+0ed1Vz+EjiCppgbgkPvQfwCnMiB40rE6yA+etGnSDSnR6RU+3PAGxAh5
         MvmFq7mAeqKUD2LF/opZd7OUV514O06q53xXl0CwM4GzprAzGiDbIxZ6DqwMs413pFzx
         MuL+s1EkiJla5d5R2yYkmTaEinqAnkxMNWo8Fuzb2uONO5X4z+d3Ctw0upZYvWtCu4pG
         BEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGigY40HNC0vIIg2KqrMRVX3IHwlm3zXsKb7MGlt1hE=;
        b=aE/+sjiXbER8X7oh3vtRZ3oc+W5YM9kIoyCx5Uo3IqvgMuZ7yH1vV1edpglynp98mC
         dPrdfBW9Gi0JVvHvegv1/f9fpyTK0/pB3r6/VZyVH3XgC0+LwuVNned+dFyfa5NTDs45
         1uUnQ2uNmv3GokyxmDrNcYForzgghNL/p26lQZXLPc9bA0NciIp3s9B9y6bjlV3x0vq9
         61lhLTY1ptidX+N9Ms440ohbTaSictFJchlX/fsu3TUqADBTZpUkOvLbkLunL4nWGE/d
         UR6zLya7IDDEoCaY+1Om/JJpZPmmjK3H8NkQXZDe/L3zJiibKFb0QFWF71idU0KeteN9
         MMPw==
X-Gm-Message-State: AOAM533Nw8IakXS2KUQ63uPaT4VIfYRmRccRl+wwxP4A12A8X3ncOHRm
        wXgzyvLF1Wg/gj5n4HY13Wrm+1K4nCrhiqdS8pG5Rw==
X-Google-Smtp-Source: ABdhPJxBmTa1h8WlktzqD3pLbVyqrx3p3qFiTuM+yFXGEoO7RIjFXQifYAYsXge406O6IyIPcO5/3UB23gV5x4p5eQM=
X-Received: by 2002:ac2:5e9c:: with SMTP id b28mr3067625lfq.50.1589456210950;
 Thu, 14 May 2020 04:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200514113003.19067-1-geert@linux-m68k.org>
In-Reply-To: <20200514113003.19067-1-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 May 2020 13:36:39 +0200
Message-ID: <CANiq72=tpSaYkZHf9ip0A1Lhip+B4rWPf-fCJorq7oigaVe98Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: auxdisplay: hd44780: Convert to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, May 14, 2020 at 1:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Convert the Hitachi HD44780 Character LCD Controller Device Tree binding
> documentation to json-schema.

Do you usually take these ones or should I?

Cheers,
Miguel
