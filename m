Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EBEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85420842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtZrFgtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCDEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 23:43:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39468 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:43:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so674280wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 20:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okutyK5a8uQZodANWxrUAY3lG9R/jofu3YcVmmvfiXg=;
        b=UtZrFgtjsSVPD97F4GruvTZtyh2VBOeQ4HKg0HP2gH+pqaH90Kj/tqXWvqJVgqLWUI
         A8QRfAJIG0iLFragRxQi4JY75xgzmcKasIin+nANgxxdQj9csad7RLWFPuSK1AkvF8Cl
         77q3rKVMKwuwtHS9sl3wggvbcKpP2CyzlN3pAXHRUeVObFSyVsoXOiWgS+JLlk6mXo+9
         cmIKQD9kIzJ9Mwhfoyu+DawM7UQVpWrrbIoKDQo8Iy7sXz9L14XsI6wu4f6Gfy30+KQB
         pmO1bQOZ2SB4rEEezl777klETr4hsjIYo9hTKe++NOgJdeaTbZSA5WKK/3EhrIpXHv0v
         qUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okutyK5a8uQZodANWxrUAY3lG9R/jofu3YcVmmvfiXg=;
        b=aKDrUCrC6LLOahivcgU0QVUlDFZGrzgHh5+AP7c8WATRdWZZkcui9rWn2iv9h/N1YA
         yvdnRV804+CA1RSFJKbm34qZAyRC84kNKMTYSrRhF4FqxdPYUvg1fL46mKS8H2952xqD
         9iYO5/QvzIJH4fvdKqHaoincLO+Wcj9/X3murVhvggQm4c9DpK0p+Ataaz6yQRuxdWKg
         VIfY5mbYn/qa1Nc8wrImIsB6KfUvHLBFijMj5J4te3tGl5RSbiBwuYBNzaIFvtfaISOB
         qK6GD/xhgK3msI8VXmQ1KaOA3CqkXNBsuLETFGYjnzhN8fd5l5nWhN1HZ3JwI/FCh+AF
         DIYg==
X-Gm-Message-State: ANhLgQ08zxg2Jzdzhn+NSJ6MW1fumlyJvfukDRmwTh57vz8RAtd+xrak
        /RZhYC9CnMRw6FZtyyvAjq+sByAMcBn2Dg6lMXw=
X-Google-Smtp-Source: ADFU+vvM2137kGKlC2DGBWaTikYu6VxUe7kjGnT7T8VaaOObxG+7akabL9DZ6E88BymipWybKPVlnzib9SXjeGFaECk=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr1770087wrv.62.1583297014940;
 Tue, 03 Mar 2020 20:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20200228060439.52749-1-leonardo@linux.ibm.com>
In-Reply-To: <20200228060439.52749-1-leonardo@linux.ibm.com>
From:   Bharata B Rao <bharata.rao@gmail.com>
Date:   Wed, 4 Mar 2020 10:13:23 +0530
Message-ID: <CAGZKiBr=8i11YPDn+1y5j6YfGj+tVbbTKakoGje9QQ8TEw9g5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arbab@linux.ibm.com, ndfont@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:36 AM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> While providing guests, it's desirable to resize it's memory on demand.
>
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
>
> But there is an issue regarding guest reboot:
> If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
> memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
> It usually prevents this memory to be hot-removed from the guest.
>
> It's possible to use device-tree information to fix that behavior, as
> it stores flags for LMB ranges on ibm,dynamic-memory-vN.
> It involves marking each memblock with the correct flags as hotpluggable
> memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
> 'movable_node' is passed.
>
> For base memory, qemu assigns these flags for it's LMBs:
> (DRCONF_MEM_AI_INVALID | DRCONF_MEM_RESERVED)
> For hot-plugged memory, it assigns (DRCONF_MEM_ASSIGNED).
>
> While guest kernel reads the device-tree, early_init_drmem_lmb() is
> called for every added LMBs, doing nothing for base memory, and adding
> memblocks for hot-plugged memory. Skipping base memory happens here:
>
> if ((lmb->flags & DRCONF_MEM_RESERVED) ||
>     !(lmb->flags & DRCONF_MEM_ASSIGNED))
>         return;
>
> Marking memblocks added by this function as hotplugable memory
> is enough to get the desirable behavior, and should cause no change
> if 'movable_node' parameter is not passed to kernel.
>
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 6620f37abe73..f4d14c67bf53 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -518,6 +518,8 @@ static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
>                 DBG("Adding: %llx -> %llx\n", base, size);
>                 if (validate_mem_limit(base, &size))
>                         memblock_add(base, size);
> +
> +               early_init_dt_mark_hotplug_memory_arch(base, size);

Hi,

I tried this a few years back
(https://patchwork.ozlabs.org/patch/800142/) and didn't pursue it
further because at that time, it was felt that the approach might not
work for PowerVM guests, because all the present memory except RMA
gets marked as hot-pluggable by PowerVM. This discussion is not
present in the above thread, but during my private discussions with
Reza and Nathan, it was noted that making all that memory as MOVABLE
is not preferable for PowerVM guests as we might run out of memory for
kernel allocations.

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/
