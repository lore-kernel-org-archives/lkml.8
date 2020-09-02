Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB679C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFF920BED
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599039625;
	bh=JesIRyeaVvb9G7U2wtfk1DCJU65SxbJ4EcS4RFuwSjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FGgyu9eLCq9Yu8JcFTcoG3SgT7uqcLAOkNHc/2Ml14PoE3H6pP/oKaDky3tO1X8rF
	 tyY8g3bF9yD8jO64KxT5lhwG3/xh8WiTfz/00Zdn/QxJS46jo4x2IHBR8y24YdogtX
	 jUWX+DDg98vsK+4iHwPZ+Fefkwc84PZdaIIiUDnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBJkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBJkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:40:23 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637392078B;
        Wed,  2 Sep 2020 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599039623;
        bh=JesIRyeaVvb9G7U2wtfk1DCJU65SxbJ4EcS4RFuwSjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBe3ALm31cOyX+cTpqTOoxuO2bSvPkBh0Pv+62XnaJ7nIJVAR3Yblt1QWbwrc+6iJ
         UTLmz3xYniNcGObD7G8+c6OXF/6p+5r6IljQUjoDoyWSc1ebINP68somxloOVyVxXC
         mfui3KbQmogSX/LIHB+GnoAY+Eu3RXDb4OTLTmbc=
Date:   Wed, 2 Sep 2020 11:40:19 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-kernel@vger.kernel.org, jeyu@suse.de,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] module: Add more error message for failed kernel module
 loading
Message-ID: <20200902094019.GA7287@linux-8ccs>
References: <20200902064619.67343-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200902064619.67343-1-wqu@suse.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Qu Wenruo [02/09/20 14:46 +0800]:
>When kernel module loading failed, user space only get one of the
>following error messages:
>
>- ENOEXEC
>  This is the most confusing one. From corrupted ELF header to bad
>  WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
>  all returns this error number.
>
>- EPERM
>  This is for blacklisted modules. But mod doesn't do extra explain
>  on this error either.
>
>- ENOMEM
>  The only error which needs no explain.
>
>This means, if a user got "Exec format error" from modprobe, it provides
>no meaningful way for the user to debug, and will take extra time
>communicating to get extra info.
>
>So this patch will add extra error messages for -ENOEXEC and -EPERM
>errors, allowing user to do better debugging and reporting.
>
>Signed-off-by: Qu Wenruo <wqu@suse.com>
>Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Applied, thanks.

Jessica
