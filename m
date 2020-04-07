Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE68C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8293120936
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586271364;
	bh=dmf2sCt8OdjywGVBqBDJTrQdLEpDVN1TaWBbslFDsRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KcnHUJU/xCguKVRBaO3+MptFXcqyVjfvQ/QVsHe2s8zTpquOAMrM+vBlWClIJUXUD
	 5dpDPrAdeDpvh15oWTkZfKCN9CUs7zrUwAtC5IBNJ4azHh92On7RvBT8Fq7Sqfmz5Q
	 mAa85ClRNOGnMCe5uJ8uMCw6cvFRMg4+0pMP0KcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgDGO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgDGO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:56:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB7D20A8B;
        Tue,  7 Apr 2020 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586271362;
        bh=dmf2sCt8OdjywGVBqBDJTrQdLEpDVN1TaWBbslFDsRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfx7S+kokJvXRkoGEyjzLmK2uimhuiC+A0Y3zzYF/4x8dFA0kjGkbtJZ/scRZkIkd
         285K3KzLYKWkGUdloYF1oXtfqs5pC7jRnTiMHLxKOZ7J+6tF2LdmbF7/EgTdV8SDx5
         CSyVRwG8kVG2ZnuJKLh4bWExJ0XfDLDxfGn4PpYg=
Date:   Tue, 7 Apr 2020 16:55:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, fenghua.yu@intel.com,
        xiaoyao.li@intel.com, nadav.amit@gmail.com, thellstrom@vmware.com,
        tony.luck@intel.com, rostedt@goodmis.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200407145556.GA895937@kroah.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <20200407143543.GB876345@kroah.com>
 <527b5c72-96cb-a6cc-5301-449d86015ec9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527b5c72-96cb-a6cc-5301-449d86015ec9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:44:57PM +0200, Paolo Bonzini wrote:
> On 07/04/20 16:35, Greg KH wrote:
> > On Tue, Apr 07, 2020 at 01:02:39PM +0200, Peter Zijlstra wrote:
> >> It turns out that with Split-Lock-Detect enabled (default) any VMX
> >> hypervisor needs at least a little modification in order to not blindly
> >> inject the #AC into the guest without the guest being ready for it.
> >>
> >> Since there is no telling which module implements a hypervisor, scan
> >> all out-of-tree modules' text and look for VMX instructions and refuse
> >> to load it when SLD is enabled (default) and the module isn't marked
> >> 'sld_safe'.
> >>
> >> Hypervisors, which have been modified and are known to work correctly,
> >> can add:
> >>
> >>   MODULE_INFO(sld_safe, "Y");
> >>
> >> to explicitly tell the module loader they're good.
> > 
> > What's to keep any out-of-tree module from adding this same module info
> > "flag" and just lie about it?  Isn't that what you are trying to catch
> > here, or is it a case of, "if you lie, your code will break" as well?
> 
> It's the latter.  Basically it's doing _the users_ of out-of-tree
> modules a favor by avoiding crashes of their virtual machines;
> developers need to fix them anyway.

Ok, seems kind of a heavy hammer, but oh well...

thanks for the explanation.

greg k-h
