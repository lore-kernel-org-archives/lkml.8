Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BD420809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG2OuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:50:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:55809 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2OuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:50:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 06TEnogx007443;
        Wed, 29 Jul 2020 09:49:50 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 06TEnnwb007440;
        Wed, 29 Jul 2020 09:49:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Jul 2020 09:49:49 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
Message-ID: <20200729144949.GF17447@gate.crashing.org>
References: <20200729133741.62789-1-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729133741.62789-1-vdronov@redhat.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:37:41PM +0200, Vladis Dronov wrote:
> Certain warnings are emitted for powerpc code when building with a gcc-10
> toolset:
> 
>     WARNING: modpost: vmlinux.o(.text.unlikely+0x377c): Section mismatch in
>     reference from the function remove_pmd_table() to the function
>     .meminit.text:split_kernel_mapping()
>     The function remove_pmd_table() references
>     the function __meminit split_kernel_mapping().
>     This is often because remove_pmd_table lacks a __meminit
>     annotation or the annotation of split_kernel_mapping is wrong.
> 
> Add the appropriate __init and __meminit annotations to make modpost not
> complain. In all the cases there are just a single callsite from another
> __init or __meminit function:
> 
> __meminit remove_pagetable() -> remove_pud_table() -> remove_pmd_table()
> __init prom_init() -> setup_secure_guest()
> __init xive_spapr_init() -> xive_spapr_disabled()

So what changed?  These functions were inlined with older compilers, but
not anymore?


Segher
