Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E870E2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585231658;
	bh=qWk9HPzMLp4G3xmGFhWg4Ov3UmUSX9leOSeE8g8DUhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Meg8ZWkW7za/pu26CZfamCcOtYWqKRSHTzUdpg6cPaYkwnYaLDzGtjYP9CdRuDTxa
	 2RmIKHeQ/6kozlkZBcRgJIcAy5H7yxj+agM381d751UZuhJgXIsRUj1oO+56Khr+VO
	 d+yUzZUUS2sfG/5cJSRZZzQ4zRTe8fDQInNMtN/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgCZOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgCZOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:07:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E8A206F6;
        Thu, 26 Mar 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585231655;
        bh=qWk9HPzMLp4G3xmGFhWg4Ov3UmUSX9leOSeE8g8DUhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BN+eIfS+Ywt9Y1GA7cHA4PNUeZgQPO4Zr5++GzweW2gUjY0AOH1bfHI1G4mWt9lyE
         XaAQ88yZJcHLgE7d0J0fzXRBMFm9yq3quVktYN5A1jJUTmGmHDP2A2thic6q6Vg+w0
         E6ZwYHEhYAcYk3zky3pSLA+0Dvw2v3wm5CSywnlM=
Date:   Thu, 26 Mar 2020 15:07:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anton Blanchard <anton@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ulrich Weigand <uweigand@de.ibm.com>, paulmck@kernel.org,
        jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: provide IBM contacts for embargoed
 hardware
Message-ID: <20200326140733.GA1313566@kroah.com>
References: <20200326093831.428337-1-borntraeger@de.ibm.com>
 <20200326094241.GA996751@kroah.com>
 <20200326210401.7060e766@kryten.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326210401.7060e766@kryten.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:04:01PM +1100, Anton Blanchard wrote:
> Hi Greg,
> 
> > On Thu, Mar 26, 2020 at 10:38:31AM +0100, Christian Borntraeger wrote:
> > > Provide IBM contact for embargoed hardware issues. As POWER and Z
> > > are different teams with different designs it makes sense to have
> > > separate persons for the first contact.
> > > 
> > > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Cc: Anton Blanchard <anton@linux.ibm.com>
> > > ---
> > >  Documentation/process/embargoed-hardware-issues.rst | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/process/embargoed-hardware-issues.rst
> > > b/Documentation/process/embargoed-hardware-issues.rst index
> > > a19d084f9b2c..43cdc67e4f8e 100644 ---
> > > a/Documentation/process/embargoed-hardware-issues.rst +++
> > > b/Documentation/process/embargoed-hardware-issues.rst @@ -246,7
> > > +246,8 @@ an involved disclosed party. The current ambassadors
> > > list: =============
> > > ======================================================== ARM
> > >    Grant Likely <grant.likely@arm.com> AMD		Tom
> > > Lendacky <tom.lendacky@amd.com>
> > > -  IBM
> > > +  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
> > > +  IBM Power     Anton Blanchard <anton@linux.ibm.com>  
> > 
> > Can I get an ack from Anton that he really agrees with this?  :)
> 
> Sure :)
> 
> Acked-by: Anton Blanchard <anton@linux.ibm.com>

Sucker :)

thanks, I'll go queue this up now, and I will fix the checkpatch
warning...
