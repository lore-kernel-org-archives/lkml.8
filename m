Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E1C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5F4206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582472727;
	bh=NE+a683dW1qKH/Z53IjUOkdGkT7RCvu9x5lPLDGCs2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aE0fp4xw+zZhi+wsjl7dixTKjgesYo8X6WUZrV/kbi8bdGywq1QIQshVzQCPGCQEx
	 S2sSFOtdLhLm0U24++qoWDdOvAkDHakdr+XYSsb/z73kz1QOOXq0G5lyoSJSKdERt3
	 aFavvr63GSP/TGr/GYSpLmlvVno/iyDGBRmfikOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBWPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWPpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:45:25 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79538206E0;
        Sun, 23 Feb 2020 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582472724;
        bh=NE+a683dW1qKH/Z53IjUOkdGkT7RCvu9x5lPLDGCs2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2LH/+1ZHeij0os8nSN8UAXGGbsW+vbKsdEBWq/ss+41YDWDPuT3aLRE+Bozb3Q6ax
         aWn0Ka+VJJmW4CpC+ye3rkDCy/OpFjTn71iKWHCauwG90CDU3keLPSk5zaDPzmvedu
         wNwBv92kJFesCOQgNdTsH8PDm6U+bELWuZc9W3x4=
Date:   Sun, 23 Feb 2020 16:45:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Orivej Desh <c@orivej.org>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Confusing Usage-Guide in LICENSES/exceptions/Linux-syscall-note
Message-ID: <20200223154522.GA270051@kroah.com>
References: <20200222023147.3cc31b90@orivej.orivej.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222023147.3cc31b90@orivej.orivej.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 03:37:09AM +0000, Orivej Desh wrote:
> For the reference, here is the Linux syscall note:
> 
>      NOTE! This copyright does *not* cover user programs that use kernel
>      services by normal system calls - this is merely considered normal use
>      of the kernel, and does *not* fall under the heading of "derived work".
> 
> When Linux-syscall-note was split from the COPYING file [1] [2], it
> added a Usage-Guide section that says that "This exception" marks
> "user space API (uapi) header files so they can be included into non
> GPL compliant user space application code". However, the License-Text
> extracted from the COPYING does not say anything about including
> headers; instead it says that programs that make system calls to the
> kernel are not considered derived from the kernel.
> 
> I think that Linus shares the view expressed by Stallman [3]:
> 
>      Someone recently made the claim that including a header file
>      always makes a derivative work.
> 
>      That's not the FSF's view. Our view is that just using structure
>      definitions, typedefs, enumeration constants, macros with simple
>      bodies, etc., is NOT enough to make a derivative work. It would
>      take a substantial amount of code (coming from inline functions
>      or macros with substantial bodies) to do that.
> 
> and wrote the syscall note as something to be added on top of this
> view, while Thomas Gleixner took the note as a relaxation of GPL that
> allows the use of the headers in non-GPL programs when he wrote the
> Usage-Guide and Documentation/process/license-rules.rst that says:
> 
>      The User-space API (UAPI) header files, which describe the
>      interface of user-space programs to the kernel are a special
>      case. According to the note in the kernel COPYING file, the
>      syscall interface is a clear boundary, which does not extend the
>      GPL requirements to any software which uses it to communicate
>      with the kernel. Because the UAPI headers must be includable into
>      any source files which create an executable running on the Linux
>      kernel, the exception must be documented by a special license
>      expression.
> 
> I think that the lawyers should review whether the syscall note grants
> anything not already granted by GPL-2.0. If it unambiguously does not
> than the note could be deleted, overwise the following mistakes should
> be corrected:
> 
> 1. Since the note declares user programs to not be considered derived
>    from the running kernel, it applies to the kernel as a whole. It
>    does not make sense to restrict Linux-syscall-note to UAPI headers
>    only (in their SPDX-License-Identifier) and not to apply it to the
>    whole kernel. "WITH Linux-syscall-note" should be deleted from all
>    sources; the link to the note from the root COPYING is enough.
> 
> 2. Linux-syscall-note should be cleared from these parts of the old
>    COPYING unrelated to the note:
> 
>       Also note that the GPL below is copyrighted by the Free Software
>       Foundation, but the instance of code that it refers to (the Linux
>       kernel) is copyrighted by me and others who actually wrote it.
> 
>       Also note that the only valid version of the GPL as far as the kernel
>       is concerned is _this_ particular version of the license (ie v2, not
>       v2.2 or v3.x or whatever), unless explicitly otherwise stated.
> 
>                              Linus Torvalds
> 
>    Note that there is no GPL text below.
> 
> 3. Linux-syscall-note Usage-Guide could be deleted (does a three line
>    note need a guide?), or it may say something like this:
> 
>      This exception allows non-GPL programs to run on Linux.
> 
> 4. Documentation/process/license-rules.rst should be updated
>    accordingly. Something like the Stallman explanation of derived
>    works would be useful.
> 
> 5. SPDX license list maintainers should be notified to update [5]. Its
>    current Note about the exception is unclear and mistaken:
> 
>      This note is used with the Linux kernel to clarify how user space
>      API files should be treated.
> 
> The people seem easily confused by the Usage-Guide: they believe that
> the syscall exception does what it does not (allowing uapi includes in
> user programs), and do not understand what it does (allowing making
> system calls). Please correct it!

Thanks for the report.  A few of us have slowly been working on making
this all a lot more obvious as to what this means for things.

Give us some time, it's a low-priority issue at the moment, but it will
be taken care of eventually.

thanks,

greg k-h
