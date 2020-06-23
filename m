Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B37C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB57420738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbgFWLz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:55:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbgFWLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:55:27 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnhWN-00018K-3o; Tue, 23 Jun 2020 11:55:23 +0000
Date:   Tue, 23 Jun 2020 13:55:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, adrian@lisas.de
Subject: Re: [PATCH 3/3] nsproxy: support CLONE_NEWTIME with setns()
Message-ID: <20200623115521.hk3xlhixrt2zrgkn@wittgenstein>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
 <20200619153559.724863-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619153559.724863-4-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:35:59PM +0200, Christian Brauner wrote:
> So far setns() was missing time namespace support. This was partially due
> to it simply not being implemented but also because vdso_join_timens()
> could still fail which made switching to multiple namespaces atomically
> problematic. This is now fixed so support CLONE_NEWTIME with setns()
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---

Andrei,
Dmitry,

A little off-topic since its not related to the patch here but I've been
going through the current time namespace semantics and i just want to
confirm something with you:

Afaict, unshare(CLONE_NEWTIME) currently works similar to
unshare(CLONE_NEWPID) in that it only changes {pid,time}_for_children
but does _not_ change the {pid, time} namespace of the caller itself.
For pid namespaces that makes a lot of sense but I'm not completely
clear why you're doing this for time namespaces, especially since the
setns() behavior for CLONE_NEWPID and CLONE_NEWTIME is very different:
Similar to unshare(CLONE_NEWPID), setns(CLONE_NEWPID) doesn't change the
pid namespace of the caller itself, it only changes it for it's
children by setting up pid_for_children. _But_ for setns(CLONE_NEWTIME)
both the caller's and the children's time namespace is changed, i.e.
unshare(CLONE_NEWTIME) behaves different from setns(CLONE_NEWTIME). Why?

This also has the consequence that the unshare(CLONE_NEWTIME) +
setns(CLONE_NEWTIME) sequence can be used to change the callers pid
namespace. Is this intended?
Here's some code where you can verify this (please excuse the aweful
code I'm using to illustrate this):

int main(int argc, char *argv[])
{
	char buf1[4096], buf2[4096];

	if (unshare(0x00000080))
		exit(1);

	int fd = open("/proc/self/ns/time", O_RDONLY);
	if (fd < 0)
		exit(2);

	readlink("/proc/self/ns/time", buf1, sizeof(buf1));
	readlink("/proc/self/ns/time_for_children", buf2, sizeof(buf2));
	printf("unshare(CLONE_NEWTIME):		time(%s) ~= time_for_children(%s)\n", buf1, buf2);

	if (setns(fd, 0x00000080))
		exit(3);

	readlink("/proc/self/ns/time", buf1, sizeof(buf1));
	readlink("/proc/self/ns/time_for_children", buf2, sizeof(buf2));
	printf("setns(self, CLONE_NEWTIME):	time(%s) == time_for_children(%s)\n", buf1, buf2);

	exit(EXIT_SUCCESS);
}

which gives:

root@f2-vm:/# ./test
unshare(CLONE_NEWTIME):		time(time:[4026531834]) ~= time_for_children(time:[4026532366])
setns(self, CLONE_NEWTIME):	time(time:[4026531834]) == time_for_children(time:[4026531834])

why is unshare(CLONE_NEWTIME) blocked from changing the callers pid
namespace when setns(CLONE_NEWTIME) is allowed to do this?

Christian
