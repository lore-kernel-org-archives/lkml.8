Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15691C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE98B206ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581461240;
	bh=8846fUtTtG1u5dbmx7PL9BsCMN38k37aj9KG0jpXB20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GM9cgtbMDOkWcscPathNwRAMl9FKbR3DanhRZdWyN9lw7erYtFZo7OK7JPRNMyhWj
	 3ueGNenY81z06LsdMEXna1cBAUXUoo25h/n7dwmDNagaiqZh/T7N4YKEHSrO9odphk
	 jTXCUEe+e8Nj1zFjGwG+I7APG9vKJjgA7O5NeGHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBKWrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgBKWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:47:18 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF6F21739
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581461238;
        bh=8846fUtTtG1u5dbmx7PL9BsCMN38k37aj9KG0jpXB20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GdwV6pGjP1QMeQ9Q+I0Qe8Mkkt024wfIE1N1G7WKC38gYA+19B9en7ircBqB3Qp2z
         aTsU9i5zrWlfJ8kqZFxfKVJUIAmx7Pg3EQOCVPBYGv/sJ6X9dDOWNp6t9yy1e3HEV3
         WirIIuFUK4W1YI+iIr6C5Y+vFyNAdx4AoCF1r1HA=
Received: by mail-wm1-f51.google.com with SMTP id a9so5762729wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:47:17 -0800 (PST)
X-Gm-Message-State: APjAAAVbrOp2Lo1aGGBgCWC376Ows8q6ArYp5imVVK36QjL202gapSSo
        zV08L3H1/Dm3sZ/PtLBfIG0auPeu1hekJaj5H3v0nw==
X-Google-Smtp-Source: APXvYqwLMFfykA+lJO+JrGtvf5tixGtL0MJifVbP6ZDH2lGW5WHYfqpx8LjEVH0nOFYUqKIXHF9G/pYzuXtkAs32brE=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr8161092wmi.21.1581461236365;
 Tue, 11 Feb 2020 14:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-40-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-40-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:47:05 -0800
X-Gmail-Original-Message-ID: <CALCETrXnFr47OEDk8OYrHHW=1XNAQMUB=wPevhLM6ROnO6_Rog@mail.gmail.com>
Message-ID: <CALCETrXnFr47OEDk8OYrHHW=1XNAQMUB=wPevhLM6ROnO6_Rog@mail.gmail.com>
Subject: Re: [PATCH 39/62] x86/sev-es: Harden runtime #VC handler for
 exceptions from user-space
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Send SIGBUS to the user-space process that caused the #VC exception
> instead of killing the machine. Also ratelimit the error messages so
> that user-space can't flood the kernel log.

What would cause this?  CPUID?  Something else?

--Andy
