Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F4C20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1jP+8L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGBL7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:59:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbgGBL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593691160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4B17+WYNTMSxF7tB4AKTsJ+zC29K7PjVCzxXK3zdDw=;
        b=N1jP+8L6Cav+bEx5Qb58SG23obcNGaD6kgfDOYCACchDLx4nATnFf2lz32pBt2WY/ghZ0+
        3V0DyrHpNYHRddTIzRG9bD3L+Us5cywd9duBGDzrPs6aGwRvw8lfz2ykHY6MAiBzevXlAR
        tXJdQjp/hFG/omRFmeRjVlVYUfTtl4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-ULjAwMrOM6iJWe1gqQ8w7g-1; Thu, 02 Jul 2020 07:59:18 -0400
X-MC-Unique: ULjAwMrOM6iJWe1gqQ8w7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78AA4186A20F;
        Thu,  2 Jul 2020 11:59:16 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 590CF7925B;
        Thu,  2 Jul 2020 11:59:11 +0000 (UTC)
Date:   Thu, 2 Jul 2020 19:59:07 +0800
From:   Dave Young <dyoung@redhat.com>
To:     piliu <piliu@redhat.com>
Cc:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
Message-ID: <20200702115907.GC21026@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
 <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm confused about the "overlap with crashkernel memory", does that mean
> > those normal kernel used memory could be put in crashkernel reserved
> > memory range?  If so why can't just skip those areas while crashkernel
> > doing the reservation?
> I raised the same question in another mail. As Hari's answer, "kexec -p"
> skips these ranges in user space. And the same logic should be done in
> "kexec -s -p"

See it, thanks!  The confusion also applied to the userspace
implementation though.  Seems they have to be special cases because of 
the powerpc crashkernel reservation implemtation in kernel limitation

Thanks
Dave

