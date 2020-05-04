Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6ECC28CBC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59497206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgEDArS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 20:47:18 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:53038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEDArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:47:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 84CBB1800A695;
        Mon,  4 May 2020 00:47:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pen33_21ed1a190575c
X-Filterd-Recvd-Size: 2603
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 00:47:13 +0000 (UTC)
Message-ID: <a88be1298aa1600f46e868dd45f83a6075c7162e.camel@perches.com>
Subject: Re: [PATCH 12/14] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
From:   Joe Perches <joe@perches.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Sameer Rahmani <lxsameer@gnu.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-remoteproc@vger.kernel.org, tee-dev@lists.linaro.org,
        linux-arch@vger.kernel.org
Date:   Sun, 03 May 2020 17:47:11 -0700
In-Reply-To: <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
         <28687056965ff46c0e6c81663a419bc59cfb94b4.1588345503.git.mchehab+huawei@kernel.org>
         <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 08:54 +0900, Masami Hiramatsu wrote:
> On Fri,  1 May 2020 17:37:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > -F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/staging/atomic_bitops.txt

Can you please keep the file lists in alphabetic order
and move this entry down appropriately?  Thanks.

> >  F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst


