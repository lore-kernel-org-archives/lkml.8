Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A81FC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96520714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwKpSGkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXHOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:14:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbgBXHOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582528470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shbhF5QPWUZF4FXtBT/Y7FxOTeIlf15w2VQZ89Q+vRY=;
        b=UwKpSGkPGh7UNxT74qJIn4FObT7Wn/jQ1aIzuxUWRXWRnUHq3XnFxTlfjQ4DabZcXo6bfY
        2mU1CRKQiuKw5872w2bUqTEiOkfyserutaJ48qHePvl7vR5uQgptb1iqDGe5iWCZHv+rOB
        m6/v2bZIVfpsuaqi+1peTzwWhWoQhu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-OTADVYNTP1KgIKmAqwLMEg-1; Mon, 24 Feb 2020 02:14:28 -0500
X-MC-Unique: OTADVYNTP1KgIKmAqwLMEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3CE185734F;
        Mon, 24 Feb 2020 07:14:26 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-44.pek2.redhat.com [10.72.13.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 336B15C105;
        Mon, 24 Feb 2020 07:14:23 +0000 (UTC)
Date:   Mon, 24 Feb 2020 15:14:19 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] x86/kexec: do not reserve kexec setup_data in kexec e820
 table
Message-ID: <20200224071419.GA18237@dhcp-128-65.nay.redhat.com>
References: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/20 at 07:04pm, Dave Young wrote:
> The e820 table for kexec kernel always takes setup_data as reserved.
> It is reasonable for the setup_data passed by the 1st kernel boot loader,
> for example SETUP_PCI etc.  But SETUP_EFI is used by kexec itself to
> enable EFI in 2nd kernel, also kexec setups it every time. Thus it
> is pointless to reserve kexec prepared setup_data.
> 
> 1st physical boot: no SETUP_EFI
> kexec load new kernel and prepare a SETUP_EFI setup_data, then reboot
>  -> 2nd kernel sees SETUP_EFI, reserves in both e820 and kexec e820
>     another kexec load prepare a new SETUP_EFI, then reboot
>     -> 3rd kernel has two SETUP_EFI ranges reserved
>        -> and so on..
> 
> Thus skip SETUP_EFI while reserving setup_data for kexec kernel.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/e820.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-x86.orig/arch/x86/kernel/e820.c
> +++ linux-x86/arch/x86/kernel/e820.c
> @@ -999,7 +999,9 @@ void __init e820__reserve_setup_data(voi
>  	while (pa_data) {
>  		data = early_memremap(pa_data, sizeof(*data));
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -		e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> +		/* Skip kexec passed setup_data */
> +		if (data->type != SETUP_EFI)
> +			e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>  
>  		if (data->type == SETUP_INDIRECT &&
>  		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {

Ping, can someone review this? It caused fragmented memory in kexec
kernel also waste memory.

Thanks
Dave

