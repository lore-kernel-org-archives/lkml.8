Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B7CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A720BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587368932;
	bh=iVmU8MQOQbpm84PbULKI/fKx/vXsmr6HDpCNMlL6LRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TnSk/5LOT3mBvvKA82ZvA5L2H3Z4YeKVHSWcrO3dh6GgB5NjkK1WjjA7xWLO2ORYc
	 Dn9DSWI7v0NqK3nnQeJaRD5AaB62Tdu/yXCVHtCm+VYFTPXFWFuBz6nix5Zo1w3j+j
	 DnkZnivx7wPhbIhDKYcfJ2aT8+nXNY8X67/QAzSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDTHsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDTHsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:48:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:48:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so10817704wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3wz23xjfLFCUP1LDp/E/sRHfstYXbDlgI8CwoDmJPeA=;
        b=Y/IJPQW4tGi9NY8w12wxko3rFEdehSZX0Jo+pjfz40wwwNMoTbwx4nnZ+hzosuY44M
         jwOGpBWR1CR5K8fseDxjVlAX8ecAh91+SU4SCDWxkSCK27rMVotfiqziwKqFl7IUAFG/
         Kva5KP9WqBcJRCgenySYl9YrMbIqxZhUCEFn/waKM3ozsi1Pz5wkXxrJY5xfQ01TTczm
         VA2AeH52noeogXX5BYH1EenXZeq+c7kQABrOA7LSG/6F+ev3x0SEuYUDFKh0/1D6i/q0
         b7hg6kji6k5uNCSGP3nngaN1ZGpaE6cDyRwtDNbKXwGlg02hlJ2WSKBpGLT1jwe0VX7O
         rj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wz23xjfLFCUP1LDp/E/sRHfstYXbDlgI8CwoDmJPeA=;
        b=BE8Ao27ylPH8MCH7F3CPvKjDuS3c1zxHEGgqUNBr3vPbDCINJTHuzyZc31HLhUX1pa
         O3GZMcJ7DNIn70b/jJSoxWC4JFVozBWRwzUtmMZas46P8RRsDJhfTppJ7+wGzYqQWUTO
         Ge07zNNbEuLm5NhfLynWuun7kLsc+j5b0NwNzzz93aHqAi19YI8bfswYwUhGXD/wBtR/
         XFuyETIjwRfv8/HLMaogY9uPAp3FFon6EmHuE8+Uid3d2GmwqNoZNhOIBwysT/eQAVIw
         ChkoWdM22K9SjNDqqdiAIlRpZ6qZNLXC6bqyUdAtLK3LxgbLwQlEx8+xgbWa2R+OSc6N
         Nf1A==
X-Gm-Message-State: AGi0PubBJHffURd9L5ANmhHz4RSWLZrc68TYpxUB6OITb4nSaspUhIx0
        ru5VwfW5TryQQmhHN49O7Vg=
X-Google-Smtp-Source: APiQypKKXIN4nqu7dAbdtmKy5DYhWREsUmBLHEzjGeU1o4JOZBD3ftLC+DenR5SMSNPP+IifBAoB3Q==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr16920394wrr.216.1587368929464;
        Mon, 20 Apr 2020 00:48:49 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x18sm83248wrs.11.2020.04.20.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:48:48 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:48:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420074845.GA72554@gmail.com>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419200758.3xry3vn2a5caxapx@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Sun, Apr 19, 2020 at 11:56:51AM -0700, Linus Torvalds wrote:
> 
> > So I'm wondering if there any way that objtool could be run at 
> > link-time (and archive time) rather than force a re-build of all the 
> > object files from source?
> 
> We've actually been making progress in that direction.  Peter added 
> partial vmlinux.o support, for Thomas' noinstr validation.  The problem 
> is, linking is single-threaded so it ends up making the kernel build 
> slower overall.
> 
> So right now, we still do most things per compilation unit, and only do 
> the noinstr validation at vmlinux.o link time.  Eventually, especially 
> with LTO, we'll probably end up moving everything over to link time.

Fortunately, much of what objtool does against vmlinux.o can be 
parallelized in a rather straightforward fashion I believe, if we build 
with -ffunction-sections.

Here's the main "objtool check" processing steps:

int check(const char *_objname, bool orc)
{
...
        ret = decode_sections(&file);
...

        ret = validate_functions(&file);
...
        ret = validate_unwind_hints(&file);
...
                ret = validate_reachable_instructions(&file);
...
                ret = create_orc(&file);
...
                ret = create_orc_sections(&file);
}

The 'decode_sections()' step takes about 92% of the runtime against 
vmlinux.o:

 $ taskset 1 perf stat --repeat 3 --sync --null tools/objtool/objtool check vmlinux.o

 Performance counter stats for 'tools/objtool/objtool check vmlinux.o' (3 runs):

           3.05757 +- 0.00247 seconds time elapsed  ( +-  0.08% )

 $ taskset 1 perf stat --repeat 3 --exit-after-decode --null tools/objtool/objtool check vmlinux.o            

 Performance counter stats for 'tools/objtool/objtool check vmlinux.o' (3 runs):

           2.83132 +- 0.00272 seconds time elapsed  ( +-  0.10% )

(The --exit-after-decode hack makes it exit right after 
decode_sections().)

Within decode_sections(), the main overhead is in decode_instructions() 
(~75% of the total objtool overhead):

           2.31325 +- 0.00609 seconds time elapsed  ( +-  0.26% )

This goes through every executable section, to decode the instructions:

static int decode_instructions(struct objtool_file *file)
{
...
        for_each_sec(file, sec) {

                if (!(sec->sh.sh_flags & SHF_EXECINSTR))
                        continue;

The size distribution of function section sizes is strongly biased 
towards section sizes of 100 bytes or less, over 95% of all instructions 
in the vmlinux.o are in such a section.

In fact over 99% of all decoded instructions are in a section of 500 
bytes or smaller, so a threaded decoder where each thread batch-decodes a 
handful of sections in a single processing step and then batch-inserts it 
into the (global) instructions hash should do the trick.

The batching size could be driven by section byte size, i.e. we could say 
that the unit of batching is for a decoding thread to grab ~10k bytes 
worth of sections from the list, build a local list of decoded 
instructions, and then insert them into the global hash in a single go. 
This would scale very well IMO, with the defconfig already having almost 
3 million instructions, and a distro build or allmodconfig build a lot 
more.

I believe the 3.0 seconds total objdump runtime above could be reduced to 
below 1.0 second on typical contemporary development systems - which 
would IMHO make it a feasible model to run objtool only against the whole 
kernel binary.

Is there any code generation disadvantage or other quirk to 
-ffunction-sections, or other complications that I missed, that would 
make this difficult?

Thanks,

	Ingo
