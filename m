Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F7C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AEE2074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko6BUx5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgDWO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDWO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:29:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F05C08E934;
        Thu, 23 Apr 2020 07:29:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f7so3017698pfa.9;
        Thu, 23 Apr 2020 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=euZIJ/M801FkiIRohqJykf0KTV1d7R1eB6u3qEkTjI0=;
        b=Ko6BUx5ma8P13bvtmuvtoClR1kdW1PNfQ5Mdcb5ut/b6dbYDkx4snP1pcDRIaxOAWt
         OrjLtoxwLINDnrWAmg7a5CQU5PcYxBNmj260qRjWiFDyutI3obuDy12DDb+0FtQabOsJ
         /3rVzC3AOzR+z+YJlDXnT1BweMe1w5xONexIwTNdYDkMCNDJRsU1inGD2jUIRLgKCL0k
         1bpmI47cx+gGudFoSqsQaGbVCfn+4Mj1YLSG3N0PQxFoc3IwdALS/MkBBF2+D3kD6rLt
         XH+krkBwKgcXAWWSnTzI88j3+8S+pBK0gz36DD/o1UpqdI95hODX2seSYE5abCiWGtNs
         2Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=euZIJ/M801FkiIRohqJykf0KTV1d7R1eB6u3qEkTjI0=;
        b=BWE75bbEnls+v0wtezc7btijxW0BiIzpDT8nvkiR9I+d4lKq30D/e40Wscdx6ReMfH
         xErSW1Nq9xWKxSv63Jv7I8ycXxmBD5V62B9fAsdansMS1OQqbFE1FObG1AtoSrdntjj0
         AwIG49X20oiGxA9gaadOpqawqRZwls3G97p31CdSffgtz7FFKL99E2xXzPcYODfdJ/fF
         y/RNwy2PeXqFqOcXwscuudUhLqUfRZf6VuDR+VYcA8nbAQ2kVlN6r49ItRgWYdJz7zLD
         qkO/TjH92JIZWPXRjGhqFZyC7CYWbmjNBtC6q+qTp/4ZKeRi+sKoi3d43T0z1fHQc1Wd
         2jOA==
X-Gm-Message-State: AGi0PuYbDJGvKgNYrrtftyqKEynHOZlMIBV8xAkvtPNfGvoJmMRpN0ro
        9nnp8CSywumgF9KJjQpuFB4=
X-Google-Smtp-Source: APiQypLCBsvdXjd0LfkUeemwgs+0ri7ASlr6IwzFVhcmjfzaxZE5iJago8sKARkvbGq9vjBLA4PJvA==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr4085226pfq.212.1587652153207;
        Thu, 23 Apr 2020 07:29:13 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id h5sm2537837pjv.4.2020.04.23.07.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 07:29:12 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:29:09 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>,
        Thomas =?utf-8?Q?Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] console: fix an issue about ioremap leak.
Message-ID: <20200423142909.GB1562@nuc8i5>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:10:14PM +0200, Markus Elfring wrote:
> > if do_take_over_console() return an error in the newport_probe(),
> > due to the io virtual address is not released, it will cause a leak.
> 
> How do you think about a wording variant like the following?
> 
>    Subject:
>    [PATCH v2] console: Complete exception handling in newport_probe()
> 
>    Change description:
>    A call of the function “do_take_over_console” can fail here.
>    The corresponding system resources were not released then.
>    Thus add a call of the function “iounmap” together with the check
>    of a failure predicate.
>
Thanks!

> 
> I would like to point out that there is a script for the semantic
> patch language which would detect other questionable source code.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
> 
> How do you think about to extend presented software analysis approaches?
>
Sorry, I am not familiar with it, I don't know.

BR,
Dejin

> Regards,
> Markus
