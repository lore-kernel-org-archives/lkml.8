Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEB02078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgtUVPc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHNLY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:24:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbgHNLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597404265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0P93oaJk+rxt8zdGycTEaWh0GUUDLaEanFlmgIvSu4=;
        b=PgtUVPc+/ptKPEjroCETolwcymv+knbOPVC79BHOTIWq3oa/N1yjIBpbCVDvu4lnRrNh4V
        lbYFTNuvJFpwRGpqjmaMCbc31E6aruZOE9oTab4yasxay+/XPwEUx3xhEuv5S+SFvPMBPD
        8QUwU1BHM/hbtxYG/TtpCIRozBUTAYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-TX4nKKRBN224Qxarlq2mnw-1; Fri, 14 Aug 2020 07:24:23 -0400
X-MC-Unique: TX4nKKRBN224Qxarlq2mnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3581DDE1;
        Fri, 14 Aug 2020 11:24:21 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-154.pek2.redhat.com [10.72.12.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D5E4100AE5E;
        Fri, 14 Aug 2020 11:24:16 +0000 (UTC)
Date:   Fri, 14 Aug 2020 19:24:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Sang Yan <sangyan@huawei.com>
Cc:     kexec@lists.infradead.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
        guohanjun@huawei.com, luanjianhai@huawei.com, zhuling8@huawei.com,
        luchunhua@huawei.com, pasha.tatashin@soleen.com
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
Message-ID: <20200814112413.GA8097@dhcp-128-65.nay.redhat.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
 <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/14/20 at 04:21pm, Sang Yan wrote:
> 
> 
> On 08/14/20 14:58, Dave Young wrote:
> > On 08/14/20 at 01:52am, Sang Yan wrote:
> >> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> >> copy all segments from vmalloced memory to kernel boot memory,
> >> because of disabled mmu.
> > 
> > It is not the case on all archs, I assume your case is arm64, please
> > describe it in patch log :)
> > 
> Yes, it's particularly obvious on arm64. I will add it to the patch log,
> and test how long it takes on x86 and other arch.
> 
> > About the arm64 problem, I know Pavel Tatashin is working on a patchset
> > to improve the performance with enabling mmu.
> > 
> > I added Pavel in cc, can you try his patches?
> > 
> Thanks for your tips, I will try these patches. @Pavel.
> Disable mmu after finishing copying pages?
> >>
> >> We introduce quick kexec to save time of copying memory as above,
> >> just like kdump(kexec on crash), by using reserved memory
> >> "Quick Kexec".
> > 
> > This approach may have gain, but it also introduce extra requirements to
> > pre-reserve a memory region.  I wonder how Eric thinks about the idea.
> > 
> > Anyway the "quick" name sounds not very good, I would suggest do not
> > introduce a new param, and the code can check if pre-reserved region
> > exist then use it, if not then fallback to old way.
> > 
> aha. I agree with it, but I thought it may change the old behaviors of
> kexec_load.
> 
> I will update a new patch without introducing new flags and new params.

Frankly I'm still not sure it is worth to introduce a new interface if the
improvement can be done in arch code like Pavel is doing.  Can you try
that first?

Thanks
Dave

