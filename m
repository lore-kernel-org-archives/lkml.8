Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4721A21D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204201;
	bh=90SSNhpwGdtCb5Wj/SwJPwxBnOiLghvSP5V9od1z4d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YlU6wsvxWRsJcppBFeCV2yzHu08fbVbUrK/OkItsT++S0HqDlS/NidujQHD1WAoL7
	 n/j5MxjWHK3+K++OtFYCJWs//aefDt9GOcYT6uylOYTtTP8j44G5dp0upp82C7VEpU
	 QP+Q9OCQpja9mp5u2CI7cUhJM2dGTYZt61wm5LBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgCCC4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgCCC4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:56:38 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7344B24673;
        Tue,  3 Mar 2020 02:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583204198;
        bh=90SSNhpwGdtCb5Wj/SwJPwxBnOiLghvSP5V9od1z4d0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYIoBi1kbTh+Lde/77f7UJjW0iBtYOskQCEEyvLJMjhIzHQAxIpOTbFv03ssoBjae
         jr6DcwUqUITJ6oIlarqn3ci5qCCMQ9aOkmLDfMB+PppHU8vHLqcSbASTYlil41FYaf
         4vJH+pfgTWp31z1Xi55rxy6i4ukv6geXFNucKKHQ=
Date:   Tue, 3 Mar 2020 11:56:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200303115633.3db043ce643c5bc55915a57c@kernel.org>
In-Reply-To: <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
        <158313622831.3082.8237132211731864948.stgit@devnote2>
        <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 17:52:36 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/2/20 12:03 AM, Masami Hiramatsu wrote:
> > Update boot configuration documentation.
> > 
> >  - Not using "config" abbreviation but configuration or description.
> >  - Rewrite descriptions of node and its maxinum number.
> >  - Add a section of use cases of boot configuration.
> >  - Move how to use bootconfig to earlier section.
> >  - Fix some typos, indents and format mistakes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> > Changes in v3:
> >  - Specify that comments also count in size.
> >  - Fix a confusing sentence.
> >  - Add O=<builddir> to make command.
> 
> 
> Hi Masami-san,
> 
> I think that you misunderstood me.  I am asking that you
> make "make O=builddir -C tools/bootconfig" work properly, i.e.,
> the bootconfig binary should be built in the <builddir>.
> 
> Presently when I enter that command, the bootconfig binary
> is still built in the kernel source tree.

Oops, that's my mistake! It needs to be fixed soon.
Thank you for reporting it!

(Also, I misunderstood what O= option means for tools...)

> 
> > Changes in v2:
> >  - Fixes additional typos (Thanks Markus and Randy!)
> >  - Change a section title to "Tree Structured Key".
> > ---
> >  Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
> >  Documentation/trace/boottime-trace.rst   |    2 
> >  2 files changed, 117 insertions(+), 66 deletions(-)
> > 
> 
> 
> All of the other changes look good to me.

Thank you!



> 
> thanks.
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
