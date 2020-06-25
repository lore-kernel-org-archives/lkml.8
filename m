Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D4E20707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOpkywZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbgFYImi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390150AbgFYImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:42:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BBFC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:42:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k6so2502460pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Ak4YKOU6Z1LQkeYz68N9Kz3RJ7GxY3Zdvb8yaAgjb0=;
        b=dOpkywZOfZZs5ibaTbsnSX/lYi8K7cpq5wVnt7hnEwDySagQm7ZfegX0k9THbUrQkA
         hdWw1W8gloKrRtxR3USeU/5hHSeJ5vRufcv26BMCFbK8owRJzYyXCJvKhI0BM0OFdLgr
         +Flfg3f5AkuzVDQRLPVQIzz3nP11srH8hdcgfQ2wHHAMA2Pq385TSePQxuI0jJjFJpXK
         LW4dLkzLRY4sv4X06eJShAYpQgH40MaCJHVIIEWSXkMbmaEZPa8Tl+0OPCWqV8oe2FOa
         5jC+kQeke5iSXz1T9Mr/FXMzY2pQrENLZC5qSrikqStIUEedBRQGblVp6C18gsP5yZvl
         6ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Ak4YKOU6Z1LQkeYz68N9Kz3RJ7GxY3Zdvb8yaAgjb0=;
        b=XdMMsfNcusajjIRQFDNE+ykN8tP3wWS7DvDGhNhCiIL625Y0d3G9kyrFOc+oAAHqoT
         livVI3bHFhteKQfQ0Gbenk9WRRysq/0T32GS0xbabqypI3fFj+pORQDMj/CTTS3wPeB+
         Q3EKDFJQ6TTiYwFYc13fQD400jjwGwP7lvBKutk5O2Lldlf12REO+31aMXr6aqE7Tp2U
         ETkGQIlSsaiAGSjrRTjCuGDuwHtvBJXzlqREpFlvHj5S+SKTN9TkWHTT+0p2TkDHbkHr
         RmNqmLQjOIalUXQixudpZ+aM0DYfsUfubIja4mWjgvxXY4INDmONHYq0dHX0in9HY0gJ
         qeZQ==
X-Gm-Message-State: AOAM531eygSyOodyAuXAEHj/Ik/Mc9jj3ok8Gzh5zF0tQCQZbwTYazq/
        TQ2vwhui+erDUIiEnKgZj3o=
X-Google-Smtp-Source: ABdhPJzPLoaOTjTeX0um/FFziQC1BFJH5ulKh16r2QyVBel5hbJ51f7pn+ruzDrHtBtkYkraGki5HQ==
X-Received: by 2002:a17:90a:7c4e:: with SMTP id e14mr2111770pjl.175.1593074555248;
        Thu, 25 Jun 2020 01:42:35 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id p5sm23854276pfg.162.2020.06.25.01.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 01:42:34 -0700 (PDT)
Date:   Thu, 25 Jun 2020 01:42:32 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dmitry Safonov <dima@arista.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, adrian@lisas.de
Subject: Re: [PATCH 3/3] nsproxy: support CLONE_NEWTIME with setns()
Message-ID: <20200625084232.GB151695@gmail.com>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
 <20200619153559.724863-4-christian.brauner@ubuntu.com>
 <20200623115521.hk3xlhixrt2zrgkn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200623115521.hk3xlhixrt2zrgkn@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:55:21PM +0200, Christian Brauner wrote:
> On Fri, Jun 19, 2020 at 05:35:59PM +0200, Christian Brauner wrote:
> > So far setns() was missing time namespace support. This was partially due
> > to it simply not being implemented but also because vdso_join_timens()
> > could still fail which made switching to multiple namespaces atomically
> > problematic. This is now fixed so support CLONE_NEWTIME with setns()
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Dmitry Safonov <dima@arista.com>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> 
> Andrei,
> Dmitry,
> 
> A little off-topic since its not related to the patch here but I've been
> going through the current time namespace semantics and i just want to
> confirm something with you:
> 
> Afaict, unshare(CLONE_NEWTIME) currently works similar to
> unshare(CLONE_NEWPID) in that it only changes {pid,time}_for_children
> but does _not_ change the {pid, time} namespace of the caller itself.
> For pid namespaces that makes a lot of sense but I'm not completely
> clear why you're doing this for time namespaces, especially since the
> setns() behavior for CLONE_NEWPID and CLONE_NEWTIME is very different:
> Similar to unshare(CLONE_NEWPID), setns(CLONE_NEWPID) doesn't change the
> pid namespace of the caller itself, it only changes it for it's
> children by setting up pid_for_children. _But_ for setns(CLONE_NEWTIME)
> both the caller's and the children's time namespace is changed, i.e.
> unshare(CLONE_NEWTIME) behaves different from setns(CLONE_NEWTIME). Why?

This scheme allows setting clock offsets for a namespace, before any
processes appear in it. It is not allowed to change offsets if any task
has joined a time namespace. We need this to avoid corner cases with
timers and tasks don't need to be aware of offset changes.

> 
> This also has the consequence that the unshare(CLONE_NEWTIME) +
> setns(CLONE_NEWTIME) sequence can be used to change the callers pid
> namespace. Is this intended?
> Here's some code where you can verify this (please excuse the aweful
> code I'm using to illustrate this):
> 
> int main(int argc, char *argv[])
> {
> 	char buf1[4096], buf2[4096];
> 
> 	if (unshare(0x00000080))
> 		exit(1);
> 
> 	int fd = open("/proc/self/ns/time", O_RDONLY);
> 	if (fd < 0)
> 		exit(2);
> 
> 	readlink("/proc/self/ns/time", buf1, sizeof(buf1));
> 	readlink("/proc/self/ns/time_for_children", buf2, sizeof(buf2));
> 	printf("unshare(CLONE_NEWTIME):		time(%s) ~= time_for_children(%s)\n", buf1, buf2);
> 
> 	if (setns(fd, 0x00000080))
> 		exit(3);

And in this example, you use the right sequence of steps: unshare, set
offsets, setns. With clone3, we will be able to do this in one call.

> 
> 	readlink("/proc/self/ns/time", buf1, sizeof(buf1));
> 	readlink("/proc/self/ns/time_for_children", buf2, sizeof(buf2));
> 	printf("setns(self, CLONE_NEWTIME):	time(%s) == time_for_children(%s)\n", buf1, buf2);
> 
> 	exit(EXIT_SUCCESS);
> }
> 
> which gives:
> 
> root@f2-vm:/# ./test
> unshare(CLONE_NEWTIME):		time(time:[4026531834]) ~= time_for_children(time:[4026532366])
> setns(self, CLONE_NEWTIME):	time(time:[4026531834]) == time_for_children(time:[4026531834])
> 
> why is unshare(CLONE_NEWTIME) blocked from changing the callers pid
> namespace when setns(CLONE_NEWTIME) is allowed to do this?
> 
> Christian
