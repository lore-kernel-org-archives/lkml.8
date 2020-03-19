Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3625620786
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZCx6sdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCSUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:24:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33736 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:24:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so2777724lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvQkY59qXbqmh2jA/0FCgGEES29MX9NxM3v9QbCaiJg=;
        b=BZCx6sdMC/lZySAftdRcfeiiSq2uZA9YVpplNcpG2p8J9RhJnbGmiUdzWYXMmfV1pt
         qRp5YBrSnlyF9mvpiq75rGA2Teb1lRawyJ+HHOPY9yq0q29xhakmwe+xEq4Izg4v9vsZ
         ilCqAnpC4TIwbvbJyaI81jwVNVrb1D6HsAIrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvQkY59qXbqmh2jA/0FCgGEES29MX9NxM3v9QbCaiJg=;
        b=alk6x9jRIMNo5AUw8kQ8+NaFAsfDmVZ6tsziAelW4QRhNoMlcRJquoFxWJhhpl35qQ
         vw/Hf0xuIlYtqIevJTDY9fCFlNymppq86bAVjsUqKcRUbXZhfbCmYi/lKDT7T+c9rUH8
         A9Tt5ukzSJSw/+a21+qbzXyVtMmO5vjJJkZoMdrObEyUZY5NMe2fsfQ6yAZC3O4+nj1J
         uNzv153if/NIYy0KR7AEIJ8L29dQB01FklN1qVXF4T3XfLsozjqyhA3QB23OlJ6vefL5
         zt+mRahTcibs4jnrBgSlvryRJ8mVQnlUocf25GppZD182pD7wLvFApaHgbqcWh4KfJaz
         PGaA==
X-Gm-Message-State: ANhLgQ1XQ+/snv2JmnOhD09o43RQk+HkznD4qyHQB6CbbC+oy7X8OhgR
        zGc//aIPGKSnHVw7aVzlZU7EICN8FwE=
X-Google-Smtp-Source: ADFU+vsS5OP1cgQgmqNU1iapEgXJBMTtCE95/W22IkMoNpjeQ/+dLshrgWeMyF+gDmbhyp0vVtIDgg==
X-Received: by 2002:a19:6e0f:: with SMTP id j15mr3172145lfc.76.1584649490626;
        Thu, 19 Mar 2020 13:24:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f8sm2115514ljc.86.2020.03.19.13.24.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 13:24:50 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id s1so2763918lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 13:24:49 -0700 (PDT)
X-Received: by 2002:a19:c748:: with SMTP id x69mr3099253lff.196.1584649489074;
 Thu, 19 Mar 2020 13:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
In-Reply-To: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 19 Mar 2020 13:24:12 -0700
X-Gmail-Original-Message-ID: <CAE=gft4Vx8tD71TXFD++hMLiExBWDNXn7LA6ohkGLwZvG2N6YQ@mail.gmail.com>
Message-ID: <CAE=gft4Vx8tD71TXFD++hMLiExBWDNXn7LA6ohkGLwZvG2N6YQ@mail.gmail.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     x86@kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:23 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> Hi
>
> I can reproduce the lost MSI interrupt issue on 5.6-rc6 which includes
> the "Plug non-maskable MSI affinity race" patch.
>
> I can see this on a couple platforms, I'm running a script that first generates
> a lot of usb traffic, and then in a busyloop sets irq affinity and turns off
> and on cpus:
>
> for i in 1 3 5 7; do
>         echo "1" > /sys/devices/system/cpu/cpu$i/online
> done
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "A" > "/proc/irq/*/smp_affinity"
> echo "F" > "/proc/irq/*/smp_affinity"
> for i in 1 3 5 7; do
>         echo "0" > /sys/devices/system/cpu/cpu$i/online
> done
>
> I added some very simple debugging but I don't really know what to look for.
> xhci interrupts (122) just stop after a setting msi affinity, it survived many
> similar msi_set_affinity() calls before this.
>
> I'm not that familiar with the inner workings of this, but I'll be happy to
> help out with adding debugging and testing patches.

How quickly are you able to reproduce this when you run your script?
Does reverting Thomas' patch make it repro faster? Can you send the
output of lspci -vvv for the xhci device?

-Evan
