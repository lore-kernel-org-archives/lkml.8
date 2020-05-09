Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81393C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E3F21655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq5p3UF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEIMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727093AbgEIMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:23:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9FC061A0C;
        Sat,  9 May 2020 05:23:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so2403879pfg.2;
        Sat, 09 May 2020 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9nGXvXgrNS56zXO8bat5R+2UCFKhX5QA74VIRKnHNI=;
        b=oq5p3UF2zs0jcXfOfUPKq/U/KhevtgvJhyk/dDuAfmZd7GKZRvRhFgZNixhooh0J2q
         htSsTD1sMOUWsZAMDv6QzOD/eUg/rOn1UxRUIZVRebnp/RGdUmdSpDNmUqCxDVVqucCF
         AQn2uhMwySz1Hm2mmu+aCOpVqAi+AnGKEM18BmUj9abu8MAiwCpZkPQnphoLpHN8RYpI
         C1t03sL/kOK8toJ2YEZMVtLAoRfVvCZ+6TbORJvQyA4vcP5H5WmW3JyKtjEc35+Ijtk/
         Cqw5ybv0wwUgztjPa5vJH2gqDti8hXeOSN2Jo7YdXBR2aFnDTF3un4ZIDzL2LvmSRY4O
         6OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9nGXvXgrNS56zXO8bat5R+2UCFKhX5QA74VIRKnHNI=;
        b=NfvOP26qmf/RuDU/RG9TqMC4AIQuUWBS8fhteEEiL6jg7saTFV/YNX3z3e7Cn6pShA
         0tPQCrDllbaJbcya34uDHn65XJVzml3BZsKA2dKlZ793/cA9A/FHQm/EdMy0WFhzb82s
         OuGDmN8ONWSXS0LOIMabpJzo9HNOUTGQ83cbkXbHWQC/lMGEfpu+iq/qx/Vbb/Q8AE7X
         DKzBXoT1+hODf3xeBMQtaOG+2FIWAl61Zcsm6bjRfy4tVLpXj4rOB+DChCGzj/nb5U7O
         NVe4zmZnxS+PcpMlsduMIBwYMood+uVbgMkAKIHv/w4IX3jhZX3RRZj7KcNSC+y/vyvT
         Lmmg==
X-Gm-Message-State: AGi0PubZUfcuAjTMu5gVm+DsqXH4o5lZRIrWRTof1ygUwLo1C5BglpXU
        va1WOO0rf5ZrZ8zxlV+XoSgdWthnCauDhe711w4XnnNN
X-Google-Smtp-Source: APiQypL6ltbDW5mESRhWl0bTWVs4myy1cJQ6TxtFw3YE+M8+ei/9qg04f8qoBLqbNozeGWSjzOixWD6jCepbOljikSY=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr6385452pgb.203.1589027007357;
 Sat, 09 May 2020 05:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220559.99726-1-hdegoede@redhat.com> <bcb4d40a-8971-22d6-959b-14b2d329cfd4@redhat.com>
 <CAHp75Vceqb4tpM_G7hcg2RWF6Cp+P61NiiYfQsf9tr8vtFJGHg@mail.gmail.com>
In-Reply-To: <CAHp75Vceqb4tpM_G7hcg2RWF6Cp+P61NiiYfQsf9tr8vtFJGHg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 May 2020 15:23:16 +0300
Message-ID: <CAHp75VdTuwyJuGsAR4NwJm302Va+68dDdtC-kn3581asg-onvQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 11:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 10:54 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 4/23/20 12:05 AM, Hans de Goede wrote:
>
> > Andy, Darren, I see that you have already added this to the for-next
> > branch of linux-platform-drivers-x86. I'm not sure what your vision
> > on forced pushed there is. If forced pushes are ok, please drop this
> > patch. If not let me know and I will send out a revert.
>
> Forced pushes are not okay, but we have exceptions in some cases.
> It would be done here, but there are complications, i.e. we have
> already immutable branch merged from MFD. Of course, I would remerge
> it again, but I think we better not to do this right now, so, revert
> seems a less painful in this case. Or, if you have already done
> something better, than keep it as follow up improvement rather than
> pure revert.

Oops, it seems I was quick enough to push this to v5.7-rc4. So, please
send revert!

-- 
With Best Regards,
Andy Shevchenko
