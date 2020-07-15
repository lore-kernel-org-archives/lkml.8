Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C61920674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i6mXzKcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGOBXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgGOBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:23:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD33C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:23:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so866841pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtJMt5D7K9C8ql3zYlKfD8mfXyjKfGo9YIHofl3GNr8=;
        b=i6mXzKcIDfBhhNQRvvLg/C5UGIuMlqAh1ph4H7eqkHJDr7PuMbMBuSDLs83TP38yNB
         bTsbdAYiN8TVCvUTf3i2k44uwugHJxge/2LYPfWuuLuZ5XRPEeLUIzXPA7TaZAK1f0EG
         p+aeuoS5JQmDj4VQ5zoywN6JsJUFdTahr99K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtJMt5D7K9C8ql3zYlKfD8mfXyjKfGo9YIHofl3GNr8=;
        b=diZLgqMO6BifcYTG3APZPUX6tdTkM1sAgb5bRNGrlUToNNfaImfTiGtXm7GETEba9F
         zZ0cDLBzGNHtn3yp1oq7HnxFhoBAKXoSpnHObg74BIo0f1/XOt2Goaid1PbzcAIn7wBO
         BQRDO3V88psB098mFBPZtfz9TxB/VyHEL41emPhi0Y9LImzyC7hDdJXfzz2EYddNB276
         CB1yVDhsRZOEysriuJS40B1YucvI8UM8nghqcY/lLgYLbdEcO3jE3ZnztMsi2oUvz1gb
         Mjm1KFIo6RUOPdPMto+lF5zQUDaLtdlwfqzWWoO49oVpUTHoN2nQ57Z6mB+dbrhzvQj8
         3O6A==
X-Gm-Message-State: AOAM531EJQ48Yr0R+Q/thOZ2AVRcN+SbCT8RWEvFA896n6CIr3Vp7CwG
        D+5eh50mwkQPQwLeNlCTFDNOvQ==
X-Google-Smtp-Source: ABdhPJyIl+WxpdHetqRs0iY1NDJGKOEkmNO3iE3VMFuHcXkxfBCWMMImxc6uFhuMgMteLTrgR+OaPg==
X-Received: by 2002:a05:6a00:2bc:: with SMTP id q28mr6683696pfs.250.1594776229062;
        Tue, 14 Jul 2020 18:23:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm325734pfk.171.2020.07.14.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:23:48 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:23:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 15/75] x86/boot/compressed/64: Always switch to own
 page-table
Message-ID: <202007141823.326D9DC102@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-16-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-16-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:17PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> When booted through startup_64 the kernel keeps running on the EFI
> page-table until the KASLR code sets up its own page-table. Without
> KASLR the pre-decompression boot code never switches off the EFI
> page-table. Change that by unconditionally switching to a kernel
> controlled page-table after relocation.
> 
> This makes sure we can make changes to the mapping when necessary, for
> example map pages unencrypted in SEV and SEV-ES guests.
> 
> Also remove the debug_putstr() calls in initialize_identity_maps()
> because the function now runs before console_init() is called.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
