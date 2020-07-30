Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950C220829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CYke0PcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgG3MEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:04:33 -0400
Received: from ozlabs.org ([203.11.71.1]:33087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgG3MEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:04:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHTbx1lczz9sSd;
        Thu, 30 Jul 2020 22:04:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596110670;
        bh=z0WIyR/mZG9ZjQNWeL5HzLGtq1gOYwd4LC1GYXLfzlQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CYke0PcAF/Ees6uRtYzVeoJVbRvmwbMwl2Sd7v10oKOJf1C9sXfUqjLwsGKxbg2iN
         RAP1SfNDOZUOTofug5H9MHFA1Ojd4rnvgWumBThOibNO/QahMAOO6kQOGAW/mxhFEp
         VlAA7sCX09gdJklvvelzUK04jG2bQFRjCx/bycCFnUf5+aCDEdKixCNSGH/BIEOS80
         i1GRuRf1pRLDEG3gKREmiQAdv+U8+ARHRH4vKqbYvHm/Qd005UzrQY1Waz5tNZW6jf
         nPwHOJe23D3mf8eYl9UcWRlpJoj3vp3tKfaVZ/+pjYxMiMCTYamxgAdY6E9WnyA49G
         yZNpnalCUpdGQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Vladis Dronov <vdronov@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
In-Reply-To: <20200729224427.GI17447@gate.crashing.org>
References: <20200729133741.62789-1-vdronov@redhat.com> <20200729144949.GF17447@gate.crashing.org> <584129967.9672326.1596051896801.JavaMail.zimbra@redhat.com> <20200729224427.GI17447@gate.crashing.org>
Date:   Thu, 30 Jul 2020 22:04:27 +1000
Message-ID: <87ft995hv8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Wed, Jul 29, 2020 at 03:44:56PM -0400, Vladis Dronov wrote:
>> > > Certain warnings are emitted for powerpc code when building with a gcc-10
>> > > toolset:
>> > > 
>> > >     WARNING: modpost: vmlinux.o(.text.unlikely+0x377c): Section mismatch in
>> > >     reference from the function remove_pmd_table() to the function
>> > >     .meminit.text:split_kernel_mapping()
>> > >     The function remove_pmd_table() references
>> > >     the function __meminit split_kernel_mapping().
>> > >     This is often because remove_pmd_table lacks a __meminit
>> > >     annotation or the annotation of split_kernel_mapping is wrong.
>> > > 
>> > > Add the appropriate __init and __meminit annotations to make modpost not
>> > > complain. In all the cases there are just a single callsite from another
>> > > __init or __meminit function:
>> > > 
>> > > __meminit remove_pagetable() -> remove_pud_table() -> remove_pmd_table()
>> > > __init prom_init() -> setup_secure_guest()
>> > > __init xive_spapr_init() -> xive_spapr_disabled()
>> > 
>> > So what changed?  These functions were inlined with older compilers, but
>> > not anymore?
>> 
>> Yes, exactly. Gcc-10 does not inline them anymore. If this is because of my
>> build system, this can happen to others also.
>> 
>> The same thing was fixed by Linus in e99332e7b4cd ("gcc-10: mark more functions
>> __init to avoid section mismatch warnings").
>
> It sounds like this is part of "-finline-functions was retuned" on
> <https://gcc.gnu.org/gcc-10/changes.html>?  So everyone should see it
> (no matter what config or build system), and it is a good thing too :-)

I haven't seen it in my GCC 10 builds, so there must be some other
subtlety. Probably it depends on details of the .config.

cheers
