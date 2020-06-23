Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FB02078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDzyiZJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393963AbgFWVlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbgFWVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:41:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE12C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:41:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h15so107862wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=md3WRq3geqJdLGPOhsJGIsEQs0nCW0GjeQLNIB2+260=;
        b=EDzyiZJvtCxMv+eDdYCMUvn8C/dN+/dOmev0o842aiMgBm6n5ofpm2xArfPfHY/hwK
         RUxb1M2dfHYMQcLNaq3VVgiwl32wI5Fw2T/BQHQ5LxgeqhjbxjElSNtePs03KKVaRRfa
         Ru8ynNignHOlZUHiEr2oZl83BCN8Td67IdjMHUQw2ybs62SPFx/X4x6zckSe0bHudMBX
         1or47UBvL5IcXnaESTfwo+OM8PwDdHwxZu88fSMISrR9+s1vqhwiLC1h5VnNgJK6Y3l4
         2fzNuhwER1WS88ulI8VWHFJ3BAflixyuRHdnOGYMvVsh0R4XDdu13CRwYi6493L97ryA
         6i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=md3WRq3geqJdLGPOhsJGIsEQs0nCW0GjeQLNIB2+260=;
        b=MM6Ga55yIkc/WD4PASXLuNn3ukHGI0AK4g6CXR8+GoMGmeB7mw/bk2YM+RPPQiiKPe
         lXw5NcfTvynrZ6GU9/8z8P+tfXgLa/ebnJpbB5jYY61pc/0OknMwzKWoIda//HKHf/MF
         OGid/Tk53aK5E7c8b3yYYbhSB+d15zBOsjKWBYAp4mmTbFmVguRUVn8hSS8tKFbvHFHK
         zkNHWb2yE0lB/IFHt+NpV7NOzFkAKS6jrHtB00SRDGrfsk17kxpxnxlUYRJJ/LzIRZMb
         yQcxXZdeOePKO//7grwHsgI4hKUVmxEFrY0AJ1LzPQlweakk9CJAfy4enlKEqlhCKJ/p
         SbnQ==
X-Gm-Message-State: AOAM53016WRxMUXgfpqh4H27NoixavrGnJUH97jUX72Zm8mEJ+3Y9yAZ
        VEgatPO4+Nepi2bd4LJSBA==
X-Google-Smtp-Source: ABdhPJznv+RV68KZFbn8Afvx05E3kwhi1vnwFncc+m8HUFuX/FF+Db3CpJwGe47cL299GaisUun/oA==
X-Received: by 2002:adf:f711:: with SMTP id r17mr27909588wrp.409.1592948465540;
        Tue, 23 Jun 2020 14:41:05 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id u9sm5458017wme.16.2020.06.23.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:41:05 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:41:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200623214103.GA42474@localhost.localdomain>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <202006231131.AD0A7F5F@keescook>
 <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:33:50PM -0700, Christian Kujau wrote:
> On Tue, 23 Jun 2020, Kees Cook wrote:
> > > $ checksec --format=json --extended --file=`which rsync` | jq
> > > {
> > >   "/usr/bin/rsync": {
> > >     "relro": "full",
> > >     "canary": "yes",
> > >     "nx": "no",
> > ^^^^^^^^^^^^^^^^^^
> > 
> > It is, indeed, marked executable, it seems. What distro is this?
> 
> Arch Linux (x86-64) with 5.6.5.a-1-hardened[0], running in a Xen DomU.

Congratulations!

https://www.archlinux.org/packages/extra/x86_64/rsync/

  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RWE    0x10
