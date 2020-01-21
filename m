Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA88C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A762087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoEpqp79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:30:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50779 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgAUSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579631419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6ph8C+aXX0HI0FhHPqndGPmUHr5PUk3iM34mdtK754=;
        b=WoEpqp79Jpao9qyUg3Uvvc4mQ4n9D8MEvA3+3z2MgM4dsuIZZk6KlSojelnpG8O+TGbQFs
        RGTZkuPhSuQbKVM8sW0jDEzGTojGx50RohV1GspTrIK6KESh83e+R12JgYZ0Xo59XMEUkR
        9U4Za2L+3Ldo/jV6+OjjjcHJzZfyC0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-uxQgXMv6MISRi-IAIju01Q-1; Tue, 21 Jan 2020 13:30:15 -0500
X-MC-Unique: uxQgXMv6MISRi-IAIju01Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2643800D4C;
        Tue, 21 Jan 2020 18:30:12 +0000 (UTC)
Received: from treble (ovpn-122-154.rdu2.redhat.com [10.10.122.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3115639A;
        Tue, 21 Jan 2020 18:30:11 +0000 (UTC)
Date:   Tue, 21 Jan 2020 12:30:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200121183009.253yh6aehvnvxoew@treble>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
 <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com>
 <20200121103101.GE11154@willie-the-truck>
 <CAKwvOd=_PqQWUvd_WZRpEr+T==3w6LpsHKBz3E9ybaQ0javVkw@mail.gmail.com>
 <20200121180632.GA13592@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121180632.GA13592@willie-the-truck>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 06:06:34PM +0000, Will Deacon wrote:
> On Tue, Jan 21, 2020 at 09:08:29AM -0800, Nick Desaulniers wrote:
> > On Tue, Jan 21, 2020 at 2:31 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Jan 13, 2020 at 07:57:48AM +0000, Julien Thierry wrote:
> > > > On 1/12/20 8:42 AM, Nathan Chancellor wrote:
> > > > > The 0day bot reported a couple of issues with clang with this series;
> > > > > the full report is available here (clang reports are only sent to our
> > > > > mailing lists for manual triage for the time being):
> > > > >
> > > > > https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ
> > > > >
> > > >
> > > > Thanks, I'll have a look at those.
> > > >
> > > > > The first obvious issue is that this series appears to depend on a GCC
> > > > > plugin? I'll be quite honest, objtool and everything it does is rather
> > > > > over my head but I see this warning during configuration (allyesconfig):
> > > > >
> > > > > WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
> > > > >    Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
> > > > >      Selected by [y]:
> > > > >        - ARM64 [=y] && STACK_VALIDATION [=y]
> > > > >
> > > > > Followed by the actual error:
> > > > >
> > > > > error: unable to load plugin
> > > > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
> > > > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
> > > > > open shared object file: No such file or directory'
> > > > >
> > > > > If this plugin is absolutely necessary and can't be implemented in
> > > > > another way so that clang can be used, seems like STACK_VALIDATION
> > > > > should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.
> > > > >
> > > >
> > > > So currently the plugin is necessary for proper validation. One option can
> > > > be to just let objtool output false positives on files containing jump
> > > > tables when the plugin cannot be used. But overall I guess it makes more
> > > > sense to disable stack validation for non-gcc builds, for now.
> > >
> > > Alternatively, could we add '-fno-jump-tables' to the KBUILD_CFLAGS if
> > > STACK_VALIDATION is selected but we're not using GCC? Is that sufficient
> > > to prevent generation of these things?
> > 
> > Surely we wouldn't want to replace jump tables with long chains of
> > comparisons just because objtool couldn't validate jump tables without
> > a GCC plugin for aarch64 for some reason, right?  objtool validation
> > is valuable, but tying runtime performance to a GCC plugin used for
> > validation seems bad.
> 
> I'm only suggesting it if STACK_VALIDATION is selected. It's off by default,
> and lives in Kconfig.debug. I'd prefer that to "cross your fingers are do
> nothing differently", which is what the other option seems to be.

I don't know what the right answer is here, but keep in mind that
objtool is on by default for x86, so don't be surprised if that
eventually happens to arch64 too.

Short term it might be ok to disable jump tables with objtool enabled,
or to disable objtool when clang is in use, but long term we'll need to
figure out a better solution.

-- 
Josh

