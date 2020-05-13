Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013DDC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD172088E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgEMOsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:48:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43190 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbgEMOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:48:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYsgK-0000yu-51; Wed, 13 May 2020 08:48:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYsg9-0006lM-P3; Wed, 13 May 2020 08:48:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
        <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
        <20200512003305.GX11244@42.do-not-panic.com>
        <87y2pxs73w.fsf@x220.int.ebiederm.org>
        <20200512172413.GC11244@42.do-not-panic.com>
        <87k11hrqzc.fsf@x220.int.ebiederm.org>
        <20200512220341.GE11244@42.do-not-panic.com>
        <87d078oss9.fsf@x220.int.ebiederm.org>
        <20200513141421.GP11244@42.do-not-panic.com>
Date:   Wed, 13 May 2020 09:44:40 -0500
In-Reply-To: <20200513141421.GP11244@42.do-not-panic.com> (Luis Chamberlain's
        message of "Wed, 13 May 2020 14:14:22 +0000")
Message-ID: <87tv0jopwn.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYsg9-0006lM-P3;;;mid=<87tv0jopwn.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FNoLfkTBHcu+1wfubNVYoTzAxcIgHFsA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Wed, May 13, 2020 at 08:42:30AM -0500, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>> 
>> > On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
>> >> Luis Chamberlain <mcgrof@kernel.org> writes:
>> >> 
>> >> > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
>> >> >> Luis Chamberlain <mcgrof@kernel.org> writes:
>> >> >> 
>> >> >> > +static struct ctl_table fs_base_table[] = {
>> >> >> > +	{
>> >> >> > +		.procname	= "fs",
>> >> >> > +		.mode		= 0555,
>> >> >> > +		.child		= fs_table,
>> >> >> > +	},
>> >> >> > +	{ }
>> >> >> > +};
>> >> >>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
>> >> >> > > +static int __init fs_procsys_init(void)
>> >> >> > +{
>> >> >> > +	struct ctl_table_header *hdr;
>> >> >> > +
>> >> >> > +	hdr = register_sysctl_table(fs_base_table);
>> >> >>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
>> >> >> 	AKA
>> >> >>         hdr = register_sysctl("fs", fs_table);
>> >> >
>> >> > Ah, much cleaner thanks!
>> >> 
>> >> It is my hope you we can get rid of register_sysctl_table one of these
>> >> days.  It was the original interface but today it is just a
>> >> compatibility wrapper.
>> >> 
>> >> I unfortunately ran out of steam last time before I finished converting
>> >> everything over.
>> >
>> > Let's give it one more go. I'll start with the fs stuff.
>> 
>> Just to be clear moving the tables out of kernel/sysctl.c is a related
>> but slightly different problem.
>
> Sure, but also before we go on this crusade, how about we add a few
> helpers:
>
> register_sysctl_kernel()
> register_sysctl_vm()
> register_sysctl_fs()
> register_sysctl_debug()
> register_sysctl_dev()

Hmm.

  register_sysctl("kernel")

> That should make it easier to look for these, and shorter. We *know*
> this is a common path, given the size of the existing table.

I don't really care but one character shorter doesn't look like it
really helps.  Not really for grepping and not maintenance as we get a
bunch of trivial one line implementations.

Eric
