Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8036C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BBE20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583244917;
	bh=CjxVJIk2GRMkI+aexuaFJkj4rdIHh1K0MxjOvbTOuHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bRh79pHeHJmH47FckC+kJfEO9mkHPq0EypwPdF/t3qNqZ97MnJocozfs+V618f9HA
	 JjaqRNFXe8cfuzQVW2ryaz3E1lih2HmKTjOZ7/UDmfM2OGfHrJtttHUJuM0Ayzn3pi
	 OPmcOEMPmwLWo4uz+Gl5zqWfUe7LHGoill6bkCpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgCCOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCCOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:15:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20C920838;
        Tue,  3 Mar 2020 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583244908;
        bh=CjxVJIk2GRMkI+aexuaFJkj4rdIHh1K0MxjOvbTOuHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfWDSJZFaVtO2Sm7kObMRnB38aqqykP8ysgH3kis0axH0H7CKcGHk9MtijxdFLHlp
         17U3cyNF5yxf7rkmV6lhS0wxcc3g9iOYeXrEMr1LX313FTfkuvMOmP0Nxvmka2f/Kt
         5HGaEDOX7WRHyUPV77HRU7/VV6Sq2aO7RjtNoOgc=
Date:   Tue, 3 Mar 2020 15:15:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     zzyiwei@google.com, mingo@redhat.com, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        bhelgaas@google.com, darekm@google.com, ndesaulniers@google.com,
        joelaf@google.com, linux-kernel@vger.kernel.org,
        prahladk@google.com, android-kernel@google.com
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
Message-ID: <20200303141505.GA3405@kroah.com>
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
 <20200302235044.59163-1-zzyiwei@google.com>
 <20200303090703.32b2ad68@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303090703.32b2ad68@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 09:07:03AM -0500, Steven Rostedt wrote:
> 
> Greg,
> 
> You acked this patch before, did you want to ack it again, and I'll take it
> in my tree?

Sure, but where did my ack go?  What changed from previous versions???

Anyway, the patch seems sane enough to me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
