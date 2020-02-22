Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59AC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8C20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPealTR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgBVHmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:42:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46896 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgBVHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:42:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so4194405otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQq+GG1QYp01vrYlwItFyogojmSp6nseyu5/GmAeVxU=;
        b=UPealTR+A1lWpBpjmEQT0UuvCt8sqThRPvX+mm+73OH1c3o1zkatglYw3zFh5GHzWQ
         KeyZ/iVPz0P4AC4jMeje3ewgwq1y3yFVyNWKpUQzk8U3A0+Jt3W1jFZ5Ut2nBVdc0Bpq
         EHmfDM9fTHWhvmCrdmwfzh61LIhj4zz0M2BQAovBxAEOE8kcLB5mfRKeLw5AIqRYEsva
         VcNY0OTh/8RdKt4j3oobva5VVPQ6Shgzt79PEowAmezjXgd1ZIqE3OoYdVfk2Pa3tSzi
         L6i4lLb7tVwNHh+0R8SWoftWm07xFQB475yLXWwfgqOyL/sYNlAGdfX4vhUDWuazIbRy
         /GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQq+GG1QYp01vrYlwItFyogojmSp6nseyu5/GmAeVxU=;
        b=guyHCj+lqvGb0psh8UC4ifEFMwBQjNm/ZRF8+y9/mLB/699nX+FLqy3WdlurVRIuAW
         QARGGhpwLvCQsjSQf69vSUBZfI4cajnH6295YBiuXjQjPZNo2DxCSJ3Wymw54wRGbbaK
         B45g5VhqKkv69Z4+Qi3479iTJRR+QBWfjnzZ4bz3BPALnNK8ux52eQ6huqIjoj3Gp41M
         JDva4CKkBK6Pauv3Oqh+bBFoPeWWGSfC1vnx2AqGpWbIm2nlC4rsorKR4mTkoK03BlNS
         jf7fk8iPp6whhkk19xkIF8gJ9viDBNHADRcZxw5/JG21fR1zn28l1/ES+QjCeBAdDhLY
         0S1Q==
X-Gm-Message-State: APjAAAVKaP42pCp0lbG9OTcXjj17HO2DsdcQYfhk/wRUs/N2KXQKbluM
        v52i4/p1mYPBnCQdlirRPew=
X-Google-Smtp-Source: APXvYqwBaRcdhblgw+y7Y2xeQ+lzWp+sV40sHv7JSYdpZ/vMVvkH+nwAXWQ5h/vVZIzcypNepR35sw==
X-Received: by 2002:a05:6830:1296:: with SMTP id z22mr30687060otp.354.1582357364220;
        Fri, 21 Feb 2020 23:42:44 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g5sm1972708otp.10.2020.02.21.23.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 23:42:43 -0800 (PST)
Date:   Sat, 22 Feb 2020 00:42:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222074242.GA17358@ubuntu-m2-xlarge-x86>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222072144.asqaxlv364s6ezbv@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:21:44PM -0800, Fangrui Song wrote:
> On 2020-02-22, Nathan Chancellor wrote:
> > On Sat, Feb 22, 2020 at 07:55:21AM +0100, Borislav Petkov wrote:
> > > On Fri, Feb 21, 2020 at 10:08:45PM -0700, Nathan Chancellor wrote:
> > > > On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
> > > > > Discarding the sections that are unused in the compressed kernel saves
> > > > > about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
> > > > >
> > > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > ---
> > > > >  arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > > index 508cfa6828c5..12a20603d92e 100644
> > > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > > @@ -73,4 +73,9 @@ SECTIONS
> > > > >  #endif
> > > > >  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> > > > >  	_end = .;
> > > > > +
> > > > > +	/* Discard all remaining sections */
> > > > > +	/DISCARD/ : {
> > > > > +		*(*)
> > > > > +	}
> > > > >  }
> > > > > --
> > > > > 2.24.1
> > > > >
> > > >
> > > > This patch breaks linking with ld.lld:
> > > >
> > > > $ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
> > > > ld.lld: error: discarding .shstrtab section is not allowed
> > > 
> > > Well, why is it not allowed? And why isn't the GNU linker complaining?
> > 
> > No idea, unfortunately I am not a linker expert and the patch that
> > changes this in lld does not really explain why it adds this
> > restriction:
> > 
> > https://github.com/llvm/llvm-project/commit/1e799942b37d04f30b73f6a9e792d551dadafeea
> > 
> > CC'ing Fangrui as I don't know George's email and he is usually
> > responsive to ld.lld issues/questions.
> > 
> > Cheers,
> > Nathan
> 
> In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> cased. Neither the input section description *(.shstrtab) nor *(*)
> discards .shstrtab . I feel that this is a weird case (probably even a bug)
> that lld should not implement.
> 
> In GNU ld, the following is not useful, while lld will discard the
> synthesized .strtab as requested:
> 
>   /DISCARD/ : { *(.strtab) }
> 
> I think it is better making the intention (retaining .shstrtab)
> explicit, by adding a .shstrtab beside /DISCARD/ :
> 
>   SECTIONS {
>     ...
>     .shstrtab : { *(.shstrtab) }
>     /DISCARD/ : { *(*) }
>   }

Thanks for the clarity. With your suggestion (diff below), I see the
following error:

arch/x86/boot/compressed/vmlinux: no symbols
ld.lld: error: undefined symbol: ZO_input_data
>>> referenced by arch/x86/boot/header.o:(.header+0x59)

ld.lld: error: undefined symbol: ZO_z_input_len
>>> referenced by arch/x86/boot/header.o:(.header+0x5D)
make[3]: *** [../arch/x86/boot/Makefile:108: arch/x86/boot/setup.elf]

It seems like the section still isn't being added?

Cheers,
Nathan

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 12a20603d92e..a6c3c7440c27 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -74,6 +74,10 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	.shstrtab : {
+		*(.shstrtab)
+	}
+
 	/* Discard all remaining sections */
 	/DISCARD/ : {
 		*(*)
