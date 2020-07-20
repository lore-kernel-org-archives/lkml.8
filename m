Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F396C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51A220773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595246475;
	bh=8mMAy0br36nLOKBa9g59l13frn54aW+3qVhtgGwDjbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JQE7KYPWsFOAmGdDKf9EbYZfSZTTXjMy7zi+aoAmYG5I4h7x3YguHAzciYhCzD9Yo
	 pgRohQWOFF3v+Kjy797BVgJFPGolXI9nhY8hN1EGCH1AoqB0WyZoHtsXw3ESM7taO9
	 5YQn+M5WBKa562xOiWfCU9yPIz/kBMFjB7vgKMI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGTMBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTMBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:01:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EFA2070A;
        Mon, 20 Jul 2020 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595246473;
        bh=8mMAy0br36nLOKBa9g59l13frn54aW+3qVhtgGwDjbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mXi5m/BxyFm2Os9QipmOLMrjDkz03Q0K/sqDmW/MXHx9/Pf/0mLmxuGrr0Tp36MmH
         LBU+zIWinewNio4VMiqnLSzJbdR8SC6T2rPRLr5/ggQLJDiVuKdKBSDisZXvjxG3+l
         bq7rJuY6ZXY3+d/zUUwyovK3ooUM9I7PsFQlmhns=
Date:   Mon, 20 Jul 2020 21:01:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        anil.s.keshavamurthy@intel.com, corbet@lwn.net,
        davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kprobes
Message-Id: <20200720210109.d46926c7d1dbe703d6c74a65@kernel.org>
In-Reply-To: <2b0d6f67-7844-644c-1806-5d795cb5093d@al2klimov.de>
References: <20200707194959.52487-1-grandmaster@al2klimov.de>
        <20200708184201.611d929ae6017c87ea98b114@kernel.org>
        <1594388442.4mjtjyic5z.naveen@linux.ibm.com>
        <20200713232011.da584d6f7147b54ba083556f@kernel.org>
        <2b0d6f67-7844-644c-1806-5d795cb5093d@al2klimov.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 00:02:49 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> 
> 
> Am 13.07.20 um 16:20 schrieb Masami Hiramatsu:
> > Hi Naveen and Alexander,
> > 
> > On Fri, 10 Jul 2020 19:14:47 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >>> On Tue,  7 Jul 2020 21:49:59 +0200
> >>> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> >>>
> >>>> Rationale:
> >>>> Reduces attack surface on kernel devs opening the links for MITM
> >>>> as HTTPS traffic is much harder to manipulate.
> >>>>
> >>>> Deterministic algorithm:
> >>>> For each file:
> >>>>    If not .svg:
> >>>>      For each line:
> >>>>        If doesn't contain `\bxmlns\b`:
> >>>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> >>>>            If both the HTTP and HTTPS versions
> >>>>            return 200 OK and serve the same content:
> >>>>              Replace HTTP with HTTPS.
> >>>
> >>> OK, but it seems that some of them are disappeared :(
> >>>
> >>>   http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
> >>>
> >>>   -> https://www.ibm.com/developerworks/library/l-kprobes/index.html
> >>
> >> That looks right.
> >>
> >>>
> >>>   http://www.redhat.com/magazine/005mar05/features/kprobes/
> >>>
> >>>   -> I can not find that.
> >>
> >> Ditto, we should drop that.
> >>
> >>>
> >>>>   - http://www-users.cs.umn.edu/~boutcher/kprobes/
> >>>>   - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
> >>>
> >>> Both are not found.
> >>
> >> It looks like the first link is gone, but there seems to be a copy in
> >> the web archive:
> >> https://web.archive.org/web/20061106154519/http://www-users.cs.umn.edu/~boutcher/kprobes/
> >>
> >> I suppose we can drop that link.
> >>
> >>>
> >>> (OT, it seems http://www.linuxsymposium.org/ has been left from historical
> >>>   Linux Symposium, we must remove it asap)
> >>
> >> Indeed, I think that link pointed to the Kprobes paper:
> >> https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf
> > 
> > Ah, there is.
> > Thank you for the confirmation.
> > Alexander, can you update other urls instead of just replacing the http with https?
> Sry, but I don't steal others' work (on principle).
> 
> If I didn't the work (e.g. searched the replacement URL), I don't 
> deserve to author the respective commit.
> 
> Also my HTTPSifying task is not done yet.

Hmm, Naveen, then, can you make the update?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
