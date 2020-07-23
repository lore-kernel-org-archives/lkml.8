Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9900522BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595493154;
	bh=vKmUCEiiI8SQInZVvb+IqGwIN9wLx7EtCfFCvYdl3yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g4co+9C6S6hSywGq+PPHkmy9owNBWwmfZVlUsQebDwWlu54zWBbxw5AOFR9/5Ew/Q
	 zvy8wizz+P85RT4rpFsYz0OxoADL09OaASapgLuS0Fndpeg60aWlbjlXurdzjSO4ZT
	 e8h1TtKN+6OLfiyNe6m5vnoEFIg+YZW/gXDLc2zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGWIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgGWIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:32:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F103A2084D;
        Thu, 23 Jul 2020 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595493152;
        bh=vKmUCEiiI8SQInZVvb+IqGwIN9wLx7EtCfFCvYdl3yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyspoBTHNlqJByq3jaUfNxCaGoPdYXqgp68z9CqoZXapiwHjtxM1ZWkFAjtJxW3HU
         m4u+1hxKW+neLIIy+peb2YfknfOmc/fYg8BvlVrVWaAdtN0YtxYnCiQQBbNEuXgwsj
         tYWAQy3jyzHl64Z+G/cWnfhTB5kcp8rBPNMiDaWk=
Date:   Thu, 23 Jul 2020 10:32:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: Avoid the use of one-element arrays
Message-ID: <20200723083237.GA1560114@kroah.com>
References: <20200716180858.GA30115@embeddedor>
 <f8aa0762-4af2-54a2-c9e8-8023a4b7aed5@kernel.org>
 <8dd6e3ae-7ab3-d829-0231-e436de3ad6a8@embeddedor.com>
 <6228681b-f601-597a-64c2-87cd048d2599@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6228681b-f601-597a-64c2-87cd048d2599@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:30:47AM +0200, Jiri Slaby wrote:
> On 22. 07. 20, 20:24, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 7/17/20 01:10, Jiri Slaby wrote:
> >> On 16. 07. 20, 20:08, Gustavo A. R. Silva wrote:
> >>> One-element arrays are being deprecated[1]. Replace the one-element arrays
> >>> with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
> >>> once it seems these are just placeholders for alignment.
> >>>
> >>> Also, while there, use the preferred form for passing a size of a struct.
> >>> The alternative form where struct name is spelled out hurts readability
> >>> and introduces an opportunity for a bug when the variable type is changed
> >>> but the corresponding sizeof that is passed as argument is not.
> >>>
> >>> Lastly, fix the checkpatch.pl warnings below:
> >>>
> >>> ERROR: code indent should use tabs where possible
> >>> +        char    reserved_char;$
> >>>
> >>> WARNING: please, no spaces at the start of a line
> >>> +        char    reserved_char;$
> >>>
> >>> ERROR: code indent should use tabs where possible
> >>> +        compat_int_t    reserved;$
> >>>
> >>> WARNING: please, no spaces at the start of a line
> >>> +        compat_int_t    reserved;$
> >>
> >> May I ask you to send a follow-up patch to fix the whole structure's
> >> indentation?
> >>
> > 
> > Hi Jiri,
> > 
> > Sure thing. I'll fix that up and send v2, shortly.
> 
> Hi,
> 
> by a follow-up patch I meant a separate patch. Looking at it once again,
> I would do 3 patches:
> 1) remove [1] arrays
> 2) change sizeofs
> 3) fix white space

I agree, that would be the ideal series.

thanks,

greg k-h
