Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55DC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9679B20836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmIjQHAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgEAQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728443AbgEAQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:37:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB5C061A0C;
        Fri,  1 May 2020 09:37:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so1909420pgr.10;
        Fri, 01 May 2020 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LOCLhxjzGT7WvTJ7KJtjfQrNcETlh804e30Mz9BMbJ0=;
        b=LmIjQHAouDZBqRO2Z7NupCQgXGSaK5rRAwDV045S6iNq+K4F818cYyiaoUReiRS125
         a46Uy0rJjbP9qz/pGk3GKffWewVFeHR71gjLcOBqbum+ZYmS1LoUsangw62aiG0iLv3z
         9mVjfmWPZJEaImoOpcvcdJVJjxtJeGFbkRQK0tcLZwvzPgPz1R9CuM8dXnxc2T5pgSBn
         TMnyModlWTHULd/QB0UJTX3TRXRNfaTCaRtzKlh+XKOgqA8WZblWpC8AqUq6l1kpBbU8
         qc9/n4ZPCwvju98KyNxQiMFu/o30PaBVT+66JDGho9s3+7m54CZ2dQ1aUx+/ginzciOI
         x32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LOCLhxjzGT7WvTJ7KJtjfQrNcETlh804e30Mz9BMbJ0=;
        b=q1C8sRTldkVt1GP3ehCrPc8evXFGzS1VamJ+F3lniIgyuX5sf7FDFPFoD2pZD2SthM
         f++2OnDeliTFDixvEz1dMJ9cn9dJec+69csT7hkrrwgVHrwGdTyzEGDle5bvQVmHYxQ+
         +DAnO0J4SQvLdk/PN9lsE0r5zr/4PJnituBj3HU4gowxZW/rjOrPRIs3hI0DtVzOO1gp
         ow3d7u3UxqVDy5lQtbTaf97+/HQQpxSF+GDHlGFtkzB+2xiQ4h9DJJqmxDF4c53TGuR4
         xeKpz4bA2/FG7PTechdO/wvCibT17vCA4FIit+fH0yWOFHFFU4WPwvFo4jNIen65Y5Aw
         ze+w==
X-Gm-Message-State: AGi0PuamjrdgeVqtueHE/M6X68+PZHJxREznBl8HCuuvp4DDz9j2J0Od
        xoamCSFRIg3sWueR+KirLmQ=
X-Google-Smtp-Source: APiQypJzWKKak8PbW+kZIdR7/TVsm2rivJyOhaM0wST//Mq0DDvkBNHskkneZWNWP5wgUMeouJLGDA==
X-Received: by 2002:a62:15c5:: with SMTP id 188mr4592641pfv.66.1588351025385;
        Fri, 01 May 2020 09:37:05 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id c2sm2683258pfp.118.2020.05.01.09.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 09:37:04 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 041GYn38026961;
        Sat, 2 May 2020 00:34:49 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 041GYe1E026958;
        Sat, 2 May 2020 00:34:40 +0800
Date:   Sat, 2 May 2020 00:34:40 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200501163440.GA19874@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
References: <20200501154033.GA25730@udknight>
 <3aeb6ab5059ec753d922051d7732e13322188e7c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aeb6ab5059ec753d922051d7732e13322188e7c.camel@perches.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 08:57:42AM -0700, Joe Perches wrote:
> On Fri, 2020-05-01 at 23:40 +0800, Wang YanQing wrote:
> > According to submitting-patches.rst, 'Fixes:' tag has a little
> > stricter condition about the one line summary than normal git
> > commit description:
> > “...
> > Do not split the tag across multiple lines, tags are exempt from
> > the "wrap at 75 columns" rule in order to simplify parsing scripts
> > ...”
> > 
> > And there is no sanity check for 'Fixes:' tag format in checkpatch
> > the same as GIT_COMMIT_ID for git commit description, so let's expand
> > the GIT_COMMIT_ID to add 'Fixes:' tag format check support.
> > 
> > The check supports below formats:
> > Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> > Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
> > Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
> > Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
> > Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")
> 
> Hi again YanQing.
> 
> I think all the non-standard and incomplete forms
> should have a warning emitted.

Hi Joe Perches
I am not sure whether I get your words, you mean we need to emit warning
for incomplete title line format? For example:
Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")


Thanks.
> 
> > The check doesn't support below formats:
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> > Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
> > Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
> > Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
> > Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
> > Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
> > Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
> > Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')
> 
> 
> > Note: this patch also fixes double quotation mark issue for normal git
> >       commit description, and now it supports double quotation mark in
> >       title line, for example:
> >       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
> >       when checking usable channels"")
> 
> Nice.
> 
