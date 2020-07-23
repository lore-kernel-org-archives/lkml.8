Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604DAC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC5206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYaMfDhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgGWUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:31:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbgGWUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595536274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40t+4qcg6UR1VcXiSRsIIDp9z0DXZ4q6WAM4TN0/6lk=;
        b=aYaMfDhP4PCilBwMubvz0FD+P4GpQRfw20FIQTQ+PpuqIgiNSAXkd1QQmVNveyPznj11Q6
        lXB3dCH9k6o2kW/y6cMQy9vGH3t36diNlVEBKbenyl05sdIa/5Zzl80XgKhN3zCXfhltQv
        g/PDaEStFfkM1lFZMXQyYLPYdV0UdVw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-POOgeOrbPEGiiscNvv_afw-1; Thu, 23 Jul 2020 16:31:10 -0400
X-MC-Unique: POOgeOrbPEGiiscNvv_afw-1
Received: by mail-qv1-f69.google.com with SMTP id g17so4398015qvw.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40t+4qcg6UR1VcXiSRsIIDp9z0DXZ4q6WAM4TN0/6lk=;
        b=MRGNuXETL5WN+jF2OaHAw0Pxxyl0YEtLsYMRne7c8YKpEYXST8cCzPv+GWOGltZQA4
         TTinoC1WBEYG4pDA6gBGbyj9hGskR44WIjT55uIx6PZNH26/7Uvt8IwDiA3vWXI39rzZ
         J6wu7OscsxJfJvcfp5K+IxlAe7XNIkDp/hNGfR7fUjRqn7O0rNPfP/4vKRRNUS8/syis
         GN0Fu3qH3GHLtYi4sBWQP4USBye+Z5Lw+lvGYx5Pvngy5aZgfyd8XJptisP4MKflI5Td
         jql0DDAtM9Mi2qRaURNk+Bv8MUlK40/4zdUFuQPvaGJVExLa0ZawdB2TIdqjj1J2DwIb
         tnJQ==
X-Gm-Message-State: AOAM531xwODKIVGt5wm3ZEudLCxiG7KAxQ+EcyIkr7WcjJBJP1Rx8LB3
        9c9Zh4gfjE1tsV6cfU94COnpgFfelYeOXtudRCNAIa5XKbjc+mf3Nb0RRO7WnqAwZl1nSvI3VAF
        YHJLBJriVGuUF1/MAookLbu9UQmw/J1h9TyOFxYmy
X-Received: by 2002:a37:5c04:: with SMTP id q4mr7263413qkb.192.1595536270039;
        Thu, 23 Jul 2020 13:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaz+FKwj1+Qpe9+JR57Hg1bCOgF5rhbZUwIe/feWxQzxhiCYW2p0q4YNTbBH3ZcWu7BRmV4VUvG7uvN9PukuM=
X-Received: by 2002:a37:5c04:: with SMTP id q4mr7263386qkb.192.1595536269773;
 Thu, 23 Jul 2020 13:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520> <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com> <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com> <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
 <20200722092507.GC5180@lahna.fi.intel.com>
In-Reply-To: <20200722092507.GC5180@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 23 Jul 2020 22:30:58 +0200
Message-ID: <CACO55tsv63VP93F7xJ3nfZ7SkOk0c6WkgvuP+8fY14gypmn4Fg@mail.gmail.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Patrick Volkerding <volkerdi@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:25 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2020 at 01:37:12PM -0500, Patrick Volkerding wrote:
> > On 7/21/20 10:27 AM, Mika Westerberg wrote:
> > > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > >> Sure thing. Also, feel free to let me know if you'd like access to one of the
> > >> systems we saw breaking with this patch - I'm fairly sure I've got one of them
> > >> locally at my apartment and don't mind setting up AMT/KVM/SSH
> > > Probably no need for remote access (thanks for the offer, though). I
> > > attached a test patch to the bug report:
> > >
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > >
> > > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > > anyone would have time to try it out.
> >
> >
> > Hi Mika,
> >
> > I can confirm that this patch applied to 5.4.52 fixes the issue with
> > hybrid graphics on the Thinkpad X1 Extreme gen2.
>
> Great, thanks for testing!
>

yeah, works on the P1G2 as well.

