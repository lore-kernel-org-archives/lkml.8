Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60696C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6C2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzzXq+Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTFxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDTFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:53:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85745C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:53:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so10519491wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnAMQjTDH7lLrNULYEV7Ij8ljI9O9hltmkzvqcgr3cY=;
        b=tzzXq+KfTcsdxjq/Lh4slqha3MG717ieAB5DbwSJp5YoQk1A+d7E9pVckvbDvrMhso
         wgiq/bmTArtl5SA1kG7ce4pGuCDHKsVnPCfVIreYBtyAPfcK2hd042R9LddmKBihvpxO
         pEubMKdXy/Fv8R/nb1aFuU5fa83+Ujsk3IJEKBKYQEn+k6bES6YFoIe/C8NbDUAOiJWf
         qRLnxGo13LeyEvGKPYsX6kW7EQJl4WQw4+dpNFj16ihFr7s5HZi3FAApOMQ/dXBGDTRY
         3LlKjVChIlsZsdrdotX88VK0UywP2O83vnqKcHPM2On23XPFAA9APrZHI6Ui3VHxTnAN
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnAMQjTDH7lLrNULYEV7Ij8ljI9O9hltmkzvqcgr3cY=;
        b=dIrB8rJcpZgOwMgt4ezpUXVYzCvnqfF9VDD7qwCuYLdfjtzO2xsBUjeMxh+w3CBzpN
         dLsX1bYG3l7lmG0O8cnotQdBKDhU1z+OKW7D1s1RirLjKMJEvNQ3hcu5jxfPBQDnq7yI
         uG/8GQ88ao3oK8qpulAN9KzazAVnXY8h1EHA3dwOBVcE1j0jS2sWaPwzF8yjLg4OugMT
         wT43kRRBAzSM8MmNfqWWVNehrhfotUJh+TCYqNj6Dt27eeVy+JtaI5KERFoe2IJ+wsZg
         9dE7OmAE6cokTRCquOy1bbYA+gL0QRrLHMouENzMntCUdtiHyAyu3wK6RnAajZ3S0GwF
         SCUg==
X-Gm-Message-State: AGi0PuYxFOiXIAjelEPTjchs2/awc74Zp0pff+mci2SlKHjp6DBeYNQ0
        I9zCeY5pyHxiF4/w7wcwN+Ch+iU5RwYlVe42Ifp0YllbfF4=
X-Google-Smtp-Source: APiQypI3MGbkHlN8kvVjklZaCXXH4FrurgGwKEWAk5YqwZe8sgHddYTQVB3/Z/mNTvYfLfynblgEknQLPOh6HdoH66w=
X-Received: by 2002:a5d:688f:: with SMTP id h15mr17038210wru.352.1587361984334;
 Sun, 19 Apr 2020 22:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com> <20200419165434.GA3697654@kroah.com>
In-Reply-To: <20200419165434.GA3697654@kroah.com>
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
Date:   Mon, 20 Apr 2020 08:52:53 +0300
Message-ID: <CADqhmmdrXa6jrHEa-C2bLurM9DKhVxrQ1TeJdaOkWEA0D16-sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/CPU: Add native CPUID variants returning a single datum
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second patch depends on this commit by Borislav so i included
this, probably I should have just mentioned it in my comment?

On Sun, Apr 19, 2020 at 7:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 19, 2020 at 07:29:42PM +0300, Evalds Iodzevics wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > ... similarly to the cpuid_<reg>() variants.
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Link: http://lkml.kernel.org/r/20170109114147.5082-2-bp@alien8.de
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/include/asm/processor.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
>
> Why are you resending patches from someone else?
