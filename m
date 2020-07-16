Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ACC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558FE206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943585;
	bh=4CYHGW9f4TNDqQkfNjdBI3p0P2PYHswYd3FtirRWxXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HeOu9mMOaDoTCMX0BDIvdABqdWap61R3d2k+AzGdHoMxqWy3xDAhDexwdJczyuFP6
	 T+KspLf6OkTce4JgZRnNvQanKBjqJyPCSEahXxd1TTUBJlYY0BHQvtyvKXhfBT4hfz
	 PqCB03eUu0oazUa44vPiSdG/gQCmQkmdnGfho/mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGPXw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgGPXw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:52:59 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8847206F4;
        Thu, 16 Jul 2020 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943577;
        bh=4CYHGW9f4TNDqQkfNjdBI3p0P2PYHswYd3FtirRWxXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgdn9gwXPbrVgYJvq6kzBsXYH+nQmYTZwhsChh6QZz6ZEJIHbq3kLU4EiWkFCoNtn
         33DUYjVC5p42m9+RqLVs2IqhO3Se5pnt5jgnSEDxmoWXmxBJOXV/O+YZYKTww39/wl
         Bf+i96oXjizncsBu4hURDwZUNrys7aoCbESTM43w=
Date:   Thu, 16 Jul 2020 16:52:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: Replace HTTP links with HTTPS ones
Message-Id: <20200716165257.88776064be381ca5797983c5@linux-foundation.org>
In-Reply-To: <642ab4dc-d0fb-d973-0e5e-7d1bc7d90f11@suse.cz>
References: <20200713164345.36088-1-grandmaster@al2klimov.de>
        <642ab4dc-d0fb-d973-0e5e-7d1bc7d90f11@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 11:41:37 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2069,7 +2069,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  	 * free), userland could trigger a small page size TLB miss on the
> >  	 * small sized TLB while the hugepage TLB entry is still established in
> >  	 * the huge TLB. Some CPU doesn't like that.
> > -	 * See http://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
> > +	 * See https://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
> >  	 * 383 on page 93. Intel should be safe but is also warns that it's
> 
> Well, it was a good opportunity to find out that the link doesn't work anyway.
> The pdf seems to be now at
> http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf
> and the erratum is on page 105

Thanks.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-thp-replace-http-links-with-https-ones-fix

fix amd.com URL, per Vlastimil

Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/huge_memory.c~mm-thp-replace-http-links-with-https-ones-fix
+++ a/mm/huge_memory.c
@@ -2065,8 +2065,8 @@ static void __split_huge_pmd_locked(stru
 	 * free), userland could trigger a small page size TLB miss on the
 	 * small sized TLB while the hugepage TLB entry is still established in
 	 * the huge TLB. Some CPU doesn't like that.
-	 * See https://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
-	 * 383 on page 93. Intel should be safe but is also warns that it's
+	 * See http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf, Erratum
+	 * 383 on page 105. Intel should be safe but is also warns that it's
 	 * only safe if the permission and cache attributes of the two entries
 	 * loaded in the two TLB is identical (which should be the case here).
 	 * But it is generally safer to never allow small and huge TLB entries
_

