Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B7C54E91
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A156206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589205493;
	bh=J4KKC8+vrNZz8SuyyVe6Qmx4TGwxNCTYQEPJY1Jd6Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=V4wE2bdrYfykukivnO3Php3Shhtl0bnUUP3UbajPL6ZRIetClejI4Yrc+vdnTcQRd
	 YEsyIOMrSejDOG692Rp3Y/emsQpPiLwMA7k8PY8u8PZExju7ZqqtSBBFEEHh7+f0Ob
	 KnMiW10WreN3AalQX+gJ10rjABbd7JSLs/E9ixiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgEKN6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbgEKN6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:58:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081D8206D6;
        Mon, 11 May 2020 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589205490;
        bh=J4KKC8+vrNZz8SuyyVe6Qmx4TGwxNCTYQEPJY1Jd6Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S+h93yd09KTGhPSerX2Whl5Hy0LT2F67zPe6uHU1x45kKcEg8J4iYYwMtzU4OyTnS
         JYi0BxRrt0pIxxysWo+TTQiqiwSRQupInyQ6cZwDG7SyerRUvMz4B3hKdiGXHKq9u6
         A6r7qWaUV/NM0xO3+edlrwdEL6xZtJfI5RCFJuTM=
Date:   Mon, 11 May 2020 22:58:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2] selftests/ftrace: Use printf for backslash included
 command
Message-Id: <20200511225805.ed665ee97d3cbd87a5ca9380@kernel.org>
In-Reply-To: <87eerq1tcd.fsf@igel.home>
References: <87imh21x6f.fsf@igel.home>
        <158920418730.16156.8299185499520876735.stgit@devnote2>
        <87eerq1tcd.fsf@igel.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:42:10 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Mai 11 2020, Masami Hiramatsu wrote:
> 
> > -    (! echo "$command" >> "$3" ) 2> /dev/null
> > +    (! printf "%s" "$command" >> "$3" ) 2> /dev/null
> 
> printf %s does not print a newline, you need printf '%s\n' for that.

Actually, ftrace doesn't need newline for single command.
The reason why we had used echo instead of "echo -n" here,
is just for short typing :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
