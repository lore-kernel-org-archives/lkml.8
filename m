Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBECFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20EC2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNinqeon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCXKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:14:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33428 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgCXKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585044853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2W46V6KH08v3G104dBcGJzXANovvtij5IaA5Zt56vzQ=;
        b=VNinqeonzo87zzq6XsiTqQffMtnFtyXI2lMasAjKdurHYqYjbV89L64wI3pLCFOKGOCKnF
        cKGh5KBCNd8FS9U5tZjQadnbrlgqYLa/D8JnF0gH/0ibkgPJcH5ImXGWuNcOkusUiDEOJy
        fGMMZK7NUHFMG4/O6Z7IF80vqZBCMCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-IKXQvLG0N9qrhjTwir3UOg-1; Tue, 24 Mar 2020 06:14:09 -0400
X-MC-Unique: IKXQvLG0N9qrhjTwir3UOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A3F8010E8;
        Tue, 24 Mar 2020 10:14:07 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB17A19C6A;
        Tue, 24 Mar 2020 10:14:04 +0000 (UTC)
Date:   Tue, 24 Mar 2020 18:14:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
Message-ID: <20200324101401.GA9942@MiWiFi-R3L-srv>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
 <87a746cdva.fsf@linux.ibm.com>
 <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/20 at 03:06pm, Sachin Sant wrote:
> 
> 
> > On 24-Mar-2020, at 2:45 PM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
> > 
> >> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
> >> 
> >> Bisect leads me to  commit d41e2f3bd546 
> >> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
> >> 
> >> Reverting this commit helps and the tests complete without any crash.
> > 
> > 
> > Can you try this change?
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index aadb7298dcef..3012d1f3771a 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > 			ms->usage = NULL;
> > 		}
> > 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > +		/* Mark the section invalid */
> > +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> > 	}
> > 
> > 	if (section_is_early && memmap)
> > 
> 
> This patch works for me. The test ran successfully without any crash/failure.

Hi Aneesh,

Could you make a formal patch to post, since Sachin has tested and
confirmed it works?

> 
> Thanks
> -Sachin
> 
> > a pfn_valid check involves pnf_section_valid() check if section is
> > having MEM_MAP. In this case we did end up  setting the ms->uage = NULL.
> > So when we do that tupdate the section to not have MEM_MAP.
> > 
> > -aneesh
> 

