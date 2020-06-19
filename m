Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D1CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DC821527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592575332;
	bh=gJzzZB7/IPivlAu1L2QO6aYOv9XFiWRSXkWULQj1ojM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=InSENmkNCJ79XQoU500TTK11bRtdtCHCsf6IUUQx+9quZb1eNRm9Ai5D/SPaUDcJ7
	 HBdx1NoV4ZqOL1+9KadpdyWSHcwflWr5kZWlqHAFDQmsnHvUSiiRH8zVlS4ZqAGD9i
	 2QbRbTRfo0CP/baQa1+jO8GoIeBM8NY3lxc+OsA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgFSOCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgFSOCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:02:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56105207E8;
        Fri, 19 Jun 2020 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592575329;
        bh=gJzzZB7/IPivlAu1L2QO6aYOv9XFiWRSXkWULQj1ojM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxO+IZbH+VtKny5dA4LoKDHP3cFZWC2M+d93WxoSHMmBFB2bXateTHCfRn1kNRTt+
         TneX/HlmNh7IevONOCK4SQGDxtvzMm7JPuVTTsPRI40QQ6z9F8e1kbgol+Zm8YYfBw
         ehz6msbFKlfo+8G3URyAVEfR/InnfbMCPwXgnJPU=
Date:   Fri, 19 Jun 2020 16:02:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619140206.GA1862477@kroah.com>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <20200619072041.GA2795@kroah.com>
 <CAFmMkTF7QBJQdKxhsPiUPifsxykyCVv=NYandpB0z8EccAxMXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTF7QBJQdKxhsPiUPifsxykyCVv=NYandpB0z8EccAxMXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:51:32AM -0300, Daniel Gutson wrote:
> > > +enum mktme_status_type get_mktme_status(void)
> > > +{
> > > +     return mktme_status;
> > > +}
> > > +EXPORT_SYMBOL_GPL(get_mktme_status);
> >
> > prefix of the subsystem first please:
> >         mktme_get_status
> >
> 
> OK.
> 
> > Or, better yet, why not just export the variable directly?  Why is this
> > a function at all?
> 
> Because I want this to be read only.

read-only to who?

> > > +
> > > +/* Buffer to return: always 3 because of the following chars:
> > > + *     value \n \0
> > > + */
> > > +#define BUFFER_SIZE 3
> >
> > Why a define?
> 
> Do you suggest `static const int` instead?

Why do you need it at all?

> > > +
> > > +     sprintf(tmp, "%d\n", (int)get_mktme_status() & 1);
> > > +     return simple_read_from_buffer(buf, count, ppos, tmp, sizeof(tmp));
> > > +}
> > > +
> > > +static const struct file_operations mktme_status_ops = {
> > > +     .read = mktme_status_read,
> > > +};
> > > +
> > > +static int __init mod_init(void)
> > > +{
> > > +     mktme_dir = securityfs_create_dir("mktme", NULL);
> > > +     if (IS_ERR(mktme_dir)) {
> > > +             pr_err("Couldn't create mktme sysfs dir\n");
> > > +             return -1;
> >
> > Don't make up random error numbers, use the EWHATEVER defines please.
> >
> 
> Could you please suggest one?

Why not return the error given to you?  Why throw that information away?

> > Also no Documentation/ABI/ update for your new userspace api that you
> > just created?
> >
> 
> should that be a comment in the .h?

No, you need a description in Documentation/ABI/ about any
sysfs/configfs/securityfs/whatever for new things you are creating.

thanks,

greg k-h
