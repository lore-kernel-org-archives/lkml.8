Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A220722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVzKMrrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGAHrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:47:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728210AbgGAHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593589631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0tbbv2fepFy6ZwkJj/rSA//He2y/6egv4GB/rgFFdc=;
        b=QVzKMrrXm/Fb3CAFPguJZw066pnKM6uTaU1spuyiGoRn7K3Vn0yuPEZfzDmEWj1PIGPRPx
        T+myXSIKHY101PKeqNf9p7mqyn9gOnrDVjtgLdmlP5vHmXOGaW1pMebdZJXPrdJPklNGLF
        chFN2e+ozVSNALyTDuCQlKUtsmyxEgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-EYag6ONJPzizDK3-Oe3Y8g-1; Wed, 01 Jul 2020 03:47:09 -0400
X-MC-Unique: EYag6ONJPzizDK3-Oe3Y8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE60107ACCA;
        Wed,  1 Jul 2020 07:47:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E93B3A7E;
        Wed,  1 Jul 2020 07:47:02 +0000 (UTC)
Date:   Wed, 1 Jul 2020 15:46:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Petr Tesarik <ptesarik@suse.cz>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
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
Message-ID: <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
 <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/20 at 05:26pm, Hari Bathini wrote:
> Hi Petr,
> 
> On 29/06/20 5:09 pm, Petr Tesarik wrote:
> > Hi Hari,
> > 
> > is there any good reason to add two more functions with a very similar
> > name to an existing function? AFAICS all you need is a way to call a
> > PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> > you could add something like this:
> > 
> > int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > {
> > 	return 0;
> > }
> > 
> > Call this function from kexec_add_buffer where appropriate and then
> > override it for PPC64 (it roughly corresponds to your
> > kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> > 
> > FWIW it would make it easier for me to follow the resulting code.
> 
> Right, Petr.
> 
> I was trying out a few things before I ended up with what I sent here.
> Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
> after sending out v1. Will take care of that in v2.

Another way is use arch private function to locate mem hole, then set
kbuf->mem, and then call kexec_add_buf, it will skip the common locate
hole function.

But other than that I have some confusion about those excluded ranges.
Replied a question to patch 4.

Thanks
Dave

