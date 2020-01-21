Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3997C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFF72253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579602668;
	bh=N1HxnG/W4GZnfj2DenmFwgX2DtvNPyZxVMKAKfJlmz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RRZsZ1dovBoR1zTFksM997NmwA4sbRomy9w0ybV4rTisTi/QPEU94ahPTspEna26Z
	 vSCjIOFw/cKz/2Ll70GxtUB4Jm+yL3YqqZG2J1JjGdxJ4++FsP8W/sKigb2J54+0FI
	 dBY+o6W6Q+UfKaTB4dJmpJFvNSFbuE9JaOIl5YxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgAUKbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:31:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3F820700;
        Tue, 21 Jan 2020 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579602666;
        bh=N1HxnG/W4GZnfj2DenmFwgX2DtvNPyZxVMKAKfJlmz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDgmkdso1XFVu4goBxxQPBXW2ZDKmgJeRPD37rrmhkiuwL+jP5taHeOygiaL5RagY
         u4gX0dwoARX09mIC0pXLD+lUkvD8jOqx30nZiAj/lUYcTasJce7cNOaxq6nlnYkiNT
         UPFELFZzjmZGQoiBurD+VQdYfyhqaXO4M7NEhLpU=
Date:   Tue, 21 Jan 2020 10:31:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200121103101.GE11154@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
 <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 07:57:48AM +0000, Julien Thierry wrote:
> On 1/12/20 8:42 AM, Nathan Chancellor wrote:
> > The 0day bot reported a couple of issues with clang with this series;
> > the full report is available here (clang reports are only sent to our
> > mailing lists for manual triage for the time being):
> > 
> > https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ
> > 
> 
> Thanks, I'll have a look at those.
> 
> > The first obvious issue is that this series appears to depend on a GCC
> > plugin? I'll be quite honest, objtool and everything it does is rather
> > over my head but I see this warning during configuration (allyesconfig):
> > 
> > WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
> >    Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
> >      Selected by [y]:
> >        - ARM64 [=y] && STACK_VALIDATION [=y]
> > 
> > Followed by the actual error:
> > 
> > error: unable to load plugin
> > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
> > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
> > open shared object file: No such file or directory'
> > 
> > If this plugin is absolutely necessary and can't be implemented in
> > another way so that clang can be used, seems like STACK_VALIDATION
> > should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.
> > 
> 
> So currently the plugin is necessary for proper validation. One option can
> be to just let objtool output false positives on files containing jump
> tables when the plugin cannot be used. But overall I guess it makes more
> sense to disable stack validation for non-gcc builds, for now.

Alternatively, could we add '-fno-jump-tables' to the KBUILD_CFLAGS if
STACK_VALIDATION is selected but we're not using GCC? Is that sufficient
to prevent generation of these things?

Will
