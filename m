Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32114206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F8mQFRtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgGWGrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:47:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF486C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:47:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BC2vR6Pf2z9sRR;
        Thu, 23 Jul 2020 16:47:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595486853;
        bh=iLCp72MN0Bz7Tijm/DlYPrNZEwgqJ+eZi+r993c2Gas=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F8mQFRtw6PH4Q/+W/cXQHWrXJ7h89YyzJrv4PI1hNeDQOHFhaQ2yxkl5BomVcaRK4
         0LflFjJsREETVY3Js4225bYdLmOxFtAwYx/GJKne4iL7ZD3gs4/AmvIM9ql69XkCcK
         nplSgPBkAnX59xKMdAz0ISW8AfP6PUsESdLp2ydqZ0wyPV1bhKtIWAdUgQOQjHgbSt
         KW8HE9M/c/PHhsIDgI7CS6PfB5zgUqKgDDGL0dPGHK58AdENvdyR8WN72b0WehGnzb
         f/e+MtcfgzM9Zvqg7SEeFJmwpq4ze7DpzJ+cq0WIkY6Q/1R9fEEftb8wN6WDVwVwyP
         WY84EN3OjGuHA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 07/12] ppc64/kexec_file: add support to relocate purgatory
In-Reply-To: <2037fa32-28be-5995-1c22-c8b01cafe088@linux.ibm.com>
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com> <871rl4rxao.fsf@mpe.ellerman.id.au> <2037fa32-28be-5995-1c22-c8b01cafe088@linux.ibm.com>
Date:   Thu, 23 Jul 2020 16:47:31 +1000
Message-ID: <87365iram4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hari Bathini <hbathini@linux.ibm.com> writes:
> On 22/07/20 9:55 am, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>> Right now purgatory implementation is only minimal. But if purgatory
>>> code is to be enhanced to copy memory to the backup region and verify
>>> sha256 digest, relocations may have to be applied to the purgatory.
>>> So, add support to relocate purgatory in kexec_file_load system call
>>> by setting up TOC pointer and applying RELA relocations as needed.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> ---
>>>
>>> * Michael, can you share your opinion on the below:
>>>     - https://lore.kernel.org/patchwork/patch/1272027/
>>>     - My intention in cover note.
>> 
>> It seems like a lot of complexity for little benefit.
>> 
>> AFAICS your final purgatory_64.c is only 36 lines, and all it does is a
>> single (open coded) memcpy().
>> 
>> It seems like we could write that in not many more lines of assembler
>> and avoid all this code.
>
> Hi Michael,
>
> I am not sure if you would agree with me on this, but I am looking at the
> purgatory code as work in progress. As mentioned in the cover note, I intend
> to add log messaging, sha256 verification into purgatory. And also change it
> to position independent executable after moving common purgatory code (sha256
> verification) to arch-independent code.

I've never understood the desire to put more logic into purgatory. It's
the absolute worst place to detect that something's gone wrong, because
we have no facilities in there to do anything useful. We don't even know
what platform we're on.

> When I initially took this up, I wanted to add all the above changes too, but
> cut down on it, in the interest of time, first to get kdump (kexec -s -p)
> working in v5.9 merge window.
>
> But as the logic in patches 07/12 & 08/12 has been tested in kexec-tools code
> a lot of times and there are unlikely to be any changes to them except for
> __kexec_do_relocs() function (afaics), when -PIE would be used, I submitted them.
> With patch 09/12, I tried for a change that uses relocations while is minimal
> for now.
>
> Would you prefer it to be absolutely minimal by dropping patches 7 & 8 for
> now and writing the backup data copy code in assembler?

Yes please.

cheers
