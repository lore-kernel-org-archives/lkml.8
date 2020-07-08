Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C085C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337D0206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594201329;
	bh=8qCOXJkpdszHcWBPcw5SYFwFD+A1w2gGZuyFi+QWkq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vykLYuvUT6lJCNwHB6opiP2byGC0GdN4TVinoKjj5TiaRz6nb3RmvlsnqJmkm/jaK
	 +sG7ED0zob+f/U6mMERU5SEGJEOVTJF9IcusDOupRwavMHccArNHT1ZMTsV1/IvfVF
	 JQHoRiyMDNX6ag9QmOnyVfYZvbIGAjYce7upF6mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGHJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHJmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:42:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEACE2065D;
        Wed,  8 Jul 2020 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594201326;
        bh=8qCOXJkpdszHcWBPcw5SYFwFD+A1w2gGZuyFi+QWkq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JW3g5z6jmj6g3hzydhgarDj/QRP5tXjIjUu3pBNgOdQ5kVV/6lRIXq6blcPcTMPBL
         QHaVbnPV6qWVg3wo5TFM1t6hVcSEiMcG2YMa9lsDJNS68fc+ekYGujGYTMfJ4QIpFM
         6B+1LoqocSk4pEEfJICkeP4zQplZ7gx1FSZ+lLik=
Date:   Wed, 8 Jul 2020 18:42:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kprobes
Message-Id: <20200708184201.611d929ae6017c87ea98b114@kernel.org>
In-Reply-To: <20200707194959.52487-1-grandmaster@al2klimov.de>
References: <20200707194959.52487-1-grandmaster@al2klimov.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jul 2020 21:49:59 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.

OK, but it seems that some of them are disappeared :(

 http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe

 -> https://www.ibm.com/developerworks/library/l-kprobes/index.html

 http://www.redhat.com/magazine/005mar05/features/kprobes/

 -> I can not find that.

>  - http://www-users.cs.umn.edu/~boutcher/kprobes/
>  - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)

Both are not found.

(OT, it seems http://www.linuxsymposium.org/ has been left from historical
 Linux Symposium, we must remove it asap)

Thank you,

> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/kprobes.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 8baab8832c5b..f6990f64154f 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -693,7 +693,7 @@ process. Here are sample overhead figures (in usec) for x86 architectures::
>  TODO
>  ====
>  
> -a. SystemTap (http://sourceware.org/systemtap): Provides a simplified
> +a. SystemTap (https://sourceware.org/systemtap): Provides a simplified
>     programming interface for probe-based instrumentation.  Try it out.
>  b. Kernel return probes for sparc64.
>  c. Support for other architectures.
> @@ -712,8 +712,8 @@ See samples/kprobes/kretprobe_example.c
>  
>  For additional information on Kprobes, refer to the following URLs:
>  
> -- http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
> -- http://www.redhat.com/magazine/005mar05/features/kprobes/
> +- https://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
> +- https://www.redhat.com/magazine/005mar05/features/kprobes/
>  - http://www-users.cs.umn.edu/~boutcher/kprobes/
>  - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
>  
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
