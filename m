Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CFEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF7621897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5lhRJB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGNIWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgGNIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:22:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3728C061755;
        Tue, 14 Jul 2020 01:22:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so1177977pjt.0;
        Tue, 14 Jul 2020 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxT+xVg1iEE+TdiS6PzOnTuOQmCXGShz9BDeI/0k6RI=;
        b=X5lhRJB59sgnqNf0zVexBgPh36/YV37c5fAfH/uEasMqURC7Cjb1qQQTGbU8+Vf4ya
         SLBFKjBg8XYlaOjhYH1IBYHyDq523T8IWXb3MUtHun54j87VOyJHJ0+QBU7wCW2yffCj
         jFUG20LunyablP3sh3UHL73xW+KI6skpUGIfD7wmU8amILZ2rToGcGRzJSwISDchE57W
         eHU2t0i+DPDWXAj6+XryYf5KXM5xWezs4D/MMgWqnSEA0IXp55+ZIYykU7mRsooxSz1S
         A0T/sw/PpP4rBfbLcFpEXcmi0GCG2abk/gW2aDyp+yGqUAiXILda4+7go4Bw8eb/MBFP
         vxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxT+xVg1iEE+TdiS6PzOnTuOQmCXGShz9BDeI/0k6RI=;
        b=RzUoxMgDG1O9iLq0Sa180MGgq2VAsz91cKbn0psoiOf0HqQWl3Mfc8uTuo6Ij2tSKj
         WaaUkMFCKUMsA1FdcGEMmI7kq0ECGKVjEkCOBHOXwbdxM681ttycUaeWYvo19pH4HExc
         +dDYSgxiTTC2wOSG8lSBhiPDkkM/q6YmcOZZ/qwTylyCFl5FEOVxhEU3/8Fwys3SvB5V
         DRFXIBNvd3QIKkIjVKl8plpcTMPcqsQ8z4c0325/ISD/2xcQmdD+sjxTjTnN5H+GR2Uh
         HrP314DvlUGryG9HLUqE42twwrEH2BJbraxAlE7CCDh4WLzMNExxz5tM5H9ZfLYb0axD
         2ovA==
X-Gm-Message-State: AOAM530ukV97U57Icku2IZJatj4oLIqG6aihymRcUA8+GlhOj992FCkv
        z6Z1fpugTLly9FbBkreeZxix9ueFkEfeizqmGR0=
X-Google-Smtp-Source: ABdhPJyJXVM7MeA3GmA+gb8Y/IKCddN/vz262hxa8lU5yf5tdOl+VJnVXqo/AabFiUCqcD9seS0VkBVvrXA45nivY9U=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr3099798pll.18.1594714925385;
 Tue, 14 Jul 2020 01:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200714081510.6070-1-hdegoede@redhat.com>
In-Reply-To: <20200714081510.6070-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jul 2020 11:21:48 +0300
Message-ID: <CAHp75Vd6uGNw5m3-Tc1tkABLT_Wi7CtW2yo8+B5TpYV4U8XE9A@mail.gmail.com>
Subject: Re: [PATCH 5.8 regression fix] platform/x86: thinkpad_acpi: Revert:
 Use strndup_user() in dispatch_proc_write()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:15 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user()
> in dispatch_proc_write()") cleaned up dispatch_proc_write() by replacing
> the code to copy the passed in data from userspae with strndup_user().

user space

> But strndup_user() expects a 0 terminated input buffer and the buffer
> passed to dispatch_proc_write() is NOT 0 terminated.
>
> So this change leads to strndup_user() copying some extra random bytes
> from userspace till it hits a 0 byte.
>
> This commit reverts the change to use strndup_user() fixing the
> buffer being passed to the ibm_struct.write() call back containing extra
> junk at the end.

Can we simply use memdup_user()?
And thanks for catching this up!

-- 
With Best Regards,
Andy Shevchenko
