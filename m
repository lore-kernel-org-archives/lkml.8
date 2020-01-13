Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2824C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D1206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwZHdLEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMVMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:12:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:12:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so4310266plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEGrQbJtXUyHdDNYeXnLXFrqSgQp22x47iUVvMnKGVI=;
        b=JwZHdLEFWWXUS4+dmZ57mglzi2bUON5yR/dk5VRLQD8YpL8ntr9Fbkm5X/NzozYEZE
         3GAQvjRont05QlxJdO4dZkt5sw09SRJOIVLcXLVXXuwW28sxJYrnYEr4u2u7qccl+ILq
         k1aYj6oLznO51hz83LL6+QcipY/+haL8w3iPLVHyKtXiOjTB6Wlr930ZwMW/WuvgXIco
         4Cvyw0ZoO8a+RQ3viXW2g0E+UVIDP4teiKyjP3jePrd35aupXRVHKMbTRln784YLnQ61
         O4iGlxas4g9BS+L5Ak9aZeqSNVX0SLKymHoJoPv4vzdQHSmyDnYozIrgRS58MfiQkFB6
         xDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEGrQbJtXUyHdDNYeXnLXFrqSgQp22x47iUVvMnKGVI=;
        b=og1yLjq66qIisTxMsF3FA2VXzisHv3kCPqmkd/NcI5OYZGkKXaRwf3hMhYScFWktgE
         /g7i/G9istreYCIwmuhQ79whCGAixMfvdNiGQa04exza+/BY3Za30+Z+ePr0MxWVPGTp
         irG8p8a6y3SlE/R6n7mD2fjYr2hPW6IZG4oD2zQrgw6r7FLje1/lPgX+CYc+VaizAFwF
         WhtgaQVvtr4L1YMx6mRY/w9hRcFCZarJOYWrD19Nj+WfmxCxRo/jyQqMXeN77aKbuWII
         ZoWi3xb2Bw/TLitcFSJtl18ugJ2fDSY03GkhJqZKCBbHEPZyBtBcs/D0E463UcW6lTsH
         Y9rA==
X-Gm-Message-State: APjAAAWdglOhXpJxDGQ/4MQz9E5/xDnkYdRbcwIOXfCLyd+TCevP2BeL
        7XHU1q8+PS+FLy2oxjLwF+9u5kW5Uil4g/JbfCTPkQ==
X-Google-Smtp-Source: APXvYqyRxSTr/ixAyxGOn75jEM/FlK4csx0tJINO+4ToMmlvRtFbJL/kg+2hls4p4KoZuhcGlen2IICf9Skf03R4D8M=
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr15609257plm.297.1578949919741;
 Mon, 13 Jan 2020 13:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20200110174300.1836d6c3@canb.auug.org.au> <alpine.LRH.2.20.2001101153140.3212@dhcp-10-175-222-124.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.2001101153140.3212@dhcp-10-175-222-124.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 13:11:27 -0800
Message-ID: <CAFd5g45UuLtWRYiv8R4h4GYtZ0eS0MWfqQSXk7BZUmPEue4oGA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 3:56 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 10 Jan 2020, Stephen Rothwell wrote:
>
> > Hi all,
> >
> > After merging the kunit-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_X_out_of_bounds':
> > policy_unpack.c:(.text+0xf5c): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0xf6f): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_X_code_mismatch':
> > policy_unpack.c:(.text+0x1113): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1126): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1161): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x11a5): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_X_code_match':
> > policy_unpack.c:(.text+0x1350): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1363): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x139e): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x13e9): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u64_out_of_bounds':
> > policy_unpack.c:(.text+0x15a1): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x15b4): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1646): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1677): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u64_with_name':
> > policy_unpack.c:(.text+0x17e7): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x17fa): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1857): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x18a2): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1934): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1965): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u64_with_null_name':
> > policy_unpack.c:(.text+0x1ab0): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1ac3): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1b20): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1b6b): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1bfd): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1c2e): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u32_out_of_bounds':
> > policy_unpack.c:(.text+0x1db1): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1dc4): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1e56): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1e87): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u32_with_name':
> > policy_unpack.c:(.text+0x1feb): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x1ffe): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2060): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x20b3): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2145): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2176): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u32_with_null_name':
> > policy_unpack.c:(.text+0x22b4): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x22c7): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2329): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x237c): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x240e): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x243f): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u16_chunk_out_of_bounds_2':
> > policy_unpack.c:(.text+0x2643): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x266c): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x26b4): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x26dd): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2757): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2777): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u16_chunk_out_of_bounds_1':
> > policy_unpack.c:(.text+0x297e): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x29a7): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x29ef): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2a18): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2a94): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2ab4): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_u16_chunk_basic':
> > policy_unpack.c:(.text+0x2ce1): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2d01): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2d4e): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2d7a): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2ddf): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2e07): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_strdup_out_of_bounds':
> > policy_unpack.c:(.text+0x2f86): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x2fcc): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3023): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3052): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x30bf): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x30ea): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_strdup_with_name':
> > policy_unpack.c:(.text+0x324f): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x329f): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x32da): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3350): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x33c9): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3418): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_strdup_with_null_name':
> > policy_unpack.c:(.text+0x359c): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x35ec): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3627): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x369d): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3716): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3765): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_str_out_of_bounds':
> > policy_unpack.c:(.text+0x38d3): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3919): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3986): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x39b1): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_str_with_name':
> > policy_unpack.c:(.text+0x3ae7): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3b2e): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3b95): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3bdb): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_str_with_null_name':
> > policy_unpack.c:(.text+0x3d26): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3d6d): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3dd4): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3e1a): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_nameX_with_wrong_name':
> > policy_unpack.c:(.text+0x3f55): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3f68): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x3ffa): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x402b): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_nameX_with_name':
> > policy_unpack.c:(.text+0x4186): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4199): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4229): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x425a): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_nameX_with_wrong_code':
> > policy_unpack.c:(.text+0x4390): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x43a3): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4435): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4466): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_nameX_with_null_name':
> > policy_unpack.c:(.text+0x459f): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x45b2): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4642): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4673): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_blob_out_of_bounds':
> > policy_unpack.c:(.text+0x47f3): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4839): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x48a6): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x48d1): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_blob_with_name':
> > policy_unpack.c:(.text+0x4a2a): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4a7a): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4ac3): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4af9): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_blob_with_null_name':
> > policy_unpack.c:(.text+0x4c55): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4ca5): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4cee): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4d24): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_array_out_of_bounds':
> > policy_unpack.c:(.text+0x4eac): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4eed): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4f6c): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x4f8c): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_array_with_name':
> > policy_unpack.c:(.text+0x50ec): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x512e): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x51ad): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x51cd): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_unpack_array_with_null_name':
> > policy_unpack.c:(.text+0x52f8): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x533a): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x53b9): undefined reference to `kunit_binary_ptr_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x53d9): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_inbounds_when_out_of_bounds':
> > policy_unpack.c:(.text+0x54cf): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x5533): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_inbounds_when_inbounds':
> > policy_unpack.c:(.text+0x562e): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x5641): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x5685): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x56e8): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x5727): undefined reference to `kunit_unary_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x5787): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `kunit_test_suites_init':
> > policy_unpack.c:(.text+0x57f6): undefined reference to `kunit_run_tests'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `build_aa_ext_struct':
> > policy_unpack.c:(.text+0x9e2e): undefined reference to `kunit_kmalloc'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x9e69): undefined reference to `kunit_ptr_not_err_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x9ebc): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x9ece): undefined reference to `kunit_kmalloc'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x9f09): undefined reference to `kunit_ptr_not_err_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0x9f5d): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `policy_unpack_test_init':
> > policy_unpack.c:(.text+0xa216): undefined reference to `kunit_kmalloc'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0xa251): undefined reference to `kunit_ptr_not_err_assert_format'
> > x86_64-linux-gnu-ld: policy_unpack.c:(.text+0xa2a1): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: drivers/base/power/qos-test.o: in function `kunit_test_suites_init':
> > qos-test.c:(.text+0x26): undefined reference to `kunit_run_tests'
> > x86_64-linux-gnu-ld: drivers/base/power/qos-test.o: in function `freq_qos_test_readd':
> > qos-test.c:(.text+0x179): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1c8): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x244): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x294): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x306): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x359): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x3c3): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x413): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x482): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x4d1): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x54d): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x59d): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x60f): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x662): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: drivers/base/power/qos-test.o: in function `freq_qos_test_min':
> > qos-test.c:(.text+0x7f8): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x848): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x8c7): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x917): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x989): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x9dc): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xa49): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xa99): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xb0b): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xb5e): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xbc8): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xc18): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xc87): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xcd6): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: drivers/base/power/qos-test.o: in function `freq_qos_test_maxdef':
> > qos-test.c:(.text+0xe6e): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xec1): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xf3a): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0xf89): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1005): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1054): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x10c3): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1113): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1185): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x11d8): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1247): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1296): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1308): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x135b): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x13c5): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1415): undefined reference to `kunit_do_assertion'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x1487): undefined reference to `kunit_binary_assert_format'
> > x86_64-linux-gnu-ld: qos-test.c:(.text+0x14da): undefined reference to `kunit_do_assertion'
> >
> > I am not sure what caused this.
> >
> > This build is a cross build and using a separate object directory (in
> > case that matters).
> >
> > I used the kunit-next tree from next-20200109 for today.
> >
>
> This is my fault; when kunit is built as a module, kunit
> tests that are builtin-only fail to build.  I've posted
> a patch to fix this at
>
> https://lore.kernel.org/linux-kselftest/1578656965-2993-1-git-send-email-alan.maguire@oracle.com/T/#u

Looks like this is now fixed on kselftest/kunit (thanks to your patch).

> Thanks for catching this Stephen, and apologies for the noise!

Thanks for taking care of this in my absence!
