Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5531C35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B262176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivpk23W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgBYBt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:49:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582595368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wc7tZyJ6iU/QokJr3t6fWMYT5Rf36+F0rsTqeX+IMo4=;
        b=ivpk23W4aoUduM2wKLW5NNIou+nHR/Uriv6s650DSNxJWwDRax34toPwoUH2pTE/K5b9Vz
        jhBeGGsK1POpoR/Pv1goaHHAs7xPBwtCWx5+HTX4LwLuTOnJhWJJiDm0FhaZVyqSSf3oqN
        sFxW5HGzoz3UUVS/LRgUvHE8QyhnPHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-LDxbto9CN5SO2iVJGfLBGw-1; Mon, 24 Feb 2020 20:49:20 -0500
X-MC-Unique: LDxbto9CN5SO2iVJGfLBGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF134800D50;
        Tue, 25 Feb 2020 01:49:19 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-179.pek2.redhat.com [10.72.12.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 998C060BF7;
        Tue, 25 Feb 2020 01:49:17 +0000 (UTC)
Date:   Tue, 25 Feb 2020 09:49:12 +0800
From:   Dave Young <dyoung@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/kdump] x86/kexec: Do not reserve EFI setup_data in the
 kexec e820 table
Message-ID: <20200225014912.GA13800@dhcp-128-65.nay.redhat.com>
References: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
 <158254146897.28353.4247096498069522547.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158254146897.28353.4247096498069522547.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/20 at 10:51am, tip-bot2 for Dave Young wrote:
> The following commit has been merged into the x86/kdump branch of tip:
> 
> Commit-ID:     8efbc518b884e1db2dd6a6fce62d0112ab871dcf
> Gitweb:        https://git.kernel.org/tip/8efbc518b884e1db2dd6a6fce62d0112ab871dcf
> Author:        Dave Young <dyoung@redhat.com>
> AuthorDate:    Wed, 12 Feb 2020 19:04:24 +08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Mon, 24 Feb 2020 11:41:57 +01:00
> 
> x86/kexec: Do not reserve EFI setup_data in the kexec e820 table
> 
> The e820 table for the kexec kernel unconditionally marks setup_data as
> reserved because the second kernel can reuse setup_data passed by the
> 1st kernel's boot loader, for example SETUP_PCI marked regions like PCI
> BIOS, etc.
> 
> SETUP_EFI types, however, are used by kexec itself to enable EFI in the
> 2nd kernel. Thus, it is pointless to add this type of setup_data to the
> kexec e820 table as reserved.
> 
> IOW, what happens is this:
> 
>   -  1st physical boot: no SETUP_EFI.
> 
>   - kexec loads a new kernel and prepares a SETUP_EFI setup_data blob, then
>   reboots the machine.
> 
>   - 2nd kernel sees SETUP_EFI, reserves it both in the e820 and in the
>   kexec e820 table.
> 
>   - If another kexec load is executed, it prepares a new SETUP_EFI blob and
>   then reboots the machine into the new kernel.
> 
>   5. The 3rd kexec-ed kernel has two SETUP_EFI ranges reserved. And so on...
> 
> Thus skip SETUP_EFI while reserving setup_data in the e820_table_kexec
> table because it is not needed.
> 
>  [ bp: Heavily massage commit message, shorten line and improve comment. ]

Boris, thanks for the amending and log massage.
I was hesitating to break the long line or not and then I choosed
leaving it as is.  Both are not very good and either of them is fine to me.

Thanks
Dave

