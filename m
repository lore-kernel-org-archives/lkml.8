Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB60D20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNaUC1qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgGBLsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:48:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgGBLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593690492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjmPmaD/IooVKYdxRZ/9YWrdivHE5lwEHMPYLDdNJ+Y=;
        b=NNaUC1qymoNtsNN2JBZ2AzDpn5UK84iQrJQMUKOGt2GBdQO4KWroO6RjTAvstSMrgwo3hp
        gmbt1flSDitDWPq/1ee/v6ts4DZFSfGdHIl4LwQJr9MSsVA46vX0es7WtHQwT85JN7Mfsw
        CpYCY3AHz0UqbSY9DVAzwq02AMpziI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-H_w9jTJWOV6KaVp1n8h7fg-1; Thu, 02 Jul 2020 07:48:08 -0400
X-MC-Unique: H_w9jTJWOV6KaVp1n8h7fg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC89E107ACF2;
        Thu,  2 Jul 2020 11:48:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D0419D7F;
        Thu,  2 Jul 2020 11:48:01 +0000 (UTC)
Date:   Thu, 2 Jul 2020 19:47:58 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
Message-ID: <20200702114758.GA21026@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
 <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
 <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
 <0e145e84-a6cf-4da3-1a1a-331a7e1ac1fa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e145e84-a6cf-4da3-1a1a-331a7e1ac1fa@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 at 12:01am, Hari Bathini wrote:
> 
> 
> On 01/07/20 1:16 pm, Dave Young wrote:
> > On 06/29/20 at 05:26pm, Hari Bathini wrote:
> >> Hi Petr,
> >>
> >> On 29/06/20 5:09 pm, Petr Tesarik wrote:
> >>> Hi Hari,
> >>>
> >>> is there any good reason to add two more functions with a very similar
> >>> name to an existing function? AFAICS all you need is a way to call a
> >>> PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> >>> you could add something like this:
> >>>
> >>> int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >>> {
> >>> 	return 0;
> >>> }
> >>>
> >>> Call this function from kexec_add_buffer where appropriate and then
> >>> override it for PPC64 (it roughly corresponds to your
> >>> kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> >>>
> >>> FWIW it would make it easier for me to follow the resulting code.
> >>
> >> Right, Petr.
> >>
> >> I was trying out a few things before I ended up with what I sent here.
> >> Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
> >> after sending out v1. Will take care of that in v2.
> > 
> > Another way is use arch private function to locate mem hole, then set
> > kbuf->mem, and then call kexec_add_buf, it will skip the common locate
> > hole function.
> 
> Dave, I did think about it. But there are a couple of places this can get
> tricky. One is ima_add_kexec_buffer() and the other is kexec_elf_load().
> These call sites could be updated to set kbuf->mem before kexec_add_buffer().
> But the current approach seemed like the better option for it creates a
> single point of control in setting up segment buffers and also, makes adding
> any new segments simpler, arch-specific segments or otherwise.
> 

Ok, thanks for the explanation.

