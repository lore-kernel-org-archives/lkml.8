Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FFC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E702073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585232766;
	bh=Na9yFOYQoJNOdm1p64nQqP07a+w53UVVSep7q+0qmjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZUimV5CiKPegsbxVtGToRGxJAwWLgnrWyNcF44xT2ze6UBuOaIQv6XbZuDDIH5SzV
	 miwjDXBDoJTH0YWOehKxbgQtG1vjOkOpgDxjm/yb2hU4s82FyJ3c5IGep8tvGHVoQg
	 eSMN1Gg5k8IZaXt7RyFBlLv8m3xNYNoSmzPiGFoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgCZO0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgCZO0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:26:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0412F2082D;
        Thu, 26 Mar 2020 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585232763;
        bh=Na9yFOYQoJNOdm1p64nQqP07a+w53UVVSep7q+0qmjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfwctrLsP6JgyinrNnz6xfn70JTGATFRLiG6rYV1sWJtBde8fvDnGgcaOM8WoAL57
         j9MIWheNDQSjVcvuIXklDvJ4/gnyJMCtEa5gHC+y2owGO/eyfgRaPYulQE9ma9tI8V
         461FqN7HM9qYTBl3ojun+iM1T53ZHA4FWgCqmX9A=
Date:   Thu, 26 Mar 2020 15:26:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Anton Blanchard <anton@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ulrich Weigand <uweigand@de.ibm.com>, paulmck@kernel.org,
        jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: provide IBM contacts for embargoed
 hardware
Message-ID: <20200326142601.GB1332382@kroah.com>
References: <20200326093831.428337-1-borntraeger@de.ibm.com>
 <20200326094241.GA996751@kroah.com>
 <20200326210401.7060e766@kryten.localdomain>
 <20200326140733.GA1313566@kroah.com>
 <82f6ea14-cb56-4546-20e1-7919dcd0d668@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f6ea14-cb56-4546-20e1-7919dcd0d668@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 03:14:24PM +0100, Christian Borntraeger wrote:
> 
> 
> On 26.03.20 15:07, Greg Kroah-Hartman wrote:
> > On Thu, Mar 26, 2020 at 09:04:01PM +1100, Anton Blanchard wrote:
> >> Hi Greg,
> >>
> >>> On Thu, Mar 26, 2020 at 10:38:31AM +0100, Christian Borntraeger wrote:
> >>>> Provide IBM contact for embargoed hardware issues. As POWER and Z
> >>>> are different teams with different designs it makes sense to have
> >>>> separate persons for the first contact.
> >>>>
> >>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>> Cc: Anton Blanchard <anton@linux.ibm.com>
> >>>> ---
> >>>>  Documentation/process/embargoed-hardware-issues.rst | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/process/embargoed-hardware-issues.rst
> >>>> b/Documentation/process/embargoed-hardware-issues.rst index
> >>>> a19d084f9b2c..43cdc67e4f8e 100644 ---
> >>>> a/Documentation/process/embargoed-hardware-issues.rst +++
> >>>> b/Documentation/process/embargoed-hardware-issues.rst @@ -246,7
> >>>> +246,8 @@ an involved disclosed party. The current ambassadors
> >>>> list: =============
> >>>> ======================================================== ARM
> >>>>    Grant Likely <grant.likely@arm.com> AMD		Tom
> >>>> Lendacky <tom.lendacky@amd.com>
> >>>> -  IBM
> >>>> +  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
> >>>> +  IBM Power     Anton Blanchard <anton@linux.ibm.com>  
> >>>
> >>> Can I get an ack from Anton that he really agrees with this?  :)
> >>
> >> Sure :)
> >>
> >> Acked-by: Anton Blanchard <anton@linux.ibm.com>
> > 
> > Sucker :)
> > 
> > thanks, I'll go queue this up now, and I will fix the checkpatch
> > warning...
> 
> Huh?
> 
> scripts/checkpatch.pl --strict rrr/0001-Documentation-provide-IBM-contacts-for-embargoed-har.patch
> total: 0 errors, 0 warnings, 0 checks, 9 lines checked
> 
> rrr/0001-Documentation-provide-IBM-contacts-for-embargoed-har.patch has no obvious style problems and is ready for submission.
> 
> 
> Anything that I missed?
> 

Hm, no, the original was fine, but if you look above there's trailing
whitespace after Anton's name on the line and I assumed it was in the
original.  Must have gotten added somewhere along the reply-to chain.

sorry for the noise.

greg k-h
