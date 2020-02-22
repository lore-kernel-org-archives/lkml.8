Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCBC35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DC4208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpfiRuAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBVPhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 10:37:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44287 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgBVPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 10:37:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id j8so4779739qka.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8Q3uqcVM58l6nmcPCuCIDs6oHWPeRTAFcUT/2DRxd0=;
        b=KpfiRuAh8ggHRd1R/5/qrAtQTBpV5AJztVFe5MK/sNSfvoyeewLkQzfGRWsf8krTEH
         8jyJEv0iGA9WAgCIk0VMGOLr3g/RErALz3Ft1eJziMwzpTXOh/unTBDzYdwM6D1j2tMa
         zZVEQ+VYCLYf0GARtmrICb3FOIIYzmhkjoZpDxwGLaONFb6d2/MiCOZXkyQpA/BLRF6+
         IJXrbUTXIp+FrOWaeIjg3SrbQNlcs2HRvo+M9o7Um1epVUOCS6y4UdAybyQ+1StHJPMA
         KSdzE19c2/q3unxlp8nGtmAkady7jWrhQ3/oqDEMzIYgC8eBCPPrksP+0S7B9VqKBrcO
         UXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8Q3uqcVM58l6nmcPCuCIDs6oHWPeRTAFcUT/2DRxd0=;
        b=MvgUzTyCdN5WlOjanfntNsMkJ0DEPg1CUXKyioBPoSPHV33je5ELbAx3oZ7qECQcpP
         cOfWrfgywtKxq+yoqkDJUl482TkkjEi8099YVnn3mEATpvz59wzW2fIVvql8rszcDJ0Y
         JGkgnLAhMjANX/BtPJzr2zn0VFsT3ih4fTl5dTFb2mJ1fAbkU2ZLErm9t+cwr1O+db2o
         bQCI2D2DZcrmQVQM81fRuHaWCMl/ocebI1TXdkQKvuoTUixAeS0AFRsKGrxvxtc1xMMZ
         +pWN/+IhVNuTlD3aaab++FDdMR72vwBL/PQq8SVj3pM1zAg6dGhXVe+fN/u3kOCscxsq
         khpg==
X-Gm-Message-State: APjAAAUhEHp5HWF90bch89sLPu6/9g0hpypSbom0jQuX1ENmjn5jw7BT
        nUsZYBFSW/y4P4GKe4A/A28=
X-Google-Smtp-Source: APXvYqw326DMkbv7ouegnhD6lib7/BeVmeuubjGZlkSGeWAKItvb5EpVEQkBQtGoIJeYT+uLDytsiQ==
X-Received: by 2002:a05:620a:989:: with SMTP id x9mr40662809qkx.371.1582385869376;
        Sat, 22 Feb 2020 07:37:49 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k29sm3305825qtu.54.2020.02.22.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 07:37:49 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 10:37:47 -0500
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Fangrui Song <maskray@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222153747.GA3234293@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074242.GA17358@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222074242.GA17358@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:42:42AM -0700, Nathan Chancellor wrote:
> 
> Thanks for the clarity. With your suggestion (diff below), I see the
> following error:
> 
> arch/x86/boot/compressed/vmlinux: no symbols
> ld.lld: error: undefined symbol: ZO_input_data
> >>> referenced by arch/x86/boot/header.o:(.header+0x59)
> 
> ld.lld: error: undefined symbol: ZO_z_input_len
> >>> referenced by arch/x86/boot/header.o:(.header+0x5D)
> make[3]: *** [../arch/x86/boot/Makefile:108: arch/x86/boot/setup.elf]
> 
> It seems like the section still isn't being added?
> 
> Cheers,
> Nathan

It seems like lld also doesn't treat .symtab as special and is
discarding it, but that one is actually essential to be able to build
the bzImage.

The sections that GNU ld ends up discarding via that *(*) directive are
.dynsym, .dynstr, .gnu.hash, .eh_frame, .rela.dyn, .comment and
.dynamic.

Out of these, only .eh_frame has any significant size, and that's what
we discard in the other linker scripts (in kernel/vmlinux.lds.S and
boot/setup.ld).

It looks like it would be safest to just do
	/DISCARD/ : {
		*(.eh_frame)
	}
instead. If you can double-check that that works with lld, I can send
out a new version.

Thanks and sorry for the breakage.
