Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207ABC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22E8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXL/68ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgBMSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:11:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41569 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBMSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:11:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so5064244qtr.8;
        Thu, 13 Feb 2020 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXNjQq+FuUTt0VQT8MIpwcMf0UZXgeYpJ3PifLwHNq0=;
        b=rXL/68epWcmaJ1flh2YoYdFuJU6Z4pke0g9AqLoqcDf4KwpSztoJfGQ0m1UNERfWZr
         OcZNUafEIoWK5Pm52mq1X4grALKeWlL0N7jwRIY5sA9A9vEzpLO+lKWmHVa7Ss2Ga+B5
         xzranwv06IoM4RLztDn1h4k/RL2XeTnky88zeQTQYd3Mfu87ybT8PfDQDQ8ZaQSbHoaW
         YQdINRhj1eRUVwV6QPKzCTjWkXvCriCABuT2btOWzgyZ3LuJqtez+Lux18lB/D4hRvQv
         gESjTY+pmh5DuHtFiGdLHDGLIQPOYxeMCAQgYf1SRNdh/vQQ3SKaLl09GSUL1dQLfAc4
         K4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXNjQq+FuUTt0VQT8MIpwcMf0UZXgeYpJ3PifLwHNq0=;
        b=g7+T1A7zjBotBFA+uu9S3XozgGaW98HkdslMfampuYicKSU3j2dL/jDV/vJAkggMsV
         w1XMR3GWEymzMrP+Pgz0awYZJSsOLh9TDjV50U2+fMmD0GVDSEZAYmfVLRSI9GkCjNlK
         d1AeBPgLOHmSP9ZbtsOkPTXYNsOM368nggt2czOQA94J/CBOYpKVFd71bSeY4MSKgIC5
         D7127YNub9IietjL/JVtW8YeylwBwfFVAPD7yeazFtrZS7Y+q0hYEOnc7bQrAM2nxmOm
         iSjeDLiuu0kVh8F2J0JIl/J7BBmPlp4YJC2tSjjhySa7P7+jkVJQwOR3rprrX7pak7mR
         guDA==
X-Gm-Message-State: APjAAAUDo3M2LsdfGnUkkKPnkJmlkkPJpaiJEYY5kASYJ3DjHYFeiSEI
        bKMUL+6//IK+Q7IDOal5zoAA4dfn
X-Google-Smtp-Source: APXvYqwzojWNPN+YUg/RN5gvDYAbSo4UqpU9FYLGg3QnyQkg5hrB8KyD1HqpbVXkfzqo5yakK75jhA==
X-Received: by 2002:ac8:3ac3:: with SMTP id x61mr12993517qte.25.1581617504472;
        Thu, 13 Feb 2020 10:11:44 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.215.171])
        by smtp.gmail.com with ESMTPSA id o17sm1899308qtj.80.2020.02.13.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:11:43 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D1DE403AD; Thu, 13 Feb 2020 15:11:40 -0300 (-03)
Date:   Thu, 13 Feb 2020 15:11:40 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-ID: <20200213181140.GA28626@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
 <20200213143048.GA22170@kernel.org>
 <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
> On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
 
> > Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> > > This test places a kprobe to function getname_flags() in the kernel
> > > which has the following prototype:
 
> > >   struct filename *
> > >   getname_flags(const char __user *filename, int flags, int *empty)
 
> > > Variable filename points to a filename located in user space memory.
> > > Looking at
> > > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > > the kprobe should indicate that user space memory is accessed.
 
> > > The following patch specifies user space memory access first and if this
> > > fails use type 'string' in case 'ustring' is not supported.
 
> > What are you fixing?
 
> > I haven't seen any example of this test failing, and right now testing
> > it with:
 
> > [root@quaco ~]# uname -a
> > Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> > [root@quaco ~]#
 
> This bug doesn't happen on x86 or other archs on which user-address space and
> kernel address space is same. On some arch (ppc64 in this case?) user-address
> space is partially or completely same as kernel address space. (Yes, they switch
> the world when running into the kernel) In this case, we need to use different
> data access functions for each spaces. That is why I introduced "ustring" type
> for kprobe event.
> As far as I can see, Thomas's patch is sane.

Well, without his patch, on x86, the test he is claiming to be fixing
works well, with his patch it stops working, see the rest of my reply.

- Arnaldo

> Thomas, could you show us your result on your test environment?
