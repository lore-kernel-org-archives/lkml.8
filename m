Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CFC2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtJgVF9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgCDQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:06:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgCDQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583337984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUY8udRQNo9T1W7t0z9MO6yA071FZ3UK1//rz1amElo=;
        b=UtJgVF9Xd2FT1yYsVBBd6r9BlxNFPPjKrsPhjKS2ECsKDoFbZ8c55lC1nN613aKIpQ4zA5
        4I84iF0pGz/Hrj/w1jBEavPT4qkqef3sJxOeeuVk7RRrmNatQqHueChBgPGVnvLuFIZloj
        QyvvTyQgN/Qq7ZAAp189yRoKHUh3nZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-356PBLg5PkKYaRA0mLPPDw-1; Wed, 04 Mar 2020 11:06:22 -0500
X-MC-Unique: 356PBLg5PkKYaRA0mLPPDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C8C6DBA6;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 712E38B56A;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 60B6586A01;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:06:21 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <701521302.13078565.1583337981352.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200304140720.GQ16878@linux-l9pv.suse>
References: <20200303085528.27658-1-vdronov@redhat.com> <20200304140720.GQ16878@linux-l9pv.suse>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.205, 10.4.195.15]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: IH2nruIWMwx9vxI4ZbXE47kW8jiXfg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joey, all,

Let me address both of your emails here.

> Looks that kernel uses EFI protocol to query variable everytime, then
> why should kernel keeps a copy of variable data size, data and attributes in
> memory? It makes sense to keep VariableName and VendorGuid, but why data?
> 
> The efi_variable can be used to interactive with userland. But we do not
> need to keep a data copy in efi_variable with efivar_entry. e.g. The
> efivarfs_file_read() allocates a buffer for reading variable instead
> of using efi_variable->Data.

Indeed, as far as I understand the code, we keep var's data in a memory. I
cannot tell why such was done when this code was written. Given that this
code is considered "old" and may even be obsoleted, I wouldn't like to start
a deep rewrite, and only focus on fixing bugs, like the one mentioned.

> I have reviewed and tested this patch. It's good to me if we still want
> to use efi_variable structure as the return buffer of UEFI get/set_variable
> protocols.
> 
> Please feel free to add:
> Reviewed-by: Joey Lee <jlee@suse.com>

Thank you for your time on the review! Much appreciated. Still, I've just
sent out a v2 patch (with you in To:) which is indeed simpler and implements
and idea Ard suggested, and fixes only the exact bug mentioned. I'm not sure
which one will be accepted (if any), could you please, to look at v2 also?

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

